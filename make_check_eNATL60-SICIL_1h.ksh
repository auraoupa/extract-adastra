CONFIG=eNATL60
CASE=BLB002
FREQ=1h
REG=SICIL


for reg in $REG; do
	for var in flxT sossheig vomecrty vosaline votemper vozocrtx vovecrtz; do	
                ./script_check_nb_files.ksh $CONFIG $CASE ${reg} $FREQ $var $reg
                ./script_check_time_counter0.ksh $CONFIG $CASE $reg $FREQ $var $reg
                ./script_check_time_counter.ksh $CONFIG $CASE $reg $FREQ $var $reg

        done
done

