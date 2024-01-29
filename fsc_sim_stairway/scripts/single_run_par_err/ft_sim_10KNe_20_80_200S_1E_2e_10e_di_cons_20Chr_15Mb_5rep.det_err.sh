#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 4
##SBATCH --mem 30g
#SBATCH --array=1-3%3
#SBATCH --time=06:14:00
#SBATCH --error=ft_sim_10KNe_20_80_200S_1E_2e_10e_di_cons_20Chr_15Mb_5rep_det_err.%A_%a.e.txt
#SBATCH --output=ft_sim_10KNe_20_80_200S_1E_2e_10e_di_cons_20Chr_15Mb_5rep_det_err.%A_%a.o.txt
#SBATCH --job-name=ft_10KNe_rep5_1E_2e_10e_di_cons_det_err
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## run parallel jobs
#cd /home/yzliu/DK_proj/steps/
#mkdir systematic_ftsm_test
## check No. of par file of 1 chromosome test
#ls $par_folder/*5Chr*.par | wc -l
#24
## output path of the fsc
#cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/single_run_err

#fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
par_folder=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/fastsimcoal/single_run_par_err
## test par
#par=$par_folder/ft_sim_100000Ne_200hapS_1E_500G_09d_20Chr_15Mb.par
## ft_sim_100000Ne_200hapS_1E_500G_05i_20Chr_15Mb.par
par=$(ls $par_folder/ft_sim_10000Ne*1E_*_cons_*20Chr_15Mb.par | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)

## call env
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
conda activate fastsimcoal2

fsc27093 -i $par -n 5 -q -s 0 -m --foldedSFS -c 4 -g -G -k 300000000

exit
