#!/bin/bash
for i in 5 10 15 20 ; do
cd 'P400-T'$i
echo 'P400'-'-T'-$i >> ~/final/pegs/energy
for j in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20; do
cd $j
grep 'ecc' *.out | tail -1 >> ~/final/pegs/energy
cd ..
done

cd ..
done 

echo "dsdhhjfhj"

