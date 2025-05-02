#!/bin/bash
#SBATCH --account eDNA
##SBATCH --cpus-per-task 8
#SBATCH --mem 600g
#SBATCH --array=1-12%2
#SBATCH --time=4-01:14:00
#SBATCH --error=ft_sim_10KNe_20_80_200_200S_1_2E_4e_10e_di_025_01_di_20Chr_15Mb_5rep_12left.%A_%a.e.txt
#SBATCH --output=ft_sim_10KNe_20_80_200_200S_1_2E_4e_10e_di_025_01_di_20Chr_15Mb_5rep_12left.%A_%a.o.txt
#SBATCH --job-name=ft_10KNe_rep5_1_2E_4e_10e_di_025_01_di_11left
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## run parallel jobs
#cd /home/yzliu/DK_proj/steps/
#mkdir systematic_ftsm_test
## check No. of par file of 1 chromosome test
#ls $par_folder/*5Chr*.par | wc -l
#24
#cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
#fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
par_folder=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/fastsimcoal/para_test3/10000Ne_new
#par=$(ls $par_folder/ft_sim_10000Ne*2E_*e*20Chr_15Mb.par | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)

## get list of unfinished par files
#find -maxdepth 2 -print | grep -e 'e_[id]_' | grep '_5.gen$' | sort -V | cut -d "/" -f 2 > finished_par_gen5
#find -maxdepth 2 -print | grep -e 'e_[id]_' | grep '_1.gen$' | sort -V | cut -d "/" -f 2 > finished_par_gen1
unfinished_par_list=`sort finished_par_gen5 finished_par_gen1 | uniq -u`
#unfinished_5_list={"ft_sim_100000Ne_80hapS_1E_1000G_05d_20Chr_15Mb","ft_sim_100000Ne_80hapS_1E_1000G_09d_20Chr_15Mb","ft_sim_100000Ne_200hapS_1E_50G_09d_20Chr_15Mb","ft_sim_100000Ne_200hapS_1E_500G_05d_20Chr_15Mb","ft_sim_100000Ne_200hapS_1E_1000G_05d_20Chr_15Mb"}

## https://stackoverflow.com/questions/17181787/how-to-use-variables-in-a-bash-for-loop
## https://stackoverflow.com/questions/36223802/store-for-loop-results-as-a-variable-in-bash

## variable in for-loop
unfinished_par=$(
for i in $(eval echo $unfinished_par_list);
    do echo $par_folder/$i".par";
done
)

par=$(ls $unfinished_par | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
#par=`ls $unfinished_par | sort -V`
## call env
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
conda activate fastsimcoal2

fsc27093 -i $par -n 5 -q -s 0 -m --foldedSFS -c 0 -B 50 -g -G -k 300000000

