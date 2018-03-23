#!/bin/bash

for a in Dy  Er  Eu  Gd  Ho  Nd
do
 echo $a
  cd $a
  ./run.sh
  cd ..

done
