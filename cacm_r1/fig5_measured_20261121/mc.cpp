// Fig. 5(a): Monte Carlo European call. Build: g++ -O3 -march=native -ffp-contract=fast -fopenmp -std=c++17
// Same paths and same chunking as mc.mojo: 16 threads, one chunk per thread.
#include <chrono>
#include <cmath>
#include <cstdint>
#include <cstdio>
#include <omp.h>
static const int WORKERS = 16;
static double now_ms() { return std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now().time_since_epoch()).count(); }
static inline double payoff(long i) {
    uint64_t st = uint64_t(i + 1) * 0x9E3779B97F4A7C15ULL;
    st = st * 6364136223846793005ULL + 1442695040888963407ULL;
    double u1 = (double(st >> 11) + 0.5) * (1.0 / 9007199254740992.0);
    st = st * 6364136223846793005ULL + 1442695040888963407ULL;
    double u2 = (double(st >> 11) + 0.5) * (1.0 / 9007199254740992.0);
    double z = std::sqrt(-2.0 * std::log(u1)) * std::cos(6.283185307179586 * u2);
    double st_ = 100.0 * std::exp((0.05 - 0.5 * 0.2 * 0.2) * 1.0 + 0.2 * z);
    double p = st_ - 100.0;
    return p < 0.0 ? 0.0 : p;
}
static double price(long n) {
    double partial[WORKERS];
    long chunk = (n + WORKERS - 1) / WORKERS;
    #pragma omp parallel for num_threads(WORKERS) schedule(static, 1)
    for (int w = 0; w < WORKERS; w++) {
        long lo = w * chunk, hi = lo + chunk; if (hi > n) hi = n;
        double s = 0.0;
        for (long i = lo; i < hi; i++) s += payoff(i);
        partial[w] = s;
    }
    double total = 0.0;
    for (int w = 0; w < WORKERS; w++) total += partial[w];
    return std::exp(-0.05) * total / double(n);
}
int main() {
    long sizes[] = {1000, 10000, 100000, 1000000, 10000000, 100000000};
    for (long n : sizes) {
        double best = 1e30, pr = 0;
        // at least 7 repetitions, and until 0.3 s have been spent on this size (at most 2,000)
        double spent = 0;
        for (int t = 0; t < 7 || (spent < 300.0 && t < 2000); t++) { double t0 = now_ms(); pr = price(n); double d = now_ms() - t0; spent += d; if (d < best) best = d; }
        printf("KEY cpp mc n %ld ms %.6f price %.15g\n", n, best, pr);
    }
}
