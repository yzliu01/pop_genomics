#!/bin/bash -l

#SBATCH -A snic2021-22-195
#SBATCH -p core
#SBATCH -n 8
#SBATCH --array=1_51
##SBATCH -C mem128GB
#SBATCH -t 1-09:00:00
#SBATCH -J 1_51_array_Atum_haplotypecaller
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=variant_calling_haplotypecaller_array_1_51_Atum.%A.e
#SBATCH --output=variant_calling_haplotypecaller_array_1_51_Atum.%A.o

## load modules/tools
module load bioinfo-tools GATK samtools bamtools
## file directory
DIR=/crex/proj/snic2020-6-58/private/yzliu/test/fastq_bt
OUTDIR=$DIR"/gVCF"
#cd $SEQDIR
#mkdir gVCF

## reference dir
REF=/crex/proj/snic2020-6-58/private/yzliu/test/ref_genome/AetTumi1.1_genomic_chr_1_8_mt.fna

# Haploid or diploid genotyping
# PLOIDY=2
# -ploidy $PLOIDY

cd $DIR

SAMPLE=$(ls *sorted_marked_dups.bam | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
# example: TZ_10.sorted_marked_dups.bam
RENAME=${SAMPLE/.bam/.g.vcf.gz/}
# TZ_10.sorted_marked_dups.g.vcf.gz
PLOIDY=$(cat sort_bam_sample_ploidy.list | sed -n ${SLURM_ARRAY_TASK_ID}p)

echo "Running HaplotypeCaller for $SAMPLE"

gatk HaplotypeCaller \
-R $REF \
-I $SAMPLE \
-O $OUTDIR/$RENAME \
-ploidy $PLOIDY
-ERC GVCF
