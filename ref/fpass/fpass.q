#!/bin/bash
#MOAB -l nodes=1:ppn=1
#MOAB -l walltime=4:00:00
#MOAB -A e20438
#MOAB -N fpass.q

cd $PBS_O_WORKDIR
NPROCS=`wc -l < $PBS_NODEFILE`

echo "Running on host `hostname`"
echo "Time is `date`"
echo "Directory is `pwd`"
echo ""

number_runs=10
module load intel

for i in `seq $number_runs`; do
	if [ -d $i ]; then
		rm -r $i
	fi
	mkdir $i
	cd $i
	/projects/e20438/bin/mint/mint ../input.strc ../pot.in ../set.in -opt -disp all -name best -print espresso > stdout
	cd ..
done
