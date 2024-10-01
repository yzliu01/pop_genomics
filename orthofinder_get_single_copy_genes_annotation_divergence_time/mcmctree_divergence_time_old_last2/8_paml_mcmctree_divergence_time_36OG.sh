#!/bin/sh
#SBATCH --account eDNA
#SBATCH --time=1-15:45:00
##SBATCH --cpus-per-task 10
#SBATCH --mem 5g
#SBATCH --job-name=old_last2_mcmctree
#SBATCH --error=8_paml_mcmctree_divergence_time_36OG_old_last2.%A.e
#SBATCH --output=8_paml_mcmctree_divergence_time_36OG_old_last2.%A.o
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## PRANK can do translated alignments of protein-coding DNA sequences or align them using the codon model.
## https://ariloytynoja.github.io/prank-msa/#methods
#conda activate myproject

# prepare tree file with fossile calibration
mcmctree_divergence_time_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/orthofinder_get_single_copy_genes_annotation_divergence_time/mcmctree_divergence_time_old_last2
cd $mcmctree_divergence_time_dir

# run mcmctree
mcmctree mcmctree.ctl
