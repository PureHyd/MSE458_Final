#!/bin/bash
#MSUB -l nodes=1:ppn=20
#MSUB -q short
#MSUB -l walltime=4:00:00
#MSUB -A e20438
#MSUB -N Pr-Dy-oP16-Fe3C

cd $PBS_O_WORKDIR
NPROCS=`wc -l < $PBS_NODEFILE`

echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo ""

module unload intel
module unload mpi
module load espresso

mpirun -machinefile $PBS_NODEFILE -np $NPROCS pw.x < pw-Pr-Dy-oP16-Fe3C.in > pw-Pr-Dy-oP16-Fe3C.out
