// CUB DeviceReduce at its three determinism levels: bits under repetition and permutation, and time.
// Build: nvcc -O3 -std=c++17 -I cccl/cub -I cccl/thrust -I cccl/libcudacxx/include test_cub.cu
#include <cub/device/device_reduce.cuh>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <cuda/__execution/determinism.h>
#include <cuda/__execution/require.h>
#include <cuda/std/functional>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstring>
#include <vector>
static uint64_t bits(double d) { uint64_t u; memcpy(&u, &d, 8); return u; }
static std::vector<double> load(const char* p, long n) { std::vector<double> x(n); FILE* f = fopen(p, "rb"); if (fread(x.data(), 8, n, f) != (size_t) n) exit(1); fclose(f); return x; }
static double now_ms() { return std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now().time_since_epoch()).count(); }

template <class Env>
static double red(const thrust::device_vector<double>& d, thrust::device_vector<double>& out, const Env& env) {
  auto err = cub::DeviceReduce::Reduce(d.begin(), out.begin(), (int) d.size(), cuda::std::plus<double>{}, 0.0, env);
  if (err != cudaSuccess) { printf("CUB error %d\n", (int) err); exit(2); }
  cudaDeviceSynchronize();
  return thrust::host_vector<double>(out)[0];
}
template <class Env>
static void run(const char* name, const thrust::device_vector<double>& dx, const thrust::device_vector<double>& dy, const Env& env) {
  thrust::device_vector<double> out(1);
  double a = red(dx, out, env), p = red(dy, out, env);
  int same = 0; for (int k = 0; k < 200; k++) same += bits(red(dx, out, env)) == bits(a);
  double best = 1e30;
  for (int k = 0; k < 50; k++) {
    double t = now_ms();
    cub::DeviceReduce::Reduce(dx.begin(), out.begin(), (int) dx.size(), cuda::std::plus<double>{}, 0.0, env);
    cudaDeviceSynchronize(); t = now_ms() - t; if (t < best) best = t;
  }
  printf("KEY cub %-14s sum %.17g bits %016lx | repeats %d of 200 | permuted %.17g same_bits %d | ms %.4f\n", name, a, bits(a), same, p, bits(a) == bits(p), best);
}
int main(int argc, char** argv) {
  long n = 10000000; auto x = load(argv[1], n), y = load(argv[2], n);
  thrust::device_vector<double> dx(x.begin(), x.end()), dy(y.begin(), y.end());
  run("not_guaranteed", dx, dy, cuda::execution::require(cuda::execution::determinism::not_guaranteed));
  run("run_to_run", dx, dy, cuda::execution::require(cuda::execution::determinism::run_to_run));
  run("gpu_to_gpu", dx, dy, cuda::execution::require(cuda::execution::determinism::gpu_to_gpu));
}
