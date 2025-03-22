#!/bin/sh
#SBATCH --account eDNA
##SBATCH --cpus-per-task 20
#SBATCH --mem 50g
##SBATCH --mem 25g # not enough
#SBATCH --array=1-6311%600
#SBATCH --time=28:00:00
#SBATCH --error=3_fb_variant_calling_2025_PhrFul_REF_PhrFul.100kb_g1500x.chr_regions.%A_%a.e
#SBATCH --output=3_fb_variant_calling_2025_PhrFul_REF_PhrFul.100kb_g1500x.chr_regions.%A_%a.o
#SBATCH --job-name=6311_3_fb_variant_calling_2025_PhrFul_REF_PhrFul.100kb_g1500x.chr_regions
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## the location of bam-files
BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam
## for pooled data
SAMPLE=Phrful.REF_PhrFul.sort.marked_dups.bam

## output vcf
VCF_OUT_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf

mkdir $VCF_OUT_DIR/fb_per_region_PhrFul_REF_PhrFul
cd $VCF_OUT_DIR/fb_per_region_PhrFul_REF_PhrFul

## path to your ref genome
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
REF=$REF_DIR/Phragmatobia_fuliginosa-GCA_932526445.1-softmasked.fa

Each_Region_Dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/fasta_generate_regions/chr_regions
Ref_Region=Phragmatobia_fuliginosa-GCA_932526445.1-softmasked.fb_100kb.regions
Each_Region_Ref=$(cat $Each_Region_Dir/$Ref_Region | sed -n ${SLURM_ARRAY_TASK_ID}p)

## run freebayes with single core
freebayes --region $Each_Region_Ref --fasta-reference $REF \
    --ploidy 100 --pooled-discrete --genotype-qualities --use-best-n-alleles 3 --min-alternate-fraction 0 --min-alternate-count 2 \
    --bam $BAM_DIR/$SAMPLE -g 1500 --strict-vcf --gvcf \
    > ./"PhrFul_REF_PhrFul.100kb_1500x_region_"${SLURM_ARRAY_TASK_ID}.g.vcf
