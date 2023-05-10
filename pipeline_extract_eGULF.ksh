jobid1=$(sbatch job_extract_3D_eNATL60-GULF_test36.ksh | awk '{print $NF}')
jobid2=$(sbatch --dependency=afternotok:$jobid1 job_extract_3D_eNATL60-GULF_test36.ksh | awk '{print $NF}')
sbatch --dependency=afternotok:$jobid2 job_extract_3D_eNATL60-GULF_test36.ksh
