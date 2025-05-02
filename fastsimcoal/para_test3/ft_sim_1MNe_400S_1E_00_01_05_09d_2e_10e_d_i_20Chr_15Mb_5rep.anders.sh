#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 12
#SBATCH --mem 200G
#SBATCH --array=1-36%36 # 20haps
##SBATCH --array=21-60%5
##SBATCH --time=00:30:00 # 20haps
#SBATCH --time=05:14:00
#SBATCH --error=ft_sim_1MNe_400S_1E_00_01_05_09d_2e_10e_d_i_20Chr_15Mb_5rep.anders.%A_%a.e.txt
#SBATCH --output=ft_sim_1MNe_400S_1E_00_01_05_09d_2e_10e_d_i_20Chr_15Mb_5rep.anders.%A_%a.o.txt
#SBATCH --job-name=ft_sim_1MNe_400S
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
par=$(ls $par_folder/ft_sim_1000000Ne_400hapS*1E_*20Chr_15Mb.par | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)

## anders advice to use scratch local space
cd $TEMPDIR
cp $par .
mkdir out
cd out

source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
conda activate fastsimcoal2

fsc27093 -i ../*.par -n 5 -q -x -s 0 -m --foldedSFS -c 12 -g -G -k 300000000

## copy files to faststorage
eDAN_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/1MNe_5rep_anders
cp -r * $eDAN_DIR

exit
## remove some std and err files
ls *30029690_[2-6][0-9]*txt | tail -n +3 | xargs rm