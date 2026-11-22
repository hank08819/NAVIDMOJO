# Fig. 5(b): moving-average crossover backtest over S symbols, 2,500 bars each.
# Build: mojo build bt.mojo (Mojo 1.0.0b1). Up to 16 workers; each task runs four
# symbols, one SIMD lane per symbol. Results equal the one-symbol loop bit for bit
# (bt_v1_one_symbol_per_task.mojo).
# Signal at bar t: +1 if the 10-bar mean exceeds the 50-bar mean, else -1.
# The position is held for one bar; a change of position costs 0.01 per unit.
# Gross profit and the number of units traded are accumulated separately.
from collections import List
from algorithm import parallelize
from time import perf_counter_ns
from sys import argv

alias WORKERS = 16
alias T = 2500


def main() raises:
    # Run: ./bt.mojo.bin 4 40 400 4000 40000   (numbers of symbols)
    var args = argv()
    for ci in range(1, len(args)):
        var n_sym = Int(args[ci])
        var px = List[Float64]()
        for s in range(n_sym):
            var st = UInt64(s + 1) * 0x9E3779B97F4A7C15
            var p: Float64 = 100.0
            for _ in range(T):
                st = st * 6364136223846793005 + 1442695040888963407
                var u = Float64(st >> 11) * (1.0 / 9007199254740992.0)
                p = p * (1.0 + 0.02 * (u - 0.5))
                px.append(p)
        var pnl = List[Float64]()
        var ntr = List[Int]()
        for _ in range(n_sym):
            pnl.append(0.0)
            ntr.append(0)
        var xp = px.unsafe_ptr()
        var pp = pnl.unsafe_ptr()
        var tp = ntr.unsafe_ptr()
        var groups = n_sym // 4
        var workers = WORKERS
        if groups < workers:
            workers = groups
        var best: UInt = 0
        for r in range(7):
            var t0 = perf_counter_ns()
            @parameter
            def one(g: Int):
                # four symbols per task, one SIMD lane per symbol; each lane does
                # the same operations in the same order as the one-symbol loop
                var p0 = xp + (4 * g) * T
                var p1 = p0 + T
                var p2 = p1 + T
                var p3 = p2 + T
                var fast = SIMD[DType.float64, 4](0.0)
                var slow = SIMD[DType.float64, 4](0.0)
                for t in range(40, 50):
                    fast += SIMD[DType.float64, 4](p0[t], p1[t], p2[t], p3[t])
                for t in range(0, 50):
                    slow += SIMD[DType.float64, 4](p0[t], p1[t], p2[t], p3[t])
                var prev = SIMD[DType.float64, 4](0.0)
                var acc = SIMD[DType.float64, 4](0.0)     # gross profit and loss
                var units = SIMD[DType.float64, 4](0.0)   # position changes, in units
                var tr = SIMD[DType.int64, 4](0)
                var cur = SIMD[DType.float64, 4](p0[49], p1[49], p2[49], p3[49])
                var t = 49
                while t < T - 1:
                    var nx = SIMD[DType.float64, 4](p0[t + 1], p1[t + 1], p2[t + 1], p3[t + 1])
                    var sg = (fast * 5.0).gt(slow).select(SIMD[DType.float64, 4](1.0), SIMD[DType.float64, 4](-1.0))
                    var d = sg - prev        # 0 when the position is unchanged
                    units += max(d, -d)
                    tr += sg.ne(prev).select(SIMD[DType.int64, 4](1), SIMD[DType.int64, 4](0))
                    acc += sg * (nx - cur)
                    prev = sg
                    fast += nx - SIMD[DType.float64, 4](p0[t - 9], p1[t - 9], p2[t - 9], p3[t - 9])
                    slow += nx - SIMD[DType.float64, 4](p0[t - 49], p1[t - 49], p2[t - 49], p3[t - 49])
                    cur = nx
                    t += 1
                var res = acc - 0.01 * units
                for i in range(4):
                    pp[4 * g + i] = res[i]
                    tp[4 * g + i] = Int(tr[i])
            parallelize[one](groups, workers)
            var d = perf_counter_ns() - t0
            if r == 0 or d < best:
                best = d
        var total: Float64 = 0.0
        var trades = 0
        for s in range(n_sym):
            total += pnl[s]
            trades += ntr[s]
        print("KEY mojo bt bars", n_sym * T, "ms", Float64(best) / 1.0e6, "pnl", total, "trades", trades)
