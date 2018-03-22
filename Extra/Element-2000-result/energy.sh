#!/bin/bash

rm -f energy.out
for i in La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb
do
    in="${i}/pw-${i}.in"
    out="${i}/pw-${i}.out"
    nat=$(grep nat ${in} | awk '{print $3}' | awk '{split($0,a,","); print a[1]}')  
    en=$(grep ! $out | tail -1 | awk '{print $5}')

    enatom=$(echo "${en}/${nat}" | bc -l)
    echo "$i  ${enatom}" >> energy.out

done
