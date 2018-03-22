#!/bin/bash

list=$(ls)
for a in $list
do
  cd $a
  rm -rf out/
  cd ..
done
