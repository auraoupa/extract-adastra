CONFIG=$1
CASE=$2
REG=$3
FREQ=$4
VAR=$5
sREG=$6

echo "nb files for var" $VAR
ls -l  /lus/work/CT1/ige2071/aalbert/$CONFIG/${CONFIG}-${CASE}-S/$FREQ/$REG/${CONFIG}${sREG}-${CASE}_*.${FREQ}_${VAR}.nc | wc -l


