#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=36
#SBATCH -A ige2071
#SBATCH -J extract3D
#SBATCH -e extract3D.e%j
#SBATCH -o extract3D.o%j
#SBATCH --time=2:30:00
#SBATCH --constraint=HPDA

NB_NPROC=36 #(= 12 months)

runcode() { srun -m cyclic -n $@ ; }
liste=''


case=BLB002

for reg in GULF; do
	for month in $(seq 1 12); do
		for var in votemper vosaline vovecrtz; do
			cp script_extract_3D_eNATL60-CASE_REG_VAR_MONTH.ksh tmp_extract_3D_eNATL60-${case}_${reg}_${var}_${month}.ksh
			sed -i "s/CASE/$case/g" tmp_extract_3D_eNATL60-${case}_${reg}_${var}_${month}.ksh
			sed -i "s/MONTH/$month/g" tmp_extract_3D_eNATL60-${case}_${reg}_${var}_${month}.ksh
			sed -i "s/VAR/$var/g" tmp_extract_3D_eNATL60-${case}_${reg}_${var}_${month}.ksh
			sed -i "s/REG/$reg/g" tmp_extract_3D_eNATL60-${case}_${reg}_${var}_${month}.ksh
			sed -i "s/LEVS/0-1000/g" tmp_extract_3D_eNATL60-${case}_${reg}_${var}_${month}.ksh
			chmod +x tmp_extract_3D_eNATL60-${case}_${reg}_${var}_${month}.ksh
			liste="$liste ./tmp_extract_3D_eNATL60-${case}_${reg}_${var}_${month}.ksh"
		done
	done
done

runcode  $NB_NPROC /lus/work/CT1/ige2071/aalbert/bin/mpi_shell $liste


