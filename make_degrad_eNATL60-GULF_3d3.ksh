cd /lus/home/CT1/ige2071/aalbert/git/extrac-adastra

for m in 1; do
	./script_compute_degrad_eNATL60.ksh GULF BLB002 1h votemper_0-1000m $m 3
	./script_compute_degrad_eNATL60.ksh GULF BLB002 1h vosaline_0-1000m $m 3
done
