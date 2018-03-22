#!/bin/bash

list=$(ls *.q)
for a in $list
do
echo $a
msub $a
done
