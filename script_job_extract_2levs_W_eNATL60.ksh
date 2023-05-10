#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH -A ige2071
#SBATCH -J extract1lev
#SBATCH -e extract1lev.e%j
#SBATCH -o extract3D.o%j
#SBATCH --time=3:00:00
#SBATCH --constraint=HPDA

NB_NPROC=48 #(= 12 months)

runcode() { srun -m cyclic -n $@ ; }
liste=''

REG=eNATL60
CASE=BLB002
FREQ=1h

for var in vovecrtz; do 
	for month in $(seq 1 12); do
		for dep in LEV1 LEV2; do
			echo './script_extract_1lev_eNATL60_1month.ksh '$REG' '$CASE' '$FREQ' '$var' '$month' '$dep >> tmp_extract_1lev_eNATL60-${CASE}_${FREQ}_${var}_${dep}_${month}.ksh
			chmod +x tmp_extract_1lev_eNATL60-${CASE}_${FREQ}_${var}_${dep}_${month}.ksh
			liste="$liste ./tmp_extract_1lev_eNATL60-${CASE}_${FREQ}_${var}_${dep}_${month}.ksh"
		done
	done
done

runcode  $NB_NPROC /lus/work/CT1/ige2071/aalbert/bin/mpi_shell $liste

