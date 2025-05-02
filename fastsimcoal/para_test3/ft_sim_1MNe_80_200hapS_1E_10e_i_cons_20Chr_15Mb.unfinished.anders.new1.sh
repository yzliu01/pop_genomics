#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 12
#SBATCH --mem 1500g
#SBATCH --array=1-8%8
#SBATCH --time=15:00:00
#SBATCH --error=ft_sim_1MNe_80_200hapS_1E_10_i_cons_20Chr_15Mb.anders.new1.%A_%a.e
#SBATCH --output=ft_sim_1MNe_80_200hapS_1E_10_i_cons_20Chr_15Mb.anders.new1.%A_%a.o
#SBATCH --job-name=ft_sim_1MNe_80_200hapS_1E_10_i_cons_20Chr_15Mb.new1
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## run parallel jobs

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/1000000Ne_5rep
#fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
par_folder=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/fastsimcoal/para_test3/1000000Ne_new
#par=$(ls $par_folder/ft_sim_100000Ne*2E_100_500G_2e*2e*20Chr_15Mb.par | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)

unfinished_list=("ft_sim_1000000Ne_80hapS_1E_50G_10e_i_cons_20Chr_15Mb.par"
                "ft_sim_1000000Ne_200hapS_1E_50G_10e_i_cons_20Chr_15Mb.par"
                "ft_sim_1000000Ne_80hapS_1E_100G_10e_i_cons_20Chr_15Mb.par"
                "ft_sim_1000000Ne_200hapS_1E_100G_10e_i_cons_20Chr_15Mb.par"
                "ft_sim_1000000Ne_80hapS_1E_500G_10e_i_cons_20Chr_15Mb.par"
                "ft_sim_1000000Ne_200hapS_1E_500G_10e_i_cons_20Chr_15Mb.par"
                "ft_sim_1000000Ne_80hapS_1E_1000G_10e_i_cons_20Chr_15Mb.par"
                "ft_sim_1000000Ne_200hapS_1E_1000G_10e_i_cons_20Chr_15Mb.par")
par=$(echo ${unfinished_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)

## anders advice to use scratch local space
cd $TEMPDIR
cp $par_folder/$par .
mkdir out
cd out

source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
conda activate fastsimcoal2

fsc27093 -i ../*.par -n 5 -c 12 -q -x -s 0 -m -G -k 350000000
fsc27093 -i ../*.par -n 5 -c 12 -q -x -s 0 -m -k 350000000
# -g --foldedSFS

## copy files to faststorage
eDAN_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep
cp -r * $eDAN_DIR

exit 0

/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/fastsimcoal/para_test3/100000Ne/ft_sim_100000Ne_80hapS_1E_50G_09d_20Chr_15Mb.par
ft_sim_100000Ne_200hapS_1E_1000G_09d_20Chr_15Mb.par
ft_sim_100000Ne_200hapS_1E_500G_09d_20Chr_15Mb.par
ft_sim_100000Ne_200hapS_1E_100G_09d_20Chr_15Mb.par
ft_sim_100000Ne_80hapS_1E_100G_09d_20Chr_15Mb.par
ft_sim_100000Ne_80hapS_1E_500G_09d_20Chr_15Mb.par
ft_sim_100000Ne_80hapS_1E_50G_09d_20Chr_15Mb.par

unfinished_list=("ft_sim_100000Ne_80hapS_1E_50G_09d_20Chr_15Mb.par" 
            "ft_sim_100000Ne_80hapS_1E_100G_09d_20Chr_15Mb.par"
            "ft_sim_100000Ne_80hapS_1E_500G_09d_20Chr_15Mb.par"
            "ft_sim_100000Ne_200hapS_1E_100G_09d_20Chr_15Mb.par"
            "ft_sim_100000Ne_200hapS_1E_500G_09d_20Chr_15Mb.par"
            "ft_sim_100000Ne_200hapS_1E_1000G_09d_20Chr_15Mb.par")
REF3=$(echo ${unfinished_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)

"ft_sim_100000Ne_20hapS_1E_50G_10e_i_cons_20Chr_15Mb.par"
"ft_sim_100000Ne_80hapS_1E_50G_10e_i_cons_20Chr_15Mb.par"
"ft_sim_100000Ne_200hapS_1E_50G_10e_i_cons_20Chr_15Mb.par"
"ft_sim_100000Ne_20hapS_1E_100G_10e_i_cons_20Chr_15Mb.par"
"ft_sim_100000Ne_80hapS_1E_100G_10e_i_cons_20Chr_15Mb.par"
"ft_sim_100000Ne_200hapS_1E_100G_10e_i_cons_20Chr_15Mb.par"
"ft_sim_100000Ne_20hapS_1E_500G_10e_i_cons_20Chr_15Mb.par"
"ft_sim_100000Ne_80hapS_1E_500G_10e_i_cons_20Chr_15Mb.par"
"ft_sim_100000Ne_200hapS_1E_500G_10e_i_cons_20Chr_15Mb.par"
"ft_sim_100000Ne_20hapS_1E_1000G_10e_i_cons_20Chr_15Mb.par"
"ft_sim_100000Ne_80hapS_1E_1000G_10e_i_cons_20Chr_15Mb.par"
"ft_sim_100000Ne_200hapS_1E_1000G_10e_i_cons_20Chr_15Mb.par"




"ft_sim_1000000Ne_80hapS_1E_50G_10e_i_cons_20Chr_15Mb.par"
"ft_sim_1000000Ne_200hapS_1E_50G_10e_i_cons_20Chr_15Mb.par"
"ft_sim_1000000Ne_80hapS_1E_100G_10e_i_cons_20Chr_15Mb.par"
"ft_sim_1000000Ne_200hapS_1E_100G_10e_i_cons_20Chr_15Mb.par"
"ft_sim_1000000Ne_80hapS_1E_500G_10e_i_cons_20Chr_15Mb.par"
"ft_sim_1000000Ne_200hapS_1E_500G_10e_i_cons_20Chr_15Mb.par"
"ft_sim_1000000Ne_80hapS_1E_1000G_10e_i_cons_20Chr_15Mb.par"
"ft_sim_1000000Ne_200hapS_1E_1000G_10e_i_cons_20Chr_15Mb.par"