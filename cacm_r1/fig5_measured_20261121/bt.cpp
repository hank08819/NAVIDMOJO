// Fig. 5(c): moving-average crossover backtest. Same algorithm and inputs as bt.mojo.
// Build: g++ -O3 -march=native -ffp-contract=fast -fopenmp -std=c++17. 16 threads over symbols.
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <vector>
#include <omp.h>
static const int WORKERS = 16; static const long T = 2500;
static double now_ms() { return std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now().time_since_epoch()).count(); }
static double one_symbol(const double* p, long& trades) {
    double fast = 0, slow = 0;
    for (long t = 40; t < 50; t++) fast += p[t];
    for (long t = 0; t < 50; t++) slow += p[t];
    double prev = 0, pnl = 0, units = 0;
    for (long t = 49; t < T - 1; t++) {
        double s = (fast * 5.0 > slow) ? 1.0 : -1.0;
        if (s != prev) { double d = s - prev; if (d < 0) d = -d; units += d; trades++; }
        pnl += s * (p[t + 1] - p[t]);
        prev = s;
        fast += p[t + 1] - p[t - 9];
        slow += p[t + 1] - p[t - 49];
    }
    return pnl - 0.01 * units;
}
int main() {
    long counts[] = {4, 40, 400, 4000, 40000};
    for (long n_sym : counts) {
        std::vector<double> px(n_sym * T), pnl(n_sym); std::vector<long> ntr(n_sym);
        for (long s = 0; s < n_sym; s++) {
            uint64_t st = uint64_t(s + 1) * 0x9E3779B97F4A7C15ULL; double p = 100.0;
            for (long t = 0; t < T; t++) {
                st = st * 6364136223846793005ULL + 1442695040888963407ULL;
                double u = double(st >> 11) * (1.0 / 9007199254740992.0);
                p = p * (1.0 + 0.02 * (u - 0.5)); px[s * T + t] = p;
            }
        }
        double best = 1e30;
        // at least 7 repetitions, and until 0.3 s have been spent on this size (at most 2,000)
        double spent = 0;
        for (int r = 0; r < 7 || (spent < 300.0 && r < 2000); r++) {
            double t0 = now_ms();
            #pragma omp parallel for num_threads(WORKERS) schedule(dynamic, 1)
            for (long s = 0; s < n_sym; s++) { long tr = 0; pnl[s] = one_symbol(&px[s * T], tr); ntr[s] = tr; }
            double d = now_ms() - t0; spent += d; if (d < best) best = d;
        }
        double total = 0; long trades = 0;
        for (long s = 0; s < n_sym; s++) { total += pnl[s]; trades += ntr[s]; }
        printf("KEY cpp bt bars %ld ms %.6f pnl %.15g trades %ld\n", n_sym * T, best, total, trades);
    }
}
