#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH -A ige2071
#SBATCH -J debug
#SBATCH -e debug.e%j
#SBATCH -o debug.o%j
#SBATCH --time=2:30:00
#SBATCH --constraint=HPDA

source /lus/home/CT1/ige2071/aalbert/.bashrc

NB_NPROC=3 #(= 12 months)

srun -m cyclic -n  $NB_NPROC /lus/work/CT1/ige2071/aalbert/git/DMONTOOLS/MPI_TOOLS/mpi_debug


