#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 02:00:00
#SBATCH -J freebayes_vcftools_male_BiSNP_filtered.Bsyl
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=freebayes_vcftools_male_BiSNP_filtered.Bsy.%A.e
#SBATCH --output=freebayes_vcftools_male_BiSNP_filtered.Bsy.%A.o

## lode modules
module load bioinfo-tools
module load python
module load bcftools/1.14
module load vcftools

input_dir=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/freebayes_variant_calling/gVCF

cd $input_dir
input_vcf=freeBayes_male_27monticola_62lapponicus.bam.multipleCPU.g.vcf
out_biSNP_vcf=freeBayes_male_27monticola_62lapponicus.contig_001_002.bi_snp.g.vcf.gz
out_filtered_vcf=freeBayes_male_27monticola_62lapponicus.contig_001_002.bi_snp_thin_DP3_maf005_missing05.g.vcf.gz

## take two contigs from female file
time vcftools --vcf $input_vcf \
--chr contig_001 --chr contig_002 --remove-indels --min-alleles 2 --max-alleles 2 \
--recode --recode-INFO-all --stdout | bgzip -c > $out_biSNP_vcf

time vcftools --gzvcf $out_biSNP_vcf --thin 10 --minDP 4 --maf 0.05 --max-missing 0.5 --minQ 20 \
--recode --recode-INFO-all --stdout | bgzip -c > $out_filtered_vcf

