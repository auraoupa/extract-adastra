#!/bin/bash

case=CJM165

for reg in GULF; do
	for month in $(seq 1 12); do
#		for var in votemper vosaline; do
		for var in vovecrtz; do
				cp script_extract_3D_NATL60-CASE_REG_VAR_MONTH.ksh tmp_extract_3D_NATL60-${case}_${reg}_${var}_${month}.ksh
				sed -i "s/CASE/$case/g" tmp_extract_3D_NATL60-${case}_${reg}_${var}_${month}.ksh
				sed -i "s/MONTH/$month/g" tmp_extract_3D_NATL60-${case}_${reg}_${var}_${month}.ksh
				sed -i "s/VAR/$var/g" tmp_extract_3D_NATL60-${case}_${reg}_${var}_${month}.ksh
				sed -i "s/REG/$reg/g" tmp_extract_3D_NATL60-${case}_${reg}_${var}_${month}.ksh
				sed -i "s/LEVS/0-1000/g" tmp_extract_3D_NATL60-${case}_${reg}_${var}_${month}.ksh
				chmod +x tmp_extract_3D_NATL60-${case}_${reg}_${var}_${month}.ksh
				./tmp_extract_3D_NATL60-${case}_${reg}_${var}_${month}.ksh
		done
	done
done


