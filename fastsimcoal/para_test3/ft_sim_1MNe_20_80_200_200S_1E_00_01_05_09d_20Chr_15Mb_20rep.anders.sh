#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 6
#SBATCH --mem 80g
#SBATCH --array=1-48%48
#SBATCH --time=01-10:00:00
#SBATCH --error=ft_sim_1MNe_20_80_200_200S_1E_00_01_05_09d_20Chr_15Mb_20rep.%A.e
#SBATCH --output=ft_sim_1MNe_20_80_200_200S_1E_00_01_05_09d_20Chr_15Mb_20rep.%A.o
#SBATCH --job-name=ft_1MNe_1E_00_01_05_09d_rep20
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## run parallel jobs
#cd /home/yzliu/DK_proj/steps/
#mkdir systematic_ftsm_test
## check No. of par file of 1 chromosome test
#ls $par_folder/*5Chr*.par | wc -l
#24
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/1000000Ne_5rep
#fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/1000000Ne
## test par
#par=$par_folder/ft_sim_100000Ne_200hapS_1E_500G_09d_20Chr_15Mb.par
## ft_sim_100000Ne_200hapS_1E_500G_05i_20Chr_15Mb.par

## exclude 05i scenario
#rename par par---- $par_folder/*05i_20Chr_15Mb.par

par=$(ls $par_folder/ft_sim_1000000Ne*1E_*20Chr_15Mb.par | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)

## anders advice to use scratch local space
cd $TEMPDIR
cp $par .
mkdir out
cd out

source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
conda activate fastsimcoal2

fsc27093 -i ../*.par -n 20 -q -x -s 0 -m --foldedSFS -c 6 -g -G -k 300000000

## copy files to faststorage
eDAN_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/1MNe_20rep
cp -r * $eDAN_DIR
