#!/bin/bash

for a in cF24-Cu2Mg-prototype.q cP8-Cr3Si-prototype.q hP8-Mg3Cd-prototype.q oP16-Fe3C-prototype.q cF8-NaCl-prototype.q hP12-MgZn2-prototype.q oI12-KHg2-prototype.q oS8-TlI-prototype.q cP4-Cu3Au-prototype.q hP6-CaCu5-prototype.q oP12-Co2Si-prototype.q tP2-AuCu-prototype.q
do
b=$(echo $a | awk '{split($0,a,"-"); print a[1] "-" a[2]}')
ntail=$(sed -n '/ATOMIC_SPECIES/=' $a)
ntot=$(wc -l < $a)
ntrim=$(($ntot-$ntail+1))
tail -$ntrim $a > ../prototype-q-trim/${b}-trim.q
done

