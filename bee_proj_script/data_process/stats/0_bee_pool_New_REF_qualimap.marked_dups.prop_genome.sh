#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 10
#SBATCH --mem 100g
##SBATCH --array=20-23%4
#SBATCH --array=1-4%4
#SBATCH --time=1-04:00:00
##SBATCH --time=04:00:00
#SBATCH --error=downsample_qualimap_bee_pool.New_REF_marked_dups.%A_%a.e
#SBATCH --output=downsample_qualimap_bee_pool.New_REF_marked_dups.%A_%a.o
#SBATCH --job-name=downsample_qualimap_bee_pool.New_REF_marked_dups
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
OUT_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/qualimap/New_REF
#OUT_FILE=$OUT_DIR/$OUT_FILENAME

#bam_list_path_group=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/stats/multi_bamqc_describing_pool_samples.new_rm_dups.list
##-bam flag must be given a file
##bam_list=$(ls *sort.marked_dups.new.bam | sed -n ${SLURM_ARRAY_TASK_ID}p)

## test
#SLURM_ARRAY_TASK_ID=4

##ls *sort.marked_dups.new.bam > bee_pools.sort.marked_dups.new.bam.list
bam_list=$(cat bee_4_pools.New_REF_bam_marked_dups.prop_genome.list | sed -n ${SLURM_ARRAY_TASK_ID}p)

## bed dir
bed_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/random_prop_sample_genome
cd $bed_dir
bed_list_1=$(ls Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_100b.shuf_subset_0{1..9}.sort.bed)
bed_list_2=$(ls Andrena_marginata_GCA_963932335.1-softmasked.fa.fai.win_100b.shuf_subset_0{1..9}.sort.bed)
bed_list_3=$(ls Bombus_pascuorum-GCA_905332965.1-softmasked.fa.fai.win_100b.shuf_subset_0{1..9}.sort.bed)
bed_list_4=$(ls Bombus_veteranus.hifi_asm_pl2.fa.fai.win_100b.shuf_subset_0{1..9}.sort.bed)

bed_file_list=("${bed_list_1[@]}" "${bed_list_2[@]}" "${bed_list_3[@]}" "${bed_list_4[@]}")

# select bed file
bed_file=(echo ${bed_file_list[SLURM_ARRAY_TASK_ID-1]})
#SLURM_ARRAY_TASK_ID=4
#bed_file=(${bed_file_list[3]})
#Bombus_veteranus.hifi_asm_pl2.fa.fai.win_100b.shuf_subset_01.sort.bed
#Bombus_veteranus.hifi_asm_pl2.fa.fai.win_100b.shuf_subset_02.sort.bed
# ...

#cd $BAM_DIR/qualimap
cd $BAM_DIR

for bed in ${bed_file[@]}
do
echo "Processing BED File: $bed"
out_file=${bed/.sort.bed/}
#done
#qualimap bamqc -nt 6 -bam $SORTED_BAM -outdir $OUT_DIR -outformat HTML -c
#--output-genome-coverage 300
## specify one outdir folder for each array run
# -gff,--feature-file <arg>            Feature file with regions of interest in
#                                      GFF/GTF or BED format
# bed files already have path from ls $bed_dir/...
qualimap bamqc -nt 20 -cl 400 -dl 90 -sd -c -bam $bam_list -gff $bed --java-mem-size=100G \
-outdir $OUT_DIR/$out_file \
-outformat PDF:HTML
done

exit 0

Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_100b.shuf_subset_01.sort.bed
Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_100b.shuf_subset_02.sort.bed
Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_100b.shuf_subset_03.sort.bed
Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_100b.shuf_subset_04.sort.bed
Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_100b.shuf_subset_05.sort.bed
Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_100b.shuf_subset_06.sort.bed
Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_100b.shuf_subset_07.sort.bed
Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_100b.shuf_subset_08.sort.bed
Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_100b.shuf_subset_09.sort.bed

touch bee_4_pools.New_REF_bam_marked_dups.prop_genome.list
vim bee_4_pools.New_REF_bam_marked_dups.prop_genome.list
Andhae.New_REF_AndHae.sort.marked_dups.bam
Andmar.New_REF_AndMar.sort.marked_dups.bam
Bompas.New_REF_BomPas.sort.marked_dups.bam
Bomvet.New_REF_BomVet.sort.marked_dups.bam
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
