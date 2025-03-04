#!/bin/sh
#SBATCH --account eDNA
##SBATCH --cpus-per-task 20
##SBATCH --mem 1000g
#SBATCH --cpus-per-task 10
#SBATCH --mem 500g
#SBATCH --array=1-2%2
##SBATCH --time=00:10:00
#SBATCH --time=10:30:00
#SBATCH --error=1_1_downsample_samtools_AndHae_AndMar_sort_marked_bam_clean_index.%A_%a.e
#SBATCH --output=1_1_downsample_samtools_AndHae_AndMar_sort_marked_bam_clean_index.%A_%a.o
#SBATCH --job-name=1_1_downsample_samtools_AndHae_AndMar_sort_marked_bam_clean_index
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping to use sambamba markdup
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## mapping output
BAM_DIR=/faststorage/project/eDNA/yzliu/DK_proj/data/bee_proj_data/bam
cd $BAM_DIR

## bam file
INPUT_BAM_FILE_list=(

Andhae.New_REF_AndHae.sort.marked_dups.bam
Andmar.New_REF_AndMar.sort.marked_dups.bam

)

INPUT_BAM_FILE=$(echo ${INPUT_BAM_FILE_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)

## downsample reads from bam files
#for frac in 2 4 6
#for frac in 2 3 4
for frac in 5 6
do echo $frac
#done

## out bam file name
OUT_BAM_NAME=${INPUT_BAM_FILE/bam/0_$frac.bam}
echo "Downsample $OUT_BAM_NAME"
samtools view -t 10 -b --subsample-seed 10 -s 0.$frac $INPUT_BAM_FILE > ./$OUT_BAM_NAME

## index marked_dups
samtools index $OUT_BAM_NAME

done

exit 0

find . -maxdepth 3 -name "3_fb_variant_calling_4_bee_pools.AndHae_New_REF_AndHae*" | head