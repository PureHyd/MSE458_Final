#!/bin/bash

list=$(ls)
for a in $list
do
b=$(echo $a | awk '{split($0,a,"."); print a[1]}')
ntail=$(sed -n '/ATOMIC_SPECIES/=' $a)
ntot=$(wc -l < $a)
ntrim=$(($ntot-$ntail+1))
tail -$ntrim $a > ../single-q-trim/${b}-trim.q
done

