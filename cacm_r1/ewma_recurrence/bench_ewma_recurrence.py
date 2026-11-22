"""
bench_ewma_recurrence.py

Python baselines for the true EWMA recurrence over a 10M-element tick stream:
    y[0] = x[0];  y[i] = alpha * x[i] + (1 - alpha) * y[i-1]

Baselines: pure Python loop (full size, no extrapolation), pandas ewm(adjust=False),
scipy.signal.lfilter, and a Numba-compiled loop. Same LCG-driven prices as the Mojo file.
"""
import json, platform, sys, time
import numpy as np
import pandas as pd
import scipy
from scipy.signal import lfilter
import numba

N = 10_000_000
ALPHA = 0.05
N_REPEATS = 5
MASK = (1 << 64) - 1


def make_prices(n):
    out = np.empty(n)
    state, p = 42, 100.0
    for i in range(n):
        state = (state * 6364136223846793005 + 1442695040888963407) & MASK
        p += ((state >> 11) * (1.0 / 9007199254740992.0) - 0.5) * 0.1
        out[i] = p
    return out


def ewma_py(prices, alpha):
    inv = 1.0 - alpha
    out = [0.0] * len(prices)
    prev = prices[0]
    out[0] = prev
    for i in range(1, len(prices)):
        prev = alpha * prices[i] + inv * prev
        out[i] = prev
    return out


@numba.njit(cache=False)
def ewma_numba(prices, alpha, out):
    inv = 1.0 - alpha
    prev = prices[0]
    out[0] = prev
    for i in range(1, prices.shape[0]):
        prev = alpha * prices[i] + inv * prev
        out[i] = prev


def ewma_pandas(series, alpha):
    return series.ewm(alpha=alpha, adjust=False).mean().to_numpy()


def ewma_scipy(prices, alpha):
    b, a = [alpha], [1.0, -(1.0 - alpha)]
    y, _ = lfilter(b, a, prices, zi=[(1.0 - alpha) * prices[0]])
    return y


def best_of(fn, repeats=N_REPEATS):
    best, res = None, None
    for _ in range(repeats):
        t0 = time.perf_counter_ns()
        res = fn()
        dt = time.perf_counter_ns() - t0
        best = dt if best is None or dt < best else best
    return best, res


def main():
    x = make_prices(N)
    x_list = x.tolist()
    series = pd.Series(x)
    r = {"n_elements": N, "alpha": ALPHA, "n_repeats": N_REPEATS, "price_last": float(x[-1])}

    t, y = best_of(lambda: ewma_py(x_list, ALPHA))
    ref = np.asarray(y)
    r["pure_python_best_ns"] = t
    r["pure_python_last_value"] = ref[-1].item()
    cs = 0.0
    for v in y:
        cs += v
    r["pure_python_checksum"] = cs

    out = np.empty(N)
    ewma_numba(x, ALPHA, out)  # compile
    t, _ = best_of(lambda: ewma_numba(x, ALPHA, out))
    r["numba_best_ns"] = t
    r["numba_max_abs_diff_vs_python"] = float(np.max(np.abs(out - ref)))

    t, y = best_of(lambda: ewma_pandas(series, ALPHA))
    r["pandas_ewm_best_ns"] = t
    r["pandas_max_abs_diff_vs_python"] = float(np.max(np.abs(y - ref)))

    t, y = best_of(lambda: ewma_scipy(x, ALPHA))
    r["scipy_lfilter_best_ns"] = t
    r["scipy_max_abs_diff_vs_python"] = float(np.max(np.abs(y - ref)))

    r["versions"] = {"python": sys.version.split()[0], "numpy": np.__version__, "pandas": pd.__version__,
                     "scipy": scipy.__version__, "numba": numba.__version__, "platform": platform.platform()}
    for k, v in r.items():
        if k != "versions":
            print(f"PY_KEY {k} {v!r}")
    json.dump(r, open(sys.argv[1], "w"), indent=2)


if __name__ == "__main__":
    main()
