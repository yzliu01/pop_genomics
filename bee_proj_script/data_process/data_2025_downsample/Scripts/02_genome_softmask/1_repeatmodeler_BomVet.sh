#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 20
#SBATCH --mem 50g
#SBATCH --time=16:00:00
#SBATCH --array=0%1
#SBATCH --error=detect_BomVet_Ref_softmask.%A_%a.e
#SBATCH --output=detect_BomVet_Ref_softmask.%A_%a.o
#SBATCH --job-name=detect_BomVet_Ref_softmask

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate repeatmodeler

REF_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
cd $REF_dir

## step I: build database
BuildDatabase -name Bombus_veteranus_pl3 Bombus_veteranus.hifi_asm_pl3.fa

## step II: detect repeats
species_list=(
    #"Andrena_bicolor"
    
    #"Bombus_muscorum_alt"
    #"Bombus_veteranus"
    "Bombus_veteranus_pl3"
)
## chapgpt
species=${species_list[$SLURM_ARRAY_TASK_ID]}

## run RepeatModeler
#RepeatModeler -database Andrena_marginata -threads 20 > Andrena_marginata_repeat_out.new.log
#RepeatModeler -database "$species" -threads 20 > "$species"_repeat_out.new.log
RepeatModeler -database "$species" -threads 20 -recoverDir ./RM_349843.WedSep251309402024 > "$species"_repeat_out.new.log

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

