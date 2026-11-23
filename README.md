# NAVIDMOJO — NVIDIA GPU Monte Carlo Benchmark

Three implementations of the same Black-Scholes Monte Carlo European call option
pricer, benchmarked side-by-side on a single NVIDIA GPU.

**Author:** Henry Han, Baylor University

**Paper:** "Mojo: A Reproducible, Scalable Kernel Layer for Financial AI"
(originally circulated as "Mojo: A Promising Tool for Scalable Financial AI Efficiency"), 2026 — Section 5.5, Table 2.

| File | Language | RNG used |
|---|---|---|
| `mc_cuda.cu` | CUDA C | cuRAND (`curand_normal`) |
| `mc_mojo.mojo` | Mojo GPU kernel | Hand-rolled LCG + Box-Muller |
| `mc_pytorch.py` | Python + PyTorch | `torch.randn` (Mersenne Twister) |
| `run_benchmark.sh` | Bash | Compiles and runs all three |

---

## Important: Adjust Python, PyTorch, and Mojo Versions to Your Environment

> **These files were written for a specific software stack. Before running,
> you must verify that your installed versions of Python, PyTorch, and Mojo
> match what the code expects — or update the code to match your versions.
> Using a mismatched version will produce errors or require API changes.**

### Python

`mc_pytorch.py` requires Python 3.10 or later. Check your version:

```bash
python3 --version
```

If you have multiple Python versions, replace `python3` in `run_benchmark.sh`
and in the install commands below with your specific interpreter
(e.g., `python3.12`).

### PyTorch

Install a PyTorch build that matches your CUDA driver. First check your driver:

```bash
nvidia-smi    # look for "CUDA Version: X.Y" in the top-right corner
```

Then install the matching wheel:

```bash
# CUDA 12.1 (driver >= 525):
pip install torch --index-url https://download.pytorch.org/whl/cu121

# CUDA 12.4 (driver >= 550):
pip install torch --index-url https://download.pytorch.org/whl/cu124

# CUDA 11.8 (older driver):
pip install torch --index-url https://download.pytorch.org/whl/cu118
```

Verify that CUDA is available in PyTorch:

```bash
python3 -c "import torch; print(torch.__version__, torch.cuda.is_available())"
```

### Mojo

`mc_mojo.mojo` uses the Mojo GPU API from an **early 2026 Mojo release**
(approximately Mojo 0.x beta). The specific API patterns used are:

```mojo
var ctx = DeviceContext(device_id=0)
var d   = ctx.enqueue_alloc[Float32](n_paths)
ctx.enqueue_function[mc_kernel](grid_size, block_size, d_results, n_paths)
ctx.enqueue_copy(h_ptr, d_ptr, n_paths)
ctx.synchronize()
```

**If your Mojo version is newer**, these method names may have changed.
Common API changes across Mojo versions:

| Old (this code) | New (later Mojo) |
|---|---|
| `enqueue_alloc[T](n)` | `enqueue_create_buffer[DType.float32](n)` |
| `enqueue_function[k](grid, block, args...)` | `enqueue_function[k](args..., grid_dim=G, block_dim=B)` |
| `enqueue_copy(dst, src, n)` | `enqueue_copy(dst, src)` (count removed) |

Install Mojo via the Modular CLI:

```bash
curl -ssL https://magic.modular.com | bash
source ~/.bashrc
magic install mojo
mojo --version
```

Or via pixi (recommended for reproducibility):

```bash
curl -fsSL https://pixi.sh/install.sh | bash
# create pixi.toml specifying your desired Mojo version, then:
pixi install
pixi run mojo --version
```

After installing, run `mojo mc_mojo.mojo` and fix any API errors to match
your installed version's GPU module.

### CUDA toolkit (for mc_cuda.cu)

The CUDA C kernel links against **cuRAND** (`-lcurand`). Verify cuRAND is
installed:

```bash
nvcc --version
ls /usr/local/cuda/lib64/libcurand*   # or /usr/local/cuda-XX.X/lib64/
```

If cuRAND is missing:

```bash
# Ubuntu / Debian:
sudo apt-get install libcurand-dev
```

Supported GPU architectures for the `-arch` flag (auto-detected by
`run_benchmark.sh`):

| GPU model | Compute capability | `-arch` |
|---|---|---|
| NVIDIA H100 | sm_90 | `-arch=sm_90` |
| NVIDIA A100 | sm_80 | `-arch=sm_80` |
| NVIDIA RTX 6000 Ada / RTX 4090 | sm_89 | `-arch=sm_89` |
| NVIDIA RTX 3090 / A6000 | sm_86 | `-arch=sm_86` |

---

## Algorithm

All three implementations price a European call option:

```
S = 100  (spot price)
K = 100  (strike price)
r = 0.05 (risk-free rate)
σ = 0.20 (volatility)
T = 1.0  (years to expiry)

Analytical Black-Scholes price ≈ 10.45
```

Each path simulates `S_T = S · exp((r − σ²/2)T + σ√T · Z)` where `Z` is
standard normal, then computes the discounted payoff `max(S_T − K, 0) · exp(−rT)`
and averages across all paths.

**Note on prices:** The three implementations use different RNGs (cuRAND, LCG,
`torch.randn`), so prices differ slightly across implementations — this is
normal Monte Carlo sampling variation, not a bug. All prices should converge
to approximately 10.45 as path count increases.

