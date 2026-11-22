#!/bin/bash
# Table 3: all four programs in one session on GPU 0, three runs each.
# Each program does 5 warm-up launches and prints min / median / std over 50 timed launches.
cd "$(dirname "$0")"
export PATH=/usr/local/cuda/bin:$PATH
HERE=$PWD
{ echo "date_utc: $(date -u +%FT%TZ)"; nvidia-smi --query-gpu=index,name,driver_version --format=csv,noheader
  nvcc --version | grep release; (cd ~/NAVIDMOJO && ~/.pixi/bin/pixi run mojo --version)
  ~/NAVIDMOJO/.venv-torch/bin/python -c "import torch,sys; print('Python', sys.version.split()[0], 'torch', torch.__version__)"
  echo "clock lock: none"; echo "cpu load: $(uptime)"; } > manifest.txt 2>&1
nvcc -O3 -arch=sm_89 mc_cuda.cu -o mc_cuda_nofast
nvcc -O3 -arch=sm_89 -use_fast_math mc_cuda.cu -o mc_cuda_fast
(cd ~/NAVIDMOJO && ~/.pixi/bin/pixi run mojo build "$HERE/mc_mojo.mojo" -o "$HERE/mc_mojo") > mojo_build.log 2>&1; echo "mojo build exit $?" >> mojo_build.log
for k in 1 2 3; do
  echo "== run $k: CUDA C without fast math"; ./mc_cuda_nofast
  echo "== run $k: CUDA C with -use_fast_math"; ./mc_cuda_fast
  echo "== run $k: Mojo (mojo build)"; ./mc_mojo
  echo "== run $k: PyTorch"; ~/NAVIDMOJO/.venv-torch/bin/python mc_pytorch.py
done > runs.log 2>&1
echo "cpu load at end: $(uptime)" >> manifest.txt
touch table3.done
