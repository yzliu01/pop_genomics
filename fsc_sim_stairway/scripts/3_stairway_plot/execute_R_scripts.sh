#!/bin/bash
#SBATCH --account eDNA
##SBATCH --cpus-per-task 3
#SBATCH --mem 4g
##SBATCH --array=1-340%340
#SBATCH --time=00:10:00
##SBATCH --error=stairway_plot.%A.e
##SBATCH --output=stairway_plot.%A.o
#SBATCH --job-name=stairway_plot
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env)
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate R
#which Rscript
# ~/miniforge3/envs/R/bin/Rscript

## alternative way of executing R scripts
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/fsc_sim_stairway/scripts/3_stairway_plot
Rscript stairway_plot_1MNe_200_300G_200hap_cons_1_1i_1_5i_1_9i.real_sim.modified.final.r
## a few scripts in a row
#Rscript myscript1.r
#Rscript myscript2.r

exit 0