---

## Setup

### 1. Check your GPU

```bash
nvidia-smi
```

Note the GPU name and CUDA version. The `run_benchmark.sh` script auto-detects
the GPU architecture (`sm_89`, `sm_90`, etc.) so you do not need to set it
manually.

### 2. Install PyTorch

```bash
python3 -m venv .venv-torch
source .venv-torch/bin/activate
pip install torch --index-url https://download.pytorch.org/whl/cu121   # adjust version
```

### 3. Install Mojo

```bash
curl -ssL https://magic.modular.com | bash && source ~/.bashrc
magic install mojo
mojo --version
```

If the API in `mc_mojo.mojo` does not match your Mojo version, update the
`enqueue_alloc`, `enqueue_function`, and `enqueue_copy` calls as described
in the Version Requirements section above.

### 4. Make the run script executable

```bash
chmod +x run_benchmark.sh
```

---

## Run everything

```bash
bash run_benchmark.sh
```

To use the PyTorch venv explicitly:

```bash
PYTORCH_PYTHON=.venv-torch/bin/python bash run_benchmark.sh
```

The script will:
1. Auto-detect your GPU architecture from `nvidia-smi`.
2. Compile `mc_cuda.cu` with `-O3 -lcurand` and the detected `-arch` flag.
3. Run CUDA C → PyTorch → Mojo in sequence, printing results for each.

---

## Run each implementation separately

```bash
# ── CUDA C ──────────────────────────────────────────────────────────────────
nvcc -O3 -arch=sm_89 mc_cuda.cu -lcurand -o mc_cuda && ./mc_cuda   # RTX 6000 Ada / RTX 4090
nvcc -O3 -arch=sm_90 mc_cuda.cu -lcurand -o mc_cuda && ./mc_cuda   # H100
nvcc -O3 -arch=sm_80 mc_cuda.cu -lcurand -o mc_cuda && ./mc_cuda   # A100

# ── PyTorch ─────────────────────────────────────────────────────────────────
python3 mc_pytorch.py
# or with venv:
.venv-torch/bin/python mc_pytorch.py

# ── Mojo ────────────────────────────────────────────────────────────────────
mojo mc_mojo.mojo
```

---

## Expected output format

```
GPUs detected: 2  -- using GPU 0 only
GPU 0: NVIDIA RTX 6000 Ada Generation

       Paths      CUDA C (ms)     Price        ← mc_cuda
--------------------------------------------
     1000000            0.42    10.4512
    10000000            1.73    10.4498
   100000000           16.84    10.4503

Device : NVIDIA RTX 6000 Ada Generation        ← mc_pytorch.py
       Paths   PyTorch GPU (ms)     Price
--------------------------------------------
   1,000,000              0.09    10.4380
  10,000,000              0.27    10.4475
 100,000,000              7.95    10.4504

Device: GPU 0                                  ← mc_mojo.mojo
       Paths     Mojo GPU (ms)     Price
------------------------------------------
     1000000             0.38    10.4512
    10000000             1.61    10.4498
   100000000            15.22    10.4503
```

All prices converge to approximately **10.45**. Differences between
implementations are due to different RNGs (expected).

---

## Using only one GPU on a multi-GPU machine

All three files target **GPU 0 only**:
- `mc_cuda.cu` — `cudaSetDevice(0)` at the top of `run()`.
- `mc_pytorch.py` — `os.environ["CUDA_VISIBLE_DEVICES"] = "0"` before `import torch`.
- `mc_mojo.mojo` — `DeviceContext(device_id=0)`.

To switch to GPU 1, change `0` to `1` in all three files.

Monitor GPU utilization during a run:
```bash
nvidia-smi dmon -s u    # only GPU 0 should be active
```

---

## Troubleshooting

**`nvcc: command not found`**
```bash
export PATH=/usr/local/cuda/bin:$PATH
```

**`error: cannot find -lcurand` or `curand_kernel.h: No such file`**
```bash
sudo apt-get install libcurand-dev     # Ubuntu/Debian
# or install the full CUDA toolkit for your version
```

**`mojo: command not found`**

Run `source ~/.bashrc` after installing Mojo, or use `magic run mojo`.

**Mojo GPU kernel errors (`enqueue_alloc` / `enqueue_function` not found)**

Your Mojo version uses a different GPU API. Update the three API calls in
`mc_mojo.mojo` to match your version. See the Version Requirements section
above for the mapping between old and new API names.

**PyTorch `CUDA error: no kernel image is available for execution`**

Your PyTorch wheel was not compiled for your GPU's compute capability.
Reinstall PyTorch with the correct CUDA version matching your driver.

**Prices differ by more than ~0.1 from 10.45**

Check that all three implementations use the same option parameters
(S=100, K=100, r=0.05, σ=0.20, T=1.0). Also check that `n_paths` is
large enough (100M gives the most stable price).

---

## Citation

If you use this benchmark in your own work, please cite:

```
Henry Han. "Mojo: A Reproducible, Scalable Kernel Layer for Financial AI."
(originally circulated as "Mojo: A Promising Tool for Scalable Financial AI Efficiency")
2026.
```

Repository: https://github.com/hank08819/NAVIDMOJO

## CACM revision (R1), November 2026

Code and raw logs of the runs added for the revision are in `cacm_r1/`; see `cacm_r1/README.txt`.
