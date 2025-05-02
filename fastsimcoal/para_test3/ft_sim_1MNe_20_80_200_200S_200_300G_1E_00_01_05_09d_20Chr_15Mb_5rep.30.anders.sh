#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 6
#SBATCH --mem 80g
#SBATCH --array=1-30%30
#SBATCH --time=01-10:00:00
#SBATCH --error=ft_sim_1MNe_20_80_200_200S_200_300G_1E_00_01_05_09d_20Chr_15Mb_5rep.%A_%a.e
#SBATCH --output=ft_sim_1MNe_20_80_200_200S_200_300G_1E_00_01_05_09d_20Chr_15Mb_5rep.%A_%a.o
#SBATCH --job-name=ft_1MNe_1E_00_01_05_09d_rep5
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## run parallel jobs
#cd /home/yzliu/DK_proj/steps/
#mkdir systematic_ftsm_test
## check No. of par file of 1 chromosome test
#ls $par_folder/*5Chr*.par | wc -l
#24

par_folder=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/fastsimcoal/para_test3/1000000Ne
cd $par_folder
par=$(ls -t $par_folder/* | head -30 | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)

## anders advice to use scratch local space
cd $TEMPDIR
cp $par .
mkdir out
cd out

source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
conda activate fastsimcoal2

fsc27093 -i ../*.par -n 5 -q -x -s 0 -m -c 6 -g -G -k 300000000

## copy files to faststorage
eDAN_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/1MNe_200_300G
cp -r * $eDAN_DIR
