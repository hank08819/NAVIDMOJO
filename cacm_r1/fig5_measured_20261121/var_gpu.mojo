# Fig. 5(d), GPU: portfolio VaR with risk decomposition, 10,000 scenarios, n assets.
# Same inputs and same formulae as var.mojo. Build: mojo build var_gpu.mojo -Xlinker -lm
# (Mojo 1.0.0b1). The covariance matrix is computed on the GPU: one thread computes a
# 4 x 4 tile of entries and keeps its 16 partial sums in registers. The scenario
# returns are stored scenario by scenario, so neighbouring threads read neighbouring
# memory. The product of the covariance with the weights is also computed on the GPU.
# Timed: centring on the host, copy to the device, the two kernels, copy of n numbers
# back, and the final VaR. n must be a multiple of 4.
# Run: ./var_gpu.mojo.bin 100 500 1000 2000 5000
from gpu import thread_idx, block_idx, block_dim
from gpu.host import DeviceContext
from collections import List
from algorithm import parallelize
from math import sqrt
from time import perf_counter_ns
from sys import argv

comptime WORKERS = 16
comptime M = 10000
comptime TS = 4
comptime BLOCK = 128
comptime PTR = UnsafePointer[Float64, MutAnyOrigin]


def cov_kernel(c: PTR, cov: PTR, n: Int):
    var nt = n // TS
    var tid = block_idx.x * block_dim.x + thread_idx.x
    if tid >= nt * nt:
        return
    var ti = tid // nt
    var tj = tid % nt
    if tj > ti:
        return
    var i0 = ti * TS
    var j0 = tj * TS
    var s00: Float64 = 0.0
    var s01: Float64 = 0.0
    var s02: Float64 = 0.0
    var s03: Float64 = 0.0
    var s10: Float64 = 0.0
    var s11: Float64 = 0.0
    var s12: Float64 = 0.0
    var s13: Float64 = 0.0
    var s20: Float64 = 0.0
    var s21: Float64 = 0.0
    var s22: Float64 = 0.0
    var s23: Float64 = 0.0
    var s30: Float64 = 0.0
    var s31: Float64 = 0.0
    var s32: Float64 = 0.0
    var s33: Float64 = 0.0
    var base = 0
    for _ in range(M):
        var a0 = c[base + i0 + 0]
        var a1 = c[base + i0 + 1]
        var a2 = c[base + i0 + 2]
        var a3 = c[base + i0 + 3]
        var b0 = c[base + j0 + 0]
        var b1 = c[base + j0 + 1]
        var b2 = c[base + j0 + 2]
        var b3 = c[base + j0 + 3]
        s00 += a0 * b0
        s01 += a0 * b1
        s02 += a0 * b2
        s03 += a0 * b3
        s10 += a1 * b0
        s11 += a1 * b1
        s12 += a1 * b2
        s13 += a1 * b3
        s20 += a2 * b0
        s21 += a2 * b1
        s22 += a2 * b2
        s23 += a2 * b3
        s30 += a3 * b0
        s31 += a3 * b1
        s32 += a3 * b2
        s33 += a3 * b3
        base += n
    cov[(i0 + 0) * n + j0 + 0] = s00 / Float64(M - 1)
    cov[(j0 + 0) * n + i0 + 0] = s00 / Float64(M - 1)
    cov[(i0 + 0) * n + j0 + 1] = s01 / Float64(M - 1)
    cov[(j0 + 1) * n + i0 + 0] = s01 / Float64(M - 1)
    cov[(i0 + 0) * n + j0 + 2] = s02 / Float64(M - 1)
    cov[(j0 + 2) * n + i0 + 0] = s02 / Float64(M - 1)
    cov[(i0 + 0) * n + j0 + 3] = s03 / Float64(M - 1)
    cov[(j0 + 3) * n + i0 + 0] = s03 / Float64(M - 1)
    cov[(i0 + 1) * n + j0 + 0] = s10 / Float64(M - 1)
    cov[(j0 + 0) * n + i0 + 1] = s10 / Float64(M - 1)
    cov[(i0 + 1) * n + j0 + 1] = s11 / Float64(M - 1)
    cov[(j0 + 1) * n + i0 + 1] = s11 / Float64(M - 1)
    cov[(i0 + 1) * n + j0 + 2] = s12 / Float64(M - 1)
    cov[(j0 + 2) * n + i0 + 1] = s12 / Float64(M - 1)
    cov[(i0 + 1) * n + j0 + 3] = s13 / Float64(M - 1)
    cov[(j0 + 3) * n + i0 + 1] = s13 / Float64(M - 1)
    cov[(i0 + 2) * n + j0 + 0] = s20 / Float64(M - 1)
    cov[(j0 + 0) * n + i0 + 2] = s20 / Float64(M - 1)
    cov[(i0 + 2) * n + j0 + 1] = s21 / Float64(M - 1)
    cov[(j0 + 1) * n + i0 + 2] = s21 / Float64(M - 1)
    cov[(i0 + 2) * n + j0 + 2] = s22 / Float64(M - 1)
    cov[(j0 + 2) * n + i0 + 2] = s22 / Float64(M - 1)
    cov[(i0 + 2) * n + j0 + 3] = s23 / Float64(M - 1)
    cov[(j0 + 3) * n + i0 + 2] = s23 / Float64(M - 1)
    cov[(i0 + 3) * n + j0 + 0] = s30 / Float64(M - 1)
    cov[(j0 + 0) * n + i0 + 3] = s30 / Float64(M - 1)
    cov[(i0 + 3) * n + j0 + 1] = s31 / Float64(M - 1)
    cov[(j0 + 1) * n + i0 + 3] = s31 / Float64(M - 1)
    cov[(i0 + 3) * n + j0 + 2] = s32 / Float64(M - 1)
    cov[(j0 + 2) * n + i0 + 3] = s32 / Float64(M - 1)
    cov[(i0 + 3) * n + j0 + 3] = s33 / Float64(M - 1)
    cov[(j0 + 3) * n + i0 + 3] = s33 / Float64(M - 1)


