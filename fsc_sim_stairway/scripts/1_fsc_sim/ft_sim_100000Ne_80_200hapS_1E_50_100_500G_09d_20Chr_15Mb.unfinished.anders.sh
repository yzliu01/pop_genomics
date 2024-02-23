#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 8
#SBATCH --mem 40g
#SBATCH --array=1-6%6
#SBATCH --time=05:00:00
#SBATCH --error=ft_sim_100000Ne_80_200hapS_1E_50_100_500G_09d_20Chr_15Mb.anders.%A_%a.e.txt
#SBATCH --output=ft_sim_100000Ne_80_200hapS_1E_50_100_500G_09d_20Chr_15Mb.anders.%A_%a.o.txt
#SBATCH --job-name=ft_sim_100000Ne_80_200hapS_1E_50_100_500G_09d_20Chr_15Mb
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## run parallel jobs

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep
#fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
par_folder=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/fastsimcoal/para_test3/100000Ne
#par=$(ls $par_folder/ft_sim_100000Ne*2E_100_500G_2e*2e*20Chr_15Mb.par | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)

unfinished_list=("ft_sim_100000Ne_80hapS_1E_50G_09d_20Chr_15Mb.par" 
            "ft_sim_100000Ne_80hapS_1E_100G_09d_20Chr_15Mb.par"
            "ft_sim_100000Ne_80hapS_1E_500G_09d_20Chr_15Mb.par"
            "ft_sim_100000Ne_200hapS_1E_100G_09d_20Chr_15Mb.par"
            "ft_sim_100000Ne_200hapS_1E_500G_09d_20Chr_15Mb.par"
            "ft_sim_100000Ne_200hapS_1E_1000G_09d_20Chr_15Mb.par")
par=$(echo ${unfinished_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)

## anders advice to use scratch local space
cd $TEMPDIR
cp $par_folder/$par .
mkdir out
cd out

source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
conda activate fastsimcoal2

fsc27093 -i ../*.par -n 5 -q -x -s 0 -m --foldedSFS -c 8 -g -G -k 300000000

## copy files to faststorage
eDAN_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep
cp -r * $eDAN_DIR

exit 0

/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/fastsimcoal/para_test3/100000Ne/ft_sim_100000Ne_80hapS_1E_50G_09d_20Chr_15Mb.par
ft_sim_100000Ne_200hapS_1E_1000G_09d_20Chr_15Mb.par
ft_sim_100000Ne_200hapS_1E_500G_09d_20Chr_15Mb.par
ft_sim_100000Ne_200hapS_1E_100G_09d_20Chr_15Mb.par
ft_sim_100000Ne_80hapS_1E_100G_09d_20Chr_15Mb.par
ft_sim_100000Ne_80hapS_1E_500G_09d_20Chr_15Mb.par
ft_sim_100000Ne_80hapS_1E_50G_09d_20Chr_15Mb.par

unfinished_list=("ft_sim_100000Ne_80hapS_1E_50G_09d_20Chr_15Mb.par" 
            "ft_sim_100000Ne_80hapS_1E_100G_09d_20Chr_15Mb.par"
            "ft_sim_100000Ne_80hapS_1E_500G_09d_20Chr_15Mb.par"
            "ft_sim_100000Ne_200hapS_1E_100G_09d_20Chr_15Mb.par"
            "ft_sim_100000Ne_200hapS_1E_500G_09d_20Chr_15Mb.par"
            "ft_sim_100000Ne_200hapS_1E_1000G_09d_20Chr_15Mb.par")
REF3=$(echo ${unfinished_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)

