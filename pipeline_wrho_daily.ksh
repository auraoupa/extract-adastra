#For one vertical level

lev=60m
levw=61m
# check in script_extract_1lev_eNATL60_1month.ksh that the level you want to extract is defined, if not check /lus/store/CT1/hmg2840/brodeau/eNATL60/eNATL60-I/deptht.txt to define the level corresponding to the depth you want

# extract temperature and salinity at this level
cp script_job_extract_1lev_2VAR_eNATL60.ksh job_extract_1lev_TS_eNATL60.ksh
sed -i "s/VAR1/votemper/g" job_extract_1lev_TS_eNATL60.ksh
sed -i "s/VAR2/vosaline/g" job_extract_1lev_TS_eNATL60.ksh
sed -i "s/LEV/$lev/g" job_extract_1lev_T_eNATL60.ksh
jobidts=$(sbatch job_extract_1lev_TS_eNATL60.ksh | awk '{print $NF}')


# extract vertical velocities at this level and one below
cp script_job_extract_2levs_W_eNATL60.ksh job_extract_2levs_W_eNATL60.ksh
sed -i "s/LEV1/$lev/g" job_extract_2levs_W_eNATL60.ksh
sed -i "s/LEV2/$levw/g" job_extract_2levs_W_eNATL60.ksh
jobidw=$(sbatch job_extract_2levs_W_eNATL60.ksh | awk '{print $NF}')

# compute daily means of T, S and W at this levels
cp script_job_mean_daily_2VAR_eNATL60.ksh job_mean_daily_TS_eNATL60.ksh
sed -i "s/VAR1/votemper_${lev}/g" job_mean_daily_TS_eNATL60.ksh
sed -i "s/VAR2/vosaline_${lev}/g" job_mean_daily_TS_eNATL60.ksh
jobidts1d=$(sbatch --dependency=afterok:$jobidts job_mean_daily_TS_eNATL60.ksh | awk '{print $NF}')

cp script_job_mean_daily_2VAR_eNATL60.ksh job_mean_daily_W2levs_eNATL60.ksh
sed -i "s/VAR1/vovecrtz_${lev}/g" job_mean_daily_W2levs_eNATL60.ksh
sed -i "s/VAR2/vovecrtz_${levw}/g" job_mean_daily_W2levs_eNATL60.ksh
jobidw1d=$(sbatch --dependency=afterok:$jobidw job_mean_daily_W2levs_eNATL60.ksh | awk '{print $NF}')

# compute rho from temperature and salinity
cp script_job_compute_density_eNATL60.ksh job_compute_density_eNATL60.ksh
sed -i "s/LEV/$lev/g" job_compute_density_eNATL60.ksh
sbatch --dependency=afterok:$jobidts1d job_compute_density_eNATL60.ksh


# average W between the two levels => on same vertical grid
cp script_job_mean_2levs_W_eNATL60.ksh job_mean_2levs_W_eNATL60.ksh
sed -i "s/LEV1/$lev/g" job_mean_2levs_W_eNATL60.ksh
sed -i "s/LEV2/$levw/g" job_mean_2levs_W_eNATL60.ksh
sbatch -dependency=afterok:$jobidw1d job_mean_2levs_W_eNATL60.ksh


