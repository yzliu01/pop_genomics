#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 6
#SBATCH --mem 10g
#SBATCH --array=1-68%20
#SBATCH --time=02:04:00
#SBATCH --error=qualimap_dro_mel.%A.e.txt
#SBATCH --output=qualimap_dro_mel.%A.o.txt
#SBATCH --job-name=qualimap_dro_mel
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## bam files
BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## call picard and samtools in the env
conda activate qualimap

## mark duplicates
SORTED_BAM=$(cat $BAM_DIR/dro_mel_68samples.sort.marked_dups.bam.list | sed -n ${SLURM_ARRAY_TASK_ID}p)
OUT_FILENAME=${SORTED_BAM/.bam/.bam.qualimap}
OUT_DIR=$OUT_FILENAME

cd $BAM_DIR/Qualimap

qualimap bamqc -nt 6 -bam $SORTED_BAM -outdir $OUT_DIR -outformat pdf -c

exit 0

unset DISPLAY
qualimap bamqc -nt 6 -bam $BAM_DIR/SRR24680792.sort.marked_dups.bam -outdir SRR24680792.sort.marked_dups.bam.qualimap -outformat HTML -c
# qualimap bamqc -nt 1 -bam $INPUT_BAM -outdir $OUT_FILE/$OUT_FILENAME -c –sd
