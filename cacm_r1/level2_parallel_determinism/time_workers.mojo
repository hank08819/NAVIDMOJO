# Timing check: does `parallelize` with more workers actually run in parallel?
from collections import List
from algorithm import parallelize
from time import perf_counter_ns

def work(x: List[Float64], workers: Int) -> Float64:
    var xp = x.unsafe_ptr()
    var n = len(x)
    var acc = List[Float64]()
    for _ in range(64):
        acc.append(0.0)
    var ap = acc.unsafe_ptr()
    var size = n // 64
    @parameter
    def one(b: Int):
        var s: Float64 = 0.0
        for rep in range(20):
            var i = b * size
            while i < (b + 1) * size:
                s += xp[i] * 1.0000001
                i += 1
        ap[b] = s
    parallelize[one](64, workers)
    var t: Float64 = 0.0
    for b in range(64):
        t += acc[b]
    return t

def main():
    var x = List[Float64]()
    for i in range(6_400_000):
        x.append(Float64(i % 97) * 0.5)
    for w in [1, 2, 4, 8, 16]:
        var t0 = perf_counter_ns()
        var r = work(x, w)
        var t1 = perf_counter_ns()
        print("KEY workers", w, "ms", Float64(t1 - t0) / 1.0e6, "result", r)
