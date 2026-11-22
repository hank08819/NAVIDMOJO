# =============================================================
# bench_ewma_blocked.mojo
#
# EWMA recurrence  y[i] = alpha*x[i] + (1-alpha)*y[i-1]
# rewritten in blocks of K. Inside a block,
#     q[j] = alpha*x[i+j] + c*q[j-1]        (q[-1] = 0, does not use y)
#     y[i+j] = c^(j+1) * y[i-1] + q[j]
# so the only value carried from block to block is y[i+K-1]:
# one multiply-add per K elements instead of one per element.
# Same mathematical result as the sequential loop; rounding differs.
# =============================================================

from collections import List
from time import perf_counter_ns

alias N_REPEATS = 5


def ewma_sequential(prices: List[Float64], alpha: Float64, mut ema: List[Float64]):
    var c = 1.0 - alpha
    var x = prices.unsafe_ptr()
    var y = ema.unsafe_ptr()
    var n = len(prices)
    var prev = x[0]
    y[0] = prev
    var i = 1
    while i < n:
        prev = alpha * x[i] + c * prev
        y[i] = prev
        i += 1


def ewma_blocked[K: Int](prices: List[Float64], alpha: Float64, mut ema: List[Float64]):
    var c = 1.0 - alpha
    var x = prices.unsafe_ptr()
    var y = ema.unsafe_ptr()
    var n = len(prices)
    var prev = x[0]
    y[0] = prev
    var i = 1
    while i + K <= n:
        var q: Float64 = 0.0
        var pw: Float64 = 1.0
        for j in range(K):
            q = alpha * x[i + j] + c * q
            pw = pw * c
            y[i + j] = pw * prev + q
        prev = y[i + K - 1]
        i += K
    while i < n:
        prev = alpha * x[i] + c * prev
        y[i] = prev
        i += 1


def time_blocked[K: Int](prices: List[Float64], alpha: Float64, mut ema: List[Float64], ref_: List[Float64]):
    ewma_blocked[K](prices, alpha, ema)
    var best: UInt = 0
    for trial in range(N_REPEATS):
        var t0 = perf_counter_ns()
        ewma_blocked[K](prices, alpha, ema)
        var t1 = perf_counter_ns()
        if trial == 0 or t1 - t0 < best:
            best = t1 - t0
    var maxdiff: Float64 = 0.0
    for i in range(len(ema)):
        var d = ema[i] - ref_[i]
        if d < 0.0:
            d = -d
        if d > maxdiff:
            maxdiff = d
    print("MOJO_KEY blocked K", K, "best_ns", best, "last_value", ema[len(ema) - 1], "max_abs_diff_vs_sequential", maxdiff)


def main():
    var n = 10_000_000
    var alpha: Float64 = 0.05
    var prices = List[Float64]()
    var ema = List[Float64]()
    var ref_ = List[Float64]()
    var state: UInt64 = 42
    var p: Float64 = 100.0
    for _ in range(n):
        state = state * 6364136223846793005 + 1442695040888963407
        var u = Float64(state >> 11) * (1.0 / 9007199254740992.0)
        p += (u - 0.5) * 0.1
        prices.append(p)
        ema.append(0.0)
        ref_.append(0.0)

    ewma_sequential(prices, alpha, ref_)
    var best: UInt = 0
    for trial in range(N_REPEATS):
        var t0 = perf_counter_ns()
        ewma_sequential(prices, alpha, ref_)
        var t1 = perf_counter_ns()
        if trial == 0 or t1 - t0 < best:
            best = t1 - t0
    print("MOJO_KEY sequential best_ns", best, "last_value", ref_[n - 1])

    time_blocked[2](prices, alpha, ema, ref_)
    time_blocked[4](prices, alpha, ema, ref_)
    time_blocked[8](prices, alpha, ema, ref_)
    time_blocked[16](prices, alpha, ema, ref_)
    time_blocked[32](prices, alpha, ema, ref_)
