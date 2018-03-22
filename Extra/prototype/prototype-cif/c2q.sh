#!/bin/bash

for a in cF24-Cu2Mg-prototype.cif hP12-MgZn2-prototype.cif oP16-Fe3C-prototype.cif cF8-NaCl-prototype.cif hP6-CaCu5-prototype.cif oS8-TlI-prototype.cif hP8-Mg3Cd-prototype.cif tP2-AuCu-prototype.cif cP4-Cu3Au-prototype.cif oI12-KHg2-prototype.cif cP8-Cr3Si-prototype.cif oP12-Co2Si-prototype.cif

do

echo $a
b=$(echo $a | awk '{split($0,a,"-"); print a[1] "-" a[2]}')
echo $b
./cif2qe.sh $a > ${b}-prototype.q
../mint $a -print espresso
done
