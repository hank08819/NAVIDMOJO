// ReproBLAS against a naive sum: bits under permutation and under partition (OpenMP threads), and time.
// Build: gcc -O3 -march=native -fopenmp test_reproblas.c -I<ReproBLAS>/include -L<lib> -lreproblas -lbinnedblas -lbinned -lm
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <time.h>
#include <omp.h>
#include <binned.h>
#include <binnedBLAS.h>
#include <reproBLAS.h>
#define FOLD 3
static double now_ms(void){ struct timespec t; clock_gettime(CLOCK_MONOTONIC,&t); return t.tv_sec*1e3+t.tv_nsec*1e-6; }
static uint64_t bits(double d){ uint64_t u; memcpy(&u,&d,8); return u; }
static double *load(const char *p, long n){ double *x=malloc(8*n); FILE *f=fopen(p,"rb"); if(fread(x,8,n,f)!=(size_t)n) exit(1); fclose(f); return x; }

static double naive_part(const double *x, long n, int T){
    double part[64]; long chunk=(n+T-1)/T;
    #pragma omp parallel for num_threads(T) schedule(static,1)
    for(int w=0;w<T;w++){ long lo=w*chunk, hi=lo+chunk; if(hi>n) hi=n; double s=0; for(long i=lo;i<hi;i++) s+=x[i]; part[w]=s; }
    double t=0; for(int w=0;w<T;w++) t+=part[w]; return t;
}
static double repro_part(const double *x, long n, int T){
    double_binned *acc[64]; long chunk=(n+T-1)/T;
    for(int w=0;w<T;w++){ acc[w]=binned_dballoc(FOLD); binned_dbsetzero(FOLD,acc[w]); }
    #pragma omp parallel for num_threads(T) schedule(static,1)
    for(int w=0;w<T;w++){ long lo=w*chunk, hi=lo+chunk; if(hi>n) hi=n; if(hi>lo) binnedBLAS_dbdsum(FOLD,(int)(hi-lo),x+lo,1,acc[w]); }
    for(int w=1;w<T;w++) binned_dbdbadd(FOLD,acc[w],acc[0]);
    double r=binned_ddbconv(FOLD,acc[0]); for(int w=0;w<T;w++) free(acc[w]); return r;
}
int main(int argc,char**argv){
    long n=10000000; double *x=load(argv[1],n), *y=load(argv[2],n);
    double a=naive_part(x,n,1), ap=naive_part(y,n,1), r=reproBLAS_dsum((int)n,x,1), rp=reproBLAS_dsum((int)n,y,1);
    printf("KEY naive      sum %.17g bits %016lx | permuted %.17g same_bits %d\n",a,bits(a),ap,bits(a)==bits(ap));
    printf("KEY reproblas  sum %.17g bits %016lx | permuted %.17g same_bits %d (fold %d)\n",r,bits(r),rp,bits(r)==bits(rp),FOLD);
    int sn=0,sr=0;
    for(int T=1;T<=16;T++){ double u=naive_part(x,n,T), v=repro_part(x,n,T); sn+=bits(u)==bits(a); sr+=bits(v)==bits(r); }
    printf("KEY naive_identical_over_thread_counts %d of 16\nKEY reproblas_identical_over_thread_counts %d of 16\n",sn,sr);
    int rep=0; for(int k=0;k<200;k++) rep+=bits(repro_part(x,n,16))==bits(r);
    printf("KEY reproblas_repeats_identical %d of 200\n",rep);
    double bn=1e30,br=1e30,bn16=1e30,br16=1e30; volatile double sink=0;
    for(int k=0;k<7;k++){ double t=now_ms(); sink+=naive_part(x,n,1); t=now_ms()-t; if(t<bn) bn=t;
        t=now_ms(); sink+=reproBLAS_dsum((int)n,x,1); t=now_ms()-t; if(t<br) br=t;
        t=now_ms(); sink+=naive_part(x,n,16); t=now_ms()-t; if(t<bn16) bn16=t;
        t=now_ms(); sink+=repro_part(x,n,16); t=now_ms()-t; if(t<br16) br16=t; }
    printf("KEY time_ms naive_1 %.3f reproblas_1 %.3f naive_16 %.3f reproblas_16 %.3f\n",bn,br,bn16,br16);
    return 0;
}
