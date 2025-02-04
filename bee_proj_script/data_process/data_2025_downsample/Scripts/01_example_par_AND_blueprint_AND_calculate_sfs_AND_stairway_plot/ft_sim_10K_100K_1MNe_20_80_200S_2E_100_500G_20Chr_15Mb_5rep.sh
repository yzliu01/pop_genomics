#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 6
#SBATCH --mem 100g
#SBATCH --array=1-18%18
#SBATCH --time=2-14:00:00
#SBATCH --error=ft_sim_10K_100K_1MNe_20_80_200S_2E_100_500G_20Chr_15Mb_5rep.%A_%a.e
#SBATCH --output=ft_sim_10K_100K_1MNe_20_80_200S_2E_100_500G_20Chr_15Mb_5rep.%A_%a.o
#SBATCH --job-name=ft_sim_10K_100K_1MNe_20_80_200S_2E_100_500G_20Chr_15Mb_5rep

#fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
par_folder=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/fastsimcoal/para_test3
cd $par_folder
par=$(ls -t $par_folder/* | head -18 | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)

## use scratch local space
cd $TEMPDIR
cp $par .
mkdir out
cd out

source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate fastsimcoal2

fsc27093 -i ../*.par -n 5 -q -x -s 0 -m -c 6 -g -G -k 300000000

## copy files to faststorage
eDAN_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/extra_sim_2d_2i
cp -r * $eDAN_DIR
