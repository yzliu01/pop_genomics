#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 10
#SBATCH --mem 50g
#SBATCH --array=14%1
#SBATCH --time=05:00:00
#SBATCH --error=qualimap_bee_16_pool_woodlouse.marked_dups.%A_%a.e
#SBATCH --output=qualimap_bee_16_pool_woodlouse.marked_dups.%A_%a.o
#SBATCH --job-name=qualimap_bee_16_pool_woodlouse.marked_dups
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
#rename bam files due to a mistake in previous step
#rename "_R1_001.fq.clean.gz" "" *_R1_001.fq.clean.gz*bam

#ls -t *sort.marked_dups.bam | head -16 > bee_16_pools.sort.marked_dups.bam.list
#Andhae.New_REF_AndHae.sort.marked_dups.bam
#Andmar.New_REF_AndHae.sort.marked_dups.bam
# Aphsti.REF_AphSti.sort.marked_dups.bam

************************** samtools view does not automatically modify the header unless explicitly told to do so ***********************
## subset only those contigs > 10bp
bed_file=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/fasta_generate_regions/chr_regions/Porcellio_scaber-GCA_034700385.1.fb_100kb.regions_10kb.masked

samtools view -b PorSca.REF_PorSca.sort.marked_dups.bam \
  'ENA|JAQIXM010000001|JAQIXM010000001.1:0-17937' > PorSca.region_10kb.new1.bam
    #-L $bed_file -o PorSca.region_10kb.new.bam \
samtools index PorSca.region_10kb.bam


************************** Picard can subset reads and adjust headers *****************
bed_file_old=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/fasta_generate_regions/chr_regions/Porcellio_scaber-GCA_034700385.1.fb_100kb.regions_10kb.masked
# Create the header
echo -e "@HD\tVN:1.6" > PorSca.target_intervals.list

# Add @SQ lines for each contig (using the end position as LN)
awk '{print "@SQ\tSN:"$1"\tLN:"$3}' $bed_file_old | sort -u >> PorSca.target_intervals.list

# Add intervals (convert 0-based to 1-based)
awk '{print $1"\t"($2+1)"\t"$3"\t+\t"$1"_"$2"_"$3}' $bed_file_old >> PorSca.target_intervals.list

picard FilterSamReads \
  I=PorSca.REF_PorSca.sort.marked_dups.bam \
  O=PorSca.region_10kb.clean.bam \
  INTERVAL_LIST=PorSca.target_intervals.list  \
  FILTER=includePairedIntervals
samtools index PorSca.region_10kb.clean.bam

samtools -H PorSca.region_10kb.clean.bam | head



samtools view -H PorSca.region_10kb.clean.bam > original_header.sam
# delete those not needed manually

samtools reheader original_header.sam PorSca.region_10kb.clean.bam > PorSca.region_10kb.final.bam
samtools view -H PorSca.region_10kb.final.bam
samtools index PorSca.region_10kb.final.bam
# samtools index: failed to create index for "PorSca.region_10kb.final.bam": Numerical result out of range

samtools index PorSca.region_10kb.fixed.bam
samtools view -H PorSca.region_10kb.fixed.bam


#SLURM_ARRAY_TASK_ID=14
#bam_list=$(cat bee_16_pools.sort.marked_dups.bam.list | sed -n ${SLURM_ARRAY_TASK_ID}p)

#qualimap bamqc -nt 6 -bam $SORTED_BAM -outdir $OUT_DIR -outformat HTML -c
#--output-genome-coverage 300
## specify one outdir folder for each array run
#bed_file_old=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/fasta_generate_regions/chr_regions/Porcellio_scaber-GCA_034700385.1.fb_100kb.regions_10kb.masked
# --feature-file $bed_file
qualimap bamqc -nt 10 -cl 400 -dl 90 -sd -c -bam PorSca.region_10kb.fixed.bam --java-mem-size=100G \
-outdir $OUT_DIR/PorSca.region_10kb.fixed.bam.10kb \
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

ls -dt ./* | head -17 | find . -name genome_results.txt | sort | xargs grep 'mean coverageData =' | awk '{print $NF}'
ls -dt ./* | head -18 | find . -name genome_results.txt | sort | xargs grep 'mean coverageData =' | sed -e 's/\.sort\.marked_dups\.bam\/genome_results\.txt:     mean coverageData =//' -e 's/\.\///' | awk '{print $1 "\t" $NF}'

## assign each line to variable dir
ls -dt */ | head -18 | while read dir; do
#echo "Directory: $dir"
    file="${dir}genome_results.txt"
    #echo $file
    if [ -f $file ]; then
    ## output with file names
        grep -H 'mean coverageData =' $file \
        | sed -e 's/\.sort\.marked_dups\.bam\/genome_results\.txt:     mean coverageData =//' | awk '{print $1 "\t" $NF}'
    fi
done
#AelAcu.REF_AelAcu       85.347X
#LepDol.REF_LepDol       101.2703X

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
