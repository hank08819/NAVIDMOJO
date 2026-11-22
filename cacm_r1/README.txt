cacm_r1: code and raw logs of the runs added for the R1 revision
(CACM-26-06-6049), collected on 21 November 2026.

Each folder holds the source files, the run script or manifest, and the logs.

ewma_recurrence/              EWMA time-series recurrence (Table 2 row; Reviewer 2, comment 2)
fig2_measured/                Figure 2: three kernels in Python, MATLAB, Julia, Rust, C++ and Mojo
level2_parallel_determinism/  Section 4.3: fixed-order sum across runs and thread counts
reprolibs_server_20261121/    Table 1: ReproBLAS, ExBLAS, CUB and the fixed-order Mojo kernel
gpu_fastmath_20261121/        GPU Monte Carlo, CUDA C and Mojo math settings (Reviewer 2, comment 3)
fig5_measured_20261121/       Figure 5: Monte Carlo pricing, backtest, portfolio VaR

fig5_measured_20261121:
  mc.mojo  mc.cpp  mc.py            (a) Monte Carlo European call
  bt.mojo  bt.cpp  bt.py            (b) moving-average crossover backtest
  var_blas.mojo  var_gpu.mojo  var.py   (c) portfolio VaR (Mojo + OpenBLAS, Mojo on GPU, Python / NumPy)
  run_quiet4.sh                     run script (waits until the machine is idle before each program)
  logs_final/                       raw logs of the run plotted in Figure 5 (each size repeated at least
                                    7 times and until 0.3 s have been spent on it)
  make_fig5_measured.py             python make_fig5_measured.py logs_final fig5_measured.png

Machine for Figure 5: Intel Xeon w7-3445, NVIDIA RTX 6000 Ada, Mojo 1.0.0b1, g++ 13.3,
Python 3.14.6, NumPy 2.5.2 (OpenBLAS 0.3.34), pandas 2.3.3. 16 threads.

compiler_output/              Section 3.2: bench_dot_product.s (mojo build --emit asm, Apple M4 Max, Mojo 1.0.0b1);
                              mc.ll and mc_kernel_device_code.elf (mojo build --emit llvm, Mojo 0.25.6.0)
listing_sources/              Listing 1 source: bench_dot_product.mojo


table3_gpu_montecarlo/        Table 3: GPU Monte Carlo in CUDA C, Mojo and PyTorch; sources, build commands, raw output

supplement/                   Supplemental material of the article (PDF): hardware, inputs, timing procedure, full results
