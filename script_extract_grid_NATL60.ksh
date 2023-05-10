#!/bin/bash

REG=$1
LEVS=$2


CONFIG=NATL60

case $REG in
	EATL) coord='-d x,2113,3913 -d y,1014,2094'; sREG=EATL;;
        GULFSTREAM) coord='-d x,989,1604 -d y,452,1224'; sREG=GULFSTREAM;;
        GULF) coord='-d x,929,1667 -d y,379,1306'; sREG=GULF;;
esac


dir=/lus/work/CT1/ige2071/aalbert/${CONFIG}/${CONFIG}-I
mkdir -p $dir
cd $dir

stdir=/lus/store/CT1/hmg2840/molines/NATL60/NATL60-I

for file in NATL60_coordinates_v4.nc NATL60_v4.1_cdf_byte_mask.nc NATL60_v4.1_cdf_mesh_hgr.nc NATL60_v4.1_cdf_mesh_zgr.nc; do
	echo $file
	fileo=$(echo $file | sed "s/NATL60/NATL60${sREG}/g")
	if [ ! -f  $fileo ]; then echo $fileo; ncks -O -F $coord $stdir/$file $fileo; fi

done



