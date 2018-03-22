#!/bin/bash

list=$(ls)
for a in $list
do
 echo $a
  cd $a
 # ./run.sh
  rm -rf out/
  cd ..

done
