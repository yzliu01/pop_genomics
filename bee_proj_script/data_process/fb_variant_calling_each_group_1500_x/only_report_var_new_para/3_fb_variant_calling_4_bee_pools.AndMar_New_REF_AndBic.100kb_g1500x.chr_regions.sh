#!/bin/sh
#SBATCH --account eDNA
##SBATCH --cpus-per-task 20
#SBATCH --mem 25g
#SBATCH --array=1-3718%600
#SBATCH --time=24:00:00
##SBATCH --time=3-04:04:00
#SBATCH --error=3_fb_variant_calling_4_bee_pools.AndMar_New_REF_AndBic.100kb_g1500x.chr_regions.%A_%a.e
#SBATCH --output=3_fb_variant_calling_4_bee_pools.AndMar_New_REF_AndBic.100kb_g1500x.chr_regions.%A_%a.o
#SBATCH --job-name=4108_3_fb_variant_calling_4_bee_pools.AndMar_New_REF_AndBic
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## the location of bam-files
BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam
## output vcf
VCF_OUT_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf

mkdir $VCF_OUT_DIR/fb_per_region_AndMar_New_REF_AndBic
cd $VCF_OUT_DIR/fb_per_region_AndMar_New_REF_AndBic

## path to your ref genome
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
REF=$REF_DIR/Andrena_bicolor-GCA_960531205.1.fa

## for pooled data
SAMPLE=Andmar.New_REF_AndBic.sort.marked_dups.bam

Each_Region_Dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/fasta_generate_regions/chr_regions
Ref_Region=Andrena_bicolor-GCA_960531205.1.fb_100kb.regions
Each_Region_Ref=$(cat $Each_Region_Dir/$Ref_Region | sed -n ${SLURM_ARRAY_TASK_ID}p)
# 1:0-2000000
# 1:2000000-4000000
# 1:4000000-6000000

## run freebayes with single core
freebayes --region $Each_Region_Ref --fasta-reference $REF \
    --ploidy 80 --pooled-discrete --genotype-qualities --use-best-n-alleles 3 --min-alternate-fraction 0 --min-alternate-count 2 \
    --bam $BAM_DIR/$SAMPLE -g 1500 --strict-vcf --gvcf \
    > ./"Andmar.New_REF_AndBic.100kb_1500x_region_"${SLURM_ARRAY_TASK_ID}.g.vcf

## not execute after this line
exit 0
