#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 2
#SBATCH --mem 20g
#SBATCH --array=1-68%20
#SBATCH --time=00:15:00
#SBATCH --error=2_bamstats_mark_dups_index_dro_mel_68inds.%A_%a.e.txt
#SBATCH --output=2_bamstats_mark_dups_index_dro_mel_68inds.%A_%a.o.txt
#SBATCH --job-name=2_bamstats_mark_dups_index_dro_mel_68inds
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
MARKED_BAM=$(ls SRR*.marked_dups.bam | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p) # forward sequence
OUTPUT_NAMES=${MARKED_BAM/.bam/}
## stats
bamtools stats -in $MARKED_BAM > ./stats/$OUTPUT_NAMES.bamtools_stats.csv
## if not specified, output will be in .o files

exit 0

## stats check with multiqc
conda activate multiqc
multiqc .


# Index the file
#samtools index $OUTPUT_NAMES.sorted_marked_dups.bam
#samtools idxstats $MARKED_BAM > $OUTPUT_NAMES.samtools_idxstats.csv
samtools idxstats SRR24680758.sort.bam
chrX    23542271        8832190 0
chr2L   23513712        11748211        0
chr2R   25286936        14332037        0
chr3L   28110227        14685868        0
chr3R   32079331        18023741        0
chr4    1348131 643088  0
*       0       0       5557954
