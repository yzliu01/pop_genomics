#!/bin/bash
#SBATCH --account eDNA
##SBATCH --cpus-per-task 6
#SBATCH --mem 1000g
##SBATCH --array=1-6%6
#SBATCH --array=2,5,8
##SBATCH --array=2,5,8
##SBATCH --time=00:04:00
#SBATCH --time=04:00:00
#SBATCH --error=ft_sim_1MNe_20_80_200S_2E_5i_5i_20Chr_15Mb_5rep.1000G_258.%A_%a.e.txt
#SBATCH --output=ft_sim_1MNe_20_80_200S_2E_5i_5i_20Chr_15Mb_5rep.1000G_258.%A_%a.o.txt
#SBATCH --job-name=1000G_258ft_1MNe_rep5_5i_5i
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## run parallel jobs
#cd /home/yzliu/DK_proj/steps/
#mkdir systematic_ftsm_test
## check No. of par file of 1 chromosome test
#ls $par_folder/*5Chr*.par | wc -l
#24
#cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/1000000Ne_5rep
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/1000000Ne_5rep
#fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
par_folder=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/fastsimcoal/para_test3/1000000Ne_new
## test par
#par=$par_folder/ft_sim_100000Ne_200hapS_1E_500G_09d_20Chr_15Mb.par
## ft_sim_100000Ne_200hapS_1E_500G_05i_20Chr_15Mb.par
par=$(ls $par_folder/ft_sim_1000000Ne*2E_100_500G_*20Chr_15Mb.par | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)

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
eDAN_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/1MNe_5rep_anders
cp -r * $eDAN_DIR

