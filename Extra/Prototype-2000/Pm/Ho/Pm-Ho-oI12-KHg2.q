#!/bin/bash
#MSUB -l nodes=1:ppn=4
#MSUB -q short
#MSUB -l walltime=4:00:00
#MSUB -A e20438
#MSUB -N Pm-Ho-oI12-KHg2

cd $PBS_O_WORKDIR
NPROCS=`wc -l < $PBS_NODEFILE`

echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo ""

module unload intel
module unload mpi
module load espresso

mpirun -machinefile $PBS_NODEFILE -np $NPROCS pw.x < pw-Pm-Ho-oI12-KHg2.in > pw-Pm-Ho-oI12-KHg2.out