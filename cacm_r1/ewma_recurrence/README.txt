True-recurrence EWMA benchmark, run 2026-11-20/21 on the Apple M4 Max (macOS, arm64).
Mojo 1.0.0b1 (a9591de6), installed with pixi from conda.modular.com/max in a scratch folder.
Python 3.12.16, numpy 2.5.5, pandas 3.1.1, scipy 1.18.1, numba 0.68.1 (same pixi environment).
10,000,000 ticks, alpha 0.05, best of 5 timed calls after one warm-up call, three separate runs (run1-3).
Build: mojo build bench_ewma_recurrence.mojo ; Python: python bench_ewma_recurrence.py out.json
