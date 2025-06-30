#!/bin/bash
#SBATCH --account eDNA
##SBATCH --cpus-per-task 16
#SBATCH --mem 30g
#SBATCH --time=00:30:00
#SBATCH --error=Rscript_5KNe_2d_2d_2ei_2ed.%A.e
#SBATCH --output=Rscript_5KNe_2d_2d_2ei_2ed.%A.o
#SBATCH --job-name=Rscript_5KNe_2d_2d_2ei_2ed
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate R

script_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/fastsimcoal_sim_stairway_plot_2024/scripts/3_stairway_plot
cd $script_dir
script=5KNe_2d_2d_2i_2i_10i_10i_2d_2i_2i_2d_2ei_2ed_2ed_2ei_plot_20_80_200S.R
Rscript $script