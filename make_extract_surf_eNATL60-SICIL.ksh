#!/bin/bash

for sim in BLBT02 BLB002; do 
	for var in sossheig flxT; do
		for month in 7; do
			cp script_extract_surf_eNATL60-CASE_REG_VAR_MONTH.ksh tmp_extract_surf_eNATL60-${sim}_SICIL_${var}_${month}.ksh
			sed -i "s/CASE/$sim/g" tmp_extract_surf_eNATL60-${sim}_SICIL_${var}_${month}.ksh
			sed -i "s/MONTH/$month/g" tmp_extract_surf_eNATL60-${sim}_SICIL_${var}_${month}.ksh
			sed -i "s/REG/SICIL/g" tmp_extract_surf_eNATL60-${sim}_SICIL_${var}_${month}.ksh
			sed -i "s/VAR/${var}/g" tmp_extract_surf_eNATL60-${sim}_SICIL_${var}_${month}.ksh
			chmod +x tmp_extract_surf_eNATL60-${sim}_SICIL_${var}_${month}.ksh
			./tmp_extract_surf_eNATL60-${sim}_SICIL_${var}_${month}.ksh
		done
	done
done


