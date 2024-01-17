#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 15:10:00
#SBATCH --array=1-209%110
#SBATCH -J Bsyl_qualimap
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=Bsyl_qualimap.%A.e
#SBATCH --output=Bsyl_qualimap.%A.o

module load bioinfo-tools
module load QualiMap

SEQDIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL
cd $SEQDIR
INPUT_BAM=$(cat all_bam.list | sed -n ${SLURM_ARRAY_TASK_ID}p)
# DA_02.sorted_marked_dups.bam

OUT_FILE=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/QC_qualimap/mon_lap
OUT_FILENAME=${INPUT_BAM/.bam/.bam.Qualimap}

qualimap bamqc -nt 4 -bam $INPUT_BAM -outdir $OUT_FILE -outfile $OUT_FILENAME -outformat HTML -c
