#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 6
#SBATCH --mem 1g
#SBATCH --array=1-4%4
#SBATCH --time=00:05:00
##SBATCH --time=21:30:00
##SBATCH --time=3-04:04:00
#SBATCH --error=naming_test.%A_%a.e.txt
#SBATCH --output=naming_test.%A_%a.o.txt
#SBATCH --job-name=naming_test
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## read fastq files and Read group lines
FASTQ_CLEAN=/faststorage/project/eDNA/yzliu/DK_proj/data/bee_proj_data/fastq_clean
cd $FASTQ_CLEAN
# Andhae_fastq1.fq.clean.gz
# Andhae_fastq2.fq.clean.gz
# Andmar_fastq1.fq.clean.gz
# Andmar_fastq2.fq.clean.gz
seq1=$(ls *fastq1.fq.clean.gz | sed -n ${SLURM_ARRAY_TASK_ID}p) # forward sequence
seq2=$(ls *fastq2.fq.clean.gz | sed -n ${SLURM_ARRAY_TASK_ID}p) # reverse sequence

## Read group
Sorted_ReadGroup_FILE=/faststorage/project/eDNA/yzliu/DK_proj/data/bee_proj_data/bam/ReadGroup_pooled.tab.list
ReadGroup=$(cat $Sorted_ReadGroup_FILE | sed -n ${SLURM_ARRAY_TASK_ID}p)

## mapping output
OUT_BAM=/faststorage/project/eDNA/yzliu/DK_proj/data/bee_proj_data/bam
## reference dir
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome

REF1_list=("iyAndHaem1_1.md_chr.fa" "iyAndHaem1_1.md_chr.fa" "iyBomPasc1_1.md_chr.fa" "iyBomPasc1_1.md_chr.fa")
REF1=$(echo ${REF1_list[*]} | tr ' ' '\n' | sort | sed -n ${SLURM_ARRAY_TASK_ID}p)

#REF1=$(cat $REF_DIR/REF1.list | sed -n ${SLURM_ARRAY_TASK_ID}p)

## modify output file names
#File1=${seq1/.fastq.clean.gz/.bam}				 ### SRR13647737_1.bam
#File2=${File1/.bam/_sort.bam}				 ### SRR13647737_1_sort.bam

OUT_NAME_list=("REF_AndHae" "REF_AndHae" "REF_BomPas" "REF_BomPas")
OUT_NAME=$(echo ${OUT_NAME_list[*]} | tr ' ' '\n' | sort | sed -n ${SLURM_ARRAY_TASK_ID}p)

seq=`ls *fastq1.fq.clean.gz`
File=${seq/_fastq1.fq.clean.gz/} # bad
File2=${seq2/_fastq2.fq.clean.gz/} # good
#File=$(${seq/_fastq1.fq.clean.gz/} | sed -n ${SLURM_ARRAY_TASK_ID}p)
#File2=$(${seq2/_fastq2.fq.clean.gz/} | sed -n ${SLURM_ARRAY_TASK_ID}p)

echo $File.$OUT_NAME".sort.bam" > naming_test.${SLURM_ARRAY_TASK_ID}.txt
echo $File2.$OUT_NAME".sort.bam" > naming_test2.${SLURM_ARRAY_TASK_ID}.txt