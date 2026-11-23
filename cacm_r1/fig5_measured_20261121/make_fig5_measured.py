"""Fig. 5, measured on one server (Intel Xeon w7-3445, NVIDIA RTX 6000 Ada).
Every point is a measurement read from the logs in the directory given as argv[1];
for programs that were run several times the smallest time is used.
Layout: (a) and (b) on the first row, (c) on the second row with the times at the largest portfolio;
each row is set in a frame.
Usage: python make_fig5_measured.py <log_dir> <out.png>"""
import glob, os, re, sys
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.gridspec import GridSpec
from matplotlib.lines import Line2D
from matplotlib.patches import FancyBboxPatch
from matplotlib.ticker import FixedLocator, FixedFormatter, NullFormatter, NullLocator

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
def ratio(a, b, wl, size):
    return best[(a, wl, size)] / best[(b, wl, size)]

INK, MUTED, RULE = "#1c1c1c", "#5f6368", "#d9dce1"
GREY, RED, BLUE, GREEN, LGREEN = "#888888", "#c0392b", "#1f4e8c", "#2a9d3f", "#86c98f"
plt.rcParams.update({"font.family": "DejaVu Sans", "font.size": 10, "axes.edgecolor": "#8a8f98",
                     "axes.linewidth": 0.8, "xtick.color": INK, "ytick.color": INK, "text.color": INK,
                     "axes.labelcolor": INK, "xtick.labelsize": 9.5, "ytick.labelsize": 9.5})

fig = plt.figure(figsize=(7.9, 5.2))
# one frame per row
bg = fig.add_axes([0, 0, 1, 1], zorder=-1); bg.set_axis_off(); bg.set_xlim(0, 1); bg.set_ylim(0, 1)
for y0, y1 in ((0.522, 0.994), (0.006, 0.494)):
    bg.add_patch(FancyBboxPatch((0.006, y0), 0.988, y1 - y0, boxstyle="round,pad=0.0,rounding_size=0.012",
                                fc="white", ec="#9aa0a8", lw=0.9))
gs = GridSpec(1, 2, figure=fig, left=0.085, right=0.975, top=0.856, bottom=0.612, wspace=0.27)
gs_c = GridSpec(1, 2, figure=fig, left=0.085, right=0.965, top=0.326, bottom=0.112, width_ratios=[1.45, 1.0], wspace=0.44)

def style(ax):
    for side in ("top", "right"):
        ax.spines[side].set_visible(False)
    ax.grid(True, which="major", color=RULE, lw=0.7)
    ax.set_axisbelow(True)
    ax.tick_params(which="both", length=3, width=0.7)
    ax.tick_params(which="minor", length=0)

def lines(ax, wl, specs):
    for impl, marker, color, lw, ls, z in specs:
        x, y = series(impl, wl)
        ax.loglog(x, y, ls, marker=marker, color=color, lw=lw, ms=6.2, mec="white", mew=0.9, zorder=z)
    ax.xaxis.set_minor_locator(NullLocator()); ax.yaxis.set_minor_locator(NullLocator())

def title(ax, text, size=11):
    ax.set_title(text, fontsize=size, fontweight="bold", loc="left", pad=6, color=INK)

def note(ax, head, body):
    ax.text(0.975, 0.07, head + ": " + body, transform=ax.transAxes, ha="right", va="bottom", fontsize=8.3,
            color=INK,
            bbox=dict(boxstyle="round,pad=0.38", fc="white", ec=GREEN, lw=1.0))

# ---------- (a) Monte Carlo ----------
ax = fig.add_subplot(gs[0, 0]); style(ax)
lines(ax, "mc", [("python", "o", GREY, 1.8, "-", 2), ("numpy", "s", RED, 1.8, "-", 3),
                 ("cpp", "^", BLUE, 1.8, "-", 4), ("mojo", "v", GREEN, 2.4, "-", 5)])
lo, hi = ax.get_ylim(); ax.set_ylim(lo / 150, hi * 1.6)
ax.set_xlabel("Monte Carlo paths"); ax.set_ylabel("Time (s)")
title(ax, "(a) Monte Carlo option pricing")
note(ax, "Mojo at 10M paths", "%.0f$\\times$ Python, %.0f$\\times$ NumPy" %
     (ratio("python", "mojo", "mc", 10**7), ratio("numpy", "mojo", "mc", 10**7)))

# ---------- (b) backtest ----------
ax = fig.add_subplot(gs[0, 1]); style(ax)
lines(ax, "bt", [("python", "o", GREY, 1.8, "-", 2), ("pandas", "s", RED, 1.8, "-", 3),
                 ("cpp", "^", BLUE, 1.8, "-", 4), ("mojo", "v", GREEN, 2.4, "-", 5)])
lo, hi = ax.get_ylim(); ax.set_ylim(lo / 150, hi * 1.6)
ax.set_xlabel("Bars (2,500 per symbol)"); ax.set_ylabel("Time (s)")
title(ax, "(b) Multi-asset backtest")
note(ax, "Mojo at 100M bars", "{:,.0f}$\\times$ Python, {:,.0f}$\\times$ pandas".format(
     ratio("python", "mojo", "bt", 10**8), ratio("pandas", "mojo", "bt", 10**8)))

