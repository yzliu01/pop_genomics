#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 2
##SBATCH --mem 50g
##SBATCH --array=1-136%20
#SBATCH --array=1-10%10
##SBATCH --time=04:04:00
#SBATCH --time=00:04:00
#SBATCH --error=1_bam_stat_dro_mel.%A_%a.e.txt
#SBATCH --output=1_bam_stat_dro_mel.%A_%a.o.txt
#SBATCH --job-name=1_bam_stat_dro_mel
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## clean fastq sequence dir
#SEQDIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/empirical_drosophila_fastq
## mapping output
bam=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate
## reference dir
#REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/D_melanogaster.7509v1.md_chr.fa

## bam files
cd $bam
seq1=$(ls SRR*.sort.bam | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p) # forward sequence

## input file to bamtools
bamtools stats -in $bam/$seq1