def sw_kernel(cov: PTR, sw: PTR, n: Int):
    var i = block_idx.x * block_dim.x + thread_idx.x
    if i >= n:
        return
    var w = 1.0 / Float64(n)
    var s: Float64 = 0.0
    for j in range(n):
        s += cov[i * n + j] * w
    sw[i] = s


def main() raises:
    var ctx = DeviceContext(device_id=0)
    var args = argv()
    for si in range(1, len(args)):
        var n = Int(args[si])
        # returns, scenario-major: scenario k occupies x[k*n .. k*n+n)
        var x = List[Float64]()
        for _ in range(n * M):
            x.append(0.0)
        for i in range(n):
            var st = UInt64(i + 1) * 0x9E3779B97F4A7C15
            var fs: UInt64 = 0x243F6A8885A308D3
            for k in range(M):
                st = st * 6364136223846793005 + 1442695040888963407
                fs = fs * 6364136223846793005 + 1442695040888963407
                var u = Float64(st >> 11) * (1.0 / 9007199254740992.0)
                var f = Float64(fs >> 11) * (1.0 / 9007199254740992.0)
                x[k * n + i] = 0.02 * (f - 0.5) + 0.04 * (u - 0.5)
        var xp = x.unsafe_ptr()
        var mean = List[Float64]()
        for _ in range(n):
            mean.append(0.0)
        var mp = mean.unsafe_ptr()
        # buffers are created once, before the timed region
        var h_c = ctx.enqueue_create_host_buffer[DType.float64](n * M)
        var d_c = ctx.enqueue_create_buffer[DType.float64](n * M)
        var d_cov = ctx.enqueue_create_buffer[DType.float64](n * n)
        var d_sw = ctx.enqueue_create_buffer[DType.float64](n)
        var h_sw = ctx.enqueue_create_host_buffer[DType.float64](n)
        ctx.synchronize()
        var cp = h_c.unsafe_ptr()
        var nt = n // TS
        var chunk = (n + WORKERS - 1) // WORKERS
        var best: UInt = 0
        var v: Float64 = 0.0
        var comp_sum: Float64 = 0.0
        # repeat at least 7 times and until 0.3 s have been spent on this size (at most 2,000 times)
        var r = 0
        var spent: UInt = 0
        while r < 8 or (spent < 300000000 and r < 2000):
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
            ctx.enqueue_copy(dst_buf=d_c, src_buf=h_c)
            ctx.enqueue_function[cov_kernel, cov_kernel](d_c, d_cov, n,
                grid_dim=(nt * nt + BLOCK - 1) // BLOCK, block_dim=BLOCK)
            ctx.enqueue_function[sw_kernel, sw_kernel](d_cov, d_sw, n,
                grid_dim=(n + BLOCK - 1) // BLOCK, block_dim=BLOCK)
            ctx.enqueue_copy(dst_buf=h_sw, src_buf=d_sw)
            ctx.synchronize()
            var w = 1.0 / Float64(n)
            var var2: Float64 = 0.0
            for i in range(n):
                var2 += w * h_sw[i]
            var sigma = sqrt(var2)
            v = 2.3263478740408408 * sigma
            comp_sum = 0.0
            for i in range(n):
                comp_sum += 2.3263478740408408 * w * h_sw[i] / sigma
            var d = perf_counter_ns() - t0
            # the first repetition includes kernel compilation and is not counted
            spent += d
            if r == 1 or (r > 1 and d < best):
                best = d
            r += 1
        print("KEY mojo_gpu var n", n, "ms", Float64(best) / 1.0e6, "var99", v, "component_sum", comp_sum)