# one legend for the first row
h = [Line2D([], [], color=GREY, marker="o", lw=1.8, ms=6.2, mec="white", mew=0.9, label="Pure Python (loop)"),
     Line2D([], [], color=RED, marker="s", lw=1.8, ms=6.2, mec="white", mew=0.9, label="NumPy (a) / pandas (b)"),
     Line2D([], [], color=BLUE, marker="^", lw=1.8, ms=6.2, mec="white", mew=0.9, label="C++ (OpenMP, 16 threads)"),
     Line2D([], [], color=GREEN, marker="v", lw=2.4, ms=6.2, mec="white", mew=0.9, label="Mojo (SIMD, 16 threads)")]
fig.legend(handles=h, loc="upper center", bbox_to_anchor=(0.5, 0.963), ncol=4, frameon=False, fontsize=8.8,
           handlelength=2.0, columnspacing=1.4, handletextpad=0.5)

# ---------- (c) VaR: second row ----------

ax = fig.add_subplot(gs_c[0, 0]); style(ax); ax.set_facecolor("none")
lines(ax, "var", [("python", "o", GREY, 1.8, "-", 2), ("numpy", "s", RED, 1.8, "-", 3),
                  ("mojo_blas", "^", LGREEN, 1.8, "--", 4), ("mojo_gpu", "v", GREEN, 2.4, "-", 5)])
sizes = sorted({s for (i, w, s) in best if w == "var"})
ax.xaxis.set_major_locator(FixedLocator(sizes)); ax.xaxis.set_major_formatter(FixedFormatter(["{:,}".format(s) for s in sizes]))
ax.xaxis.set_minor_formatter(NullFormatter())
lo, hi = ax.get_ylim(); ax.set_ylim(lo / 2.5, hi * 1.6)
ax.set_xlabel("Assets in the portfolio"); ax.set_ylabel("Time (s)")
fig.text(0.03, 0.456, "(c) Portfolio VaR with risk decomposition", fontsize=11.5, fontweight="bold", color=INK, ha="left", va="center")
fig.text(0.522, 0.456, "10,000 scenarios, full covariance", fontsize=10, color=MUTED, ha="left", va="center")
ax.set_title("Time against portfolio size", fontsize=9.8, fontweight="bold", loc="left", pad=5, color=INK)
hc = [Line2D([], [], color=GREY, marker="o", lw=1.8, ms=6.2, mec="white", mew=0.9, label="Pure Python (loop)"),
      Line2D([], [], color=RED, marker="s", lw=1.8, ms=6.2, mec="white", mew=0.9, label="NumPy (OpenBLAS)"),
      Line2D([], [], color=LGREEN, marker="^", lw=1.8, ls="--", ms=6.2, mec="white", mew=0.9, label="Mojo CPU + OpenBLAS"),
      Line2D([], [], color=GREEN, marker="v", lw=2.4, ms=6.2, mec="white", mew=0.9, label="Mojo on GPU (RTX 6000 Ada)")]
fig.legend(handles=hc, loc="center", bbox_to_anchor=(0.5, 0.409), ncol=4, frameon=False, fontsize=8.8,
           handlelength=2.2, columnspacing=1.4, handletextpad=0.5)

# times at the largest portfolio, on a linear axis
big = max(sizes)
axb = fig.add_subplot(gs_c[0, 1]); axb.set_facecolor("none")
rows = [("numpy", "NumPy", RED), ("mojo_blas", "Mojo CPU", LGREEN), ("mojo_gpu", "Mojo GPU", GREEN)]
vals = [best[(k, "var", big)] for k, _, _ in rows]
ypos = [2, 1, 0]
axb.barh(ypos, vals, height=0.56, color=[c for _, _, c in rows], edgecolor="white", linewidth=1.0, zorder=3)
for y, v, (k, lab, _) in zip(ypos, vals, rows):
    txt = "%.0f ms" % v
    if k != "numpy":
        txt += "   %.1f$\\times$" % (vals[0] / v)
    axb.text(v + max(vals) * 0.02, y, txt, va="center", ha="left", fontsize=9.2, color=INK,
             fontweight="bold" if k == "mojo_gpu" else "normal")
axb.set_yticks(ypos); axb.set_yticklabels([lab for _, lab, _ in rows], fontsize=9.2)
axb.set_xlim(0, max(vals) * 1.42); axb.set_ylim(-0.55, 2.55)
for side in ("top", "right", "left"):
    axb.spines[side].set_visible(False)
axb.tick_params(axis="y", length=0); axb.tick_params(axis="x", length=3, width=0.7)
axb.grid(True, axis="x", color=RULE, lw=0.7); axb.set_axisbelow(True)
axb.set_xlabel("Time (ms)")
axb.set_title("At {:,} assets, against NumPy".format(big), fontsize=9.8, fontweight="bold", loc="left", pad=5, color=INK)

plt.savefig(out, dpi=450)
print("saved", out)
for k in sorted(best): print(k, round(best[k], 4))
