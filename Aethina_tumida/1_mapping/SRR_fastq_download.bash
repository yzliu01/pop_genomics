#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 10:30:00
#SBATCH -J SRR_fastq_download
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=SRR_fastq_download_49.%A.e
#SBATCH --output=SRR_fastq_download_49.%A.o

module load bioinfo-tools sratools

DIR=/crex/proj/snic2020-6-58/private/yzliu/test/fastq_bt
cd $DIR

SRR=`cat fastq_SRR_49.list`

# this function is to run the jobs in parallel
	function pwait() {
	while [ $(jobs -p | wc -l) -ge $1 ]; do
	sleep $2
	done
	}

# create a function
function SRR_fastq_download() {
		pwait 10 10s
		for id in $SRR; do
		fastq-dump $id --split-files --defline-seq '@$ac[.$si][:$sn][:$sg][:$rn] $ri' --gzip
		done
}

# execute the function
SRR_fastq_download