#!/bin/bash

for a in  Pm  Pr  Sm  Tb  Tm  Yb
do
 echo $a
  cd $a
  ./run.sh
  cd ..

done
