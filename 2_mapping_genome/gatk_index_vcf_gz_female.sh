#!/bin/bash -l

#SBATCH -A snic2021-22-195
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 01:00:00
#SBATCH -J gatk_index_vcf_gz_female
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=gatk_index_vcf_gz_female.B_syl.%A.e
#SBATCH --output=gatk_index_vcf_gz_female.B_syl.%A.o

module load bioinfo-tools
module load GATK

INPUT=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/DB_VCF/vcftools_filtered_concat_phased

cd $INPUT

time gatk IndexFeatureFile -I gatk_female_52mon_66lap_B_syl.remove_het_sites_found_in_male_for_female_mon_lap_207_B_syl.vcf.gz