#! /bin/bash

if [ $# -lt 2 ]; then
	echo "This script reads PEGS output and writes the solution in VASP"
	echo " format to screen. To get a format compatible with Mint, the "
	echo " script needs to know element names as well"
	echo "Usage: $0 <path to PEGS output> <element names...>"
	echo "Example: $0 pegs.out Na Cl"
	exit -1
fi

if [ ! -e $1 ]; then
	echo "No such file: $1"
	exit
fi
module load intel
## Get the pegs output
temp_file=$RANDOM.temp
cat $1 | awk '($1=="*P"){print $0}' | sed 's/*P //' > $temp_file
if [ `cat $temp_file | wc -l` -eq 0 ]; then 
	rm $temp_file
	echo "$1 does not contain a PEGS solution."
	exit 1
fi

## Get the element names from user input
nelem=$(( $# - 1 ))
shift
elem_names=`echo "$@"`

## Wrap up
output=$RANDOM.out
echo $elem_names > $output
awk 'NR > 1{
	if (NR == 6) {
		for (i=1; i<=NR; i++) 
			if ($i > 0) 
				printf " %d", $i
		printf "\n"
	} else {
		print $0
	}
}' $temp_file >> $output
if [ `awk 'NR == 6 {print $0}' $output | wc -w` -ne $nelem ]; then
	echo "Wrong number of elements supplied"
	rm $temp_file $output
	exit 2
fi
cat $output
rm $temp_file $output
	
