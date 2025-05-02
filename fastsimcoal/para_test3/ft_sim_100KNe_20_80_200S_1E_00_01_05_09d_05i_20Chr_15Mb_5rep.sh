#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 6
#SBATCH --mem 60g
#SBATCH --array=1-60%20
#SBATCH --time=01-00:14:00
#SBATCH --error=ft_sim_100KNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb_5rep.%A.e.txt
#SBATCH --output=ft_sim_100KNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb_5rep.%A.o.txt
#SBATCH --job-name=ft_05i_rep5
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## run parallel jobs
#cd /home/yzliu/DK_proj/steps/
#mkdir systematic_ftsm_test
## check No. of par file of 1 chromosome test
#ls $par_folder/*5Chr*.par | wc -l
#24
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep
#fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne
## test par
#par=$par_folder/ft_sim_100000Ne_200hapS_1E_500G_09d_20Chr_15Mb.par
## ft_sim_100000Ne_200hapS_1E_500G_05i_20Chr_15Mb.par
par=$(ls $par_folder/ft_sim_100000Ne*1E_*20Chr_15Mb.par | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
conda activate fastsimcoal2
fsc27093 -i $par -n 5 -q -s 0 -m --foldedSFS -c 6 -g -G -k 300000000

exit
