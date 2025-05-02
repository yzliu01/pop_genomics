#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 5
##SBATCH --mem 50g
#SBATCH --array=1-48%12
#SBATCH --time=01-15:14:00
#SBATCH --error=ft_sim_100KNe_20_80_200_200S_2E_4e_10e_di_025_01_di_20Chr_15Mb_5rep.%A.e.txt
#SBATCH --output=ft_sim_100KNe_20_80_200_200S_2E_4e_10e_di_025_01_di_20Chr_15Mb_5rep.%A.o.txt
#SBATCH --job-name=ft_100KNe_rep5_1E_2e_10e_di_cons
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## run parallel jobs
#cd /home/yzliu/DK_proj/steps/
#mkdir systematic_ftsm_test
## check No. of par file of 1 chromosome test
#ls $par_folder/*5Chr*.par | wc -l
#24
#cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep
#fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
par_folder=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/fastsimcoal/para_test3/100000Ne_new
## test par
#par=$par_folder/ft_sim_100000Ne_200hapS_1E_500G_09d_20Chr_15Mb.par
## ft_sim_100000Ne_200hapS_1E_500G_05i_20Chr_15Mb.par
par=$(ls $par_folder/ft_sim_100000Ne*2E_*e*20Chr_15Mb.par | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)

## call env
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
conda activate fastsimcoal2

fsc27093 -i $par -n 5 -q -s 0 -m --foldedSFS -c 5 -g -G -k 300000000

exit
