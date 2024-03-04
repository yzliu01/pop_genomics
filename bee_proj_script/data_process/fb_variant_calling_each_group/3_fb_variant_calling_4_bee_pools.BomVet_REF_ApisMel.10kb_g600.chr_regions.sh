#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 20
#SBATCH --mem 1100g
#SBATCH --array=1-76%10
##SBATCH --time=00:05:00
#SBATCH --time=10:30:00
##SBATCH --time=3-04:04:00
#SBATCH --error=3_fb_variant_calling_4_bee_pools.BomVet_REF_ApisMel.array_per_contig_177.10kb_g600.%A_%a.e
#SBATCH --output=3_fb_variant_calling_4_bee_pools.BomVet_REF_ApisMel.array_per_contig_177.10kb_g600.%A_%a.o
#SBATCH --job-name=3_fb_variant_calling_4_bee_pools.BomVet_REF_ApisMel
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## the location of bam-files
BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam
## output vcf
VCF_OUT_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf

cd $VCF_OUT_DIR
mkdir fb_per_contig_BomVet_REF_ApisMel

## path to your ref genome
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Amel_HAv3_1.md_chr.fa

## example
#Run freebayes in parallel on 100000bp chunks of the ref (fasta_generate_regions.py is also
#located in the scripts/ directory in the freebayes distribution).  Use 36 threads.
#freebayes-parallel <(fasta_generate_regions.py ref.fa.fai 100000) 36 -f ref.fa aln.bam >out.vcf
#fasta_generate_regions.py $REF_DIR/Bombus_sylvicola_v1.fna.fai 100000 > $REF_DIR/syl.ref.fa.100kbp.regions.freebayes
## https://github.com/freebayes/freebayes/issues/73

fasta_generate_regions=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/fasta_generate_regions/chr_regions

cd $fasta_generate_regions

contig_regions=$(ls ./ApisMel/*regions.[0-9][0-9].fb | sed -n ${SLURM_ARRAY_TASK_ID}p)
# ./ApisMel/Amel_HAv3_1.md_chr.fa.10kbp.regions.70.fb
#contig_name=$(cut -f 1 $REF_DIR/Amel_HAv3_1.md_chr.fa.fai | sed -n ${SLURM_ARRAY_TASK_ID}p)

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## for pooled data
#SAMPLE=$SEQDIR/Andhae_Andmar.REF_Andhae.bam.list
SAMPLE=Bomvet.REF_ApisMel.sort.marked_dups.new.bam
## Bompas.REF_ApisMel.sort.marked_dups.new.bam
## Bomvet.REF_ApisMel.sort.marked_dups.new.bam

## output vcf file name
## Andmar.REF_AndHat.sort.marked_dups.new.bam
BAM2VCF_NAME=${SAMPLE/sort.marked_dups.new.bam/g600_10kb_fb}
contig_regions_order=${contig_regions/\.\/ApisMel\/Amel_HAv3_1.md_chr.fa/}
## ./ApisMel/Amel_HAv3_1.md_chr.fa.10kbp.regions.65.fb

freebayes-parallel $contig_regions 20 --fasta-reference $REF \
    --ploidy 58 --pooled-discrete --genotype-qualities --use-best-n-alleles 4 \
    --bam $BAM_DIR/$SAMPLE -g 600 --strict-vcf --gvcf | \
    vcffilter -f "QUAL > 20" > $VCF_OUT_DIR/fb_per_contig_BomVet_REF_ApisMel/"$BAM2VCF_NAME""$contig_regions_order".qual_20.g.vcf





## not execute after this line
exit 0

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
