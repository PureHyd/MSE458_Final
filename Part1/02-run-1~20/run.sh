#!/bin/bash

for a in `seq 20`
do
  echo $a
  sed "s/AAA/$a/g" pwscf.q > pwscf-$a.q
  msub pwscf-$a.q
done
