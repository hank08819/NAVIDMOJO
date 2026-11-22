#!/bin/bash
# Fig. 5 measurements on the server, taken only while the machine is otherwise idle.
# Before each program the script waits until all other processes together use less
# than 0.6 of one core (two-second sample of top; the system process systemd-udevd,
# which holds one core permanently on this machine, is not counted). Compiled programs run three times;
# every program repeats each size at least 7 times and until 0.3 s have been spent on it,
# and reports the best repetition.
cd ~/NAVIDMOJO/cacm_r1_fig5_20261121
export OMP_NUM_THREADS=16 OPENBLAS_NUM_THREADS=16 MKL_NUM_THREADS=16
PY=~/miniforge3/bin/python
R=~/NAVIDMOJO/repromojollm
quiet() {
  while true; do
    b=$(top -b -n 2 -d 2 -w 250 -c | awk '/^top -/{n++} n==2 && $1 ~ /^[0-9]+$/ && $0 !~ /top -b|systemd-udevd/ {s+=$9} END{print int(s)}')
    [ "$b" -lt 60 ] && break
    sleep 5
  done
}
q() { quiet; "$@"; }
echo "quiet run started: $(date)" > quiet_manifest.txt
for k in 1 2 3; do
  echo "RUN $k"
  q ./mc.cpp.bin; q ./mc.mojo.bin 1000 10000 100000 1000000 10000000 100000000
  q ./bt.cpp.bin; q ./bt.mojo.bin 4 40 400 4000 40000
  q ./var_blas.mojo.bin 100 500 1000 2000 5000
  quiet; ./var_gpu.mojo.bin 100 500 1000 2000 5000 2>&1 | grep KEY
done > quiet_compiled_runs.log 2>&1
q $PY mc.py numpy > quiet_numpy_mc.log 2>&1
q $PY bt.py pandas > quiet_pandas_bt.log 2>&1
q $PY var.py numpy > quiet_numpy_var.log 2>&1
q $PY bt.py python > quiet_python_bt.log 2>&1
q $PY mc.py python > quiet_python_mc.log 2>&1
q $PY var.py python 100 500 1000 2000 > quiet_python_var.log 2>&1
echo "quiet run finished: $(date); load: $(uptime)" >> quiet_manifest.txt
touch quiet.done
