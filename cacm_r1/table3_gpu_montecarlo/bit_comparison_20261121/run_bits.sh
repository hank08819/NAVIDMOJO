#!/bin/bash
# Bit comparison of the Monte Carlo price: CUDA C with and without -use_fast_math, and Mojo.
# Each program runs twice. mc_cuda_bits.cu and mc_mojo_bits.mojo are the Table 3 sources
# plus lines that print the price to 17 digits and save the 262,144 partial sums.
cd "$(dirname "$0")"
export CUDA_VISIBLE_DEVICES=1
{ date -u; nvidia-smi --query-gpu=name,driver_version --format=csv,noheader | head -1; nvcc --version | grep release; (cd ~/NAVIDMOJO && ~/.pixi/bin/pixi run mojo --version); } > manifest.txt 2>&1
nvcc -O3 -arch=sm_89 mc_cuda_bits.cu -o mc_cuda_nofast
nvcc -O3 -arch=sm_89 -use_fast_math mc_cuda_bits.cu -o mc_cuda_fast
for k in 1 2; do ./mc_cuda_nofast nofast_run$k | grep KEY; ./mc_cuda_fast fast_run$k | grep KEY; done > cuda_bits.log 2>&1
for k in 1 2; do (cd ~/NAVIDMOJO && ~/.pixi/bin/pixi run mojo "$OLDPWD/mc_mojo_bits.mojo") > mojo_raw_run$k.txt 2>&1; grep KEY mojo_raw_run$k.txt; done > mojo_bits.log 2>&1
touch bits.done
