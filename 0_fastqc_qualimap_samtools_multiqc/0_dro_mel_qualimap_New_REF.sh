#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 6
#SBATCH --mem 10g
#SBATCH --array=1-68%20
#SBATCH --time=02:04:00
#SBATCH --error=qualimap_dro_mel_New_REF.%A_%a.e.txt
#SBATCH --output=qualimap_dro_mel_New_REF.%A_%a.o.txt
#SBATCH --job-name=qualimap_dro_mel_New_REF
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## call picard and samtools in the env
conda activate qualimap

## bam files
BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate
cd $BAM_DIR

## bam marked_duplicates
bam_list=$(cat dro_mel_68samples.sort.marked_dups.bam.list | sed -n ${SLURM_ARRAY_TASK_ID}p)
out_filename=${bam_list/.bam/.bam.qualimap}

#OUT_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/qualimap
OUT_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate/qualimap
#qualimap bamqc -nt 6 -bam $SORTED_BAM -outdir $OUT_DIR -outformat HTML -c
#--output-genome-coverage 300
## specify one outdir folder for each array run
qualimap bamqc -nt 6 -cl 400 -dl 90 -sd -c -bam $bam_list --java-mem-size=10G \
-outdir $OUT_DIR/$out_filename \
-outformat PDF:HTML

exit 0
## multiqc plot
conda activate multiqc
multiqc .