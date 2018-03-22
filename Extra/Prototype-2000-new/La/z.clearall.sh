#!/bin/bash

for a in Ce  Dy  Er  Eu  Gd  Ho  Nd  Pm  Pr  Sm  Tb  Tm  Yb
do
 echo $a
  cd $a
    rm -rf out/
  cd ..

done
