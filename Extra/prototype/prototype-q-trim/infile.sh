#!/bin/bash

rm -rf infiles
mkdir infiles

for i in La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb
do
    mkdir infiles/$i
    for j in La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb
    do
        if [ "$i" != "$j" ]; then
            mkdir infiles/$i/$j
            echo "$i"-"$j"
            for k in cF24-Cu2Mg-trim.q cP4-Cu3Au-trim.q hP12-MgZn2-trim.q hP8-Mg3Cd-trim.q oP12-Co2Si-trim.q oS8-TlI-trim.q cF8-NaCl-trim.q cP8-Cr3Si-trim.q hP6-CaCu5-trim.q oI12-KHg2-trim.q oP16-Fe3C-trim.q tP2-AuCu-trim.q
            do
                b=$(echo $k | awk '{split($0,a,"-"); print a[1] "-" a[2]}')
                out="infiles/${i}/${j}/pw-${i}-${j}-${b}.in"
                sed "s/AAA/${i}-${j}/g" ex1 > $out

                pp1=$(head -2 $k | tail -1 | awk {'print $3'})
                ele1=$(echo ${pp1} | awk '{split($0,a,"."); print a[1]}')
                pp2=$(head -3 $k | tail -1 | awk {'print $3'})
                ele2=$(echo ${pp2} | awk '{split($0,a,"."); print a[1]}')

                sed "s/${pp1}/${i}.UPF/g" $k > tmp
                sed "s/${pp2}/${j}.UPF/g" tmp > tmp1
                sed "s/${ele1}/${i}/g" tmp1 > tmp2
                sed "s/${ele2}/${j}/g" tmp2 >> $out

                aa="${i}-${j}-${b}"
                sed "s/AAA/${aa}/g" pwscf.q > infiles/${i}/${j}/${aa}.q
                rm tmp*
            done
            cp run.sh infiles/${i}/${j}/
        fi
    done
done
