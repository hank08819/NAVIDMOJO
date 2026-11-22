# Fixed-order sum with different numbers of blocks B (a power of two).
# Same kernel and input as test_fixed_cost.mojo; only the number of blocks is varied.
# For each B: the sum on 1 worker, how many of the worker counts 1 to 16 return the same
# bits, and the best time on 1 and on 16 workers (at least 7 repetitions and 0.3 s).
from collections import List
from algorithm import parallelize
from time import perf_counter_ns


def fixed_sum(x: List[Float64], workers: Int, nb: Int) -> Float64:
    var n = len(x)
    var xp = x.unsafe_ptr()
    var block = List[Float64]()
    for _ in range(nb):
        block.append(0.0)
    var bp = block.unsafe_ptr()
    var size = (n + nb - 1) // nb
    @parameter
    def one(b: Int):
        var lo = b * size
        var hi = lo + size
        if hi > n:
            hi = n
        var s: Float64 = 0.0
        var c: Float64 = 0.0
        var i = lo
        while i < hi:
            var y = xp[i] - c
            var t = s + y
            c = (t - s) - y
            s = t
            i += 1
        bp[b] = s
    parallelize[one](nb, workers)
    # fixed pairwise tree over the block sums
    var m = nb
    while m > 1:
        var half = m // 2
        for k in range(half):
            block[k] = block[2 * k] + block[2 * k + 1]
        m = half
    return block[0]


def main():
    var n = 10_000_000
    var x = List[Float64]()
    var state: UInt64 = 2026
    for _ in range(n):
        state = state * 6364136223846793005 + 1442695040888963407
        var u = Float64(state >> 11) * (1.0 / 9007199254740992.0)
        state = state * 6364136223846793005 + 1442695040888963407
        var e = Int((state >> 33) % 13)
        var mag: Float64 = 1.0
        for _ in range(e):
            mag *= 10.0
        x.append((u - 0.5) * mag * 1.0e-6)
    for nb in [16, 64, 256, 1024, 4096, 16384, 65536, 262144, 1048576]:
        var f1 = fixed_sum(x, 1, nb)
        var same = 0
        for w in range(1, 17):
            if fixed_sum(x, w, nb) == f1:
                same += 1
        print("KEY blocks", nb, "sum", f1, "same_bits_for_workers_1_to_16", same, "of 16")
        for w in [1, 16]:
            var best: UInt = 0
            var r = 0
            var spent: UInt = 0
            while r < 7 or (spent < 300000000 and r < 2000):
                var t0 = perf_counter_ns()
                var f = fixed_sum(x, w, nb)
                var d = perf_counter_ns() - t0
                spent += d
                if r == 0 or d < best:
                    best = d
                if f != f1:
                    print("MISMATCH", f)
                r += 1
            print("KEY blocks", nb, "workers", w, "ms", Float64(best) / 1.0e6)
