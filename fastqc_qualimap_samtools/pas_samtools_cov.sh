#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 10:10:00
##SBATCH --array=1-55%55
#SBATCH -J Bpas_st_cov_dp
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=Bpas_st_cov_dp.%A.e
#SBATCH --output=Bpas_st_cov_dp.%A.o

module load bioinfo-tools
module load samtools

SEQDIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/PAS
cd $SEQDIR
#INPUT_BAM=$(cat pas.sorted_marked_dups.bam.list | sed -n ${SLURM_ARRAY_TASK_ID}p)
INPUT_BAM=pas.sorted_marked_dups.bam.list
# DA_02.sorted_marked_dups.bam

OUT_FILE=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/PAS/QC_qualimap/pas
#OUT_FILENAME=${INPUT_BAM/.bam/.bam.st_cov_dp.txt}

samtools coverage -b $INPUT_BAM -o $OUT_FILE/pas_bam_samtools_cov_dp.txt
