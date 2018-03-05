#!/bin/bash
#MSUB -l nodes=1:ppn=4
#MSUB -l walltime=4:00:00
#MSUB -A e20438
#MSUB -N pwscf.q

module load espresso
cd $PBS_O_WORKDIR
NPROCS=`wc -l < $PBS_NODEFILE`

echo "Running on host `hostname`"
echo "Time is `date`"
echo "Directory is `pwd`"
echo ""

pw_in="NaCl_rocksalt_cell_relax_pw.in"
pw_out="NaCl_rocksalt.out"
mpirun -machinefile $PBS_NODEFILE -np $NPROCS pw.x < $pw_in > $pw_out
