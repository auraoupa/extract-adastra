month=MONTH
year=2013
day=1

mm=$(printf "%02d" $month)
dd=$(printf "%02d" $day)
date=${year}${mm}${dd}

./script_extract_3D_NATL60.ksh REG CJM165 1d VAR ${date} LEVS
