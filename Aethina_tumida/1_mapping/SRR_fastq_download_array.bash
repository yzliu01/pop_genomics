#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 6
##SBATCH -C mem128GB
#SBATCH -t 25:30:00
#SBATCH --array=1-49%10
#SBATCH -J SRR_fastq_download_array
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=SRR_fastq_download_49_array.%A.e
#SBATCH --output=SRR_fastq_download_49_array.%A.o

## load modules/tools
module load bioinfo-tools sratools

DIR=/crex/proj/snic2020-6-58/private/yzliu/test/fastq_bt
cd $DIR

## SRR variables
#SRR=`cat fastq_SRR_49.list`
SRR=$(cat fastq_SRR_49.list | sed -n ${SLURM_ARRAY_TASK_ID}p)

## this function is to run the jobs in parallel
#	function pwait() {
#	while [ $(jobs -p | wc -l) -ge $1 ]; do
#	sleep $2
#	done
#	}

## create a function
#function SRR_fastq_download() {
#		pwait 20 10s
#		for id in $SRR; do
#		fastq-dump $id --split-files --defline-seq '@$ac[.$si][:$sn][:$sg][:$rn] $ri' --gzip
#		done
#}

## execute the function
#SRR_fastq_download

## Array jobs
## OUTPUT_NAMES=${INTPUT_NAMES/.g.vcf.gz/.hard_filtered.g.vcf.gz} # modify file names # working
fastq-dump $SRR --split-files --defline-seq '@$ac[.$si][:$sn][:$sg][:$rn] $ri' --gzip
