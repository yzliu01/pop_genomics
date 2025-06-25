#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 3
#SBATCH --mem 5g
##SBATCH --mem-per-cpu=8G
#SBATCH --array=1-30,41-100%90
#SBATCH --time=10:00:00
#SBATCH --error=fsc2stairway_100KNe_no_singleton_20_80_200hapS_1E_rest.%A_%a.e
#SBATCH --output=fsc2stairway_100KNe_no_singleton_20_80_200hapS_1E_rest.%A_%a.o
#SBATCH --job-name=fsc2stairway_100KNe_no_singleton_20_80_200hapS_1E_rest
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification


## run batch files in array jobs

## excluding 100G_1.5i 100G_1.9i

## to plot
#ls ./stairway_plot_blueprint/ft_sim_100000Ne*20Chr_15Mb*MSFS.blueprint.sh | sort -V | wc -l
#300
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2
blueprint_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/100000Ne_5rep_no_singletons
## early
##run_blueprint_plot_sh=$(ls $blueprint_dir/ft_sim_100000Ne*e_[id]_cons_20Chr_15Mb_*.blueprint.sh | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
run_blueprint_plot_sh=$(ls $blueprint_dir/ft_sim_100000Ne_80hapS*2e_[di]_cons_20Chr_15Mb_*.blueprint.sh $blueprint_dir/ft_sim_100000Ne_80hapS*1.*i_20Chr_15Mb_*.blueprint.sh | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)

time bash $run_blueprint_plot_sh

exit 0

## parallel job
## This function is to run the job in parallel, submitting each task to a core for up to $1q tasks at a $2 time
function pwait() {
    while [ $(jobs -p | wc -l) -ge $1 ]; do
    sleep $2
    done
    }
## generate blueprint.sh batch files
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2
blueprint_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/100000Ne_5rep_no_singletons
## e.g. ft_sim_100000Ne_20hapS_1E_50G_05d_20Chr_15Mb_1_5_MSFS.blueprint
#blueprint_file=`ls ft_sim_100000Ne*20Chr_15Mb_*MSFS.blueprint | sort -V`
blueprint_file=`ls $blueprint_dir/ft_sim_100000Ne_80hapS*2e_[di]_cons_20Chr_15Mb_*.blueprint $blueprint_dir/ft_sim_100000Ne_80hapS*1.*i_20Chr_15Mb_*.blueprint | sort -V`

#blueprint_file=$(ls ft_sim_100000Ne*20Chr_15Mb_*MSFS.blueprint | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
## create a function to run blueprint file
## attention to nrand as integer
## blueprint files and program are in the same folder
create_batch_files(){
    for file in $blueprint_file; do
    time java -cp stairway_plot_es Stairbuilder $file
    done
}
## run the function and output **blueprint.sh files
create_batch_files

## run batch files
#blueprint_sh=`ls ./stairway_plot_blueprint/ft_sim_100000Ne*20Chr_15Mb*.blueprint.sh | sort -V | head -2`
blueprint_sh=`ls $blueprint_file_dir/ft_sim_100000Ne*20Chr_15Mb*.blueprint.sh | sort -V`
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


## plot stairway plot results in R
