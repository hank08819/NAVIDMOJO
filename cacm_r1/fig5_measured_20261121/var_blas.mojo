# Fig. 5(d), CPU: portfolio VaR with risk decomposition, 10,000 scenarios, n assets.
# Same inputs and same formulae as var.mojo. The covariance matrix is computed by
# OpenBLAS (dsyrk), called from Mojo through external_call; this is the same OpenBLAS
# library that NumPy uses on this machine (64-bit integers, 16 threads).
# Build: mojo build var_blas.mojo -Xlinker <path to libscipy_openblas64_.so> -Xlinker -lm
# Run:   ./var_blas.mojo.bin 100 500 1000 2000 5000
from collections import List
from algorithm import parallelize
from ffi import external_call
from math import sqrt
from time import perf_counter_ns
from sys import argv

comptime WORKERS = 16
comptime M = 10000


def main() raises:
    external_call["scipy_openblas_set_num_threads64_", NoneType](Int64(WORKERS))
    var args = argv()
    for si in range(1, len(args)):
        var n = Int(args[si])
        # returns, scenario-major: scenario k occupies x[k*n .. k*n+n)
        var x = List[Float64]()
        var c = List[Float64]()
        for _ in range(n * M):
            x.append(0.0)
            c.append(0.0)
        for i in range(n):
            var st = UInt64(i + 1) * 0x9E3779B97F4A7C15
            var fs: UInt64 = 0x243F6A8885A308D3
            for k in range(M):
                st = st * 6364136223846793005 + 1442695040888963407
                fs = fs * 6364136223846793005 + 1442695040888963407
                var u = Float64(st >> 11) * (1.0 / 9007199254740992.0)
                var f = Float64(fs >> 11) * (1.0 / 9007199254740992.0)
                x[k * n + i] = 0.02 * (f - 0.5) + 0.04 * (u - 0.5)
        var mean = List[Float64]()
        var wv = List[Float64]()
        var sw = List[Float64]()
        for _ in range(n):
            mean.append(0.0)
            wv.append(1.0 / Float64(n))
            sw.append(0.0)
        var cov = List[Float64]()
        for _ in range(n * n):
            cov.append(0.0)
        var xp = x.unsafe_ptr()
        var cp = c.unsafe_ptr()
        var mp = mean.unsafe_ptr()
        var chunk = (n + WORKERS - 1) // WORKERS
        var best: UInt = 0
        var v: Float64 = 0.0
        var comp_sum: Float64 = 0.0
        # repeat at least 7 times and until 0.3 s have been spent on this size (at most 2,000 times)
        var r = 0
        var spent: UInt = 0
        while r < 7 or (spent < 300000000 and r < 2000):
            var t0 = perf_counter_ns()
            @parameter
            def centre(wk: Int):
                var lo = wk * chunk
                var hi = lo + chunk
                if hi > n:
                    hi = n
                for i in range(lo, hi):
                    mp[i] = 0.0
                for k in range(M):
                    for i in range(lo, hi):
                        mp[i] += xp[k * n + i]
                for i in range(lo, hi):
                    mp[i] = mp[i] / Float64(M)
                for k in range(M):
                    for i in range(lo, hi):
                        cp[k * n + i] = xp[k * n + i] - mp[i]
            parallelize[centre](WORKERS, WORKERS)
            # cov (lower triangle) = c^T c / (M - 1): row-major 101, lower 122, transpose 112
            external_call["scipy_cblas_dsyrk64_", NoneType](
                Int32(101), Int32(122), Int32(112), Int64(n), Int64(M),
                1.0 / Float64(M - 1), cp, Int64(n), Float64(0.0), cov.unsafe_ptr(), Int64(n))
            # sw = cov w
            external_call["scipy_cblas_dsymv64_", NoneType](
                Int32(101), Int32(122), Int64(n), Float64(1.0), cov.unsafe_ptr(), Int64(n),
                wv.unsafe_ptr(), Int64(1), Float64(0.0), sw.unsafe_ptr(), Int64(1))
            var w = 1.0 / Float64(n)
            var var2: Float64 = 0.0
            for i in range(n):
                var2 += w * sw[i]
            var sigma = sqrt(var2)
            v = 2.3263478740408408 * sigma
            comp_sum = 0.0
            for i in range(n):
                comp_sum += 2.3263478740408408 * w * sw[i] / sigma
            var d = perf_counter_ns() - t0
            spent += d
            if r == 0 or d < best:
                best = d
            r += 1
        print("KEY mojo_blas var n", n, "ms", Float64(best) / 1.0e6, "var99", v, "component_sum", comp_sum)
