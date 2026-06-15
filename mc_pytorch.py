"""
Monte Carlo option pricer - PyTorch GPU baseline.
Runs on GPU 0 only (second GPU disabled via CUDA_VISIBLE_DEVICES).
"""
import os
os.environ["CUDA_VISIBLE_DEVICES"] = "0"   # use only the first GPU

import torch
import time

def mc_price(n_paths: int, device: str = "cuda") -> float:
    S, K, r, sig, T = 100.0, 100.0, 0.05, 0.2, 1.0
    z      = torch.randn(n_paths, device=device, dtype=torch.float32)
    ST     = S * torch.exp((r - 0.5 * sig**2) * T + sig * T**0.5 * z)
    payoff = torch.clamp(ST - K, min=0.0) * torch.exp(torch.tensor(-r * T, device=device, dtype=torch.float32))
    return payoff.mean().item()

def benchmark(n_paths: int, repeats: int = 10) -> float:
    # warm up
    for _ in range(3):
        mc_price(n_paths)
    torch.cuda.synchronize()
    t0 = time.perf_counter()
    for _ in range(repeats):
        mc_price(n_paths)
        torch.cuda.synchronize()
    return (time.perf_counter() - t0) / repeats * 1000   # ms

if __name__ == "__main__":
    print(f"Device : {torch.cuda.get_device_name(0)}")
    print(f"{'Paths':>12}  {'PyTorch GPU (ms)':>18}  {'Price':>8}")
    print("-" * 44)
    for n in [1_000_000, 10_000_000, 100_000_000]:
        ms  = benchmark(n)
        px  = mc_price(n)
        print(f"{n:>12,}  {ms:>18.2f}  {px:>8.4f}")
