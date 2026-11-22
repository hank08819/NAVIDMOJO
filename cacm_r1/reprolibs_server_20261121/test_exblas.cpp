// ExBLAS exsum: bits under repetition and permutation, and time. Thread count is set from outside with taskset. Usage: test_exblas x.bin x_perm.bin <fpe> <repeats>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <vector>
#include "blas1.hpp"
static uint64_t bits(double d) { uint64_t u; memcpy(&u, &d, 8); return u; }
static double* load(const char* p, long n) { double* x; if (posix_memalign((void**) &x, 64, 8 * n)) exit(1); FILE* f = fopen(p, "rb"); if (fread(x, 8, n, f) != (size_t) n) exit(1); fclose(f); return x; }
static double now_ms() { return std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now().time_since_epoch()).count(); }
int main(int argc, char** argv) {
  int n = 10000000; double *x = load(argv[1], n), *y = load(argv[2], n);
  int reps = atoi(argv[4]);
  {
    int fpe = atoi(argv[3]);
    double a = exsum(n, x, 1, 0, fpe), p = exsum(n, y, 1, 0, fpe);
    int same = 0; for (int k = 0; k < reps; k++) same += bits(exsum(n, x, 1, 0, fpe)) == bits(a);
    double best = 1e30; for (int k = 0; k < 7; k++) { double t = now_ms(); volatile double s = exsum(n, x, 1, 0, fpe); (void) s; t = now_ms() - t; if (t < best) best = t; }
    printf("KEY exblas fpe %d sum %.17g bits %016lx | repeats %d of %d | permuted %.17g same_bits %d | ms %.3f\n", fpe, a, bits(a), same, reps, p, bits(a) == bits(p), best);
  }
}
