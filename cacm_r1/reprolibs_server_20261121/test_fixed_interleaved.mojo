# Fixed-order sum of Equation (4), two implementations that must return the same bits:
#
#   fixed_sum(T):        one block at a time (the implementation of test_partition_independence.mojo).
#   fixed_sum_group(T):  sixteen consecutive blocks side by side in one loop. Each block keeps its own
#                        Kahan sum and its own compensation, and reads its elements in index order,
#                        so every block sum is the same sequence of IEEE 754 operations as before.
#                        Only the order in which the processor works on different blocks changes.
#
# The block sums are combined by the same fixed pairwise tree in both.
# Checks: same bits as fixed_sum for 1 to 16 workers, 200 repeated runs, reversed input.
# Times: best of 7, for 1 and 16 workers, with the naive parallel sum for reference.
# Group sizes of 4, 8, 16 and 32 were timed (tune/); 16 was the fastest and is used here.
# Input: the 10,000,000 doubles of test_partition_independence.mojo.

from collections import List
from algorithm import parallelize
from time import perf_counter_ns

alias N_BLOCKS = 4096
alias GROUP = 16


def naive_sum(x: List[Float64], workers: Int) -> Float64:
    var n = len(x)
    var xp = x.unsafe_ptr()
    var partial = List[Float64]()
    for _ in range(workers):
        partial.append(0.0)
    var pp = partial.unsafe_ptr()
    var chunk = (n + workers - 1) // workers
    @parameter
    def one(w: Int):
        var lo = w * chunk
        var hi = lo + chunk
        if hi > n:
            hi = n
        var s: Float64 = 0.0
        var i = lo
        while i < hi:
            s += xp[i]
            i += 1
        pp[w] = s
    parallelize[one](workers, workers)
    var total: Float64 = 0.0
    for w in range(workers):
        total += partial[w]
    return total


def fixed_sum(x: List[Float64], workers: Int) -> Float64:
    var n = len(x)
    var xp = x.unsafe_ptr()
    var block = List[Float64]()
    for _ in range(N_BLOCKS):
        block.append(0.0)
    var bp = block.unsafe_ptr()
    var size = (n + N_BLOCKS - 1) // N_BLOCKS
    @parameter
    def one(b: Int):
        var lo = b * size
        var hi = lo + size
        if hi > n:
            hi = n
        var s: Float64 = 0.0
        var c: Float64 = 0.0
        var i = lo
        while i < hi:
            var y = xp[i] - c
            var t = s + y
            c = (t - s) - y
            s = t
            i += 1
        bp[b] = s
    parallelize[one](N_BLOCKS, workers)
    var m = N_BLOCKS
    while m > 1:
        var half = m // 2
        for k in range(half):
            block[k] = block[2 * k] + block[2 * k + 1]
        m = half
    return block[0]


