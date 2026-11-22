#!/bin/bash
# Runs the ExBLAS test and the Mojo-calls-ReproBLAS check; everything has a timeout.
cd ~/NAVIDMOJO/cacm_r1_reprolibs_20261121
E=$PWD/exenv/.pixi/envs/default; CXX=$E/bin/x86_64-conda_cos6-linux-gnu-g++
$CXX -O3 -march=native -std=c++11 -fopenmp test_exblas.cpp -Iexblas/include -Iexblas/build/include -I$E/include exblas/build/src/cpu/libexblas.a -L$E/lib -Wl,-rpath,$E/lib -ltbb -lpthread -o test_exblas
for c in 0 0-15; do for k in 1 2 3; do echo "CORES $c"; taskset -c $c timeout 300 ./test_exblas x.bin x_perm.bin 3 200; done; echo "CORES $c"; taskset -c $c timeout 300 ./test_exblas x.bin x_perm.bin 0 3; done > exblas_runs.log 2>&1
P="timeout 400 $HOME/.pixi/bin/pixi run --manifest-path mojo100b1/pixi.toml"
B=$PWD/reproblas/ReproBLAS/build/release/Linux-x86_64/src
{ $P mojo build mojo_calls_reproblas.mojo -o mcr.bin -Xlinker -L$B/reproBLAS/obj -Xlinker -L$B/binnedBLAS/obj -Xlinker -L$B/binned/obj -Xlinker -lreproblas -Xlinker -lbinnedblas -Xlinker -lbinned -Xlinker -lm; echo "build exit $?"; timeout 120 ./mcr.bin; echo "run exit $?"; } > mojo_calls_reproblas.log 2>&1
echo DONE > rest.done
