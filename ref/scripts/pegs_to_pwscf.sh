#!/bin/bash

pegs_out=$1
pw_temp=$2
pw_in=$3

#pegs_out="NaAlH4_pegs.out"
#pw_temp="NaAlH4_pwscf_template.in"
#pw_in="NaAlH4_rocksalt_cell_relax_pw.in"

conversion=1.8897 #bohr radii per angstrom

# Read in unitcell parameters
scale=`cat $pegs_out | awk '($1=="*P"){print $2,$3,$4}' | sed 's/*P //' | head -2 | tail -1`
a11=`cat $pegs_out | awk '($1=="*P"){print $2}' | sed 's/*P //' | head -3 | tail -1`
a12=`cat $pegs_out | awk '($1=="*P"){print $3}' | sed 's/*P //' | head -3 | tail -1`
a13=`cat $pegs_out | awk '($1=="*P"){print $4}' | sed 's/*P //' | head -3 | tail -1`
a21=`cat $pegs_out | awk '($1=="*P"){print $2}' | sed 's/*P //' | head -4 | tail -1`
a22=`cat $pegs_out | awk '($1=="*P"){print $3}' | sed 's/*P //' | head -4 | tail -1`
a23=`cat $pegs_out | awk '($1=="*P"){print $4}' | sed 's/*P //' | head -4 | tail -1`
a31=`cat $pegs_out | awk '($1=="*P"){print $2}' | sed 's/*P //' | head -5 | tail -1`
a32=`cat $pegs_out | awk '($1=="*P"){print $3}' | sed 's/*P //' | head -5 | tail -1`
a33=`cat $pegs_out | awk '($1=="*P"){print $4}' | sed 's/*P //' | head -5 | tail -1`
# Convert unitcell parameters to bohr radii
scale=`echo "$scale*$conversion" | bc -l`
a11=`echo "$a11*$scale" | bc -l`
a12=`echo "$a12*$scale" | bc -l`
a13=`echo "$a13*$scale" | bc -l`
a21=`echo "$a21*$scale" | bc -l`
a22=`echo "$a22*$scale" | bc -l`
a23=`echo "$a23*$scale" | bc -l`
a31=`echo "$a31*$scale" | bc -l`
a32=`echo "$a32*$scale" | bc -l`
a33=`echo "$a33*$scale" | bc -l`

# Convert PEGS output structure to PWSCF intput
file_len=`cat $pegs_out | awk '($1=="*P"){print $2,$3,$4}' | sed 's/*P //' | wc -l`
atom_len=`echo "$file_len-7" | bc`
num_atom_types=`cat $pegs_out | awk '($1=="*P"){print $0}' | sed 's/*P //' | head -6 | tail -1 | wc -w`
type_temp=`cat $pegs_out | awk '($1=="*P"){print $0}' | sed 's/*P //' | head -6 | tail -1`
atom_types=( `echo "$type_temp"` )
name_temp=`awk '/ATOMIC_SPECIES/ {getline; while (NF != 0) {print $1; getline;}}' $pw_temp`
atom_names=( `echo "$name_temp"` )
cat $pw_temp | sed -e "/CELL_PARAMETERS/a$a11 $a12 $a13\n$a21 $a22 $a23\n$a31 $a32 $a33" > $pw_in
k=0
for ((i=0; i<$num_atom_types; i++))
do
  for ((j=0; j<${atom_types[i]}; j++))
  do
    (( k++ ))
    cat $pegs_out | awk '($1=="*P"){print $0}' | sed 's/*P //' | tail -$atom_len | sed -n "$k s/^/${atom_names[i]} /p" >> $pw_in
  done
done
exit
