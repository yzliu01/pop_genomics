#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 4
#SBATCH --mem 2g
##SBATCH --mem-per-cpu=8G
#SBATCH --array=1-12%12
#SBATCH --time=10:06:00
#SBATCH --error=dro_mel_4_groups.%A_%a.e.txt
#SBATCH --output=dro_mel_4_groups.%A_%a.o.txt
#SBATCH --job-name=dro_mel_4_groups
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## parallel job
## This function is to run the job in parallel, submitting each task to a core for up to $1q tasks at a $2 time
function pwait() {
    while [ $(jobs -p | wc -l) -ge $1 ]; do
    sleep $2
    done
    }
## generate blueprint.sh batch files
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2
blueprint_file_dir=./stairway_plot_blueprint/dro_mel_4_groups_blueprint
## e.g. ft_sim_10000Ne_20hapS_1E_50G_05d_20Chr_15Mb_1_5_MSFS.blueprint
#blueprint_file=`ls ft_sim_10000Ne*20Chr_15Mb_*MSFS.blueprint | sort -V`
blueprint_file=`ls $blueprint_file_dir/*New_REF*blueprint | sort -V`
#blueprint_file=$(ls ft_sim_10000Ne*20Chr_15Mb_*MSFS.blueprint | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
## create a function to run blueprint file
## attention to nrand as integer
## blueprint files and program are in the same folder
create_batch_files(){
    for file in $blueprint_file; do
    time java -cp stairway_plot_es Stairbuilder ./$file
    done
}
## run the function and output **blueprint.sh files
#create_batch_files

## run batch files
#blueprint_sh=`ls ./stairway_plot_blueprint/ft_sim_10000Ne*20Chr_15Mb*.blueprint.sh | sort -V | head -2`
#blueprint_sh=`ls $blueprint_file_dir/ft_sim_10000Ne*.blueprint.sh | sort -V`
run_batch_file(){
    for file in $blueprint_sh; do
    pwait 2 10
    print $file
    time bash $file
    done
    wait
}
## execute the function
#run_batch_file


## run batch files in array jobs to plot
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2

run_blueprint_plot_sh=$(ls $blueprint_file_dir/*New_REF*blueprint.sh | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
time bash $run_blueprint_plot_sh

exit

## plot stairway plot results in R
