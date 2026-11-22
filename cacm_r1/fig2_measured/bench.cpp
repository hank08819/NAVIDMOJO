// Three kernels, single thread. Build: clang++ -O3 -mcpu=native -ffp-contract=off -std=c++17
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
using namespace std;
static double now_ms() { return chrono::duration<double, milli>(chrono::steady_clock::now().time_since_epoch()).count(); }
static uint64_t st;
static double rnd() { st = st * 6364136223846793005ULL + 1442695040888963407ULL; return double(st >> 11) * (1.0 / 9007199254740992.0); }

static void matmul(const double* a, const double* b, double* c, long n) {
    for (long i = 0; i < n; i++)
        for (long k = 0; k < n; k++) {
            double x = a[i * n + k];
            for (long j = 0; j < n; j++) c[i * n + j] += x * b[k * n + j];
        }
}

static void qsort_it(double* a, long n) {
    vector<long> stack; stack.push_back(0); stack.push_back(n - 1);
    while (!stack.empty()) {
        long hi = stack.back(); stack.pop_back();
        long lo = stack.back(); stack.pop_back();
        while (hi - lo > 16) {
            long mid = lo + (hi - lo) / 2;
            double x = a[lo], y = a[mid], z = a[hi], p;
            if (x < y) { p = (y < z) ? y : ((x < z) ? z : x); } else { p = (x < z) ? x : ((y < z) ? z : y); }
            long i = lo, j = hi;
            while (i <= j) {
                while (a[i] < p) i++;
                while (a[j] > p) j--;
                if (i <= j) { double t = a[i]; a[i] = a[j]; a[j] = t; i++; j--; }
            }
            if (j - lo < hi - i) { stack.push_back(i); stack.push_back(hi); hi = j; }
            else { stack.push_back(lo); stack.push_back(j); lo = i; }
        }
        for (long i = lo + 1; i <= hi; i++) {
            double v = a[i]; long j = i - 1;
            while (j >= lo && a[j] > v) { a[j + 1] = a[j]; j--; }
            a[j + 1] = v;
        }
    }
}

static const double P10[10] = {1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000, 1000000000};
struct Sums { int64_t ts, sym, qty, rec; double px; };
static Sums parse(const unsigned char* s, long n) {
    Sums r{0, 0, 0, 0, 0.0};
    long i = 0;
    while (i < n) {
        while (s[i] != ':') i++; i++;
        int64_t ts = 0; while (s[i] >= '0' && s[i] <= '9') { ts = ts * 10 + (s[i] - '0'); i++; }
        while (s[i] != ':') i++; i += 2;
        int64_t h = 0; while (s[i] != '"') { h += s[i]; i++; }
        while (s[i] != ':') i++; i++;
        int64_t m = 0; while (s[i] >= '0' && s[i] <= '9') { m = m * 10 + (s[i] - '0'); i++; }
        long k = 0;
        if (s[i] == '.') { i++; while (s[i] >= '0' && s[i] <= '9') { m = m * 10 + (s[i] - '0'); i++; k++; } }
        while (s[i] != ':') i++; i++;
        int64_t q = 0; while (s[i] >= '0' && s[i] <= '9') { q = q * 10 + (s[i] - '0'); i++; }
        while (s[i] != '\n') i++; i++;
        r.ts += ts; r.sym += h; r.px += double(m) / P10[k]; r.qty += q; r.rec++;
    }
    return r;
}

int main(int argc, char** argv) {
    { long n = 512; st = 1; vector<double> a(n * n), b(n * n), c(n * n);
      for (auto& v : a) v = rnd(); for (auto& v : b) v = rnd();
      double best = 1e30;
      for (int t = 0; t < 5; t++) { fill(c.begin(), c.end(), 0.0); double t0 = now_ms(); matmul(a.data(), b.data(), c.data(), n); double d = now_ms() - t0; if (d < best) best = d; }
      double s = 0; for (auto v : c) s += v;
      printf("KEY matmul ms %.3f checksum %.6f\n", best, s); }
    { long n = 2000000; st = 7; vector<double> x(n), a(n); for (auto& v : x) v = rnd();
      double best = 1e30;
      for (int t = 0; t < 5; t++) { a = x; double t0 = now_ms(); qsort_it(a.data(), n); double d = now_ms() - t0; if (d < best) best = d; }
      long bad = 0; for (long i = 1; i < n; i++) if (a[i - 1] > a[i]) bad++;
      printf("KEY sort ms %.3f unsorted %ld median %.17g\n", best, bad, a[n / 2]); }
    { ifstream f(argv[1], ios::binary); stringstream ss; ss << f.rdbuf(); string s = ss.str();
      double best = 1e30; Sums r{};
      for (int t = 0; t < 5; t++) { double t0 = now_ms(); r = parse((const unsigned char*)s.data(), (long)s.size()); double d = now_ms() - t0; if (d < best) best = d; }
      printf("KEY parse ms %.3f records %lld ts %lld sym %lld qty %lld px %.6f\n", best, (long long)r.rec, (long long)r.ts, (long long)r.sym, (long long)r.qty, r.px); }
}
