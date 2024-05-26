#!/bin/sh
#SBATCH --account eDNA
##SBATCH --cpus-per-task 10
#SBATCH --mem 10g
#SBATCH --array=1-6%6
#SBATCH --time=2-00:00:00
#SBATCH --error=popoolation_pi.vet_hae_mar.new.%A_%a.e
#SBATCH --output=popoolation_pi.vet_hae_mar.new.%A_%a.o
#SBATCH --job-name=popoolation_pi.vet_hae_mar
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

##conda activate bioproject
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping
## install perl module in both env
## https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjw2_jJy4KFAxVZwAIHHURfAUcQFnoECBgQAQ&url=https%3A%2F%2Fbioconda.github.io%2Frecipes%2Fperl-math-bigrat%2FREADME.html&usg=AOvVaw2D0-bp_ROEvTktz6jpbm32&opi=89978449
#conda install perl-math-bigrat
Variance_sliding_pl=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/popoolation_1.2.2/Variance-sliding.pl 

## https://marineomics.github.io/POP_03_poolseq.html#Nucleotide_Diversity
## ref dir
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
REF_INDEX_list=(
    "Bombus_pascuorum-GCA_905332965.1-softmasked.fa"
    "Bombus_pascuorum-GCA_905332965.1-softmasked.fa"
    "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa"
    "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa"
    "Andrena_hattorfiana-GCA_944738655.1-softmasked.fa"
    "Andrena_marginata_GCA_963932335.1-softmasked.fa"
)
REF_INDEX=$(echo ${REF_INDEX_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)
## input dir
BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam
cd $BAM_DIR
IN_BAM_list=(
    "Bompas.New_REF_BomPas.sort.marked_dups.bam"
    "Bomvet.New_REF_BomPas.sort.marked_dups.bam"
    "Andhae.New_REF_AndHae.sort.marked_dups.bam"
    "Andmar.New_REF_AndHae.sort.marked_dups.bam"
    "Andmar.New_REF_AndHat.sort.marked_dups.bam"
    "Andmar.New_REF_AndMar.sort.marked_dups.bam"
)
IN_BAM=$(echo ${IN_BAM_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)
## output dir
OUT_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/samtools_mpileup
## pool size
POOL_SIZE_list=(
    68 58 78 80 80 80
)
POOL_SIZE=$(echo ${POOL_SIZE_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)
## array jobs
#time \
#samtools mpileup -f $REF_DIR/$REF_INDEX $BAM_DIR/$IN_BAM > \
#    $OUT_DIR/$IN_BAM.mpileup

## array jobs to calculate Tajima's pi
cd $OUT_DIR

time \
perl $Variance_sliding_pl --measure pi --input $OUT_DIR/$IN_BAM.mpileup --output $OUT_DIR/$IN_BAM.mpileup.50kb.pi \
    --min-count 2 --min-coverage 200 --max-coverage 1500 --window-size 50000 --step-size 50000 \
    --pool-size $POOL_SIZE --fastq-type illumina


exit 0

## --region regions_to_be_calculated
## complement region
pas_softmasked_region=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed/Bombus_pascuorum-GCA_905332965.1-softmasked.bed
OUT_BED=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed
## bedtools complement -h
## Use samtools faidx to create a genome file from a FASTA: 
##        One can the samtools faidx command to index a FASTA file.
##        The resulting .fai index is suitable as a genome file, 
##        as bedtools will only look at the first two, relevant columns
##        of the .fai file.
##
##        For example:
##        samtools faidx GRCh38.fa
##        bedtools complement -i my.bed -g GRCh38.fa.fai
bedtools complement -i $pas_softmasked_region -g $REF_PAS_INDEX.fai \
    > $OUT_BED/Bombus_pascuorum-GCA_905332965.1-softmasked_excluded.bed