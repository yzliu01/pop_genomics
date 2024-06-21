#!/bin/sh
#SBATCH --account eDNA
#"SBATCH --cpus-per-task 4
#SBATCH --mem 30g
##SBATCH --array=1-1%1
##SBATCH --time=00:15:00
#SBATCH --time=16:30:00
#SBATCH --error=4-6_new_mapping_gatk_sort.%A_%a.e
#SBATCH --output=4-6new_mapping_gatk_sort.%A_%a.o
#SBATCH --job-name=4-6new_mapping_gatk_sort
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com


## Step II: reorder the chromosome order
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate gatk_4.3.0.0
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
## New_REF New_mapping
#for vcf in `ls concated*.100kb_g1500x_regions.vcf.gz`
for vcf in `ls -t concated*.100kb_g1500x_regions.vcf.gz | head -6`
    do 
    vcf_sorted_chr=${vcf/.vcf.gz/}
    gatk SortVcf --INPUT $vcf --OUTPUT $vcf_sorted_chr.all_chr.sorted.vcf.gz
done
