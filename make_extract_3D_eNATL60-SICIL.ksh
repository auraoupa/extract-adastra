#!/bin/bash

for sim in BLBT02 BLB002; do
	for reg in SICIL; do
		for var in vomecrty vozocrtx votemper vosaline vovecrtz; do
			for month in 7; do
				cp script_extract_3D_eNATL60-CASE_REG_VAR_MONTH.ksh tmp_extract_3D_eNATL60-${sim}_${reg}_${var}_${month}.ksh
				sed -i "s/CASE/$sim/g" tmp_extract_3D_eNATL60-${sim}_${reg}_${var}_${month}.ksh
				sed -i "s/MONTH/$month/g" tmp_extract_3D_eNATL60-${sim}_${reg}_${var}_${month}.ksh
				sed -i "s/VAR/$var/g" tmp_extract_3D_eNATL60-${sim}_${reg}_${var}_${month}.ksh
				sed -i "s/REG/$reg/g" tmp_extract_3D_eNATL60-${sim}_${reg}_${var}_${month}.ksh
				sed -i "s/LEVS//g" tmp_extract_3D_eNATL60-${sim}_${reg}_${var}_${month}.ksh
				chmod +x tmp_extract_3D_eNATL60-${sim}_${reg}_${var}_${month}.ksh
				./tmp_extract_3D_eNATL60-${sim}_${reg}_${var}_${month}.ksh
			done
		done
	done
done


