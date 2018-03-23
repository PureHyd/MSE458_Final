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

rm -f time.T time.P

for i in `seq $T1 $T2 $T3` ; do
  cd 'P'$P'-T'$i
  echo '!  P'$P'-T'$i >> ../time.T
  for j in `seq $N`; do
    cd $j
    grep time *.out | tail -2 | head -1 | awk '{print $8}' >> ../../time.T
    cd ..
  done
  cd ..
done 

echo "Done T!"

for i in `seq $P1 $P2 $P3` ; do
  cd 'P'$i'-T'$T
  echo '!  P'$i'-T'$T >> ../time.P
  for j in `seq $N`; do
    cd $j
    grep time *.out | tail -2 | head -1 | awk '{print $8}' >> ../../time.P
    cd ..
  done
  cd ..
done 

echo "Done P!"

