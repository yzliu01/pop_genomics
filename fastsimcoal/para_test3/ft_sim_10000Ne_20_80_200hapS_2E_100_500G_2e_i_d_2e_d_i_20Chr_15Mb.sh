#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 8
#SBATCH --mem 20g
#SBATCH --array=1-6%6
##SBATCH --array=24,28,32,36,40,44,48:4
#SBATCH --time=03:00:00
#SBATCH --error=ft_sim_10000Ne_200hapS_2E_100_500G_2e_i_d_2e_d_i_20Chr_15Mb.anders.%A_%a.e.txt
#SBATCH --output=ft_sim_10000Ne_200hapS_2E_100_500G_2e_i_d_2e_d_i_20Chr_15Mb.anders.%A_%a.o.txt
#SBATCH --job-name=ft_sim_10000Ne_200hapS_2E_100_500G_2e_i_d_2e_d_i_20Chr_15Mb
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## run parallel jobs
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
#fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
par_folder=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/fastsimcoal/para_test3/10000Ne
par=$(ls $par_folder/ft_sim_10000Ne*2E_100_500G_2e*2e*20Chr_15Mb.par | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)

## anders advice to use scratch local space
cd $TEMPDIR
cp $par .
mkdir out
cd out

source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
conda activate fastsimcoal2

fsc27093 -i ../*.par -n 5 -q -x -s 0 -m --foldedSFS -c 8 -g -G -k 300000000

## copy files to faststorage
eDAN_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
cp -r * $eDAN_DIR


