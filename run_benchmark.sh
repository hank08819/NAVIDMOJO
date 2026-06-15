#!/usr/bin/env bash
# run_benchmark.sh -- compile and run all three Monte Carlo benchmarks.
# Uses GPU 0 only; the second GPU is never touched.
set -e

# ── detect GPU architecture for nvcc ─────────────────────────────────────────
ARCH=$(python3 -c "
import subprocess, re
out = subprocess.check_output(['nvidia-smi', '--query-gpu=compute_cap',
                               '--format=csv,noheader'], text=True)
cap = out.strip().split('\n')[0].replace('.', '')  # e.g. '90' for H100
print('sm_' + cap)
")
echo "Detected GPU arch: $ARCH"

# ── 1. CUDA C ─────────────────────────────────────────────────────────────────
echo ""
echo "=========================================="
echo " Compiling CUDA C reference kernel ..."
echo "=========================================="
nvcc -O3 -arch="$ARCH" mc_cuda.cu -lcurand -o mc_cuda
echo " Running CUDA C benchmark ..."
./mc_cuda

# ── 2. PyTorch ────────────────────────────────────────────────────────────────
echo ""
echo "=========================================="
echo " Running PyTorch GPU baseline ..."
echo "=========================================="
python3 mc_pytorch.py

# ── 3. Mojo ───────────────────────────────────────────────────────────────────
echo ""
echo "=========================================="
echo " Running Mojo GPU kernel ..."
echo "=========================================="
mojo mc_mojo.mojo

echo ""
echo "Done. Copy the numbers into Table 2 of the paper."
