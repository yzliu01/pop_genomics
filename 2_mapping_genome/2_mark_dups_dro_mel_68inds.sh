#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 6
#SBATCH --mem 50g
#SBATCH --array=1-68%20
##SBATCH --array=1-10%10
#SBATCH --time=00:15:00
#SBATCH --error=2_mark_dups_dro_mel_68inds.%A_%a.e.txt
#SBATCH --output=2_mark_dups_dro_mel_68inds.%A_%a.o.txt
#SBATCH --job-name=2_mark_dups_dro_mel_68inds
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## bam files
BAM_FILE=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate
## reference dir
REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/D_melanogaster.7509v1.md_chr.fa

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## call picard and samtools in the env
conda activate variant_calling_mapping

# Mark duplicate reads
# Final output: ...sort.marked_dups.bam, ...bam.bai
## bam files
cd $BAM_FILE
BAM=$(ls SRR*.sort.bam | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p) # forward sequence
MARKED_BAM=${BAM_FILE/.sort.bam/.sort.marked_dups.bam}

echo -e ${BAM_FILE[*]}"\t"${MARKED_BAM[*]} >> SampleID_2_Name.1-68.log

picard MarkDuplicates \
I=$BAM \
O=$MARKED_BAM \
M=$MARKED_BAM".metrics.csv" >& $MARKED_BAM.log

## 
## Index the file
samtools index $MARKED_BAM
samtools idxstats $MARKED_BAM > $MARKED_BAM.idxstats.csv


exit



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

