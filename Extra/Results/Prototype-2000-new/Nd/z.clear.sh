#!/bin/bash

list=$(ls)
for a in $list
do
 echo $a
  cd $a
    rm -rf *out/
  cd ..

done
