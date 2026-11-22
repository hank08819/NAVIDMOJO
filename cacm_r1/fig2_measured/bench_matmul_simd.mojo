# Matrix multiply, same i-k-j algorithm, inner loop written with explicit SIMD
# vectors (the idiom of Listing 1). Build: mojo build (Mojo 1.0.0b1)
from collections import List
from time import perf_counter_ns


def rnd(mut st: UInt64) -> Float64:
    st = st * 6364136223846793005 + 1442695040888963407
    return Float64(st >> 11) * (1.0 / 9007199254740992.0)


def matmul_simd[W: Int](a: List[Float64], b: List[Float64], mut c: List[Float64], n: Int):
    var ap = a.unsafe_ptr()
    var bp = b.unsafe_ptr()
    var cp = c.unsafe_ptr()
    for i in range(n):
        for k in range(n):
            var x = SIMD[DType.float64, W](ap[i * n + k])
            var j = 0
            while j + W <= n:
                var v = (cp + i * n + j).load[width=W]() + x * (bp + k * n + j).load[width=W]()
                (cp + i * n + j).store(v)
                j += W
            while j < n:
                cp[i * n + j] += ap[i * n + k] * bp[k * n + j]
                j += 1


def run[W: Int](a: List[Float64], b: List[Float64], mut c: List[Float64], n: Int):
    var best: UInt = 0
    for t in range(5):
        for q in range(n * n):
            c[q] = 0.0
        var t0 = perf_counter_ns()
        matmul_simd[W](a, b, c, n)
        var d = perf_counter_ns() - t0
        if t == 0 or d < best:
            best = d
    var s: Float64 = 0.0
    for q in range(n * n):
        s += c[q]
    print("KEY matmul_simd width", W, "ms", Float64(best) / 1.0e6, "checksum", s)


def main():
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
    run[2](a, b, c, n)
    run[4](a, b, c, n)
    run[8](a, b, c, n)
    run[16](a, b, c, n)
