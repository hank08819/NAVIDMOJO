"""Same block-iterated EWMA as bench_ewma_blocked.mojo, compiled with Numba (K = 16)."""
import time, numpy as np, numba
N, ALPHA, K, MASK = 10_000_000, 0.05, 16, (1 << 64) - 1

def make_prices(n):
    out = np.empty(n); state, p = 42, 100.0
    for i in range(n):
        state = (state * 6364136223846793005 + 1442695040888963407) & MASK
        p += ((state >> 11) * (1.0 / 9007199254740992.0) - 0.5) * 0.1
        out[i] = p
    return out

@numba.njit
def seq(x, alpha, y):
    c = 1.0 - alpha; prev = x[0]; y[0] = prev
    for i in range(1, x.shape[0]):
        prev = alpha * x[i] + c * prev; y[i] = prev

@numba.njit
def blocked(x, alpha, y):
    c = 1.0 - alpha; n = x.shape[0]; prev = x[0]; y[0] = prev; i = 1
    while i + K <= n:
        q = 0.0; pw = 1.0
        for j in range(K):
            q = alpha * x[i + j] + c * q
            pw = pw * c
            y[i + j] = pw * prev + q
        prev = y[i + K - 1]; i += K
    while i < n:
        prev = alpha * x[i] + c * prev; y[i] = prev; i += 1

def best(fn):
    b = None
    for _ in range(5):
        t0 = time.perf_counter_ns(); fn(); dt = time.perf_counter_ns() - t0
        b = dt if b is None or dt < b else b
    return b

x = make_prices(N); ref = np.empty(N); y = np.empty(N)
seq(x, ALPHA, ref); blocked(x, ALPHA, y)
print("PY_KEY numba_sequential_best_ns", best(lambda: seq(x, ALPHA, ref)))
print("PY_KEY numba_blocked_K16_best_ns", best(lambda: blocked(x, ALPHA, y)))
print("PY_KEY numba_blocked_max_abs_diff_vs_sequential", float(np.max(np.abs(y - ref))))
