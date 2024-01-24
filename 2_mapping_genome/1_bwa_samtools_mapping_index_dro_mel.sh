#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 6
#SBATCH --mem 80g
#SBATCH --array=1-136%20
##SBATCH --array=1-10%10
##SBATCH --time=3-04:04:00
#SBATCH --time=15:05:00
#SBATCH --error=1_mapping_dro_mel.%A_%a.e.txt
#SBATCH --output=1_mapping_dro_mel.%A_%a.o.txt
#SBATCH --job-name=1_mapping_dro_mel
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## clean fastq sequence dir
SEQDIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/empirical_drosophila_clean_fastq
## mapping output
OUT_BAM=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate
## reference dir
REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/D_melanogaster.7509v1.md_chr.fa

## read fastq files and Read group lines
cd $SEQDIR
seq1=$(ls SRR*_1.fastq.clean.gz | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p) # forward sequence
seq2=$(ls SRR*_2.fastq.clean.gz | sort -V| sed -n ${SLURM_ARRAY_TASK_ID}p) # reverse sequence

## read fastq files and Read group lines
#Read1=$(find $DIR -print | grep '.*_1.fastq.gz' | sort | sed -n ${SLURM_ARRAY_TASK_ID}p)
#Read2=$(find $DIR -print | grep '.*_2.fastq.gz' | sort | sed -n ${SLURM_ARRAY_TASK_ID}p)
## /crex/proj/snic2020-6-58/private/yzliu/test/fastq_bt/SRR13647737_1.fastq.gz
#ReadGroup=$(cat ReadGroup_new.txt | sed -n ${SLURM_ARRAY_TASK_ID}p)
## @RG\tID:SRR13647737\tPL:Illumina_NovaSeq_S4\t:SA_4

## modify output file names
#File1=${seq1/.fastq.clean.gz/.bam}				 ### SRR13647737_1.bam
#File2=${File1/.bam/_sort.bam}				 ### SRR13647737_1_sort.bam
File1=${seq1/_1.fastq.clean.gz/.sort.bam}

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## read mapping, convert sam file to bam file, and sort reads
## not necessary to view and generate those files
## https://www.biostars.org/p/319730/
#bwa mem -t 8 $REF $seq1 $seq1 | samtools view -b -@ 8 | samtools sort -@ 8 -m 5G -o $OUTPUT/$File2

script_path=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/2_mapping_genome

rm $script_path/dro_mel_aligning_sorting.log
rm $script_path/dro_mel_bam_index.log

echo -e "aligning: $seq1 $seq2\n" >> $script_path/dro_mel_aligning_sorting.log
bwa mem -t 6 $REF $seq1 $seq1 | samtools sort -@ 6 -m 40G -o $OUT_BAM/$File1

## indexing
echo -e "indexing: $seq1 $seq2\n" >> $script_path/dro_mel_bam_index.log
samtools index $OUT_BAM/$File1
#bamtools stats -in $OUTPUT/$File1