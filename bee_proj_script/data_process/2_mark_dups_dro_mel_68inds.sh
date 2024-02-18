#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 6
#SBATCH --mem 30g
#SBATCH --array=1-68%20
##SBATCH --array=64,65
#SBATCH --time=00:30:00
#SBATCH --error=2_RG_mark_dups_index_dro_mel_68inds.%A_%a.e.txt
#SBATCH --output=2_RG_mark_dups_index_dro_mel_68inds.%A_%a.o.txt
#SBATCH --job-name=2_RG_mark_dups_index_dro_mel_68inds
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## bam files
BAM_DIRE=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate
## reference dir
REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/D_melanogaster.7509v1.md_chr.fa

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## call picard and samtools in the env
conda activate variant_calling_mapping

cd $BAM_DIRE
## mark duplicates
SORTED_BAM=$(ls SRR*.sort.bam | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p) # forward sequence
MARKED_BAM=${SORTED_BAM/.sort.bam/.sort.marked_dups.bam}

echo -e ${SORTED_BAM}"\t"${MARKED_BAM} >> Mark_dups.1-68.log
picard MarkDuplicates \
    I=$SORTED_BAM \
    O=$MARKED_BAM \
    M=$MARKED_BAM".metrics.csv" >& $MARKED_BAM.log

## indexing marked_dups
echo -e "\nindexing: $MARKED_BAM" >> dro_mel_sort_marked_bam_index.log
samtools index $MARKED_BAM >> dro_mel_sort_marked_bam_index.log

## stats
printf "\n######  bamtools stats: $MARKED_BAM ######" >> bamtools_stats_marked_dups_68samples.txt
bamtools stats -in $MARKED_BAM 
bamtools stats -in $MARKED_BAM >> bamtools_stats_marked_dups_68samples.txt
#echo -e "\n###### Job Done! #####\n" >> bamtools_stats_68samples.txt

exit 0

# Mark duplicate reads
# Final output: ...sort.marked_dups.bam, ...bam.bai

cd $SEQDIR
INPUT_NAMES=$(ls *_sort.bam | sed -n ${SLURM_ARRAY_TASK_ID}p) ## e.g. P23261_469_sort.bam
LINE_NUMBER=${SLURM_ARRAY_TASK_ID}
#OUTPUT_NAMES=$(awk '{if(NR==$LINE_NUMBER) print $5}' seed3_ReadGroup) ## M_L001
OUTPUT_NAMES=$(awk -v var=$LINE_NUMBER '{if(NR==var) print $5}' seed3_ReadGroup)

echo -e ${INPUT_NAMES[*]}"\t"${OUTPUT_NAMES[*]} >> SampleID_2_Name.1-209.log

java -Xmx8g -jar "/sw/apps/bioinfo/picard/2.20.4/rackham/picard.jar" \
MarkDuplicates \
INPUT=$INPUT_NAMES \
OUTPUT=$OUTPUT_NAMES.sorted_marked_dups.bam \
METRICS_FILE=$OUTPUT_NAMES.sorted_marked_dups.csv >& $OUTPUT_NAMES.sorted_marked_dups.log
# output file: M_L001.sorted_marked_dups.bam

# Index the file
samtools index $OUTPUT_NAMES.sorted_marked_dups.bam
samtools idxstats $OUTPUT_NAMES.sorted_marked_dups.bam > $OUTPUT_NAMES.sorted_marked_dups.idxstats.csv

