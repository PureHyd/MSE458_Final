#!/bin/bash
#MSUB -l nodes=1:ppn=4
#MSUB -q short
#MSUB -l walltime=4:00:00
#MSUB -A e20438
#MSUB -N Pr-Nd-hP6-CaCu5

cd $PBS_O_WORKDIR
NPROCS=`wc -l < $PBS_NODEFILE`

echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo ""

module unload intel
module unload mpi
module load espresso

mpirun -machinefile $PBS_NODEFILE -np $NPROCS pw.x < pw-Pr-Nd-hP6-CaCu5.in > pw-Pr-Nd-hP6-CaCu5.out

rm -rf ./hP6-CaCu5-out/