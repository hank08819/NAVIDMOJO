# Fig. 5(a): Monte Carlo European call, pure Python loop and NumPy vectorized.
# Same paths as mc.mojo / mc.cpp (64-bit LCG seeded by the path index).
import math, sys, time
import numpy as np
M = (1 << 64) - 1
A, B, G = 6364136223846793005, 1442695040888963407, 0x9E3779B97F4A7C15
INV = 1.0 / 9007199254740992.0

def price_python(n):
    total = 0.0
    sqrt, log, cos, exp = math.sqrt, math.log, math.cos, math.exp
    for i in range(n):
        st = ((i + 1) * G) & M
        st = (st * A + B) & M
        u1 = ((st >> 11) + 0.5) * INV
        st = (st * A + B) & M
        u2 = ((st >> 11) + 0.5) * INV
        z = sqrt(-2.0 * log(u1)) * cos(6.283185307179586 * u2)
        p = 100.0 * exp((0.05 - 0.5 * 0.2 * 0.2) * 1.0 + 0.2 * z) - 100.0
        if p > 0.0:
            total += p
    return math.exp(-0.05) * total / n

def price_numpy(n):
    with np.errstate(over="ignore"):
        st = (np.arange(1, n + 1, dtype=np.uint64)) * np.uint64(G)
        st = st * np.uint64(A) + np.uint64(B)
        u1 = ((st >> np.uint64(11)).astype(np.float64) + 0.5) * INV
        st = st * np.uint64(A) + np.uint64(B)
        u2 = ((st >> np.uint64(11)).astype(np.float64) + 0.5) * INV
    z = np.sqrt(-2.0 * np.log(u1)) * np.cos(6.283185307179586 * u2)
    p = 100.0 * np.exp((0.05 - 0.5 * 0.2 * 0.2) * 1.0 + 0.2 * z) - 100.0
    return math.exp(-0.05) * float(np.maximum(p, 0.0).sum()) / n

which = sys.argv[1]
for n in [1000, 10000, 100000, 1000000, 10000000, 100000000]:
    if which == "python":
        if n > 10000000:
            continue
        reps = 3 if n <= 1000000 else 1
        f = price_python
    else:
        reps = 7 if n <= 10000000 else 3
        f = price_numpy
    best = 1e30
    for _ in range(reps):
        t0 = time.perf_counter(); pr = f(n); d = (time.perf_counter() - t0) * 1e3
        best = min(best, d)
    print("KEY", which, "mc n", n, "ms", best, "price", repr(pr), flush=True)
