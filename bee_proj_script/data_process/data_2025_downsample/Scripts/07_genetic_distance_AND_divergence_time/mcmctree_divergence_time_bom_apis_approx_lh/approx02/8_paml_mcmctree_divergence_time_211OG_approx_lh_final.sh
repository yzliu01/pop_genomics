#!/bin/sh
#SBATCH --account eDNA
##SBATCH --time=05:45:00
#SBATCH --time=02:45:00
##SBATCH --cpus-per-task 10
#SBATCH --mem 2g
#SBATCH --job-name=ap_lh_final_2_211OG_mcmctree_bom_apis
#SBATCH --error=8_mcmctree_211OG_bom_apis_divergence_time_approx_lh_final_2.%A.e
#SBATCH --output=8_mcmctree_211OG_bom_apis_divergence_time_approx_lh_final_2.%A.o

source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## PRANK can do translated alignments of protein-coding DNA sequences or align them using the codon model.
## https://ariloytynoja.github.io/prank-msa/#methods
#conda activate myproject

# prepare tree file with fossile calibration
mcmctree_divergence_time_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/orthofinder_get_single_copy_genes_annotation_divergence_time/mcmctree_divergence_time_bom_apis_approx_lh/approx02
cd $mcmctree_divergence_time_dir

# run mcmctree
mcmctree mcmctree.ctl
