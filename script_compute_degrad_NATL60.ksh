#!/bin/bash

ulimit -s unlimited

REG=$1
CASE=$2
FREQ=$3
VAR=$4
MONTH=$5
ratio=$6

CONFIG=NATL60

dir=/lus/work/CT1/ige2071/aalbert/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/${REG}-degrad
mkdir -p $dir
cd $dir

case $REG in
	eNATL60) sREG='';;
        MEDWEST) sREG=MEDWEST;;
        NANFL)   sREG=NANFL;;
        EGULF)   sREG=EGULF;;
        GULF)   sREG=GULF;;
esac

ln -sf /lus/work/CT1/ige2071/aalbert/NATL60/NATL60-I/NATL60GULF_v4.1_cdf_byte_mask.nc mask.nc
ln -sf /lus/work/CT1/ige2071/aalbert/NATL60/NATL60-I/NATL60GULF_v4.1_cdf_mesh_hgr.nc mesh_hgr.nc
ln -sf /lus/work/CT1/ige2071/aalbert/NATL60/NATL60-I/NATL60GULF_v4.1_cdf_mesh_zgr.nc mesh_zgr.nc


for month in $MONTH; do

	case $month in
	      10|11|12) year=2012;;
	      1|2|3|4|5|6|7|8|9) year=2013;;
	esac

	case $month in
	      1|3|5|7|8|10|12) day1=1; day2=31;;
	      4|6|9|11) day1=1; day2=30;;
	      2) day1=1; day2=28;;
	esac

    	for day in $(seq $day1 $day2); do
		mm=$(printf "%02d" $month)
	        dd=$(printf "%02d" $day)
	
	    	for var in $VAR; do
	
	        	case $var in
	                	sossheig) varn=sossheig; pt=T;;
	                	sosstsst) varn=sosstsst; pt=T;;
	                	votemper) varn=votemper; pt=T;;
	                	votemper_0-1000m) varn=votemper; pt=T;;
	                	vosaline_0-1000m) varn=vosaline; pt=T;;
	                	vosaline) varn=vosaline; pt=T;;
	                	sosaline) varn=sosaline; pt=T;;
	                	sozocrtx) varn=sozocrtx; pt=U;;
	                	somecrty) varn=vomecrty;pt=V;;
	        	esac
			stdir=/lus/work/CT1/ige2071/aalbert/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/${REG}
			for file in $(ls $stdir/${CONFIG}${REG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_${var}.nc); do
				fileo=${CONFIG}${REG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_${var}_degrad${ratio}.nc
				if [ ! -f  $fileo ]; then echo $fileo; cdfdegrad -f ${file} -v ${varn} -r $ratio $ratio -p ${pt} -o ${fileo}; fi
	  		done
		done
	done
done

