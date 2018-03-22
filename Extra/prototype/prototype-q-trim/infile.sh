#!/bin/bash

rm -rf infiles
mkdir infiles

for i in La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb
do
    mkdir infiles/$i
    cp z.runall.sh infiles/$i
    for j in La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb
    do
        if [ "$i" != "$j" ]; then
            mkdir infiles/$i/$j
            echo "$i"-"$j"
            for k in cF24-Cu2Mg-trim.q cP4-Cu3Au-trim.q hP12-MgZn2-trim.q hP8-Mg3Cd-trim.q oP12-Co2Si-trim.q oS8-TlI-trim.q cF8-NaCl-trim.q cP8-Cr3Si-trim.q hP6-CaCu5-trim.q oI12-KHg2-trim.q oP16-Fe3C-trim.q tP2-AuCu-trim.q
            do
                b=$(echo $k | awk '{split($0,a,"-"); print a[1] "-" a[2]}')
                out="infiles/${i}/${j}/pw-${i}-${j}-${b}.in"
                sed "s/AAA/${b}/g" ex1 > tmp1

                pp1=$(head -2 $k | tail -1 | awk {'print $3'})
                ele1="$(echo ${pp1} | awk '{split($0,a,"."); print a[1]}') "
                pp2=$(head -3 $k | tail -1 | awk {'print $3'})
                ele2="$(echo ${pp2} | awk '{split($0,a,"."); print a[1]}') "

                sed "s/${pp1}/${i}.UPF/g" $k > tmp2
                sed "s/${pp2}/${j}.UPF/g" tmp2 >> tmp1
                #sed "s/${ele1}/${i}/g" tmp1 > tmp2
                #sed "s/${ele2}/${j}/g" tmp2 >> $out

                nat1=$(grep -c "${ele1} " tmp1)
                nat2=$(grep -c "${ele2} " tmp1)
                nat=$((${nat1}+${nat2}-2))
                sed "s/BBB/${nat}/g" tmp1 > tmp2 #$out

                aa="${i}-${j}-${b}"
                sed "s/AAA/${aa}/g" pwscf.q > infiles/${i}/${j}/${aa}.q

                nk_grep=$(grep -A2 K_POINTS tmp2 | tail -2 )
                echo ${nk_grep}
                new_nk=$(./k_mesh.sh 2000 tmp2 | tail -1 | awk '{print "    "  $NF-2 "  " $NF-1 "  " $NF " 0  0  0"}')
                echo ${new_nk}
                sed "s/${nk_grep}/${new_nk}/g" tmp2 > $out

                rm tmp*
            done
            cp run.sh infiles/${i}/${j}/
        fi
    done
done
rm -rf ~/Prototype-2000
cp -r infiles/ ~/Prototype-2000
