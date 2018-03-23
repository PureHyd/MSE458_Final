#!/bin/bash

N=1
NN=118

round=9
mkdir ~/Compete/$round

for i in `seq $N $NN`
do
  at1=$(head -$i comp_list | tail -1 | awk '{print $(NF-2)}')
  at2=$(head -$i comp_list | tail -1 | awk '{print $(NF-1)}')
  proto=$(head -$i comp_list | tail -1 | awk '{print $(NF)}')

  mkdir ~/Compete/$round/$i
  cp $at1/$at2/*${proto}* ~/Compete/$round/$i
  mkdir ~/Compete/$round/$i/new

  sed "s/ppn=4/ppn=8/g" ~/Compete/$round/$i/${at1}-${at2}-${proto}.q > tmp1
  sed "s/N -${at1}-${at2}-${proto}/N ${i}-${at1}-${at2}-${proto}/g" tmp1 > ~/Compete/$round/$i/new/${at1}-${at2}-${proto}.q
  sed "s/ecutwfc = 40.0/ecutwfc = 60.0/g" ~/Compete/$round/$i/pw-${at1}-${at2}-${proto}.in > tmp1
  sed "s/ecutrho = 160.0/ecutrho = 240.0/g" tmp1 > tmp2
  sed "s/conv_thr =  1.0d-4/conv_thr =  1.0d-6/g" tmp2 > tmp3
  sed "s/trust_radius_min = 1.0d3/trust_radius_min = 1.0d-2/g" tmp3 > tmp4
  sed "s/cell_dynamics='bfgs'/cell_dynamics='bfgs'\n   cell_factor=4.0/g" tmp4 > ~/Compete/$round/$i/new/pw-${at1}-${at2}-${proto}.in
  rm tmp*

  cd ~/Compete/$round/$i/new/
  msub ${at1}-${at2}-${proto}.q
  cd ~/Prototype-2000-new
done
