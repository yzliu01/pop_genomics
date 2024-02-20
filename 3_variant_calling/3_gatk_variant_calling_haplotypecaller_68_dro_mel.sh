#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 6
#SBATCH --mem 120g
#SBATCH --array=1-68%8
#SBATCH -t 00:05:00
##SBATCH -t 1-10:00:00
#SBATCH -J gatk_snp_calling_dro_mel
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=gatk_variant_calling_haplotypecaller_array_68_deo_mel.%A.e
#SBATCH --output=gatk_variant_calling_haplotypecaller_array_68_deo_mel.%A.o

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate gatk_4.3.0.0

## bam file directory
BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate
VCF_OUT_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_gatk_vcf/gVCF
#cd $VCF_OUT_DIR
#mkdir gVCF

## path to your ref genome
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/D_melanogaster.7509v1.md_chr.fa

cd $BAM_DIR

SAMPLE=$(ls *sort.marked_dups.bam | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
# SRR24680758.sort.marked_dups.bam
RENAME=${SAMPLE/.bam/.g.vcf.gz}
# SRR24680758.sort.marked_dups.bam.g.vcf.gz
#PLOIDY=$(cat sort_bam_sample_ploidy.list | sed -n ${SLURM_ARRAY_TASK_ID}p)

echo "Running HaplotypeCaller for $SAMPLE"

gatk HaplotypeCaller \
-R $REF \
-I $SAMPLE \
-O $VCF_OUT_DIR/$RENAME \
-ploidy 2
-ERC GVCF
