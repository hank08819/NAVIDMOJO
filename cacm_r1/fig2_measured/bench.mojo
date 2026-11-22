# Three kernels, single thread. Build: mojo build bench.mojo (Mojo 1.0.0b1)
from collections import List
from time import perf_counter_ns
from sys import argv


def rnd(mut st: UInt64) -> Float64:
    st = st * 6364136223846793005 + 1442695040888963407
    return Float64(st >> 11) * (1.0 / 9007199254740992.0)


def matmul(a: List[Float64], b: List[Float64], mut c: List[Float64], n: Int):
    var ap = a.unsafe_ptr()
    var bp = b.unsafe_ptr()
    var cp = c.unsafe_ptr()
    for i in range(n):
        for k in range(n):
            var x = ap[i * n + k]
            for j in range(n):
                cp[i * n + j] += x * bp[k * n + j]


def qsort_it(mut arr: List[Float64]):
    var a = arr.unsafe_ptr()
    var n = len(arr)
    var stack = List[Int]()
    stack.append(0)
    stack.append(n - 1)
    while len(stack) > 0:
        var hi = stack.pop()
        var lo = stack.pop()
        while hi - lo > 16:
            var mid = lo + (hi - lo) // 2
            var x = a[lo]
            var y = a[mid]
            var z = a[hi]
            var p: Float64 = 0.0
            if x < y:
                if y < z:
                    p = y
                elif x < z:
                    p = z
                else:
                    p = x
            else:
                if x < z:
                    p = x
                elif y < z:
                    p = z
                else:
                    p = y
            var i = lo
            var j = hi
            while i <= j:
                while a[i] < p:
                    i += 1
                while a[j] > p:
                    j -= 1
                if i <= j:
                    var t = a[i]
                    a[i] = a[j]
                    a[j] = t
                    i += 1
                    j -= 1
            if j - lo < hi - i:
                stack.append(i)
                stack.append(hi)
                hi = j
            else:
                stack.append(lo)
                stack.append(j)
                lo = i
        var i = lo + 1
        while i <= hi:
            var v = a[i]
            var j = i - 1
            while j >= lo and a[j] > v:
                a[j + 1] = a[j]
                j -= 1
            a[j + 1] = v
            i += 1


def main() raises:
    var args = argv()
    # ---- matmul
    var n = 512
    var st: UInt64 = 1
    var a = List[Float64]()
    var b = List[Float64]()
    var c = List[Float64]()
    for _ in range(n * n):
        a.append(rnd(st))
    for _ in range(n * n):
        b.append(rnd(st))
    for _ in range(n * n):
        c.append(0.0)
    var best: UInt = 0
    for t in range(5):
        for q in range(n * n):
            c[q] = 0.0
        var t0 = perf_counter_ns()
        matmul(a, b, c, n)
        var d = perf_counter_ns() - t0
        if t == 0 or d < best:
            best = d
    var s: Float64 = 0.0
    for q in range(n * n):
        s += c[q]
    print("KEY matmul ms", Float64(best) / 1.0e6, "checksum", s)

    # ---- sort
    var m = 2000000
    st = 7
    var x = List[Float64]()
    var w = List[Float64]()
    for _ in range(m):
        x.append(rnd(st))
        w.append(0.0)
    for t in range(5):
        for q in range(m):
            w[q] = x[q]
        var t0 = perf_counter_ns()
        qsort_it(w)
        var d = perf_counter_ns() - t0
        if t == 0 or d < best:
            best = d
    var bad = 0
    for q in range(1, m):
        if w[q - 1] > w[q]:
            bad += 1
    print("KEY sort ms", Float64(best) / 1.0e6, "unsorted", bad, "median", w[m // 2])

    # ---- parse
    var text = open(args[1], "r").read()
    var sp = text.unsafe_ptr()
    var len_s = text.byte_length()
    var p10 = List[Float64]()
    var pw: Float64 = 1.0
    for _ in range(10):
        p10.append(pw)
        pw *= 10.0
    var pp = p10.unsafe_ptr()
    var sts: Int = 0
    var ssym: Int = 0
    var sq: Int = 0
    var rec: Int = 0
    var spx: Float64 = 0.0
    for t in range(5):
        sts = 0
        ssym = 0
        sq = 0
        rec = 0
        spx = 0.0
        var t0 = perf_counter_ns()
        var i = 0
        while i < len_s:
            while sp[i] != 58:
                i += 1
            i += 1
            var ts: Int = 0
            while sp[i] >= 48 and sp[i] <= 57:
                ts = ts * 10 + Int(sp[i] - 48)
                i += 1
            while sp[i] != 58:
                i += 1
            i += 2
            var h: Int = 0
            while sp[i] != 34:
                h += Int(sp[i])
                i += 1
            while sp[i] != 58:
                i += 1
            i += 1
            var mant: Int = 0
            while sp[i] >= 48 and sp[i] <= 57:
                mant = mant * 10 + Int(sp[i] - 48)
                i += 1
            var k = 0
            if sp[i] == 46:
                i += 1
                while sp[i] >= 48 and sp[i] <= 57:
                    mant = mant * 10 + Int(sp[i] - 48)
                    i += 1
                    k += 1
            while sp[i] != 58:
                i += 1
            i += 1
            var qty: Int = 0
            while sp[i] >= 48 and sp[i] <= 57:
                qty = qty * 10 + Int(sp[i] - 48)
                i += 1
            while sp[i] != 10:
                i += 1
            i += 1
            sts += ts
            ssym += h
            spx += Float64(mant) / pp[k]
            sq += qty
            rec += 1
        var d = perf_counter_ns() - t0
        if t == 0 or d < best:
            best = d
    print("KEY parse ms", Float64(best) / 1.0e6, "records", rec, "ts", sts, "sym", ssym, "qty", sq, "px", spx)
