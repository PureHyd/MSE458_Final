#!/bin/bash

rm -f energy-prototype.out

for i in La Ce Pr Nd Sm Eu Gd Tb Dy Ho Er Tm Yb
do
    for j in La Ce Pr Nd Sm Eu Gd Tb Dy Ho Er Tm Yb
    do
        if [ "$i" != "$j" ]; then
            echo "$i"-"$j"
            for k in cF24-Cu2Mg-trim.q cP4-Cu3Au-trim.q hP12-MgZn2-trim.q hP8-Mg3Cd-trim.q oP12-Co2Si-trim.q cF8-NaCl-trim.q cP8-Cr3Si-trim.q hP6-CaCu5-trim.q tP2-AuCu-trim.q
            do
                b=$(echo $k | awk '{split($0,a,"-"); print a[1] "-" a[2]}')
                out="${i}/${j}/pw-${i}-${j}-${b}.out"

                pp1=$(head -2 protos/$k | tail -1 | awk {'print $3'})
                ele1="$(echo ${pp1} | awk '{split($0,a,"."); print a[1]}') "
                pp2=$(head -3 protos/$k | tail -1 | awk {'print $3'})
                ele2="$(echo ${pp2} | awk '{split($0,a,"."); print a[1]}') "


                nat1=$(grep -c "${ele1} " protos/$k)
                nat2=$(grep -c "${ele2} " protos/$k)
                at1=$((${nat1}-1))
                at2=$((${nat2}-1))

                echo "$i $at1"

                echo "$j $at2"

                aa="${i}-${j}-${b}"

                en=$(grep ! $out | tail -1 | awk '{print $5}')
                echo $en

                echo "$i    $at1    $j    $at2    $b    $en" >> energy-prototype.out
            done
        fi
    done
done
