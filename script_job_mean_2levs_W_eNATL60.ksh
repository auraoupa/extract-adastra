#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH -A ige2071
#SBATCH -J mean
#SBATCH -e mean.e%j
#SBATCH -o mean.o%j
#SBATCH --time=3:00:00
#SBATCH --constraint=HPDA

NB_NPROC=12 #(= 12 months)

runcode() { srun -m cyclic -n $@ ; }
liste=''

REG=eNATL60
CASE=BLB002
FREQ=1d

for var in vovecrtz; do 
	for month in $(seq 1 12); do
		echo './script_mean_2files_1month.ksh '$CONFIG' '$CASE' '${REG}' '$FREQ' '${var}_LEV1' '${var}_LEV2' '$month >> tmp_mean_2levs_eNATL60-${CASE}_${FREQ}_${var}_${month}.ksh
		chmod +x tmp_mean_2levs_eNATL60-${CASE}_${FREQ}_${var}_${month}.ksh
		liste="$liste ./tmp_mean_2levs_eNATL60-${CASE}_${FREQ}_${var}_${month}.ksh"
	done
done

runcode  $NB_NPROC /lus/work/CT1/ige2071/aalbert/bin/mpi_shell $liste

