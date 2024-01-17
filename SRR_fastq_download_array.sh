#!/bin/bash
#SBATCH --account eDNA
##SBATCH --cpus-per-task 12
#SBATCH --mem 60g
#SBATCH --array=1-68%7
#SBATCH --time=20:14:00
#SBATCH --error=empirical_dro_mel_SRR.%A_%a.e.txt
#SBATCH --output=empirical_dro_mel_SRR.%A_%a.o.txt
#SBATCH --job-name=empirical_dro_mel_SRR
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## install sra-tools
#conda create --name sratools sra-tools -y
## call env
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
conda activate parallel-fastq-dump

## output dir
DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/empirical_drosophila_fastq
cd $DIR

## SRR variables
#SRR=`cat fastq_SRR_49.list`
SRR=$(cat fastq_SRR_68.list | sed -n ${SLURM_ARRAY_TASK_ID}p)

## this function is to run the jobs in parallel
#   function pwait() {
#   while [ $(jobs -p | wc -l) -ge $1 ]; do
#   sleep $2
#   done
#   }

## create a function
#function SRR_fastq_download() {
#       pwait 20 10s
#       for id in $SRR; do
#       fastq-dump $id --split-files --defline-seq '@$ac[.$si][:$sn][:$sg][:$rn] $ri' --gzip
#       done
#}

## execute the function
#SRR_fastq_download

## Array jobs
## OUTPUT_NAMES=${INTPUT_NAMES/.g.vcf.gz/.hard_filtered.g.vcf.gz} # modify file names # working
#fastq-dump $SRR --split-files --defline-seq '@$ac[.$si][:$sn][:$sg][:$rn] $ri' --gzip
parallel-fastq-dump --sra-id $SRR --threads 6 --outdir . --split-3 --skip-technical --defline-seq '@$ac[.$si][:$sn][:$sg][:$rn] $ri' --gzip

#parallel-fastq-dump --sra-id SRR24680761 --threads 6 --outdir . --split-3 --skip-technical --defline-seq '@$ac[.$si][:$sn][:$sg][:$rn] $ri' --gzip


# have a test 01-11-2024
test
more bla bla bla