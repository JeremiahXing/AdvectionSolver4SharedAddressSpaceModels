#!/bin/bash
#PBS -q express
#PBS -j oe
#PBS -l walltime=00:01:00,mem=32GB
#PBS -l wd
#PBS -l ncpus=48
#

e= #echo

r=10
M=4096
N=4094

ps="1 3 6 12 24 48"

for p in $ps; do
    opts= #"-P 1"
    echo ""
    if [ $p -le 24 ] ; then
	numactl="numactl --cpunodebind=0 --membind=0"
    else
	numactl=
    fi
    echo OMP_NUM_THREADS=$p $numactl ./testAdvect $opts $M $N $r
    OMP_NUM_THREADS=$p $e $numactl ./testAdvect $opts $M $N $r
    echo ""
done


exit

# OMP_NUM_THREADS=24 numactl --cpunodebind=0 --membind=0 ./testAdvect 1000 1000 100
