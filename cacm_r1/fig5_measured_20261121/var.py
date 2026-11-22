# Fig. 5(d): portfolio VaR with risk decomposition, pure Python and NumPy (BLAS).
# Same inputs as var.mojo.
import math, sys, time
import numpy as np
M = 10000
A, B, G = 6364136223846793005, 1442695040888963407, 0x9E3779B97F4A7C15
Z = 2.3263478740408408

def gen(n):
    x = np.empty((M, n))
    with np.errstate(over="ignore"):
        st = np.arange(1, n + 1, dtype=np.uint64) * np.uint64(G)
        fs = np.uint64(0x243F6A8885A308D3)
        for k in range(M):
            st = st * np.uint64(A) + np.uint64(B)
            fs = fs * np.uint64(A) + np.uint64(B)
            u = (st >> np.uint64(11)).astype(np.float64) * (1.0 / 9007199254740992.0)
            f = float(fs >> np.uint64(11)) * (1.0 / 9007199254740992.0)
            x[k] = 0.02 * (f - 0.5) + 0.04 * (u - 0.5)
    return x

def var_numpy(x):
    n = x.shape[1]
    c = x - x.mean(axis=0)
    cov = (c.T @ c) / (M - 1)
    w = np.full(n, 1.0 / n)
    sw = cov @ w
    sigma = math.sqrt(float(w @ sw))
    return Z * sigma, float((Z * w * sw / sigma).sum())

def var_python(cols):
    n = len(cols)
    cen = []
    for col in cols:
        mu = sum(col) / M
        cen.append([v - mu for v in col])
    cov = [[0.0] * n for _ in range(n)]
    for i in range(n):
        ci = cen[i]
        for j in range(i + 1):
            cj = cen[j]
            s = 0.0
            for a, b in zip(ci, cj):
                s += a * b
            s /= (M - 1)
            cov[i][j] = s
            cov[j][i] = s
    w = 1.0 / n
    sw = [sum(v * w for v in row) for row in cov]
    sigma = math.sqrt(sum(w * s for s in sw))
    return Z * sigma, sum(Z * w * s / sigma for s in sw)

which = sys.argv[1]
sizes = [int(a) for a in sys.argv[2:]] or [100, 500, 1000, 2000, 5000]
for n in sizes:
    x = gen(n)
    if which == "python":
        cols = x.T.tolist(); min_reps = 1
        f = lambda: var_python(cols)
    else:
        min_reps = 7
        f = lambda: var_numpy(x)
    # at least min_reps runs, and until 0.3 s have been spent on this size (at most 2,000)
    best = 1e30; spent = 0.0; k = 0
    while k < min_reps or (spent < 300.0 and k < 2000):
        t0 = time.perf_counter(); r = f(); d = (time.perf_counter() - t0) * 1e3
        best = min(best, d); spent += d; k += 1
    print("KEY", which, "var n", n, "ms", best, "var99", repr(r[0]), "component_sum", repr(r[1]), flush=True)
