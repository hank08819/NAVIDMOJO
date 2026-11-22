# Fig. 5(a): Monte Carlo European call. Build: mojo build mc.mojo (Mojo 1.0.0b1)
# Path i draws its two uniforms from a 64-bit LCG seeded by i, so every
# language prices the same paths. Up to 16 workers, one chunk per worker; a worker
# prices eight paths per step, one SIMD lane per path. Chunk sums are added in chunk order.
# Run: ./mc.mojo.bin 1000 10000 100000 1000000 10000000 100000000
from collections import List
from algorithm import parallelize
from math import exp, sqrt, log, cos
from time import perf_counter_ns
from sys import argv

alias WORKERS = 16


@always_inline
def payoff(i: Int) -> Float64:
    var st = UInt64(i + 1) * 0x9E3779B97F4A7C15
    st = st * 6364136223846793005 + 1442695040888963407
    var u1 = (Float64(st >> 11) + 0.5) * (1.0 / 9007199254740992.0)
    st = st * 6364136223846793005 + 1442695040888963407
    var u2 = (Float64(st >> 11) + 0.5) * (1.0 / 9007199254740992.0)
    var z = sqrt(-2.0 * log(u1)) * cos(6.283185307179586 * u2)
    var s_t = 100.0 * exp((0.05 - 0.5 * 0.2 * 0.2) * 1.0 + 0.2 * z)
    var p = s_t - 100.0
    if p < 0.0:
        p = 0.0
    return p


def main() raises:
    var args = argv()
    for si in range(1, len(args)):
        var n = Int(args[si])
        var partial = List[Float64]()
        for _ in range(WORKERS):
            partial.append(0.0)
        var pp = partial.unsafe_ptr()
        # small jobs use fewer workers: at least 2,048 paths per worker
        var workers = n // 2048
        if workers < 1:
            workers = 1
        if workers > WORKERS:
            workers = WORKERS
        var chunk = (n + workers - 1) // workers
        var best: UInt = 0
        var pr: Float64 = 0.0
        # repeat at least 7 times and until 0.3 s have been spent on this size (at most 2,000 times)
        var r = 0
        var spent: UInt = 0
        while r < 7 or (spent < 300000000 and r < 2000):
            var t0 = perf_counter_ns()
            @parameter
            def one(w: Int):
                var lo = w * chunk
                var hi = lo + chunk
                if hi > n:
                    hi = n
                # eight paths per step, one SIMD lane per path
                var acc = SIMD[DType.float64, 8](0.0)
                var lane = SIMD[DType.uint64, 8](1, 2, 3, 4, 5, 6, 7, 8)
                var i = lo
                while i + 8 <= hi:
                    var st = (SIMD[DType.uint64, 8](UInt64(i)) + lane) * 0x9E3779B97F4A7C15
                    st = st * 6364136223846793005 + 1442695040888963407
                    var u1 = ((st >> 11).cast[DType.float64]() + 0.5) * (1.0 / 9007199254740992.0)
                    st = st * 6364136223846793005 + 1442695040888963407
                    var u2 = ((st >> 11).cast[DType.float64]() + 0.5) * (1.0 / 9007199254740992.0)
                    var z = sqrt(-2.0 * log(u1)) * cos(6.283185307179586 * u2)
                    var s_t = 100.0 * exp((0.05 - 0.5 * 0.2 * 0.2) * 1.0 + 0.2 * z)
                    acc += max(s_t - 100.0, SIMD[DType.float64, 8](0.0))
                    i += 8
                var s = acc.reduce_add()
                while i < hi:
                    s += payoff(i)
                    i += 1
                pp[w] = s
            parallelize[one](workers, workers)
            var total: Float64 = 0.0
            for w in range(workers):
                total += partial[w]
            pr = exp(-0.05) * total / Float64(n)
            var d = perf_counter_ns() - t0
            spent += d
            if r == 0 or d < best:
                best = d
            r += 1
        print("KEY mojo mc n", n, "ms", Float64(best) / 1.0e6, "price", pr)
