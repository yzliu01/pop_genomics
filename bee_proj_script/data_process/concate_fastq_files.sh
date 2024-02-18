#!/bin/bash
#SBATCH --account eDNA
##SBATCH --cpus-per-task 2
#SBATCH --mem 20g
##SBATCH --array=1-8%8
#SBATCH --time=08:10:00
#SBATCH --error=cat_pool_bee1.%A_%a.e.txt
#SBATCH --output=cat_pool_bee1.%A_%a.o.txt
#SBATCH --job-name=cat_pool_bee1
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

fastq_dir=/home/yzliu/eDNA/faststorage/yzliu/BACKUP/pool_raw_data/F22FTSEUET0086_ANItfynR_20240116172811
cd $fastq_dir
Bomvet_fastq1=./Bomvet_pool1/V3502*_L0*_565_1.fq.gz
Bomvet_fastq2=./Bomvet_pool1/V3502*_L0*_565_2.fq.gz

Bompas_fastq1=./Bompas_pool1/V3502*_L0*_564_1.fq.gz
Bompas_fastq2=./Bompas_pool1/V3502*_L0*_564_2.fq.gz

Andmar_fastq1=./Andmar_pool1/V3502*_L0*_567_1.fq.gz
Andmar_fastq2=./Andmar_pool1/V3502*_L0*_567_2.fq.gz

Andhae_fastq1=./Andhae_pool1/V3502*_L0*_566_1.fq.gz
Andhae_fastq2=./Andhae_pool1/V3502*_L0*_566_2.fq.gz

## concate fq data from different lanes
cat $Bomvet_fastq1 > ../Bomvet_fastq1.fq.gz
cat $Bomvet_fastq2 > ../Bomvet_fastq2.fq.gz

cat $Bompas_fastq1 > ../Bompas_fastq1.fq.gz
cat $Bompas_fastq2 > ../Bompas_fastq2.fq.gz

cat $Andmar_fastq1 > ../Andmar_fastq1.fq.gz
cat $Andmar_fastq2 > ../Andmar_fastq2.fq.gz

cat $Andhae_fastq1 > ../Andhae_fastq1.fq.gz
cat $Andhae_fastq2 > ../Andhae_fastq2.fq.gz

exit 0
## array 
# sample_fq_list=($Bomvet_fastq1,$Bomvet_fastq2,$Bompas_fastq1,$Bompas_fastq2)
sample_fq_list=($Bomvet_fastq1 $Bomvet_fastq2 $Bompas_fastq1 $Bompas_fastq2)
concated_fq=("Bomvet_fastq1.fq.gz" "Bomvet_fastq2.fq.gz" "Bompas_fastq1.fq.gz" "Bompas_fastq1.fq.gz")
#echo $sample_fq_list
#echo $concated_fq

sample=$(echo $sample_fq_list | sed -n ${SLURM_ARRAY_TASK_ID}p)
concate_each_sample=$(echo $concated_fq | sed -n ${SLURM_ARRAY_TASK_ID}p)
cat $sample > $concate_each_sample

exit 0