#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 5:00:00
#SBATCH -J bcftools_sort_chr_Bbal
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=bcftools_filtered_DP3_GQ20_BiSNP_redo_maf005_missing05_Bbal.sort_chr.%A.e
#SBATCH --output=bcftools_filtered_DP3_GQ20_BiSNP_redo_maf005_missing05_Bbal.sort_chr.%A.o

## lode modules
module load bioinfo-tools
module load python
module load bcftools/1.14

## Main directories as variables
INPUT_DIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/BAL/new_variant_calling_ploidy/combined_vcf_genotyping

cd $INPUT_DIR

Input_vcf=gatk_17haploid_54diploid_B_bal.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.05_f_missing0.5.vcf.gz
sort=gatk_17haploid_54diploid_B_bal.SNP_hard_filtered.DP3_GQ20_biSNP_maf005_f_missing05.sort_chr.vcf.gz

bcftools sort $Input_vcf -Oz -o $sort

