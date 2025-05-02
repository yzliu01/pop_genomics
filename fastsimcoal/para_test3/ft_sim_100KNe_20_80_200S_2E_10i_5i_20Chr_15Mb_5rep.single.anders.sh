#!/bin/bash
#SBATCH --account eDNA
##SBATCH --cpus-per-task 10
#SBATCH --mem 30g
#SBATCH --array=1-15%5
#SBATCH --time=00:24:00
#SBATCH --error=ft_sim_100KNe_20_80_200S_2E_10i_5i_20Chr_15Mb_5rep.single.%A_%a.e.txt
#SBATCH --output=ft_sim_100KNe_20_80_200S_2E_10i_5i_20Chr_15Mb_5rep.single.%A_%a.o.txt
#SBATCH --job-name=ft_sim_100KNe_20_80_200S_2E_10i_5i_single
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## run parallel jobs
#cd /home/yzliu/DK_proj/steps/
#mkdir systematic_ftsm_test
## check No. of par file of 1 chromosome test
#ls $par_folder/*5Chr*.par | wc -l
#24
#cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep
#fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
par_folder=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/fastsimcoal/para_test3/100000Ne_new
## test par
#par=$par_folder/ft_sim_100000Ne_200hapS_1E_500G_09d_20Chr_15Mb.par
## ft_sim_100000Ne_200hapS_1E_500G_05i_20Chr_15Mb.par
par=$(ls $par_folder/ft_sim_100000Ne*2E_*10i_5i*20Chr_15Mb_[1-5].par | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)

## anders advice to use scratch local space
cd $TEMPDIR
cp $par .
mkdir out
cd out

source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
conda activate fastsimcoal2

fsc27093 -i ../*.par -n 5 -q -x -s 0 -m --foldedSFS -c 10 -g -G -k 300000000

## copy files to faststorage
eDAN_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/100KNe_5rep_anders
cp -r * $eDAN_DIR

exit

## make 5 duplicate par
## 10i_5i
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/fastsimcoal/para_test3/100000Ne_new
ls *10i_5i*.par | wc -l

for par in `ls *10i_5i*.par`;do
    for rep in {1..5};do
        # copy files
        cp $par $par"_"$rep".par"
        # rename files
        rename .par_ "_" *_[1-5].par
    done
done