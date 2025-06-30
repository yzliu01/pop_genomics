#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 3
#SBATCH --mem 3g
#SBATCH --array=1-15%15
#SBATCH --time=18:00:00
#SBATCH --error=fsc2stairway_1MNe_20_80_200hapS_1E_10d_10d.%A_%a.e
#SBATCH --output=fsc2stairway_1MNe_20_80_200hapS_1E_10d_10d.%A_%a.o
#SBATCH --job-name=fsc2stairway_1MNe_20_80_200hapS_1E_10d_10d
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## array job
## single run
## I - generate blueprint.sh batch files
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2
blueprint_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/1000000Ne_5rep
blueprint_plot_sh=$(ls -t $blueprint_dir/*100_500G_10d_10d*blueprint.sh | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)

time bash $blueprint_plot_sh

exit 0


*************************************
## parallel job
## This function is to run the job in parallel, submitting each task to a core for up to $1q tasks at a $2 time
function pwait() {
    while [ $(jobs -p | wc -l) -ge $1 ]; do
    sleep $2
    done
}

## single run
## I - generate blueprint.sh batch files
#cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2
blueprint_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/1000000Ne_5rep
blueprint_file=`ls -t $blueprint_dir/*100_500G_10d_10d*blueprint | sort -V`
## attention to nrand as integer
## blueprint files and program are in the same folder
create_batch_files(){
    for file in $blueprint_file; do
    time java -cp stairway_plot_es Stairbuilder $file
    done
}
## run the function and output **blueprint.sh files
create_batch_files


## II - run batch files
single_run_blueprint_sh=`ls ./single_run_err_blueprint_array/*.sh | head -3 | sort -V`

run_batch_file(){
    for file in $single_run_blueprint_sh; do
    pwait 2 10
    printf $file
    time bash $file
    done
    wait
}
## execute the function
run_batch_file

