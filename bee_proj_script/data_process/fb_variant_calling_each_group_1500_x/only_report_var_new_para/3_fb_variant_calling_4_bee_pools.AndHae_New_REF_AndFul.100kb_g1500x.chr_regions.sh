#!/bin/sh
#SBATCH --account eDNA
##SBATCH --cpus-per-task 20
#SBATCH --mem 25g
#SBATCH --array=1-4803%600
#SBATCH --time=24:00:00
##SBATCH --time=3-04:04:00
#SBATCH --error=3_fb_variant_calling_4_bee_pools.AndHae_New_REF_AndFul.100kb_g1500x.chr_regions.%A_%a.e
#SBATCH --output=3_fb_variant_calling_4_bee_pools.AndHae_New_REF_AndFul.100kb_g1500x.chr_regions.%A_%a.o
#SBATCH --job-name=4803_3_fb_variant_calling_4_bee_pools.AndHae_New_REF_AndFul
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## the location of bam-files
BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam
## output vcf
VCF_OUT_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf

mkdir $VCF_OUT_DIR/fb_per_region_AndHae_New_REF_AndFul
cd $VCF_OUT_DIR/fb_per_region_AndHae_New_REF_AndFul

## path to your ref genome
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
REF=$REF_DIR/Andrena_fulva-GCA_946251845.1-softmasked.fa

## for pooled data
SAMPLE=Andhae.New_REF_AndFul.sort.marked_dups.bam

Each_Region_Dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/fasta_generate_regions/chr_regions
Ref_Region=Andrena_fulva-GCA_946251845.1-softmasked.fb_100kb.regions
Each_Region_Ref=$(cat $Each_Region_Dir/$Ref_Region | sed -n ${SLURM_ARRAY_TASK_ID}p)
# 1:0-2000000
# 1:2000000-4000000
# 1:4000000-6000000

## run freebayes with single core
freebayes --region $Each_Region_Ref --fasta-reference $REF \
    --ploidy 78 --pooled-discrete --genotype-qualities --use-best-n-alleles 3 --min-alternate-fraction 0 --min-alternate-count 2 \
    --bam $BAM_DIR/$SAMPLE -g 1500 --strict-vcf --gvcf \
    > ./"Andhae.New_REF_AndFul.100kb_1500x_region_"${SLURM_ARRAY_TASK_ID}.g.vcf

## not execute after this line
exit 0

# ref list
BAM_list_left=(
            "Andhae.New_REF_AndFul.sort.bam"  
            "Andmar.New_REF_AndTri.sort.bam"
            "Bompas.New_REF_BomHor.sort.bam"
            "Bomvet.New_REF_BomHor.sort.bam"
            "Bompas.New_REF_BomCon.sort.bam"
            "Bomvet.New_REF_BomCon.sort.bam"
            )
   REF1_list=(
            #"Andrena_fulva-GCA_946251845.1-softmasked.fa"
            #"Andrena_trimmerana-GCA_951215215.1-softmasked.fa"
            #"Bombus_hortorum-GCA_905332935.1-softmasked.fa"
            #"Bombus_hortorum-GCA_905332935.1-softmasked.fa"
            "Bombus_confusus-GCA_014737475.1_ASM1473747v1-softmasked.fa"
            "Bombus_confusus-GCA_014737475.1_ASM1473747v1-softmasked.fa"
            )         

for chr in `cut -d ":" -f 1 iyAndHaem1_1.md_chr.fa.2Mbp.regions.fb | uniq`;do
    grep "$chr" iyAndHaem1_1.md_chr.fa.2Mbp.regions.fb > ./iyAndHaem1_1.md_chr.fa.2Mbp."$chr".regions.fb;
done

for ref in "${fb_list[@]}";do
    echo $ref
done

## final
for ref in "${fb_list[@]}";do
    for chr in `cut -d ":" -f 1 "$ref" | uniq`;do
        grep "$chr" "$ref" > ./per_chr/$ref.$chr
    done
done
