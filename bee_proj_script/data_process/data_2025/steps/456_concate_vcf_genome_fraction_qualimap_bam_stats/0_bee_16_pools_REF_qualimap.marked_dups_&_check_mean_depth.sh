#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 10
#SBATCH --mem 200g
#SBATCH --array=1-16%16
#SBATCH --time=10:00:00
#SBATCH --error=qualimap_bee_16_pool.marked_dups.%A_%a.e
#SBATCH --output=qualimap_bee_16_pool.marked_dups.%A_%a.o
#SBATCH --job-name=qualimap_bee_16_pool.marked_dups
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## call picard and samtools in the env
conda activate qualimap # v2.2.3

## bam files
BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam

## mark duplicates
#SORTED_BAM=$(cat $BAM_DIR/bee_spools.bam.list | sed -n ${SLURM_ARRAY_TASK_ID}p)
#OUT_FILENAME=${SORTED_BAM/.bam/.bam.qualimap}
OUT_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/qualimap/data_2025
#OUT_FILE=$OUT_DIR/$OUT_FILENAME

#cd $BAM_DIR/qualimap
cd $BAM_DIR

#bam_list_path_group=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/stats/multi_bamqc_describing_pool_samples.new_rm_dups.list
##-bam flag must be given a file
##bam_list=$(ls *sort.marked_dups.new.bam | sed -n ${SLURM_ARRAY_TASK_ID}p)

## create a bam file list
ls -t *sort.marked_dups.bam | head -16 > bee_16_pools.sort.marked_dups.bam.list
#Andhae.New_REF_AndHae.sort.marked_dups.bam
#Andmar.New_REF_AndHae.sort.marked_dups.bam
# Aphsti.REF_AphSti.sort.marked_dups.bam
bam_list=$(cat bee_16_pools.sort.marked_dups.bam.list | sed -n ${SLURM_ARRAY_TASK_ID}p)

#qualimap bamqc -nt 6 -bam $SORTED_BAM -outdir $OUT_DIR -outformat HTML -c
#--output-genome-coverage 300
## specify one outdir folder for each array run
qualimap bamqc -nt 20 -cl 400 -dl 90 -sd -c -bam $bam_list --java-mem-size=100G \
-outdir $OUT_DIR/$bam_list \
-outformat PDF:HTML

exit 0

## multiqc plot
conda activate multiqc
multiqc .

qualimap bamqc -nt 10 -cl 400 -dl 90 -sd -c -bam Andhae.REF_AndHae.sort.marked_dups.new.bam --java-mem-size=30G \
-outdir $OUT_DIR \
-outformat PDF:HTML


## run multi-bamqc after bamqc
##  it must have raw result data
qualimap multi-bamqc -nt 10 -r -cl 300 -dl 60 -d $bam_list_path_group --java-mem-size=100G \
-outdir $OUT_DIR \
-outformat PDF:HTML



exit 0

## check the mean depth 
find . -name genome_results.txt | sort | xargs grep 'mean coverageData ='
./Aphsti.REF_AphSti.sort.marked_dups.bam/genome_results.txt:     mean coverageData = 210.7389X
./Bommaj.REF_BomMaj.sort.marked_dups.bam/genome_results.txt:     mean coverageData = 269.7475X
./Cerryb.REF_CerRyb.sort.marked_dups.bam/genome_results.txt:     mean coverageData = 223.265X
./Ephdan.REF_EphDan.sort.marked_dups.bam/genome_results.txt:     mean coverageData = 267.984X
./Meglea.REF_MegLea.sort.marked_dups.bam/genome_results.txt:     mean coverageData = 208.0607X
./Notgla.REF_NotGla.sort.marked_dups.bam/genome_results.txt:     mean coverageData = 177.7244X
./Ochple.REF_OchPle.sort.marked_dups.bam/genome_results.txt:     mean coverageData = 222.2991X
./Phrful.REF_PhrFul.sort.marked_dups.bam/genome_results.txt:     mean coverageData = 196.3824X
./Rutmac.REF_RutMac.sort.marked_dups.bam/genome_results.txt:     mean coverageData = 138.2332X
./Stemel.REF_SteMel.sort.marked_dups.bam/genome_results.txt:     mean coverageData = 151.7856X
## print out just the last column
find . -name genome_results.txt | sort | xargs grep 'mean coverageData =' | awk '{print $NF}'
#cut -d '=' -f 2 | tr -d ' '
## print the first and last columns
find . -name genome_results.txt | sort | xargs grep 'mean coverageData =' | sed -e 's/\.sort\.marked_dups\.bam\/genome_results\.txt:     mean coverageData =//' -e 's/\.\///' | awk '{print $1 "\t" $NF}'


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
