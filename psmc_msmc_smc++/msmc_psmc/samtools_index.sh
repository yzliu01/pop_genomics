#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:30:00
#SBATCH -J bam_index.inc_syl
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=bam_index.inc_syl.%A.%a.e
#SBATCH --output=bam_index.inc_syl.%A.%a.o

module load bioinfo-tools python samtools

bam_path=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL
cd $bam_path
bam=`ls *marked_dupes.rg.bam`

for i in $bam;do
samtools index $i;
done
