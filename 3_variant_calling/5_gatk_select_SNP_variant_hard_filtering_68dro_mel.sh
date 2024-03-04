#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 6
#SBATCH --mem 10g
##SBATCH --array=1-10%10
#SBATCH -t 00:25:00
#SBATCH -J gatk_select_SNP_hard_filtering_68_deo_mel
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=gatk_select_SNP_hard_filtering_68_deo_mel.%A.e
#SBATCH --output=gatk_select_SNP_hard_filtering_68_deo_mel.%A.o

# Main directories as variables
# Path to where you have the genotyped vcf-files
VCF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_gatk_vcf/DB_VCF

# Reference sequence
# Path and file name for ref genome
REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/D_melanogaster.7509v1.md_chr.fa

cd $VCF_DIR

INTPUT_VCF=concated_deo_mel_all_chr.sorted_chr.vcf.gz
#OUTPUT_NAMES=${INTPUT_NAMES/.g.vcf.gz/.SNP.vcf.gz} # modify file names

source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate gatk_4.3.0.0

# select SNPs
gatk SelectVariants -R $REF \
-V $INTPUT_VCF \
--select-type-to-include SNP \
-O concated_deo_mel_all_chr.sorted_chr.SNP.vcf.gz

# hard filtering
gatk VariantFiltration \
-R $REF \
-V concated_deo_mel_all_chr.sorted_chr.SNP.vcf.gz \
-O concated_deo_mel_all_chr.sorted_chr.SNP_hard_filtered.vcf.gz \
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
