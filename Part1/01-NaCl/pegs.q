#!/bin/bash
#MOAB -l nodes=1:ppn=24
#MOAB -l walltime=4:00:00
#MOAB -A e20438
#MOAB -N pegs.q

cd $PBS_O_WORKDIR
NPROCS=`wc -l < $PBS_NODEFILE`

echo "Running on host `hostname`"
echo "Time is `date`"
echo "Directory is `pwd`"
echo ""

pegs_in="NaCl_pegs.in"
pegs_out="pegs.out"
number_runs=20

## Command to run several PEGS runs at once
# First argument = Number of Monte-Carlo steps / degree of freedom
# Second argument = Number of temperature steps
runPEGS() {
	p_runs=$1
	t_runs=$2
	dir=P${p_runs}-T${t_runs}
	if [ -e $dir ]; then
		rm -r $dir
	fi
	mkdir $dir
	cd $dir
	for i in `seq $number_runs`; do
		mkdir $i
		cd $i
		rnd=$RANDOM
		/projects/e20438/bin/pack-4.12.0.5/pack_exe -f ../../$pegs_in -P -R -r $p_runs -t $t_runs -g $rnd > $pegs_out
		cd ..
	done
	cd ..
}

## Loops through several values of "t_runs" while hold "p_runs" constan
for t in `seq 5 5 25`; do
	runPEGS 400 $t
done

for p in `seq 200 100 600`; do
	runPEGS $p 15
done
