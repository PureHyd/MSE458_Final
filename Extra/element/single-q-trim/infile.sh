#!/bin/bash

rm -rf infiles
mkdir infiles

for i in La Ce Pr Nd Pm Sm Eu Gd Tb Dy Ho Er Tm Yb
do
    mkdir infiles/$i
            echo "$i"
                out="infiles/${i}/pw-${i}.in"
                sed "s/AAA/${i}.q/g" ex1 > tmp1

                pp=$(head -2 ${i}-trim.q | tail -1 | awk {'print $3'})

                sed "s/${pp}/${i}.UPF/g" ${i}-trim.q > tmp2

                nat1=$(grep -c "${i} " tmp2)
                nat=$((${nat1}-1))
                sed "s/BBB/${nat}/g" tmp1 > tmp3
                cat tmp3 tmp2 > tmp1

                sed "s/AAA/${i}/g" pwscf.q > infiles/${i}/${i}.q

                nk_grep=$(grep -A2 K_POINTS tmp1 | tail -2 )
                echo ${nk_grep}
                new_nk=$(./k_mesh.sh 8000 tmp1 | tail -1 | awk '{print "    "  $NF-2 "  " $NF-1 "  " $NF " 0  0  0"}')
                echo ${new_nk}
                sed "s/${nk_grep}/${new_nk}/g" tmp1 > $out

                rm tmp*
done
