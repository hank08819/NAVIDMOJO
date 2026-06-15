# Monte Carlo option pricer -- Mojo GPU kernel.
# Targets GPU 0 only via DeviceContext(device_id=0).
#
# Run:
#   mojo mc_mojo.mojo

from gpu import thread_idx, block_idx, block_dim
from gpu.host import DeviceContext
from math import exp, sqrt, log, cos, sin
from memory import UnsafePointer
from time import perf_counter_ns

# ── constants ────────────────────────────────────────────────────────────────
alias S     = Float32(100.0)
alias K     = Float32(100.0)
alias R     = Float32(0.05)
alias SIGMA = Float32(0.2)
alias T     = Float32(1.0)
alias PI    = Float32(3.14159265358979)

# ── per-thread LCG + Box-Muller normal ───────────────────────────────────────
@always_inline
fn lcg(seed: UInt32) -> UInt32:
    return seed * UInt32(1664525) + UInt32(1013904223)

@always_inline
fn uniform(seed: UInt32) -> Float32:
    # scale the top 23 bits of seed to [0, 1) by dividing by 2^23
    # (Float32 numeric conversion is safe here; no bitcast needed)
    return Float32(seed >> 9) * Float32(1.1920929e-7)

@always_inline
fn normal_pair(seed: UInt32) -> (Float32, Float32):
    var s1 = lcg(seed)
    var s2 = lcg(s1)
    var u1 = uniform(s1) + Float32(1e-7)   # avoid log(0)
    var u2 = uniform(s2)
    var mag = sqrt(-Float32(2.0) * log(u1))
    return (mag * cos(Float32(2.0) * PI * u2),
            mag * sin(Float32(2.0) * PI * u2))

# ── GPU kernel ────────────────────────────────────────────────────────────────
fn mc_kernel(results: UnsafePointer[Float32], n_paths: Int):
    var idx = block_idx.x * block_dim.x + thread_idx.x
    if idx >= n_paths:
        return
    var seed = UInt32(idx) * UInt32(2654435761) ^ UInt32(0xDEADBEEF)
    var z    = normal_pair(seed).get[0]()
    var ST   = S * exp((R - Float32(0.5) * SIGMA * SIGMA) * T
                       + SIGMA * sqrt(T) * z)
    results[idx] = max(ST - K, Float32(0.0)) * exp(-R * T)

# ── host code ─────────────────────────────────────────────────────────────────
fn run_benchmark(n_paths: Int, ctx: DeviceContext) -> (Float64, Float64):
    var d_results = ctx.enqueue_alloc[Float32](n_paths)

    var block_size = 256
    var grid_size  = (n_paths + block_size - 1) // block_size

    ctx.enqueue_function[mc_kernel](
        grid_size, block_size,
        d_results, n_paths
    )
    ctx.synchronize()

    # copy back and reduce on host
    var h_results = UnsafePointer[Float32].alloc(n_paths)
    ctx.enqueue_copy(h_results, d_results, n_paths)
    ctx.synchronize()

    var total = Float64(0.0)
    for i in range(n_paths):
        total += Float64(h_results[i])
    h_results.free()
    _ = d_results

    return (total / Float64(n_paths), Float64(0.0))

fn main():
    # GPU 0 only -- second GPU is never opened
    var ctx = DeviceContext(device_id=0)

    print("Device: GPU 0")
    print("")
    print(String("{:>12}  {:>16}  {:>8}").format("Paths", "Mojo GPU (ms)", "Price"))
    print("-" * 42)

    var sizes = List[Int](1_000_000, 10_000_000, 100_000_000)
    var repeats = 5

    for n in sizes:
        # warm up
        for _ in range(2):
            _ = run_benchmark(n[], ctx)

        var t0    = perf_counter_ns()
        var price = Float64(0.0)
        for _ in range(repeats):
            price = run_benchmark(n[], ctx).get[0]()
        var ms = Float64(perf_counter_ns() - t0) / Float64(repeats) / Float64(1_000_000)

        print(String("{:>12}  {:>16.2f}  {:>8.4f}").format(n[], ms, price))
