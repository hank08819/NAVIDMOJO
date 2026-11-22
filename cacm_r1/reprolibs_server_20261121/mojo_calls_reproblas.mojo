# A Mojo program that sums with ReproBLAS through external_call.
from collections import List
from ffi import external_call


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
    var a = external_call["reproBLAS_dsum", Float64](Int32(n), x.unsafe_ptr(), Int32(1))
    var b = external_call["reproBLAS_dsum", Float64](Int32(n), xr.unsafe_ptr(), Int32(1))
    print("KEY mojo_calls_reproblas sum", a, "reversed_input", b, "same", a == b)
