#!/bin/sh
#SBATCH --account eDNA
##SBATCH --cpus-per-task 20
##SBATCH --mem 50g
#SBATCH --mem 25g # not enough
##SBATCH --array=1-455076%600
#SBATCH --array=1-35080%1000
#SBATCH --time=08:00:00
#SBATCH --error=3_fb_variant_calling_2025_PorSca_REF_PorSca.100kb_g1500x.chr_regions.4.%A_%a.e
#SBATCH --output=3_fb_variant_calling_2025_PorSca_REF_PorSca.100kb_g1500x.chr_regions.4.%A_%a.o
#SBATCH --job-name=455076_3_fb_variant_calling_2025_PorSca_REF_PorSca.100kb_g1500x.chr_regions.4
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## You can check your system's limit with:
## scontrol show config | grep MaxArraySize

## the location of bam-files
BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam
## for pooled data
SAMPLE=PorSca.REF_PorSca.sort.marked_dups.bam

## output vcf
VCF_OUT_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf

mkdir $VCF_OUT_DIR/fb_per_region_PorSca_REF_PorSca
cd $VCF_OUT_DIR/fb_per_region_PorSca_REF_PorSca

## path to your ref genome
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
REF=$REF_DIR/Porcellio_scaber-GCA_034700385.1.fa.masked

Each_Region_Dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/fasta_generate_regions/chr_regions
Ref_Region=Porcellio_scaber-GCA_034700385.1.fb_100kb.regions.masked

#ENA|JAQIXM010000001|JAQIXM010000001.1:0-17937
#ENA|JAQIXM010000002|JAQIXM010000002.1:0-15635
#ENA|JAQIXM010000003|JAQIXM010000003.1:0-15535

#SLURM_ARRAY_TASK_ID=140000
NEW_SLURM_ARRAY_TASK_ID=$((SLURM_ARRAY_TASK_ID + 420000))
#echo $NEW_SLURM_ARRAY_TASK_ID

Each_Region_Ref=$(cat $Each_Region_Dir/$Ref_Region | sed -n ${NEW_SLURM_ARRAY_TASK_ID}p)

## run freebayes with single core
freebayes --region $Each_Region_Ref --fasta-reference $REF \
    --ploidy 100 --pooled-discrete --genotype-qualities --use-best-n-alleles 3 --min-alternate-fraction 0 --min-alternate-count 2 \
    --bam $BAM_DIR/$SAMPLE -g 1500 --strict-vcf --gvcf \
    > ./"PorSca_REF_PorSca.100kb_1500x_region_"${NEW_SLURM_ARRAY_TASK_ID}.g.vcf
