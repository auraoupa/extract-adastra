#!/bin/bash


for reg in GULF; do
	for var in somxl010; do
		for month in $(seq 1 12); do
			echo './script_extract_surf_NATL60_1month.ksh '$reg' CJM165 1d '$var' '$month >> tmp_extract_NATL60-CJM165_${reg}_${var}_m${month}.ksh
			sed -i "s/MONTH/$month/g" tmp_extract_NATL60-CJM165_${reg}_${var}_m${month}.ksh
			sed -i "s/REG/${reg}/g" tmp_extract_NATL60-CJM165_${reg}_${var}_m${month}.ksh
			sed -i "s/VAR/${var}/g" tmp_extract_NATL60-CJM165_${reg}_${var}_m${month}.ksh
			chmod +x tmp_extract_NATL60-CJM165_${reg}_${var}_m${month}.ksh
			./tmp_extract_NATL60-CJM165_${reg}_${var}_m${month}.ksh
		done
	done
done