def fixed_sum_group(x: List[Float64], workers: Int) -> Float64:
    var n = len(x)
    var xp = x.unsafe_ptr()
    var block = List[Float64]()
    for _ in range(N_BLOCKS):
        block.append(0.0)
    var bp = block.unsafe_ptr()
    var size = (n + N_BLOCKS - 1) // N_BLOCKS
    @parameter
    def one(g: Int):
        var b0 = g * GROUP
        if (b0 + GROUP) * size <= n:
            # sixteen full blocks, each with its own Kahan sum
            var p0 = b0 * size
            var p1 = p0 + size
            var p2 = p1 + size
            var p3 = p2 + size
            var p4 = p3 + size
            var p5 = p4 + size
            var p6 = p5 + size
            var p7 = p6 + size
            var p8 = p7 + size
            var p9 = p8 + size
            var p10 = p9 + size
            var p11 = p10 + size
            var p12 = p11 + size
            var p13 = p12 + size
            var p14 = p13 + size
            var p15 = p14 + size
            var s0: Float64 = 0.0
            var s1: Float64 = 0.0
            var s2: Float64 = 0.0
            var s3: Float64 = 0.0
            var s4: Float64 = 0.0
            var s5: Float64 = 0.0
            var s6: Float64 = 0.0
            var s7: Float64 = 0.0
            var s8: Float64 = 0.0
            var s9: Float64 = 0.0
            var s10: Float64 = 0.0
            var s11: Float64 = 0.0
            var s12: Float64 = 0.0
            var s13: Float64 = 0.0
            var s14: Float64 = 0.0
            var s15: Float64 = 0.0
            var c0: Float64 = 0.0
            var c1: Float64 = 0.0
            var c2: Float64 = 0.0
            var c3: Float64 = 0.0
            var c4: Float64 = 0.0
            var c5: Float64 = 0.0
            var c6: Float64 = 0.0
            var c7: Float64 = 0.0
            var c8: Float64 = 0.0
            var c9: Float64 = 0.0
            var c10: Float64 = 0.0
            var c11: Float64 = 0.0
            var c12: Float64 = 0.0
            var c13: Float64 = 0.0
            var c14: Float64 = 0.0
            var c15: Float64 = 0.0
            var i = 0
            while i < size:
                var y0 = xp[p0 + i] - c0
                var y1 = xp[p1 + i] - c1
                var y2 = xp[p2 + i] - c2
                var y3 = xp[p3 + i] - c3
                var y4 = xp[p4 + i] - c4
                var y5 = xp[p5 + i] - c5
                var y6 = xp[p6 + i] - c6
                var y7 = xp[p7 + i] - c7
                var y8 = xp[p8 + i] - c8
                var y9 = xp[p9 + i] - c9
                var y10 = xp[p10 + i] - c10
                var y11 = xp[p11 + i] - c11
                var y12 = xp[p12 + i] - c12
                var y13 = xp[p13 + i] - c13
                var y14 = xp[p14 + i] - c14
                var y15 = xp[p15 + i] - c15
                var t0 = s0 + y0
                var t1 = s1 + y1
                var t2 = s2 + y2
                var t3 = s3 + y3
                var t4 = s4 + y4
                var t5 = s5 + y5
                var t6 = s6 + y6
                var t7 = s7 + y7
                var t8 = s8 + y8
                var t9 = s9 + y9
                var t10 = s10 + y10
                var t11 = s11 + y11
                var t12 = s12 + y12
                var t13 = s13 + y13
                var t14 = s14 + y14
                var t15 = s15 + y15
                c0 = (t0 - s0) - y0
                c1 = (t1 - s1) - y1
                c2 = (t2 - s2) - y2
                c3 = (t3 - s3) - y3
                c4 = (t4 - s4) - y4
                c5 = (t5 - s5) - y5
                c6 = (t6 - s6) - y6
                c7 = (t7 - s7) - y7
                c8 = (t8 - s8) - y8
                c9 = (t9 - s9) - y9
                c10 = (t10 - s10) - y10
                c11 = (t11 - s11) - y11
                c12 = (t12 - s12) - y12
                c13 = (t13 - s13) - y13
                c14 = (t14 - s14) - y14
                c15 = (t15 - s15) - y15
                s0 = t0
                s1 = t1
                s2 = t2
                s3 = t3
                s4 = t4
                s5 = t5
                s6 = t6
                s7 = t7
                s8 = t8
                s9 = t9
                s10 = t10
                s11 = t11
                s12 = t12
                s13 = t13
                s14 = t14
                s15 = t15
                i += 1
            bp[b0] = s0
            bp[b0 + 1] = s1
            bp[b0 + 2] = s2
            bp[b0 + 3] = s3
            bp[b0 + 4] = s4
            bp[b0 + 5] = s5
            bp[b0 + 6] = s6
            bp[b0 + 7] = s7
            bp[b0 + 8] = s8
            bp[b0 + 9] = s9
            bp[b0 + 10] = s10
            bp[b0 + 11] = s11
            bp[b0 + 12] = s12
            bp[b0 + 13] = s13
            bp[b0 + 14] = s14
            bp[b0 + 15] = s15
        else:
            # a group that reaches the end of the input: one block at a time
            for b in range(b0, b0 + GROUP):
                var lo = b * size
                var hi = lo + size
                if hi > n:
                    hi = n
                var s: Float64 = 0.0
                var c: Float64 = 0.0
                var i = lo
                while i < hi:
                    var y = xp[i] - c
                    var t = s + y
                    c = (t - s) - y
                    s = t
                    i += 1
                bp[b] = s
    parallelize[one](N_BLOCKS // GROUP, workers)
    var m = N_BLOCKS
    while m > 1:
        var half = m // 2
        for k in range(half):
            block[k] = block[2 * k] + block[2 * k + 1]
        m = half
    return block[0]


def main():
    var n = 10_000_000
    var x = List[Float64]()
    var state: UInt64 = 2026
    for _ in range(n):
        state = state * 6364136223846793005 + 1442695040888963407
        var u = Float64(state >> 11) * (1.0 / 9007199254740992.0)
        state = state * 6364136223846793005 + 1442695040888963407
        var e = Int((state >> 33) % 13)
        var mag: Float64 = 1.0
        for _ in range(e):
            mag *= 10.0
        x.append((u - 0.5) * mag * 1.0e-6)
    var xr = List[Float64]()
    for i in range(n):
        xr.append(x[n - 1 - i])

    print("KEY n_elements", n, "n_blocks", N_BLOCKS, "group", GROUP)
    var want = fixed_sum(x, 1)
    var same_workers = 0
    for t in range(1, 17):
        var f = fixed_sum_group(x, t)
        print("KEY workers", t, "one_block_at_a_time", fixed_sum(x, t), "group", f)
        if f == want:
            same_workers += 1
    print("KEY group_same_bits_as_one_block_at_a_time", same_workers, "of 16")
    var rep = 0
    for _ in range(200):
        if fixed_sum_group(x, 16) == want:
            rep += 1
    print("KEY group_repeats_identical", rep, "of 200")
    var fr = fixed_sum(xr, 1)
    var gr = fixed_sum_group(xr, 1)
    print("KEY reversed_input one_block_at_a_time", fr, "group", gr, "same", fr == gr, "same_as_forward", gr == want)

    for w in [1, 16]:
        var b1: Float64 = 1.0e30
        var b2: Float64 = 1.0e30
        var b3: Float64 = 1.0e30
        for _ in range(7):
            var t0 = perf_counter_ns()
            var f = fixed_sum(x, w)
            var t1 = perf_counter_ns()
            var g = fixed_sum_group(x, w)
            var t2 = perf_counter_ns()
            var h = naive_sum(x, w)
            var t3 = perf_counter_ns()
            var d1 = Float64(t1 - t0) / 1.0e6
            var d2 = Float64(t2 - t1) / 1.0e6
            var d3 = Float64(t3 - t2) / 1.0e6
            if d1 < b1:
                b1 = d1
            if d2 < b2:
                b2 = d2
            if d3 < b3:
                b3 = d3
            if f != want or g != want:
                print("MISMATCH", f, g, h)
        print("KEY time_ms workers", w, "one_block_at_a_time", b1, "group", b2, "naive", b3)
