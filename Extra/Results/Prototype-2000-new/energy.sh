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


                search_atom_line=$(grep -n "atomic species" ${out} | tail -1 | awk '{split($0,a,":"); print a[1]}')
                out_atom_1=$(head -$((${search_atom_line}+1)) ${out} | tail -1 | awk '{print $1}')
                out_atom_2=$(head -$((${search_atom_line}+2)) ${out} | tail -1 | awk '{print $1}')

                search_natom_line=$(grep -n "site n.     atom" ${out} | tail -1 | awk '{split($0,a,":"); print a[1]}')
                search_natom_end=$(grep -n "tau(" ${out} | tail -1 | awk '{split($0,a,":"); print a[1]}')

                natom_1=0
                natom_2=0
            if [[ ${search_natom_line} != "" ]]; then
                ntot=$((${search_natom_end} - ${search_natom_line}))

                for count in `seq ${ntot}`
                do
                    ele_tmp=$(head -$((${count} + ${search_natom_line})) $out | tail -1 | awk '{print $2}')
                    if [[ ${ele_tmp} = ${out_atom_1} ]]; then
                        count_natom=$((${natom_1} + 1))
                        natom_1=${count_natom}
                    fi
                    if [[ ${ele_tmp} = ${out_atom_2} ]]; then
                        count_natom=$((${natom_2} + 1))
                        natom_2=${count_natom}
                    fi
                done

                at1=${natom_1}
                at2=${natom_2}


                #nat1=$(grep -c "${ele1} " protos/$k)
                #nat2=$(grep -c "${ele2} " protos/$k)
                #at1=$((${nat1}-1))
                #at2=$((${nat2}-1))

                echo "$i $at1"
                echo "$j $at2"
                aa="${i}-${j}-${b}"
                en=$(grep ! $out | tail -1 | awk '{print $5}')
                echo $en
                echo "$i    $at1    $j    $at2    $b    $en" >> energy-prototype.out
            fi
            done
        fi
    done
done
