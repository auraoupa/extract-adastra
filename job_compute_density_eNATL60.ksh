#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH -J density
#SBATCH -e density.e%j
#SBATCH -o density.o%j
#SBATCH --time=02:30:00
#SBATCH --exclusive
#SBATCH --constraint=HPDA
#SBATCH -A ige2071

NB_NPROC=12 #(= 1 regions * 1 variable * 12 month)

runcode() { srun -m cyclic -n $@ ; }
liste=''

for reg in eNATL60; do
		for month in $(seq 1 12); do
			echo './compute_density_eNATL60_1month.ksh '$reg' BLB002 1d votemper_60m '$month >> tmp_compute_density_eNATL60-BLB002_m${month}.ksh
			chmod +x tmp_compute_density_eNATL60-BLB002_m${month}.ksh
			liste="$liste ./tmp_compute_density_eNATL60-BLB002_m${month}.ksh"
		done
done

runcode  $NB_NPROC /lus/work/CT1/ige2071/aalbert/bin/mpi_shell $liste

