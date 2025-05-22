#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 20
#SBATCH --mem 70g
#SBATCH --array=0-8%9
#SBATCH --time=05:30:00
#SBATCH --error=0_concate_fastq_files.%A_%a.e
#SBATCH --output=0_concate_fastq_files.%A_%a.o
#SBATCH --job-name=0_concate_fastq_files
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

cd /home/yzliu/eDNA/faststorage/yzliu/BACKUP/pool_raw_data/pool_05_2025
#SLURM_ARRAY_TASK_ID=4
species_list=(
Aelacu
Agealn
Ampsol
Eriint
Eriper
Gerlac
Lasmor
Lepdol
Malbip
Myslon
Phoatr
Porsca
Rhaful
Tacfer
Thodec
Xesc-n

)
species=${species_list[SLURM_ARRAY_TASK_ID]}
#echo $species
## array jobs
cat ${species}_R1_00*.fastq.gz > ${species}_R1_000.fastq.gz
cat ${species}_R2_00*.fastq.gz > ${species}_R2_000.fastq.gz

exit 0
