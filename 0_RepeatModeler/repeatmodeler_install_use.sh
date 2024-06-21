#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 20
#SBATCH --mem 2g
#SBATCH --time=16:00:00
#SBATCH --error=detect_Ref_softmask.%A.e
#SBATCH --output=detect_Ref_softmask.%A.o
#SBATCH --job-name=Andrena_marginata_Ref_softmask
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate repeatmodeler

REF_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
cd $REF_dir

## step I: build database
#BuildDatabase -name Andrena_marginata Andrena_marginata_GCA_963932335.1.fa
#BuildDatabase -name Andrena_bicolor Andrena_bicolor-GCA_960531205.1.fa
#BuildDatabase -name Bombus_muscorum Bombus_muscorum-GCA_963971185.1.fa

## step II: detect repeats                          
#RepeatModeler -database Andrena_marginata -threads 20 > Andrena_marginata_repeat_out.new.log
RepeatModeler -database Andrena_bicolor -threads 20 > Andrena_bicolor_repeat_out.new.log
RepeatModeler -database Bombus_muscorum -threads 20 > Bombus_muscorum_repeat_out.new.log

exit 0

# -LTRStruct (optional)
mkdir MaskerOutput
#consensi_fa_classified_dir=./RM_1536747.WedApr101949002024
RepeatMasker -pa 20 -gff -lib ./RM_1536747.WedApr101949002024/consensi.fa.classified -dir MaskerOutput Andrena_marginata_GCA_963932335.1.fa \
    -html -xsmall

RepeatMasker -pa 20 -gff -lib ./RM_1536747./consensi.fa.classified -dir MaskerOutput Andrena_bicolor_GCA_960531205.1.fa \
    -html -xsmall

RepeatMasker -pa 20 -gff -lib ./RM_1536747./consensi.fa.classified -dir MaskerOutput Bombus_muscorum_GCA_963971185.1.fa \
    -html -xsmall


exit 0

## create masked reference genome bed file in two steps
## https://www.danielecook.com/generate-a-bedfile-of-masked-ranges-a-fasta-file/

## /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/1_create_ref_genome_mask_regions/
generate_masked_bed.for_list_index.sh


## installment
## https://bioinformaticsworkbook.org/dataAnalysis/ComparativeGenomics/RepeatModeler_RepeatMasker.html#upgrade-repeatmodeler
conda create -n repeatmodeler -c bioconda repeatmodeler

conda activate repeatmodeler

RepeatModeler -h 
BuildDatabase  -h 

BuildDatabase -name Andrena_marginata Andrena_marginata_GCA_963932335.1.fa

