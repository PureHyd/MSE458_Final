#!/bin/bash

# Constructs a k-point mesh given a PWSCF input file and a desired KPPRA
if [ $# -ne 2 ]; then
	echo "This script computes k-point mesh given PWSCF input file and KPPRA"
	echo "Usage: $0 <KPPRA> <PWSCF input file>"
	echo "Example: $0 8000 pwscf.in"
	exit -1
fi

KPPRA=$1 
pwscf_in=$2
module load intel
# Check input 
if [ $KPPRA -le 0 ]; then
	echo "KPPRA must be positive"
	exit 1
fi
if [ ! -e $pwscf_in ]; then
	echo "No such file: " $pwscf_in
	exit 1
fi

# Get the number of atoms
echo "Desired KPPRA    :" $KPPRA
natoms=`awk 'BEGIN {x=0} 
	/ATOMIC_POSITIONS/ { 
		getline
		while (NF == 4) { 
			x++
			if (getline == 0)
				break; 
		}
	}
	END { print x }' $pwscf_in`
if [ $natoms -eq 0 ]; then
	echo "File does not contain any atoms!"
	exit 2
fi
echo "Number of atoms  :" $natoms

# Read in unitcell parameters
unit_cell=$RANDOM.cell
awk '/CELL_PARAMETERS/ {getline; for (i=0; i<3; i++) {print; getline}}' $pwscf_in > $unit_cell
if [ `cat $unit_cell | wc -l` -ne 3 ]; then
	echo "PWSCF file is missing unit cell"
	rm $unit_cell
	exit 3
fi
a11=`awk 'NR==1 {print $1}' $unit_cell`
a12=`awk 'NR==1 {print $2}' $unit_cell`
a13=`awk 'NR==1 {print $3}' $unit_cell`
a21=`awk 'NR==2 {print $1}' $unit_cell`
a22=`awk 'NR==2 {print $2}' $unit_cell`
a23=`awk 'NR==2 {print $3}' $unit_cell`
a31=`awk 'NR==3 {print $1}' $unit_cell`
a32=`awk 'NR==3 {print $2}' $unit_cell`
a33=`awk 'NR==3 {print $3}' $unit_cell`
rm $unit_cell

# Calculate proprtional reciprocal lattice vectors
touch temp
#b11=`echo "($a22*$a33-$a23*$a32)" | bc -l`
b11=`awk 'END{printf("%f",a22*a33-a23*a32)}' a22=$a22 a33=$a33 a23=$a23 a32=$a32 < temp`

#b12=`echo "($a23*$a31-$a21*$a33)" | bc -l`
b12=`awk 'END{printf("%f",a23*a31-a21*a33)}' a23=$a23 a31=$a31 a21=$a21 a33=$a33 < temp`

#b13=`echo "($a21*$a32-$a22*$a31)" | bc -l`
b13=`awk 'END{printf("%f",a21*a32-a22*a31)}' a21=$a21 a32=$a32 a22=$a22 a31=$a31 < temp`

#b21=`echo "($a13*$a32-$a12*$a33)" | bc -l`
b21=`awk 'END{printf("%f",a13*a32-a12*a33)}' a13=$a13 a32=$a32 a12=$a12 a33=$a33 < temp`

#b22=`echo "($a11*$a33-$a13*$a31)" | bc -l`
b22=`awk 'END{printf("%f",a11*a33-a13*a31)}' a11=$a11 a33=$a33 a13=$a13 a31=$a31 < temp`

#b23=`echo "($a12*$a31-$a11*$a32)" | bc -l`
b23=`awk 'END{printf("%f",a12*a31-a11*a32)}' a12=$a12 a31=$a31 a11=$a11 a32=$a32 < temp`

#b31=`echo "($a12*$a23-$a13*$a22)" | bc -l`
b31=`awk 'END{printf("%f",a12*a23-a13*a22)}' a12=$a12 a23=$a23 a13=$a13 a22=$a22 < temp`

#b32=`echo "($a13*$a21-$a11*$a23)" | bc -l`
b32=`awk 'END{printf("%f",a13*a21-a11*a23)}' a13=$a13 a21=$a21 a11=$a11 a23=$a23 < temp`

#b33=`echo "($a11*$a22-$a12*$a21)" | bc -l`
b33=`awk 'END{printf("%f",a11*a22-a12*a21)}' a11=$a11 a22=$a22 a12=$a12 a21=$a21 < temp`

# Calculate relative magnitudes of reciprocal lattice vectors
b1=`echo "sqrt($b11^2+$b12^2+$b13^2)" | bc -l`
b2=`echo "sqrt($b21^2+$b22^2+$b23^2)" | bc -l`
b3=`echo "sqrt($b31^2+$b32^2+$b33^2)" | bc -l`
b2=`echo "$b2/$b1" | bc -l`
b3=`echo "$b3/$b1" | bc -l`
b1=1

# Determine scale factor which will give desired KPPRA
scale=1
  kx=`echo "$scale*$b1" | bc`
  ky=`echo "(($scale*$b2)/1)+1" | bc`
  kz=`echo "(($scale*$b3)/1)+1" | bc`
  kppra=`echo "$natoms*$kx*$ky*$kz" | bc`
while true
do
  kx=`echo "$scale*$b1" | bc`
  ky=`echo "(($scale*$b2)/1)+1" | bc`
  kz=`echo "(($scale*$b3)/1)+1" | bc`
  kppra=`echo "$natoms*$kx*$ky*$kz" | bc`
  if [ "$kppra" -ge "$KPPRA" ]
  then
    break
  fi
  (( scale++ ))
done
# Output K-point mesh
echo "Achieved KPPRA   :" $kppra
echo "Recommended grid :" $kx $ky $kz
rm temp
exit

