#!/bin/bash
#MSUB -l nodes=1:ppn=20
#MSUB -q short
#MSUB -l walltime=4:00:00
#MSUB -A e20438
#MSUB -N Tb-Eu-tP2-AuCu

cd $PBS_O_WORKDIR
NPROCS=`wc -l < $PBS_NODEFILE`

echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo ""

module unload intel
module unload mpi
module load espresso

mpirun -machinefile $PBS_NODEFILE -np $NPROCS pw.x < pw-Tb-Eu-tP2-AuCu.in > pw-Tb-Eu-tP2-AuCu.out
