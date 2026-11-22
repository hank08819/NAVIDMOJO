# =============================================================
# bench_ewma_recurrence.mojo
#
# True time-series EWMA over a 10M-element tick stream:
#     y[0] = x[0];  y[i] = alpha * x[i] + (1 - alpha) * y[i-1]
# Each output depends on the previous output, so the loop is
# sequential. The old elementwise kernel is timed next to it
# for reference.
#
# Input: a random walk driven by a 64-bit LCG, so the Python
# baselines generate bit-identical prices.
# =============================================================

from collections import List
from sys import simd_bit_width
from time import perf_counter_ns


alias W = simd_bit_width() // 64
alias N_REPEATS = 5


def ewma_recurrence(prices: List[Float64], alpha: Float64, mut ema: List[Float64]):
    """True EWMA recurrence, plain indexing."""
    var inv_alpha = 1.0 - alpha
    ema[0] = prices[0]
    for i in range(1, len(prices)):
        ema[i] = alpha * prices[i] + inv_alpha * ema[i - 1]


def ewma_recurrence_ptr(prices: List[Float64], alpha: Float64, mut ema: List[Float64]):
    """True EWMA recurrence, previous value kept in a local."""
    var inv_alpha = 1.0 - alpha
    var x = prices.unsafe_ptr()
    var y = ema.unsafe_ptr()
    var n = len(prices)
    var prev = x[0]
    y[0] = prev
    var i = 1
    while i < n:
        prev = alpha * x[i] + inv_alpha * prev
        y[i] = prev
        i += 1


def elementwise_blend(prices: List[Float64], alpha: Float64, mut ema: List[Float64]):
    """The kernel of the submitted Table 1 row: ema[i] uses ema[i], not ema[i-1]."""
    var inv_alpha = 1.0 - alpha
    var x = prices.unsafe_ptr()
    var y = ema.unsafe_ptr()
    var n = len(prices)
    var i = 0
    while i + W <= n:
        y.store(i, alpha * x.load[width=W](i) + inv_alpha * y.load[width=W](i))
        i += W
    while i < n:
        ema[i] = alpha * prices[i] + inv_alpha * ema[i]
        i += 1


def checksum(ema: List[Float64]) -> Float64:
    var s: Float64 = 0.0
    for i in range(len(ema)):
        s += ema[i]
    return s


def main():
    var n = 10_000_000
    var alpha: Float64 = 0.05

    var prices = List[Float64]()
    var ema = List[Float64]()
    var state: UInt64 = 42
    var p: Float64 = 100.0
    for _ in range(n):
        state = state * 6364136223846793005 + 1442695040888963407
        var u = Float64(state >> 11) * (1.0 / 9007199254740992.0)
        p += (u - 0.5) * 0.1
        prices.append(p)
        ema.append(0.0)

    print("MOJO_KEY n_elements", n)
    print("MOJO_KEY hardware_simd_width", W)
    print("MOJO_KEY n_repeats", N_REPEATS)
    print("MOJO_KEY price_last", prices[n - 1])

    ewma_recurrence(prices, alpha, ema)       # warmup
    var best: UInt = 0
    for trial in range(N_REPEATS):
        var t0 = perf_counter_ns()
        ewma_recurrence(prices, alpha, ema)
        var t1 = perf_counter_ns()
        if trial == 0 or t1 - t0 < best:
            best = t1 - t0
    print("MOJO_KEY recurrence_best_ns", best)
    print("MOJO_KEY recurrence_last_value", ema[n - 1])
    print("MOJO_KEY recurrence_checksum", checksum(ema))

    ewma_recurrence_ptr(prices, alpha, ema)   # warmup
    for trial in range(N_REPEATS):
        var t0 = perf_counter_ns()
        ewma_recurrence_ptr(prices, alpha, ema)
        var t1 = perf_counter_ns()
        if trial == 0 or t1 - t0 < best:
            best = t1 - t0
    print("MOJO_KEY recurrence_ptr_best_ns", best)
    print("MOJO_KEY recurrence_ptr_last_value", ema[n - 1])
    print("MOJO_KEY recurrence_ptr_checksum", checksum(ema))

    for i in range(n):
        ema[i] = prices[0]
    elementwise_blend(prices, alpha, ema)     # warmup
    for trial in range(N_REPEATS):
        for i in range(n):
            ema[i] = prices[0]
        var t0 = perf_counter_ns()
        elementwise_blend(prices, alpha, ema)
        var t1 = perf_counter_ns()
        if trial == 0 or t1 - t0 < best:
            best = t1 - t0
    print("MOJO_KEY elementwise_best_ns", best)
    print("MOJO_KEY elementwise_last_value", ema[n - 1])
