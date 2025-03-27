#!/bin/bash
#SBATCH --account eDNA
##SBATCH --cpus-per-task 6
#SBATCH --mem 1g
##SBATCH --mem-per-cpu=8G
#SBATCH --array=1-9%9
##SBATCH --array=1-3%3 BomMus
#SBATCH --time=08:00:00
#SBATCH --error=bees_4pools.DP_3x_5x_7x_no_singleton.sm_genic.AndBic_BomSyl.%A_%a.e
#SBATCH --output=bees_4pools.DP_3x_5x_7x_no_singleton.sm_genic.AndBic_BomSyl.%A_%a.o
#SBATCH --job-name=bees_4pools.DP_3x_5x_7x_no_singleton.sm_genic.AndBic_BomSyl
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## parallel job
## This function is to run the job in parallel, submitting each task to a core for up to $1q tasks at a $2 time
function pwait() {
    while [ $(jobs -p | wc -l) -ge $1 ]; do
    sleep $2
    done
    }
## generate blueprint.sh batch files
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2
blueprint_file_dir=./stairway_plot_blueprint/bee_pools_blueprint/New_REF
## check declining PasVet first
blueprint_file=`ls -t $blueprint_file_dir/*no_singleton_sfs_*_1500x.sm_genic.blueprint | head -9 | sort -r`
#blueprint_file=$(ls ft_sim_10000Ne*20Chr_15Mb_*MSFS.blueprint | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
## create a function to run blueprint file
## attention to nrand as integer
## blueprint files and program are in the same folder
create_batch_files(){
    for file in $blueprint_file; do
    time java -cp stairway_plot_es Stairbuilder $file
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
run_blueprint_plot_sh=$(ls -t $blueprint_file_dir/*no_singleton_sfs_*_1500x.sm_genic.blueprint.sh | head -9 | sort -r | sed -n ${SLURM_ARRAY_TASK_ID}p)
time bash $run_blueprint_plot_sh

exit 0

for plot in 

## modify blueprint files
for bp in `ls *extended.blueprint`; do cp $bp $bp.new1;done
sed -i -e '21s/0.01,100/0.01,300/' -e '12s/bee_pools_plot_new/bee_pools_plot_new1/' *extended.blueprint.new1
rename blueprint.new1 new1.blueprint *extended.blueprint.new1
## plot stairway plot results in R
