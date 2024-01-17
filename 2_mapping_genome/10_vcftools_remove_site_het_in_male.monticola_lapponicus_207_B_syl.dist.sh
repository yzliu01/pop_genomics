#!/bin/bash -l

#SBATCH -A snic2021-22-195
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 01:00:00
#SBATCH -J remove_heterozygous_sites_in_male_monticola_lapponicus_207_B_syl.dist
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=remove_heterozygous_sites_in_male_monticola_lapponicus_207_B_syl.dist.%A.e
#SBATCH --output=remove_heterozygous_sites_in_male_monticola_lapponicus_207_B_syl.dist.%A.o

# Main directories as variables
INPUT=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/DB_VCF/vcftools_filtered_concat_phased

cd $INPUT

module load bioinfo-tools
module load vcftools
module load python
module load bcftools

# compress with bgzip not gzip, GATK cannot recognize correctly otherwise
time vcftools --gzvcf bcftools_SNP_biallelic.gatk_207_B_syl.gatk_remove_non_variant.vcf.gz --exclude-positions heterozygous_site_male.cut.list --recode --recode-INFO-all --stdout | bgzip -c > remove_heterozygous_sites_in_male_monticola_lapponicus_207_B_syl.vcf.gz

time /home/yzliu/bin/VCF2Dis-master/VCF2Dis-1.46/bin/VCF2Dis -InPut remove_heterozygous_sites_in_male_monticola_lapponicus_207_B_syl.vcf.gz \
-OutPut remove_heterozygous_sites_in_male_monticola_lapponicus_207_B_syl.dist.txt




