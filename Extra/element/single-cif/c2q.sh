#!/bin/bash

list=$(ls)
for a in ${list}

do

echo $a
b=$(echo $a | awk '{split($0,a,"_"); print a[1]}')
echo $b
./cif2qe.sh $a > ${b}.in
#../mint $a -print espresso
done
