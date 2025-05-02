#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 6
#SBATCH --mem 20g
#SBATCH --array=1-12%12
#SBATCH --time=02:00:00
#SBATCH --error=ft_sim_100KNe_20Chr_15Mb_5rep.%A_%a.e
#SBATCH --output=ft_sim_100KNe_20Chr_15Mb_5rep.%A_%a.o
#SBATCH --job-name=ft_sim_100KNe_20Chr_15Mb_5rep
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## run parallel jobs
#cd /home/yzliu/DK_proj/steps/
#mkdir systematic_ftsm_test
## check No. of par file of 1 chromosome test
#ls $par_folder/*5Chr*.par | wc -l
#24
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep
#fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
#par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne
par_folder=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/fastsimcoal/para_test3/100000Ne
## test par
#par=$par_folder/ft_sim_100000Ne_200hapS_1E_500G_09d_20Chr_15Mb.par
## ft_sim_100000Ne_200hapS_1E_500G_05i_20Chr_15Mb.par

## exclude 05i scenario
#rename par par---- $par_folder/*05i_20Chr_15Mb.par

#./100000Ne/ft_sim_100000Ne_200hapS_1E_1000G_05i_20Chr_15Mb.par
par=$(ls $par_folder/ft_sim_100000Ne*1E_*05i_20Chr_15Mb.par | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)

## anders advice to use scratch local space
cd $TEMPDIR
cp $par .
mkdir out
cd out

source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
conda activate fastsimcoal2

fsc27093 -i ../*.par -n 5 -q -x -s 0 -m --foldedSFS -c 6 -g -G -k 300000000

## copy files to faststorage
eDAN_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep
cp -r * $eDAN_DIR
