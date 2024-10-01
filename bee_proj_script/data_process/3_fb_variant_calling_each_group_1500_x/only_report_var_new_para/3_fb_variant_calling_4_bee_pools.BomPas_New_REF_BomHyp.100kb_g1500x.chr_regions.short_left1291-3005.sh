#!/bin/sh
#SBATCH --account eDNA
##SBATCH --cpus-per-task 20
#SBATCH --mem 20g
##SBATCH --array=1-2964%60
#SBATCH --array=1291-3005%1000
#SBATCH --time=14:00:00
##SBATCH --time=3-04:04:00
#SBATCH --error=3_fb_variant_calling_4_bee_pools.BomPas_New_REF_BomHyp.100kb_g1500x.chr_regions.short_left1291-.%A_%a.e
#SBATCH --output=3_fb_variant_calling_4_bee_pools.BomPas_New_REF_BomHyp.100kb_g1500x.chr_regions.short_left1291-.%A_%a.o
#SBATCH --job-name=left257-3_fb_variant_calling_4_bee_pools.BomPas_New_REF_BomHyp.short
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## the location of bam-files
BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam
## output vcf
VCF_OUT_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf

## mkdir $VCF_OUT_DIR/fb_per_contig_BomPas_REF_BomHyp
mkdir $VCF_OUT_DIR/fb_per_region_BomPas_New_REF_BomHyp
#cd $VCF_OUT_DIR/fb_per_contig_BomPas_REF_BomHyp
cd $VCF_OUT_DIR/fb_per_region_BomPas_New_REF_BomHyp

## path to your ref genome
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
REF=$REF_DIR/Bombus_hypnorum-GCA_911387925.1-softmasked.fa

## example
#Run freebayes in parallel on 100000bp chunks of the ref (fasta_generate_regions.py is also
#located in the scripts/ directory in the freebayes distribution).  Use 36 threads.
#freebayes-parallel <(fasta_generate_regions.py ref.fa.fai 100000) 36 -f ref.fa aln.bam >out.vcf
#fasta_generate_regions.py $REF_DIR/Bombus_sylvicola_v1.fna.fai 100000 > $REF_DIR/syl.ref.fa.100kbp.regions.freebayes
## https://github.com/freebayes/freebayes/issues/73

## for pooled data
#SAMPLE=$SEQDIR/Andhae_Andmar.REF_Andhae.bam.list
SAMPLE=Bompas.New_REF_BomHyp.sort.marked_dups.bam
## Bompas.New_REF_BomHyp.sort.marked_dups.bam
## Bomvet.New_REF_BomHyp.sort.marked_dups.bam

Each_Region_Dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/fasta_generate_regions/chr_regions
Ref_Region=Bombus_hypnorum-GCA_911387925.1-softmasked.fb_100kb.regions
Each_Region_Ref=$(cat $Each_Region_Dir/$Ref_Region | sed -n ${SLURM_ARRAY_TASK_ID}p)
# 1:0-2000000
# 1:2000000-4000000
# 1:4000000-6000000
Ref_Masked_Bed=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed/BomPas_GCA_905332965.1_gene_region_1.softmasked_chr_name.sorted.bed

## run freebayes with single core
freebayes --region $Each_Region_Ref --fasta-reference $REF \
    --ploidy 68 --pooled-discrete --genotype-qualities --use-best-n-alleles 3 --min-alternate-fraction 0 --min-alternate-count 2 \
    --bam $BAM_DIR/$SAMPLE -g 1500 --strict-vcf --gvcf \
    > $VCF_OUT_DIR/fb_per_region_BomPas_New_REF_BomHyp/"Bompas.New_REF_BomHyp.100kb_1500x_region_"${SLURM_ARRAY_TASK_ID}.g.vcf
#    vcfintersect -v -b $Ref_Masked_Bed > $VCF_OUT_DIR/$fb_per_region_BomPas_New_REF_BomHyp/"Bompas.New_REF_BomHyp.2Mb_g1500_region_"${SLURM_ARRAY_TASK_ID}.g.vcf
#    vcffilter -f "QUAL > 20"

## not execute after this line
exit 0

# ref list
REF1_list=("iyAndHaem1_1.md_chr.fa" "iyAndHaem1_1.md_chr.fa" "iyBomPasc1_1.md_chr.fa" "iyBomPasc1_1.md_chr.fa")
REF2_list=("iyAndHatt_8785v1_2.md_chr.fa" "iyAndHatt_8785v1_2.md_chr.fa" "iyBomHypn_7925v1_2.md_chr.fa" "iyBomHypn_7925v1_2.md_chr.fa")
REF3_list=("iyBomPasc1_1.md_chr.fa" "iyBomPasc1_1.md_chr.fa" "Amel_HAv3_1.md_chr.fa" "Amel_HAv3_1.md_chr.fa")

## separate chr/contig for variant calling to run in short time
fb_list=("Andrena_haemorrhoa-GCA_910592295.1-softmasked.fb_100kb.regions"
        "Andrena_hattorfiana-GCA_944738655.1-softmasked.fb_100kb.regions"
        "Bombus_pascuorum-GCA_905332965.1-softmasked.fb_100kb.regions"
        "Bombus_hypnorum-GCA_911387925.1-softmasked.fb_100kb.regions"
        "Apis_mellifera_HAv-GCF_003254395.2-softmasked.fb_100kb.regions")

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
