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

fastq_dir=/home/yzliu/eDNA/faststorage/yzliu/BACKUP/pool_raw_data/F22FTSEUET0086_ANItfynR_20240116172811
Bomvet_fastq_1=$fastq_dir/Bomvet_pool1/*
Bomvet_fastq_2=$fastq_dir/Bomvet_pool1
Bompas_fastq=$fastq_dir/Bompas_pool1
Andmar_fastq=$fastq_dir/Andmar_pool1
Andhae_fastq=$fastq_dir/Andhae_pool1

