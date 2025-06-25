#!/bin/sh
#SBATCH --account eDNA
##SBATCH --cpus-per-task 10
##SBATCH --mem 2g
##SBATCH --array=1-16%16
#SBATCH --time=00:05:00
#SBATCH --error=rename_bam_file.%A_%a.e
#SBATCH --output=rename_bam_file.%A_%a.o
#SBATCH --job-name=rename_bam_file
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
#source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## call picard and samtools in the env
#conda activate qualimap # v2.2.3

## bam files
BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam

#cd $BAM_DIR/qualimap
cd $BAM_DIR

## create a bam file list
#rename bam files due to a mistake in previous step
rename "_R1_001.fq.clean.gz" "" *_R1_001.fq.clean.gz*bam*bai
