"""Fig. 5, measured on one server (Intel Xeon w7-3445, NVIDIA RTX 6000 Ada).
Every point is a measurement read from the logs in the directory given as argv[1];
for programs that were run several times the smallest time is used.
Usage: python make_fig5_measured.py <log_dir> <out.png>"""
import glob, os, re, sys
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

log_dir, out = sys.argv[1], sys.argv[2]
best = {}   # (implementation, workload, size) -> smallest milliseconds
for path in glob.glob(os.path.join(log_dir, "*.log")):
    for line in open(path):
        m = re.match(r"KEY (\S+) (mc|bt|var) (?:n|bars) (\d+) ms ([0-9.eE+-]+)", line)
        if m:
            k = (m.group(1), m.group(2), int(m.group(3))); v = float(m.group(4))
            best[k] = min(best.get(k, v), v)
def series(impl, wl):
    pts = sorted((s, v / 1e3) for (i, w, s), v in best.items() if i == impl and w == wl)
    return [a for a, _ in pts], [b for _, b in pts]

GREY, RED, BLUE, GREEN, PURPLE = "#888888", "#c0392b", "#1f4e8c", "#2a9d3f", "#7d3c98"
fig, axes = plt.subplots(1, 3, figsize=(18, 5.2))

def panel(ax, wl, lines, xlabel, ylabel, title):
    for impl, marker, color, label, lw in lines:
        x, y = series(impl, wl)
        ax.loglog(x, y, marker + "-", color=color, lw=lw, ms=6, label=label)
    ax.set_xlabel(xlabel, fontsize=10); ax.set_ylabel(ylabel, fontsize=10)
    ax.set_title(title, fontsize=11, fontweight="bold")
    ax.grid(True, which="both", alpha=0.3)
    ax.legend(loc="upper left", fontsize=8.5)

def note(ax, text):
    ax.text(0.97, 0.05, text, transform=ax.transAxes, ha="right", va="bottom", fontsize=9,
            fontweight="bold", color=GREEN, bbox=dict(boxstyle="round,pad=0.3", fc="white", ec=GREEN, lw=0.8))

def ratio(a, b, wl, size):
    return best[(a, wl, size)] / best[(b, wl, size)]

# (a) Monte Carlo
ax = axes[0]
panel(ax, "mc", [("python", "o", GREY, "Pure Python (loop)", 2), ("numpy", "s", RED, "NumPy vectorized", 2),
                 ("cpp", "^", BLUE, "C++ (OpenMP, 16 threads)", 2), ("mojo", "v", GREEN, "Mojo (SIMD, 16 threads)", 2.4)],
      "Number of Monte Carlo paths", "Wall-clock time (s)", "(a) Monte Carlo option pricing")
note(ax, "Mojo at 10M paths:\n%.0f$\\times$ pure Python, %.0f$\\times$ NumPy" % (ratio("python", "mojo", "mc", 10**7), ratio("numpy", "mojo", "mc", 10**7)))

# (b) backtest
ax = axes[1]
panel(ax, "bt", [("python", "o", GREY, "Pure Python (loop)", 2), ("pandas", "s", RED, "pandas vectorized", 2),
                 ("cpp", "^", BLUE, "C++ (OpenMP, 16 threads)", 2), ("mojo", "v", GREEN, "Mojo (SIMD, 16 threads)", 2.4)],
      "Number of bars (2,500 per symbol $\\times$ symbols)", "Backtest wall-clock time (s)", "(b) Multi-asset backtest")
note(ax, "Mojo at 100M bars:\n%.0f$\\times$ pure Python, %.0f$\\times$ pandas" % (ratio("python", "mojo", "bt", 10**8), ratio("pandas", "mojo", "bt", 10**8)))

# (c) VaR
ax = axes[2]
panel(ax, "var", [("python", "o", GREY, "Pure Python (loop)", 2), ("numpy", "s", RED, "NumPy (OpenBLAS)", 2),
                  ("mojo_blas", "^", BLUE, "Mojo CPU + OpenBLAS", 2), ("mojo_gpu", "v", GREEN, "Mojo on GPU (RTX 6000 Ada)", 2.4)],
      "Portfolio size (number of assets)", "VaR computation time (s)", "(c) Portfolio VaR with risk decomposition\n(10,000 scenarios, full covariance)")
note(ax, "Mojo on GPU at 5,000 assets:\n%.1f$\\times$ NumPy" % ratio("numpy", "mojo_gpu", "var", 5000))

fig.suptitle("Measured on Intel Xeon w7-3445 (16 threads) and NVIDIA RTX 6000 Ada",
             fontsize=12.5, fontweight="bold", color="#0000ff", y=1.0)
plt.tight_layout()
plt.savefig(out, dpi=300, bbox_inches="tight")
print("saved", out)
for k in sorted(best): print(k, round(best[k], 4))
