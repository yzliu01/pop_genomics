#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 4
##SBATCH --mem 20g
##SBATCH --mem-per-cpu=8G
#SBATCH --array=6-10%5
##SBATCH --array=1-11%5
#SBATCH --time=21:06:00
#SBATCH --error=fsc_fold_10KNe_4E_20_60_100_200S_1_10_50_90d_5Chr_1000Kb.parallel.%A.e.txt
#SBATCH --output=fsc_fold_100_1000_1000K_Ne_4E_20_60_100_200S_1_10_50_90d_5Chr_1000Kb.parallel.%A.o.txt
#SBATCH --job-name=para_systematic_fsc_test1
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## parallel job
## This function is to run the job in parallel, submitting each task to a core for up to $1q tasks at a time
function pwait() {
    while [ $(jobs -p | wc -l) -ge $1 ]; do
    sleep $2
    done
    }
## generate blueprint.plot.sh files
cd /home/yzliu/bin/stairway_plot_v2.1.2
blueprint_file=`ls fsc_fold_1000K*5Chr_1000Kb.blueprint | sort -V | head -3`
blueprint_file=$(ls fsc_fold*5Chr_1000Kb.blueprint | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
## create a function to run blueprint file
## attention to nrand as integer
run_blueprint(){
    for file in $blueprint_file; do
    time java -cp stairway_plot_es Stairbuilder $file
    done
}
## run the function and output **blueprint.sh files
run_blueprint


## make plot
blueprint_sh=`ls fsc_fold*5Chr_1000Kb.blueprint.sh`

stairway_plot_parallel(){
    for file in $blueprint_sh; do
    pwait 4 10
    print $file
    time bash $file
    done
    wait
}
## execute the function
#stairway_plot_parallel


## array job to plot
#ls $par_folder/*5Chr*.par | wc -l
#24
cd /home/yzliu/bin/stairway_plot_v2.1.2
## current dir
blueprint_folder=.
## test blueprint_plot.sh
#plot_blueprint_file=$blueprint_folder/fsc_fold_1KNe_4E_60S_1_10_50_90d_5Chr_1000Kb.blueprint.sh
blueprint_plot_sh=$(ls $blueprint_folder/fsc_fold*5Chr_1000Kb.blueprint.sh | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
time bash $blueprint_plot_sh

exit


stairway_plot(){
    for file in $blueprint_sh; do
    time bash $file
    done
}
## execute the function
#stairway_plot

## run time of test of 200 genomes
[yzliu@fe-open-01 systematic_fsc_test1]$ $fsc -i $par -n 1 -q -s 0 -d --foldedSFS -c 8 -G -k 10000000
fastsimcoal was invoked with the following command line arguments:
/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal/para_test1/ft_sim_1000KNe_200S_4E_1_10_50_90d_5Chr_1000Kb.par -n 1 -q -s 0 -d --foldedSFS -c 8 -G -k 10000000 

Random generator seed : 130633

No population growth detected in input file

fastsimcoal2 is building 5 genealogies ...

Simulating 5 independent chromosomes using 12 batches and 8 threads.


Iteration 1/1 done in 17979.275 secs


Program total execution time: 17979.298 seconds