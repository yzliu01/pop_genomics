#!/bin/bash -l

#SBATCH -A snic2021-22-195
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 06:00:00
#SBATCH -J gatk_subset_10hyperboreus.remove_non_variant.phased
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=gatk_subset_10hyperboreus.remove_non_variant.phased.B_bal.%A.e
#SBATCH --output=gatk_subset_10hyperboreus.remove_non_variant.phased.B_bal.%A.o

# Main directories as variables
SEQDIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/BAL/DB_VCF/vcftools_filtered_concat_phased

module load bioinfo-tools
module load vcftools
module load GATK/4.1.4.1
module load Beagle/5.1

cd $SEQDIR

time gatk IndexFeatureFile -I B.bal_bcftools_SNP_biallelic_no_filter_concat.vcf.gz

time gatk SelectVariants -V B.bal_bcftools_SNP_biallelic_no_filter_concat.vcf.gz -R /crex/proj/snic2020-6-58/private/yzliu/reference_genome/Bombus_balteatus_v1.fna -sn subset_10hyperboreus.list --exclude-non-variants -O B.bal_bcftools_SNP_biallelic.gatk_subset_10hyperboreus.gatk_remove_non_variant.vcf

time vcftools --vcf B.bal_bcftools_SNP_biallelic.gatk_subset_10hyperboreus.gatk_remove_non_variant.vcf --FILTER-summary --out B.bal_bcftools_SNP_biallelic.gatk_subset_10hyperboreus.gatk_remove_non_variant.vcf

time java -Xmx4g -jar /sw/apps/bioinfo/Beagle/5.1/rackham/beagle.jar gt=B.bal_bcftools_SNP_biallelic.gatk_subset_10hyperboreus.gatk_remove_non_variant.vcf \
out=B.bal_bcftools_SNP_biallelic.gatk_subset_10hyperboreus.gatk_remove_non_variant.vcf.phased

