#!/bin/bash

list=$(ls)
for a in $list
do
  cd $a
  q=$(ls *.q)
  msub $q
  cd ..
done
