#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 8
##SBATCH -C mem128GB
#SBATCH -t 3-12:00:00
##SBATCH -t 04:00:00
#SBATCH --array=1-49%25
#SBATCH -J SRR_fastq_mapping_49_array
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=SRR_fastq_mapping_49_array.%A.e
#SBATCH --output=SRR_fastq_mapping_49_array.%A.o

## load modules/tools
module load bioinfo-tools bwa samtools bamtools
## file directory
DIR=/crex/proj/snic2020-6-58/private/yzliu/test/fastq_bt
cd $DIR
OUTPUT=/crex/proj/snic2020-6-58/private/yzliu/test/fastq_bt/mapping

## reference dir
REF=/crex/proj/snic2020-6-58/private/yzliu/test/ref_genome/AetTumi1.1_genomic_chr_1_8_mt.fna

## read fastq files and Read group lines
Read1=$(find $DIR -print | grep '.*_1.fastq.gz' | sort | sed -n ${SLURM_ARRAY_TASK_ID}p)
Read2=$(find $DIR -print | grep '.*_2.fastq.gz' | sort | sed -n ${SLURM_ARRAY_TASK_ID}p)
## /crex/proj/snic2020-6-58/private/yzliu/test/fastq_bt/SRR13647737_1.fastq.gz
ReadGroup=$(cat ReadGroup_new.txt | sed -n ${SLURM_ARRAY_TASK_ID}p)
## @RG\tID:SRR13647737\tPL:Illumina_NovaSeq_S4\t:SA_4

## modify output file names
File1=${Read1/.fastq.gz/.bam}				 ### SRR13647737_1.bam
#File2=${File1/.bam/_sort.bam}				 ### SRR13647737_1_sort.bam
File2=${Read1/.fastq.gz/_sort.bam}

## read mapping, convert sam file to bam file, and sort reads
bwa mem -t 8 -R $ReadGroup $REF $Read1 $Read2 | samtools view -b -@ 8 | samtools sort -@ 8 -m 5G -o $OUTPUT/$File2
## indexing
samtools index $OUTPUT/$File2
bamtools stats -in $OUTPUT/$File2