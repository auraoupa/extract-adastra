cd /lus/home/CT1/ige2071/aalbert/git/extrac-adastra

for m in $(seq 2 12); do
	./script_compute_degrad_NATL60.ksh GULF CJM165 1d votemper_0-1000m $m 3
	./script_compute_degrad_NATL60.ksh GULF CJM165 1d vosaline_0-1000m $m 3
done
