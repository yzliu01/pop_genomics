#!/bin/bash -l

#SBATCH -A snic2021-22-195
#SBATCH -p core
#SBATCH -n 3
#SBATCH -t 10:30:00
##SBATCH --array=1-592
#SBATCH -J gatk_hard_filtering_B_bal_hap_dip_combined
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=gatk_hard_filtering_B_bal_hap_dip_combined.%A.e
#SBATCH --output=gatk_hard_filtering_B_bal_hap_dip_combined.%A.o

# Main directories as variables
# Path to where you have the genotyped vcf-files
SEQDIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/BAL/new_variant_calling_ploidy/combined_vcf_genotyping

# Reference sequence
# Path and file name for ref genome
REF=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/Bombus_balteatus_v1.fna

cd $SEQDIR

INTPUT_NAMES=genotyping_output_17haploid_54diploid_B_bal.g.vcf.gz
# e.g. scaffold_1_output.g.vcf.gz

OUTPUT_NAMES=${INTPUT_NAMES/.g.vcf.gz/.hard_filtered.g.vcf.gz} # modify file names # working

module load bioinfo-tools
module load GATK

gatk VariantFiltration \
-R $REF \
-V $INTPUT_NAMES \
-O $OUTPUT_NAMES \
--filter-name "QD" \
--filter-expression "QD<2.0" \
--filter-name "FS" \
--filter-expression "FS>60.0" \
--filter-name "MQ" \
--filter-expression "MQ<40.0" \
--filter-name "MQRankSum" \
--filter-expression "MQRankSum<-12.5" \
--filter-name "ReadPosRankSum" \
--filter-expression "ReadPosRankSum<-8.0" \
--filter-name "SOR" \
--filter-expression "SOR>3.0"

