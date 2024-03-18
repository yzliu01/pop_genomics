#!/bin/sh
#SBATCH --account eDNA
##SBATCH --cpus-per-task 20
#SBATCH --mem 150g
##SBATCH --mem 800g
##SBATCH --array=1-10%20
#SBATCH --array=2-143%20
##SBATCH --time=03:10:00
#SBATCH --time=20:00:00
##SBATCH --time=3-04:04:00
#SBATCH --error=3_fb_variant_calling_4_bee_pools.BomPas_REF_BomPas.mono_2Mb_region_1500x.%A.e
#SBATCH --output=3_fb_variant_calling_4_bee_pools.BomPas_REF_BomPas.mono_2Mb_region_1500x.%A.o
#SBATCH --job-name=3_fb_VC_4_bee_pools.BomPas_REF_BomPas
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## the location of bam-files
BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam
## output vcf
VCF_OUT_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf

## mkdir $VCF_OUT_DIR/fb_per_contig_BomPas_REF_BomPas
#mkdir $VCF_OUT_DIR/fb_per_region_BomPas_New_REF_BomPas
#cd $VCF_OUT_DIR/fb_per_contig_BomPas_REF_BomPas
#cd $VCF_OUT_DIR/fb_per_region_BomPas_New_REF_BomPas


## path to your ref genome
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
REF=$REF_DIR/Bombus_pascuorum-GCA_905332965.1-softmasked.fa

## example
#Run freebayes in parallel on 100000bp chunks of the ref (fasta_generate_regions.py is also
#located in the scripts/ directory in the freebayes distribution).  Use 36 threads.
#freebayes-parallel <(fasta_generate_regions.py ref.fa.fai 100000) 36 -f ref.fa aln.bam >out.vcf
#fasta_generate_regions.py $REF_DIR/Bombus_sylvicola_v1.fna.fai 100000 > $REF_DIR/syl.ref.fa.100kbp.regions.freebayes
## https://github.com/freebayes/freebayes/issues/73

## for pooled data
#SAMPLE=$SEQDIR/Andhae_Andmar.REF_Andhae.bam.list
SAMPLE=Bompas.New_REF_BomPas.sort.marked_dups.bam
## Bompas.New_REF_BomPas.sort.marked_dups.bam
## Bomvet.New_REF_BomPas.sort.marked_dups.bam

Each_Region_Dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/fasta_generate_regions/chr_regions
Ref_Pas_Region=Bombus_pascuorum-GCA_905332965.1-softmasked.fb_2Mb.regions
Each_Region_Ref=$(cat $Each_Region_Dir/$Ref_Pas_Region | sed -n ${SLURM_ARRAY_TASK_ID}p)
# 1:0-2000000
# 1:2000000-4000000
# 1:4000000-6000000
Ref_Pas_Masked_Bed=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed/Bombus_pascuorum-GCA_905332965.1-softmasked.bed

## test
Ref_Pas_Dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
Ref_Pas_Old=$Ref_Pas_Dir/iyBomPasc1_1.md_chr.fa
#Ref_Pas_Region_Old=$Ref_Pas_Dir/fasta_generate_regions/iyBomPasc1_1.md_chr.fa.10kbp.regions.fb
Ref_Pas_Region_New=$Ref_Pas_Dir/fasta_generate_regions/Bombus_pascuorum-GCA_905332965.1-softmasked.fb_2Mb_chr.regions
#Each_Region_Ref_Old=$(cat $Ref_Pas_Region_Old | sed -n ${SLURM_ARRAY_TASK_ID}p)
Each_Region_Ref_New=$(cat $Ref_Pas_Region_New | sed -n ${SLURM_ARRAY_TASK_ID}p)
SAMPLE_OLD=Bompas.REF_BomPas.sort.marked_dups.new.bam

## attention to variable names
freebayes --fasta-reference $Ref_Pas_Old --ploidy 68 --pooled-discrete \
    --region $Each_Region_Ref_New --genotype-qualities --report-monomorphic --use-best-n-alleles 4 \
    --bam $BAM_DIR/$SAMPLE_OLD -g 1500 --strict-vcf --gvcf > $VCF_OUT_DIR/fb_per_contig_BomPas_REF_BomPas/"Bompas.REF_BomPas.mono_1500x_region_"${SLURM_ARRAY_TASK_ID}.g.vcf

exit 0

## run freebayes with single core
freebayes --region $Each_Region_Ref --fasta-reference $REF \
    --ploidy 68 --pooled-discrete --genotype-qualities --report-monomorphic --use-best-n-alleles 4 \
    --bam $BAM_DIR/$SAMPLE -g 1500 --strict-vcf --gvcf | \
    vcfintersect -v -b $Ref_Pas_Masked_Bed > $VCF_OUT_DIR/$fb_per_region_BomPas_New_REF_BomPas/"Bompas.New_REF_BomPas.2Mb_g1500_region_"${SLURM_ARRAY_TASK_ID}.g.vcf

## not execute after this line

exit 0

freebayes --fasta-reference $Ref_Pas_Old --ploidy 68 --pooled-discrete \
    --region chr1:10000-20000 --genotype-qualities --report-monomorphic --use-best-n-alleles 4 \
    --bam $BAM_DIR/$SAMPLE_OLD -g 1500 --strict-vcf --gvcf > Bompas.REF_BomPas.1500x_region_chr1:10000-20000.g.vcf

# ref list
REF1_list=("iyAndHaem1_1.md_chr.fa" "iyAndHaem1_1.md_chr.fa" "iyBomPasc1_1.md_chr.fa" "iyBomPasc1_1.md_chr.fa")
REF2_list=("iyAndHatt_8785v1_2.md_chr.fa" "iyAndHatt_8785v1_2.md_chr.fa" "iyBomHypn_7925v1_2.md_chr.fa" "iyBomHypn_7925v1_2.md_chr.fa")
REF3_list=("iyBomPasc1_1.md_chr.fa" "iyBomPasc1_1.md_chr.fa" "Amel_HAv3_1.md_chr.fa" "Amel_HAv3_1.md_chr.fa")

## separate chr/contig for variant calling to run in short time
fb_list=("Amel_HAv3_1.md_chr.fa.10kbp.regions.fb" "iyAndHaem1_1.md_chr.fa.10kbp.regions.fb" \
    "iyAndHatt_8785v1_2.md_chr.fa.10kbp.regions.fb" "iyBomHypn_7925v1_2.md_chr.fa.10kbp.regions.fb" \
    "iyBomPasc1_1.md_chr.fa.10kbp.regions.fb")
fb_list=("Amel_HAv3_1.md_chr.fa.10kbp.regions.fb"
        "iyAndHaem1_1.md_chr.fa.10kbp.regions.fb"
        "iyAndHatt_8785v1_2.md_chr.fa.10kbp.regions.fb"
        "iyBomHypn_7925v1_2.md_chr.fa.10kbp.regions.fb"
        "iyBomPasc1_1.md_chr.fa.10kbp.regions.fb")

for chr in `cut -d ":" -f 1 iyAndHaem1_1.md_chr.fa.10kbp.regions.fb | uniq`;do
    grep "$chr" iyAndHaem1_1.md_chr.fa.10kbp.regions.fb > ./iyAndHaem1_1.md_chr.fa.10kbp."$chr".regions.fb;
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
