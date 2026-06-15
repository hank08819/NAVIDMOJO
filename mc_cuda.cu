/*
 * Monte Carlo option pricer -- CUDA C reference kernel.
 * Targets GPU 0 only; the second GPU is never touched.
 *
 * Compile:
 *   nvcc -O3 -arch=sm_90 mc_cuda.cu -lcurand -o mc_cuda   # H100  (sm_90)
 *   nvcc -O3 -arch=sm_80 mc_cuda.cu -lcurand -o mc_cuda   # A100  (sm_80)
 *   nvcc -O3 -arch=sm_89 mc_cuda.cu -lcurand -o mc_cuda   # RTX 4090 (sm_89)
 *
 * Run:
 *   ./mc_cuda
 */

#include <cuda_runtime.h>
#include <curand_kernel.h>
#include <stdio.h>
#include <math.h>
#include <time.h>

#define BLOCK_SIZE 256
#define CHECK(call)                                                    \
    do {                                                               \
        cudaError_t e = (call);                                        \
        if (e != cudaSuccess) {                                        \
            fprintf(stderr, "CUDA error %s:%d  %s\n",                 \
                    __FILE__, __LINE__, cudaGetErrorString(e));        \
            exit(1);                                                   \
        }                                                              \
    } while (0)

__global__ void mc_kernel(float* out, int n_paths,
                           float S, float K, float r,
                           float sigma, float T,
                           unsigned long long seed)
{
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx >= n_paths) return;

    curandState state;
    curand_init(seed, (unsigned long long)idx, 0, &state);

    float z  = curand_normal(&state);
    float ST = S * expf((r - 0.5f * sigma * sigma) * T
                        + sigma * sqrtf(T) * z);
    out[idx] = fmaxf(ST - K, 0.0f) * expf(-r * T);
}

__global__ void reduce_sum(float* in, double* out, int n)
{
    __shared__ double sdata[BLOCK_SIZE];
    int tid = threadIdx.x;
    int i   = blockIdx.x * blockDim.x + threadIdx.x;
    sdata[tid] = (i < n) ? (double)in[i] : 0.0;
    __syncthreads();
    for (int s = blockDim.x / 2; s > 0; s >>= 1) {
        if (tid < s) sdata[tid] += sdata[tid + s];
        __syncthreads();
    }
    if (tid == 0) atomicAdd(out, sdata[0]);
}

/* buffers for the largest run, allocated once in main() and reused */
static float*  g_d_out = NULL;
static double* g_d_sum = NULL;
static int     g_alloc = 0;

void ensure_alloc(int n_paths) {
    if (n_paths <= g_alloc) return;
    if (g_d_out) { cudaFree(g_d_out); cudaFree(g_d_sum); }
    CHECK(cudaMalloc(&g_d_out, (size_t)n_paths * sizeof(float)));
    CHECK(cudaMalloc(&g_d_sum, sizeof(double)));
    g_alloc = n_paths;
}

double run(int n_paths) {
    CHECK(cudaMemset(g_d_sum, 0, sizeof(double)));

    int grid = (n_paths + BLOCK_SIZE - 1) / BLOCK_SIZE;
    mc_kernel<<<grid, BLOCK_SIZE>>>(g_d_out, n_paths,
                                    100.f, 100.f, 0.05f,
                                    0.2f,  1.0f,  42ULL);
    reduce_sum<<<grid, BLOCK_SIZE>>>(g_d_out, g_d_sum, n_paths);
    CHECK(cudaDeviceSynchronize());

    double h_sum = 0.0;
    CHECK(cudaMemcpy(&h_sum, g_d_sum, sizeof(double), cudaMemcpyDeviceToHost));
    return h_sum / n_paths;
}

double wall_ms() {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec * 1e3 + ts.tv_nsec * 1e-6;
}

int main(void) {
    int device_count = 0;
    CHECK(cudaGetDeviceCount(&device_count));
    printf("GPUs detected: %d  -- using GPU 0 only\n", device_count);

    cudaDeviceProp prop;
    CHECK(cudaGetDeviceProperties(&prop, 0));
    printf("GPU 0: %s\n\n", prop.name);

    int sizes[] = {1000000, 10000000, 100000000};
    int repeats = 10;

    /* pre-allocate for the largest run so timing is kernel-only */
    CHECK(cudaSetDevice(0));
    ensure_alloc(sizes[2]);

    printf("%12s  %18s  %8s\n", "Paths", "CUDA C (ms)", "Price");
    printf("%s\n", "--------------------------------------------");

    for (int s = 0; s < 3; s++) {
        int n = sizes[s];
        /* warm up */
        for (int w = 0; w < 3; w++) run(n);

        double t0 = wall_ms();
        double price = 0.0;
        for (int r = 0; r < repeats; r++) price = run(n);
        double elapsed = (wall_ms() - t0) / repeats;

        printf("%12d  %18.2f  %8.4f\n", n, elapsed, price);
    }
    cudaFree(g_d_out);
    cudaFree(g_d_sum);
    return 0;
}
