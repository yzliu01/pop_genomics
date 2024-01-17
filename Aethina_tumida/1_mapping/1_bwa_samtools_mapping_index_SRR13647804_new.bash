#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 8
##SBATCH -C mem128GB
#SBATCH -t 20:00:00
##SBATCH -t 04:00:00
##SBATCH --array=1-10%10
#SBATCH -J mapping_7804_new
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=mapping_7804_new.%A.e
#SBATCH --output=mapping_7804_new.%A.o

## load modules/tools
module load bioinfo-tools bwa samtools bamtools

## reference dir
REF=/crex/proj/snic2020-6-58/private/yzliu/test/ref_genome/AetTumi1.1_genomic_chr_1_8_mt.fna

## test in terminal
DIR=/crex/proj/snic2020-6-58/private/yzliu/test/fastq_bt
OUTPUT=$DIR/SRR13647804_fastq_mapping_1

cd $OUTPUT
## use "-" to redrict the input and output files
## https://www.biostars.org/p/296706/
bwa mem -t 8 -R '@RG\tID:SRR13647804\tPL:Illumina_NovaSeq_S4\tSM:SA_10' $REF \
$DIR/SRR13647804_fastq_1/SRR13647804_1.fastq.gz $DIR/SRR13647804_fastq_1/SRR13647804_2.fastq.gz | samtools view -b -@ 8 -o $OUTPUT/SRR13647804.bam -

# samtools sort -@ 8 -m 5G -o $OUTPUT/SRR13647804.sort.bam -

samtools index SRR13647804.bam
bamtools stats -in SRR13647804.bam
