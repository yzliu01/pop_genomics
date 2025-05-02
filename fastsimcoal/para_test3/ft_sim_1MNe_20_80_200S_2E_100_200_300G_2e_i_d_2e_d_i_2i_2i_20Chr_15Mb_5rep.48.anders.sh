#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 6
#SBATCH --mem 100g
#SBATCH --array=1-48%48
#SBATCH --time=2-14:00:00
#SBATCH --error=ft_sim_1MNe_20_80_200S_2E_2E_100_200_300G_2e_i_d_2e_d_i_2i_2i_20Chr_15Mb_5rep.anders.%A_%a.e
#SBATCH --output=ft_sim_1MNe_20_80_200S_2E_2E_100_200_300G_2e_i_d_2e_d_i_2i_2i_20Chr_15Mb_5rep.anders.%A_%a.o
#SBATCH --job-name=ft_1MNe_2E_2e_i_d_2e_d_i_2i_2i_anders_5rep
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## run parallel jobs
#cd /home/yzliu/DK_proj/steps/
#mkdir systematic_ftsm_test
## check No. of par file of 1 chromosome test
#ls $par_folder/*5Chr*.par | wc -l
#24

#fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
par_folder=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/fastsimcoal/para_test3/1000000Ne_new
cd $par_folder
par=$(ls -t $par_folder/* | head -48 | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)

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
