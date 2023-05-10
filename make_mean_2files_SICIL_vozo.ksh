#!/bin/bash

file1=/lus/work/CT1/ige2071/aalbert/eNATL60/eNATL60-BLB002-S/1h/SICIL/eNATL60SICIL-BLB002_y2009m07d11h23.1h_vozocrtx.nc
file2=/lus/work/CT1/ige2071/aalbert/eNATL60/eNATL60-BLB002-S/1h/SICIL/eNATL60SICIL-BLB002_y2009m07d12h1.1h_vozocrtx.nc
filei=/lus/work/CT1/ige2071/aalbert/eNATL60/eNATL60-BLB002-S/1h/SICIL/eNATL60SICIL-BLB002_y2009m07d11h24.1h_votemper.nc
fileo=/lus/work/CT1/ige2071/aalbert/eNATL60/eNATL60-BLB002-S/1h/SICIL/eNATL60SICIL-BLB002_y2009m07d11h24.1h_vozocrtx.nc

var=vozocrtx
vari=votemper

./script_mean_2files_nco.ksh $file1 $file2 $filei $fileo $var $vari
