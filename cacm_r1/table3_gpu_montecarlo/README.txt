Table 3: Monte Carlo option pricing on an NVIDIA RTX 6000 Ada (GPU 0), FP32.

Sources (the files that produced Table 3)
  mc_cuda.cu      CUDA C kernel
  mc_mojo.mojo    Mojo kernel
  mc_pytorch.py   PyTorch baseline
  CUDA C and Mojo use the same hand-written LCG and Box-Muller generator, grid-stride
  loops over 262,144 threads, and one partial sum per thread kept in a register.

Build and run
  nvcc -O3 -arch=sm_89 mc_cuda.cu -o mc_cuda && ./mc_cuda
      (add -use_fast_math for the fast-math runs)
  mojo build mc_mojo.mojo -o mc_mojo && ./mc_mojo
  python3 mc_pytorch.py
  run_20261121_one_session/run_table3.sh builds and runs all four programs.
  run_benchmark.sh is the script of the June 2026 runs; it passes -use_fast_math to nvcc.

Timing
  Device buffers are allocated before the timed region. The timed region is the compute
  kernel only. The final sum over the 262,144 partial sums is done on the host, outside
  the timing. Each program does 5 warm-up launches and prints min, median and std over 50 timed launches.

Raw output
  run_20261121_one_session/                  the run behind Table 3: all four programs in one session,
                                             three runs each (runs.log), with run_table3.sh and manifest.txt.
                                             Table 3 reports the median of 50 launches, best of the three runs.
  run_20260615_0538UTC_first_submission.txt  output behind the table of the first submission
  run_20260615_0624UTC_fastmath.txt          run of the same day with -use_fast_math, with manifest
  rerun_20261121/                            earlier rerun of 21 November 2026 (CUDA C and Mojo only)
  bit_comparison_20261121/                   CUDA C with and without -use_fast_math and Mojo, two runs each:
                                             price to 17 digits (cuda_bits.log, mojo_bits.log) and the number
                                             of the 262,144 partial sums that differ (partials_compare.log)

Versions: nvcc 12.6 (V12.6.85), Mojo 0.25.6.0 (06be5aab), PyTorch 2.5.1+cu121.
