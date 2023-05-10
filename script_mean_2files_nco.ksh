#!/bin/bash


file1=$1
file2=$2
filei=$3 #reference file for good time_counter
fileo=$4

var=$5
vari=$6

cp $file1 $fileo

cp $file1 tmp1.nc
cp $file2 tmp2.nc

ncrename -v ${var},var1 tmp1.nc
ncrename -v ${var},var2 tmp2.nc

ncks -A -v var1 tmp1.nc $fileo
ncks -A -v var2 tmp2.nc $fileo

ncap2 -O -s 'var3=0.5*(var1+var2)' $fileo $fileo

ncks -O -x -v var1 $fileo $fileo
ncks -O -x -v var2 $fileo $fileo

ncks -O -x -v ${var} $fileo $fileo
ncrename -v var3,${var} $fileo

ncks -A -v time_counter $filei $fileo
ncks -A -v time_centered $filei $fileo

rm tmp1.nc tmp2.nc	
