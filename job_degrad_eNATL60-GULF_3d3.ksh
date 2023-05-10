#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH -A ige2071
#SBATCH -J degrad
#SBATCH -e degrad.e%j
#SBATCH -o degrad.o%j
#SBATCH --time=3:00:00
#SBATCH --constraint=HPDA

NB_NPROC=24 #(= 12 months)

runcode() { srun -m cyclic -n $@ ; }
liste=''

REG=GULF
CASE=BLB002

for var in votemper_0-1000m vosaline_0-1000m; do
	for month in $(seq 1 12); do
		echo './script_compute_degrad_eNATL60.ksh '$REG' '$CASE' 1h '$var' '$month' 3' > tmp_degrad_eNATL60-${CASE}_${REG}_${var}_${month}.ksh
		chmod +x tmp_degrad_eNATL60-${CASE}_${REG}_${var}_${month}.ksh
		liste="$liste ./tmp_degrad_eNATL60-${CASE}_${REG}_${var}_${month}.ksh"
	done
done

runcode  $NB_NPROC /lus/work/CT1/ige2071/aalbert/bin/mpi_shell $liste

