# Fig. 5(c): moving-average crossover backtest, pure Python loop and pandas vectorized.
# Same inputs as bt.mojo / bt.cpp.
import sys, time
import numpy as np
T = 2500
A, B, G = 6364136223846793005, 1442695040888963407, 0x9E3779B97F4A7C15

def gen(n_sym):
    px = np.empty((n_sym, T))
    with np.errstate(over="ignore"):
        st = np.arange(1, n_sym + 1, dtype=np.uint64) * np.uint64(G)
        p = np.full(n_sym, 100.0)
        for t in range(T):
            st = st * np.uint64(A) + np.uint64(B)
            u = (st >> np.uint64(11)).astype(np.float64) * (1.0 / 9007199254740992.0)
            p = p * (1.0 + 0.02 * (u - 0.5))
            px[:, t] = p
    return px

def one_symbol(p):
    fast = 0.0
    slow = 0.0
    for t in range(40, 50):
        fast += p[t]
    for t in range(0, 50):
        slow += p[t]
    prev = 0.0
    pnl = 0.0
    units = 0.0
    trades = 0
    for t in range(49, T - 1):
        s = 1.0 if fast * 5.0 > slow else -1.0
        if s != prev:
            units += abs(s - prev)
            trades += 1
        pnl += s * (p[t + 1] - p[t])
        prev = s
        fast += p[t + 1] - p[t - 9]
        slow += p[t + 1] - p[t - 49]
    return pnl - 0.01 * units, trades

def run_python(rows):
    total = 0.0; trades = 0
    for p in rows:
        a, b = one_symbol(p)
        total += a; trades += b
    return total, trades

def run_pandas(df):
    fast = df.rolling(10).sum().to_numpy()
    slow = df.rolling(50).sum().to_numpy()
    P = df.to_numpy()
    sig = np.where(fast[49:T - 1] * 5.0 > slow[49:T - 1], 1.0, -1.0)
    pnl = (sig * (P[50:T] - P[49:T - 1])).sum(axis=0)
    ch = np.abs(np.diff(sig, axis=0, prepend=0.0))
    pnl -= 0.01 * ch.sum(axis=0)
    return float(pnl.sum()), int(np.count_nonzero(ch))

which = sys.argv[1]
for n_sym in [4, 40, 400, 4000, 40000]:
    px = gen(n_sym)
    if which == "python":
        rows = px.tolist()
        min_reps = 1
        f = lambda: run_python(rows)
    else:
        import pandas as pd
        df = pd.DataFrame(px.T.copy())
        min_reps = 7
        f = lambda: run_pandas(df)
    # at least min_reps runs, and until 0.3 s have been spent on this size (at most 2,000)
    best = 1e30; spent = 0.0; k = 0
    while k < min_reps or (spent < 300.0 and k < 2000):
        t0 = time.perf_counter(); r = f(); d = (time.perf_counter() - t0) * 1e3
        best = min(best, d); spent += d; k += 1
    print("KEY", which, "bt bars", n_sym * T, "ms", best, "pnl", repr(r[0]), "trades", r[1], flush=True)
