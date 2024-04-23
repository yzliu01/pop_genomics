#!/bin/sh
#SBATCH --account eDNA
##SBATCH --cpus-per-task 10
#SBATCH --mem 150g
#SBATCH --array=3-4%4
#SBATCH --time=2-00:00:00
#SBATCH --error=popoolation_pi.New_REF_BomPas3_4left_marked_dups.%A_%a.e.txt
#SBATCH --output=popoolation_pi.New_REF_BomPas3_4left_marked_dups.%A_%a.o.txt
#SBATCH --job-name=popoolation_pi.New_REF_BomPas3_4left_marked_dups
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

##conda activate bioproject
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping
## install perl module in both env
## https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjw2_jJy4KFAxVZwAIHHURfAUcQFnoECBgQAQ&url=https%3A%2F%2Fbioconda.github.io%2Frecipes%2Fperl-math-bigrat%2FREADME.html&usg=AOvVaw2D0-bp_ROEvTktz6jpbm32&opi=89978449
#conda install perl-math-bigrat
Variance_sliding_pl=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/popoolation_1.2.2/Variance-sliding.pl 

## https://marineomics.github.io/POP_03_poolseq.html#Nucleotide_Diversity
BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam

cd $BAM_DIR

REF_PAS_INDEX=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_pascuorum-GCA_905332965.1-softmasked.fa
IN_BAM=$(ls *New_REF_BomPas.sort.marked_dups.bam | sed -n ${SLURM_ARRAY_TASK_ID}p)
#IN_BAM1=Bompas.New_REF_BomPas.sort.marked_dups.bam
#IN_BAM2=Bomvet.New_REF_BomPas.sort.marked_dups.bam

OUT_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/samtools_mpileup
## single run
##samtools mpileup -f $REF_PAS_INDEX $IN_BAM > $OUT_DIR/$IN_BAM.mpileup

## array jobs
time \
samtools mpileup -f $REF_PAS_INDEX $IN_BAM > \
    $OUT_DIR/$IN_BAM.mpileup

## array jobs to calculate Tajima's pi
cd $OUT_DIR

time \
perl $Variance_sliding_pl --measure pi --input $IN_BAM.mpileup --output $IN_BAM.mpileup.pi \
    --min-count 3 --min-coverage 200 --max-coverage 1500 --window-size 10000 --step-size 10000 \
    --pool-size 68 --fastq-type illumina

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