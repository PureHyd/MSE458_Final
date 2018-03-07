#!/bin/bash
############## parameters ##############
T1=5
T2=5
T3=25
P=400

P1=200
P2=100
P3=600
T=15

N=20

############## data collection ##############

rm -f energy.T energy.P

for i in `seq $T1 $T2 $T3` ; do
  cd 'P'$P'-T'$i
  echo '!  P'$P'-T'$i >> ../energy.T
  for j in `seq $N`; do
    cd $j
    grep 'ecc' *.out | tail -1 | awk {'print $4'} >> ../../energy.T
    cd ..
  done
  cd ..
done 

echo "Done T!"

for i in `seq $P1 $P2 $P3` ; do
  cd 'P'$i'-T'$T
  echo '!  P'$i'-T'$T >> ../energy.P
  for j in `seq $N`; do
    cd $j
    grep 'ecc' *.out | tail -1 | awk {'print $4'} >> ../../energy.P
    cd ..
  done
  cd ..
done 

echo "Done P!"

