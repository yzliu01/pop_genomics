#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 20
#SBATCH --mem 50g
##SBATCH --time=20:00:00 # repeatmoduler
#SBATCH --time=3-10:00:00
##SBATCH --array=0-3%4
#SBATCH --array=0%1
#SBATCH --error=0_RepeatMasker_detect_2025_Ref_softmask.%A_%a.e
#SBATCH --output=0_RepeatMasker_detect_2025_Ref_softmask.%A_%a.o
#SBATCH --job-name=0_RepeatMasker_detect_2025_Ref_softmask
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
#BuildDatabase -name Bombus_muscorum_alt Bombus_muscorum-GCA_963971125.1.fa

#BuildDatabase -name Bombus_veteranus Bombus_veteranus.hifi_asm_pl2.fa

## array index stats with 0
species_list=(
    #"Andrena_bicolor"
    #"Bombus_muscorum_alt"
    #"Bombus_veteranus"
    #"Aphodius_sticticus"
    #"Ephemera_danica"
    #"Notonecta_glauca"
    "Notonecta_glauca"
    #"Stenurella_melanura"

)
## Ste_mel need more mem and time to be done
ref_list=(
    #"Aphodius_sticticus-GCA_963966075.1.fa"
    #"Ephemera_danica-GCA_000507165.2.fa"
    #"Notonecta_glauca.hifi_asm_pl2.fa"
    "Notonecta_glauca.hifi_asm_pl3.fa"
    #"Stenurella_melanura-GCA_963583905.1.fa"
)

## chapgpt
species=${species_list[$SLURM_ARRAY_TASK_ID]}
species_ref=${ref_list[$SLURM_ARRAY_TASK_ID]}

BuildDatabase -name $species $species_ref

## step II: detect repeats

## run RepeatModeler
#RepeatModeler -database Andrena_marginata -threads 20 > Andrena_marginata_repeat_out.new.log
#RepeatModeler -database "$species" -threads 20 > "$species"_repeat_out.log

#exit 0

## Step III: mask regions run after step II is done to have a consensi_fa id

# -LTRStruct (optional)
mkdir MaskerOutput

consensi_fa=(
    "RM_3476750.FriFeb210950522025"
)
consensi=${consensi_fa[$SLURM_ARRAY_TASK_ID]}
out_fa=(
    "Notonecta_glauca.hifi_asm_pl3.fa"
)
out=${out_fa[$SLURM_ARRAY_TASK_ID]}
#consensi_fa_classified_dir=./RM_1536747.WedApr101949002024
#RepeatMasker -pa 20 -gff -lib ./RM_1536747.WedApr101949002024/consensi.fa.classified -dir MaskerOutput Andrena_marginata_GCA_963932335.1.fa \
#    -html -xsmall

# /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/RM_2598087.SatJun220724542024 -> AndBic
#RepeatMasker -pa 20 -gff -lib ./$consensi/consensi.fa.classified -dir MaskerOutput $out \
#    -html -xsmall

#RepeatMasker -pa 20 -gff -lib ./RM_2888229.FriJun211609332024/consensi.fa.classified -dir MaskerOutput Bombus_muscorum-GCA_963971185.1.fa \
#    -html -xsmall

# /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/RM_3898646.WedJun261101442024 -> BomMus-alt
RepeatMasker -pa 20 -gff -lib ./$consensi/consensi.fa.classified -dir MaskerOutput $out \
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

