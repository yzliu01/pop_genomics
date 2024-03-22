#!/bin/sh
#SBATCH --account eDNA
##SBATCH --cpus-per-task 4
#SBATCH --mem 15g
#SBATCH --array=1-68%8
#SBATCH -t 00:15:00
#SBATCH -t 3-10:00:00
#SBATCH -J gatk_snp_calling_New_REF_dro_mel
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=gatk_variant_calling_haplotypecaller_array_68_New_REF_deo_mel.BP.%A_%a.e
#SBATCH --output=gatk_variant_calling_haplotypecaller_array_68_New_REF_deo_mel.BP.%A_%a.o

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate gatk_4.3.0.0

## bam file directory
BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate
VCF_OUT_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_gatk_vcf/GVCF
#cd $VCF_OUT_DIR
#mkdir gVCF

## path to your ref genome
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Drosophila_melanoganster-GCF_000001215.4_Release_6_plus_ISO1_MT_genomic-softmasked.fa
cd $BAM_DIR

## bed file that starts with index 1
#FB_2M_regions=$REF_DIR/fasta_generate_regions/chr_regions/Drosophila_melanoganster-GCF_000001215.4_Release_6_plus_ISO1_MT_genomic-softmasked.fb_2Mb.1_index.regions
##scaffold_names=$(cut -f 1 $REF_DIR/D_melanogaster.7509v1.md_chr.fa.fai | sed -n ${SLURM_ARRAY_TASK_ID}p)
#interval_names=$(cut -f 1 $FB_2M_regions | sed -n ${SLURM_ARRAY_TASK_ID}p)

SAMPLE=$(ls *sort.marked_dups.bam | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
# SRR24680758.sort.marked_dups.bam
RENAME=${SAMPLE/.bam/.BP.vcf.gz}
# SRR24680758.sort.marked_dups.bam.g.vcf.gz
#PLOIDY=$(cat sort_bam_sample_ploidy.list | sed -n ${SLURM_ARRAY_TASK_ID}p)

echo "Running HaplotypeCaller for $SAMPLE"

gatk HaplotypeCaller \
     -R $REF \
     -I $SAMPLE \
     -O $VCF_OUT_DIR/$RENAME \
     -ploidy 2 \
     -ERC BP_RESOLUTION
#     -L $interval_names \

gatk IndexFeatureFile \
     -I $VCF_OUT_DIR/$RENAME

#bcftools index -t -f in.vcf.gz

exit 0


#NONE
#    Regular calling without emitting reference confidence calls.
#BP_RESOLUTION
#    Reference model emitted site by site.
#GVCF
#    Reference model emitted with condensed non-variant blocks, i.e. the GVCF format. 

## test of -ERC NONE
SAMPLE=SRR24680725.sort.marked_dups.bam
RENAME=${SAMPLE/.bam/.none.vcf.gz}
gatk HaplotypeCaller \
     -R $REF \
     -I $SAMPLE \
     -O $VCF_OUT_DIR/$RENAME \
     -ploidy 2 \
     -ERC NONE
     
## test of -ERC BP_RESOLUTION
RENAME=${SAMPLE/.bam/.BP.vcf.gz}
gatk HaplotypeCaller \
     -R $REF \
     -I $SAMPLE \
     -O $VCF_OUT_DIR/$RENAME \
     -ploidy 2 \
     -ERC BP_RESOLUTION