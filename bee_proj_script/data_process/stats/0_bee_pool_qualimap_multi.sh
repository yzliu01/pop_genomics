#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 10
#SBATCH --mem 100g
##SBATCH --array=1-12%12
#SBATCH --time=20:04:00
#SBATCH --error=multi_qualimap_bee_pool.%A_%a.e.txt
#SBATCH --output=multi_qualimap_bee_pool.%A_%a.o.txt
#SBATCH --job-name=multi_qualimap_bee_pool
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## bam files
BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## call picard and samtools in the env
conda activate qualimap # v2.2.3

## mark duplicates
#SORTED_BAM=$(cat $BAM_DIR/bee_spools.bam.list | sed -n ${SLURM_ARRAY_TASK_ID}p)
#OUT_FILENAME=${SORTED_BAM/.bam/.bam.qualimap}
OUT_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam_qualimap
#OUT_FILE=$OUT_DIR/$OUT_FILENAME

#cd $BAM_DIR/qualimap
cd $BAM_DIR

bam_list_path_group=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/stats/multi_bamqc_describing_pool_samples.new.list

#qualimap bamqc -nt 6 -bam $SORTED_BAM -outdir $OUT_DIR -outformat HTML -c
qualimap multi-bamqc -r -d $bam_list_path_group --java-mem-size=100G \
-outdir $OUT_DIR \
-outformat PDF:HTML

exit 0

## run multi-bamqc after bamqc
##  it must have raw result data
qualimap multi-bamqc -d $bam_list_result_path_group --java-mem-size=10G -sd \
-outdir /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate/multi_qualimap_test \
-outformat PDF:HTML



exit 0
## bam_list_path_group
sort -k1 -n describing_samples.list | awk 'BEGIN{FS=OFS="\t"}{$1=$1".sort.marked_dups.bam";$2="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate"}1' \
    > multi_bamqc_describing_samples.list
sort -k1 -n multi_bamqc_describing_pool_samples.list | awk 'BEGIN{FS=OFS="\t"}{$1=$1"";$2="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam_qualimap"}1' > multi_bamqc_describing_pool_samples.new.list

## convert spaces to a \t
sed -i 's/\s\+/\t/g' multi_bamqc_describing_pool_samples.list

sort -k1 -n multi_bamqc_describing_pool_samples.list | awk 'BEGIN{OFS="\t"}{$1=$1 OFS "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam_qualimap";$2=$2}1' > multi_bamqc_describing_pool_samples.new.list
#unset DISPLAY
#qualimap bamqc -nt 6 -bam $BAM_DIR/SRR24680792.sort.marked_dups.bam -outdir SRR24680792.sort.marked_dups.bam.qualimap -outformat HTML -c
# qualimap bamqc -nt 1 -bam $INPUT_BAM -outdir $OUT_FILE/$OUT_FILENAME -c –sd
cd $bam_list_result_path_group
sed -i 's/dups.bam/dups_stats/2' multi_bamqc_describing_samples_bamqc_stats.list

## prepare list

ls *.marked_dups.bam > /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/0_fastqc_qualimap_samtools_multiqc/describing_samples.list
