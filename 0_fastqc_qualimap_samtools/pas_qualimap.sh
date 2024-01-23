#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 3
#SBATCH -t 15:10:00
#SBATCH --array=1-55%55
#SBATCH -J Bpas_qualimap
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=Bpas_qualimap.%A.e
#SBATCH --output=Bpas_qualimap.%A.o

module load bioinfo-tools
module load QualiMap

SEQDIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/PAS
cd $SEQDIR
INPUT_BAM=$(cat pas.sorted_marked_dups.bam.list | sed -n ${SLURM_ARRAY_TASK_ID}p)
# DA_02.sorted_marked_dups.bam

OUT_FILE=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/PAS/QC_qualimap/pas
OUT_FILENAME=${INPUT_BAM/.bam/.bam.Qualimap}

qualimap bamqc -nt 3 -bam $INPUT_BAM -outdir $OUT_FILE -outfile $OUT_FILENAME -outformat HTML -c
