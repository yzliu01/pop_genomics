#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 8
##SBATCH -C mem128GB
#SBATCH -t 20:00:00
##SBATCH -t 04:00:00
#SBATCH --array=1-49%50
#SBATCH -J picard_mark_dup_array
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=picard_mark_dup_array.%A.e
#SBATCH --output=picard_mark_dup_array.%A.o

## load modules/tools
module load bioinfo-tools picard samtools

## reference dir
REF=/crex/proj/snic2020-6-58/private/yzliu/test/ref_genome/AetTumi1.1_genomic_chr_1_8_mt.fna

## file directory
DIR=/crex/proj/snic2020-6-58/private/yzliu/test/fastq_bt
BAM_FILE=/crex/proj/snic2020-6-58/private/yzliu/test/fastq_bt/Mapping_New

cd $BAM_FILE

INPUT_NAMES=$(ls *_sort.bam | sed -n ${SLURM_ARRAY_TASK_ID}p) ## e.g. SRR13647737_1_sort.bam
LINE_NUMBER=${SLURM_ARRAY_TASK_ID}

#OUTPUT_NAMES=$(awk '{if(NR==$LINE_NUMBER) print $3}' ReadGroup.txt) ## SA_4
OUTPUT_NAMES=$(awk -v var=$LINE_NUMBER '{if(NR==var) print $3}' $DIR/ReadGroup.txt)

echo -e ${INPUT_NAMES[*]}"\t"${OUTPUT_NAMES[*]} >> SampleID_2_Name.1_51.log

java -Xmx8g -jar "/sw/apps/bioinfo/picard/2.20.4/rackham/picard.jar" \
MarkDuplicates \
INPUT=$INPUT_NAMES \
OUTPUT=$OUTPUT_NAMES.sorted_marked_dups.bam \
METRICS_FILE=$OUTPUT_NAMES.sorted_marked_dups.csv >& $OUTPUT_NAMES.sorted_marked_dups.log
## output file: M_L001.sorted_marked_dups.bam
## >& or &> redrict stdout and std err to a file - https://stackoverflow.com/questions/6674327/redirect-all-output-to-file-in-bash

## index the file
samtools index $OUTPUT_NAMES.sorted_marked_dups.bam

## output stats
samtools idxstats $OUTPUT_NAMES.sorted_marked_dups.bam > $OUTPUT_NAMES.sorted_marked_dups.idxstats.csv
samtools flagstat $OUTPUT_NAMES.sorted_marked_dups.bam > $OUTPUT_NAMES.sorted_marked_dups.flagstat.csv
