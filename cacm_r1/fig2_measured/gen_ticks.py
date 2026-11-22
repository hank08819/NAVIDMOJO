# Writes N tick records as JSON lines. Usage: python gen_ticks.py out.jsonl [N]
import sys
M = (1 << 64) - 1
SYMS = ["AAPL", "MSFT", "NVDA", "JPM", "GS", "XOM", "BRK.B", "TSLA"]
n = int(sys.argv[2]) if len(sys.argv) > 2 else 1_000_000
state = 2026
ts = 1795000000000
out = []
for i in range(n):
    state = (state * 6364136223846793005 + 1442695040888963407) & M
    ts += (state >> 40) % 50
    sym = SYMS[(state >> 20) % 8]
    px = 50000 + (state >> 30) % 4000000          # in 1/10000 dollars
    qty = 100 * (1 + (state >> 10) % 50)
    out.append('{"ts":%d,"sym":"%s","px":%d.%04d,"qty":%d}\n' % (ts, sym, px // 10000, px % 10000, qty))
open(sys.argv[1], "w").write("".join(out))
