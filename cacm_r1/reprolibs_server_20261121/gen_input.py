# Writes the 10,000,000 doubles of the Mac thread-count test to x.bin (little-endian float64),
# a permuted copy to x_perm.bin, and prints the correctly rounded sum (math.fsum).
import struct, math, random, array
M = (1 << 64) - 1
st = 2026; n = 10_000_000
x = array.array('d')
for _ in range(n):
    st = (st * 6364136223846793005 + 1442695040888963407) & M
    u = (st >> 11) * (1.0 / 9007199254740992.0)
    st = (st * 6364136223846793005 + 1442695040888963407) & M
    e = (st >> 33) % 13
    mag = 1.0
    for _ in range(e): mag *= 10.0
    x.append((u - 0.5) * mag * 1.0e-6)
x.tofile(open("x.bin", "wb"))
y = list(x); random.Random(7).shuffle(y)
array.array('d', y).tofile(open("x_perm.bin", "wb"))
r = math.fsum(x)
print("KEY fsum %r hex %s" % (r, r.hex()))
print("KEY fsum_perm %r" % math.fsum(y))
