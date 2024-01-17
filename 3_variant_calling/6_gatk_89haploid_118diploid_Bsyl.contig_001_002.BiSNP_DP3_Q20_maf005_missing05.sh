#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 00:30:00
#SBATCH -J gatk_89haploid_118diploid_Bsyl.contig_001_002.BiSNP_DP3_Q20_maf005_missing05
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=gatk_89haploid_118diploid_Bsyl.contig_001_002.BiSNP_DP3_Q20_maf005_missing05.%A.e
#SBATCH --output=gatk_89haploid_118diploid_Bsyl.contig_001_002.BiSNP_DP3_Q20_maf005_missing05.%A.o

## lode modules
module load bioinfo-tools
module load python
module load bcftools/1.14
module load vcftools

input_dir=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy/combined_vcf_genotyping

cd $input_dir
input_vcf=gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.vcf.gz
out_biSNP_vcf=gatk_89haploid_118diploid_Bsyl.contig_001_002.BiSNP.vcf.gz
out_filtered_vcf=gatk_89haploid_118diploid_Bsyl.contig_001_002.BiSNP_DP3_Q20_maf005_missing05.vcf.gz

## take two contigs from female file
time vcftools --gzvcf $input_vcf \
--chr contig_001 --chr contig_002 --remove-indels --min-alleles 2 --max-alleles 2 \
--recode --recode-INFO-all --stdout | bgzip -c > $out_biSNP_vcf

time vcftools --gzvcf $out_biSNP_vcf --thin 10 --minDP 4 --maf 0.05 --max-missing 0.5 --minQ 20 \
--recode --recode-INFO-all --stdout | bgzip -c > $out_filtered_vcf

#--remove-filtered-geno-all
#time bcftools index $out_filtered_vcf

#| bcftools filter -e 'AC==0 || AC == AN' 

# not working
time vcftools --gzvcf gatk_89haploid_118diploid_Bsyl.contig_001_002.BiSNP_DP3_Q20_maf005_missing05.vcf.gz \
--remove-filtered-geno-all --recode --recode-INFO-all --stdout | bgzip -c > \
gatk_89haploid_118diploid_Bsyl.contig_001_002.BiSNP_DP3_Q20_maf005_missing05.PASS.vcf.gz &

# worked
time bcftools view -f PASS gatk_89haploid_118diploid_Bsyl.contig_001_002.BiSNP_DP3_Q20_maf005_missing05.vcf.gz -Oz \
-o gatk_89haploid_118diploid_Bsyl.contig_001_002.BiSNP_DP3_Q20_maf005_missing05.hf_PASS.vcf.gz




