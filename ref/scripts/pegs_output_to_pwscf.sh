#! /bin/bash

if [ $# -lt 2 ]; then
	echo "This script reads PEGS output and writes the solution in PWSCF"
	echo " format to screen."
	echo "Usage: $0 <path to PEGS output> <element names...>"
	echo "Example: $0 pegs.out Na Cl"
	exit -1
fi

if [ ! -e $1 ]; then
	echo "No such file: $1"
	exit
fi

module load intel
vasp_temp=$RANDOM.temp
/projects/e20438/final/scripts/pegs_output_to_vasp.sh $@ > $vasp_temp
if [ $? -ne 0 ]; then
	echo "Conversion failed due to:"
	cat $vasp_temp
	rm $vasp_temp
	exit 1
fi

## Convert to QE
/projects/e20438/bin/mint/mint $vasp_temp -print qe screen 
rm $vasp_temp
