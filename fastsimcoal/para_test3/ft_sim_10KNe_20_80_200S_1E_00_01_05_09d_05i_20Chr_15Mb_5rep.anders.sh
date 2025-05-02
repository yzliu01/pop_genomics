#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 4
#SBATCH --mem 10g
#SBATCH --array=1-12%12
#SBATCH --time=02-10:14:00
#SBATCH --error=ft_sim_10KNe_05i_20Chr_15Mb_5rep.%A_%a.e
#SBATCH --output=ft_sim_10KNe_05i_20Chr_15Mb_5rep.%A_%a.o
#SBATCH --job-name=ft_10KNe_rep5
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## run parallel jobs
#cd /home/yzliu/DK_proj/steps/
#mkdir systematic_ftsm_test
## check No. of par file of 1 chromosome test
#ls $par_folder/*5Chr*.par | wc -l
#24
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
#par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/10000Ne
par_folder=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/fastsimcoal/para_test3/10000Ne
par=$(ls $par_folder/ft_sim_10000Ne*1E_*05i_20Chr_15Mb.par | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)

## old test
fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
#par=$par_folder/ft_sim_100000Ne_200hapS_1E_500G_09d_20Chr_15Mb.par
## ft_sim_100000Ne_200hapS_1E_500G_05i_20Chr_15Mb.par
par=$(ls $par_folder/ft_sim_10000Ne*1E_*05i_20Chr_15Mb.par | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
$fsc -i $par -n 5 -q -s 0 -m --foldedSFS -c 8 -g -G -k 300000000

exit 0

# blueprint files
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/100000Ne_5rep
ls *80hapS_1E_100G_1.5i_20Chr_15Mb*blueprint
ls *80hapS_1E_500G_1.5i_20Chr_15Mb*blueprint

for i in $(ls *{80,200}hapS_1E_{100,500}G_1.5i_20Chr_15Mb*blueprint)
do
cp $i $i.new
rename '1.5i' '05i' $i.new
done
# change file names
ls *.new
rename '.new' '' *.new

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
eDAN_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
cp -r * $eDAN_DIR


exit 0

