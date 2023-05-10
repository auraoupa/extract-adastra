#!/bin/bash

ulimit -s unlimited

CONFIG=$1
CASE=$2
REG=$3
FREQ=$4
FILETYP1=$5
FILETYP2=$6
MONTH=$7

case $REG in
        eNATL60) sREG='';;
        *) sREG=$REG;;
esac

for month in $MONTH; do
    case $month in
      7|8|9|10|11|12) year=2009;;
         1|2|3|4|5|6|19|20|21|22) year=2010;;
    esac
    case $month in
      1|3|5|7|8|10|12|19|20|22) day1=1; day2=31;;
      4|6|9|11|21) day1=1; day2=30;;
      2) day1=1; day2=28;;
    esac
    case $month in
                        1|2|3|4|5|6|7|8|9|10|11|12) monthi=$month;;
                        19) monthi=7;;
                        20) monthi=8;;
                        21) monthi=9;;
                        22) monthi=10;;
    esac
    for day in $(seq $day1 $day2); do

            mm=$(printf "%02d" $monthi)
            dd=$(printf "%02d" $day)

	    file=/lus/work/CT1/ige2071/aalbert/$CONFIG/${CONFIG}-${CASE}-S/$FREQ/$REG/${CONFIG}${sREG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_${FILETYP1}.nc
	    file2=$(echo $file | sed "s/${FILETYP1}/${FILETYP2}/g")
	    fileo=$(echo $file | sed "s/${FILETYP1}/${FILETYP1}m/g")
	    if [ ! -f  ${fileo}.nc ]; then echo ${fileo}; /lus/work/CT1/ige2071/aalbert/git/CDFTOOLS/bin/cdfmoy_weighted -l $file $file2 -o $fileo; fi
    done

done
