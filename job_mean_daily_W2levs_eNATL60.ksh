#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH -A ige2071
#SBATCH -J extract3D
#SBATCH -e extract3D.e%j
#SBATCH -o extract3D.o%j
#SBATCH --time=3:00:00
#SBATCH --constraint=HPDA

NB_NPROC=24 #(= 12 months)

runcode() { srun -m cyclic -n $@ ; }
liste=''

REG=eNATL60
CASE=BLB002


for var in vovecrtz_60m vovecrtz_61m; do
	for month in $(seq 1 12); do
		echo './script_compute_daily_mean_eNATL60_reg.ksh '$REG' '$CASE' '1h' '$var' '$month > tmp_mean_daily_eNATL60-${CASE}_${REG}_${var}_${month}.ksh
		chmod +x tmp_mean_daily_eNATL60-${CASE}_${REG}_${var}_${month}.ksh
		liste="$liste ./tmp_mean_daily_eNATL60-${CASE}_${REG}_${var}_${month}.ksh"

	done
done

runcode  $NB_NPROC /lus/work/CT1/ige2071/aalbert/bin/mpi_shell $liste

