# Same three kernels in pure Python (interpreter loops, full size, best of 3),
# and the usual Python library call for each (best of 5).
import sys, time, json
import numpy as np
M = (1 << 64) - 1
st = 0
def rnd():
    global st
    st = (st * 6364136223846793005 + 1442695040888963407) & M
    return (st >> 11) * (1.0 / 9007199254740992.0)

def matmul(a, b, c, n):
    for i in range(n):
        ci = i * n
        for k in range(n):
            x = a[ci + k]; kn = k * n
            for j in range(n):
                c[ci + j] += x * b[kn + j]

def qsort_it(a):
    stack = [0, len(a) - 1]
    while stack:
        hi = stack.pop(); lo = stack.pop()
        while hi - lo > 16:
            mid = lo + (hi - lo) // 2
            x = a[lo]; y = a[mid]; z = a[hi]
            if x < y:
                p = y if y < z else (z if x < z else x)
            else:
                p = x if x < z else (z if y < z else y)
            i = lo; j = hi
            while i <= j:
                while a[i] < p: i += 1
                while a[j] > p: j -= 1
                if i <= j:
                    a[i], a[j] = a[j], a[i]; i += 1; j -= 1
            if j - lo < hi - i:
                stack.append(i); stack.append(hi); hi = j
            else:
                stack.append(lo); stack.append(j); lo = i
        i = lo + 1
        while i <= hi:
            v = a[i]; j = i - 1
            while j >= lo and a[j] > v:
                a[j + 1] = a[j]; j -= 1
            a[j + 1] = v; i += 1

P10 = [10.0 ** k for k in range(10)]
def parse(s):
    n = len(s); i = 0
    sts = ssym = sq = rec = 0; spx = 0.0
    while i < n:
        while s[i] != 58: i += 1
        i += 1
        ts = 0
        while 48 <= s[i] <= 57: ts = ts * 10 + s[i] - 48; i += 1
        while s[i] != 58: i += 1
        i += 2
        h = 0
        while s[i] != 34: h += s[i]; i += 1
        while s[i] != 58: i += 1
        i += 1
        m = 0
        while 48 <= s[i] <= 57: m = m * 10 + s[i] - 48; i += 1
        k = 0
        if s[i] == 46:
            i += 1
            while 48 <= s[i] <= 57: m = m * 10 + s[i] - 48; i += 1; k += 1
        while s[i] != 58: i += 1
        i += 1
        q = 0
        while 48 <= s[i] <= 57: q = q * 10 + s[i] - 48; i += 1
        while s[i] != 10: i += 1
        i += 1
        sts += ts; ssym += h; spx += m / P10[k]; sq += q; rec += 1
    return rec, sts, ssym, sq, spx

def best_of(reps, setup, fn):
    best = 1e30; out = None
    for _ in range(reps):
        arg = setup(); t0 = time.perf_counter(); out = fn(arg); d = (time.perf_counter() - t0) * 1e3
        best = min(best, d)
    return best, out, arg

n = 512; st = 1
a = [rnd() for _ in range(n * n)]; b = [rnd() for _ in range(n * n)]
t, _, c = best_of(3, lambda: [0.0] * (n * n), lambda c: matmul(a, b, c, n))
print("KEY pure matmul ms %.3f checksum %.6f" % (t, sum(c)), flush=True)
A = np.array(a).reshape(n, n); B = np.array(b).reshape(n, n)
t, C, _ = best_of(5, lambda: None, lambda _: A @ B)
print("KEY numpy matmul ms %.3f checksum %.6f" % (t, C.sum()), flush=True)

m = 2000000; st = 7
x = [rnd() for _ in range(m)]
t, _, w = best_of(3, lambda: list(x), qsort_it)
print("KEY pure sort ms %.3f unsorted %d median %r" % (t, sum(1 for i in range(1, m) if w[i - 1] > w[i]), w[m // 2]), flush=True)
X = np.array(x)
t, W, _ = best_of(5, lambda: None, lambda _: np.sort(X))
print("KEY numpy sort ms %.3f median %r" % (t, float(W[m // 2])), flush=True)

s = open(sys.argv[1], "rb").read()
t, r, _ = best_of(3, lambda: s, parse)
print("KEY pure parse ms %.3f records %d ts %d sym %d qty %d px %.6f" % ((t,) + r), flush=True)
def lib(s):
    sts = sq = 0; spx = 0.0; rec = 0
    for line in s.splitlines():
        d = json.loads(line); sts += d["ts"]; spx += d["px"]; sq += d["qty"]; rec += 1
    return rec, sts, sq, spx
t, r, _ = best_of(5, lambda: s, lib)
print("KEY json.loads parse ms %.3f records %d ts %d qty %d px %.6f" % ((t,) + r), flush=True)
