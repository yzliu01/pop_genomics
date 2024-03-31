#!/bin/sh
#SBATCH --account eDNA
##SBATCH --cpus-per-task 10
#SBATCH --mem 10g
##SBATCH --mem 1m
#SBATCH --array=1-8,10-12%11
#SBATCH --time=00:10:05
##SBATCH --time=4-00:00:00
#SBATCH --error=popoolation_pi.New_REF_marked_dups_others.%A_%a.e.txt
#SBATCH --output=popoolation_pi.New_REF_marked_dups_others.%A_%a.o.txt
#SBATCH --job-name=popoolation_pi.New_REF_marked_dups_others
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

##conda activate bioproject
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping
## install perl module in both env
## https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjw2_jJy4KFAxVZwAIHHURfAUcQFnoECBgQAQ&url=https%3A%2F%2Fbioconda.github.io%2Frecipes%2Fperl-math-bigrat%2FREADME.html&usg=AOvVaw2D0-bp_ROEvTktz6jpbm32&opi=89978449
#conda install perl-math-bigrat
Variance_sliding_pl=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/popoolation_1.2.2/Variance-sliding.pl 

## https://marineomics.github.io/POP_03_poolseq.html#Nucleotide_Diversity
BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam

cd $BAM_DIR

REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
IN_BAM=$(ls *New_REF_*sort.marked_dups.bam | sed -n ${SLURM_ARRAY_TASK_ID}p)
#IN_BAM1=Bompas.New_REF_BomPas.sort.marked_dups.bam
#IN_BAM2=Bomvet.New_REF_BomPas.sort.marked_dups.bam

REF_index_list=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/pooled_data_analysis/REF_index.list
REF_INDEX=$(cat $REF_index_list | sed -n ${SLURM_ARRAY_TASK_ID}p)

#REF_INDEX=$(echo ${REF_INDEX_list[*]} | sed -n ${SLURM_ARRAY_TASK_ID}p)
#for ${SLURM_ARRAY_TASK_ID} in ${!REF_INDEX_list[*]}

OUT_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/samtools_mpileup
## single run
##samtools mpileup -f $REF_PAS_INDEX $IN_BAM > $OUT_DIR/$IN_BAM.mpileup

## array jobs
#echo "$REF_INDEX ** ${SLURM_ARRAY_TASK_ID} ** $IN_BAM" >> $OUT_DIR/REF_INDEX.SLURM_ARRAY_TASK_ID.IN_BAM.txt
time \
samtools mpileup -f $REF_DIR/$REF_INDEX $IN_BAM > \
    $OUT_DIR/$IN_BAM.mpileup

## array jobs to calculate Tajima's pi
cd $OUT_DIR

#pool_sizes={78,78,78,80,80,80,68,68,68,58,58,58} # not working
#pool_sizes=(78,78,78,80,80,80,68,68,68,58,58,58) # not working
#pool_sizes=(78 78 78 80 80 80 68 68 68 58 58 58)
#pool_sizes={"78","78","78","80","80","80","58","58","58"}
#pool_sizes=("78" "78" "78" "80" "80" "80" "58" "58" "58")
pool_size_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/pooled_data_analysis
#for i in ${pool_sizes[*]}
#do
#echo $i >> pool_size.list
#done

each_pool_size=$(cat $pool_size_dir/pool_size.list |  sed -n ${SLURM_ARRAY_TASK_ID}p)
#echo "$each_pool_size *** ${SLURM_ARRAY_TASK_ID}" >> $OUT_DIR/each_pool_size.SLURM_ARRAY_TASK_ID.txt

#exit 0
time \
perl $Variance_sliding_pl --measure pi --input $IN_BAM.mpileup --output $IN_BAM.mpileup.pi \
    --min-count 3 --min-coverage 200 --max-coverage 1500 --window-size 10000 --step-size 10000 \
    --pool-size $each_pool_size --fastq-type illumina

exit 0

## --region regions_to_be_calculated
## complement region
pas_softmasked_region=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed/Bombus_pascuorum-GCA_905332965.1-softmasked.bed
OUT_BED=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed
## bedtools complement -h
## Use samtools faidx to create a genome file from a FASTA: 
##        One can the samtools faidx command to index a FASTA file.
##        The resulting .fai index is suitable as a genome file, 
##        as bedtools will only look at the first two, relevant columns
##        of the .fai file.
##
##        For example:
##        samtools faidx GRCh38.fa
##        bedtools complement -i my.bed -g GRCh38.fa.fai
bedtools complement -i $pas_softmasked_region -g $REF_PAS_INDEX.fai \
    > $OUT_BED/Bombus_pascuorum-GCA_905332965.1-softmasked_excluded.bed

      1 Andhae.New_REF_AndHae.sort.marked_dups.bam
      2 Andhae.New_REF_AndHat.sort.marked_dups.bam
      3 Andhae.New_REF_BomPas.sort.marked_dups.bam
      4 Andmar.New_REF_AndHae.sort.marked_dups.bam
      5 Andmar.New_REF_AndHat.sort.marked_dups.bam
      6 Andmar.New_REF_BomPas.sort.marked_dups.bam
      7 Bompas.New_REF_ApisMel.sort.marked_dups.bam
      8 Bompas.New_REF_BomHyp.sort.marked_dups.bam
      9 Bompas.New_REF_BomPas.sort.marked_dups.bam
     10 Bomvet.New_REF_ApisMel.sort.marked_dups.bam
     11 Bomvet.New_REF_BomHyp.sort.marked_dups.bam
     12 Bomvet.New_REF_BomPas.sort.marked_dups.bam

     REF_INDEX_list=(
            "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa"
            "Andrena_hattorfiana-GCA_944738655.1-softmasked.fa" 
            "Bombus_pascuorum-GCA_905332965.1-softmasked.fa"
            "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa"
            "Andrena_hattorfiana-GCA_944738655.1-softmasked.fa" 
            "Bombus_pascuorum-GCA_905332965.1-softmasked.fa"
            "Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa"
            "Bombus_hypnorum-GCA_911387925.1-softmasked.fa"            
            "Bombus_pascuorum-GCA_905332965.1-softmasked.fa"
            "Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa"
            "Bombus_hypnorum-GCA_911387925.1-softmasked.fa"            
            "Bombus_pascuorum-GCA_905332965.1-softmasked.fa"
            )