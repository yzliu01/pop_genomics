#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 20
#SBATCH --mem 50g
#SBATCH --time=16:00:00
##SBATCH --time=20:00:00
#SBATCH --array=0%1
#SBATCH --error=detect_BomVet_Ref_softmask.%A_%a.e
#SBATCH --output=detect_BomVet_Ref_softmask.%A_%a.o
#SBATCH --job-name=detect_BomVet_Ref_softmask
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

# BuildDatabase -name Bombus_veteranus Bombus_veteranus.hifi_asm_pl2.fa
#BuildDatabase -name Bombus_veteranus_pl3 Bombus_veteranus.hifi_asm_pl3.fa

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

## Step III: mask regions run after step II is done to have a consensi_fa id

# -LTRStruct (optional)
mkdir MaskerOutput

consensi_fa=(
    #"RM_2298508.ThuSep121905222024"
    "RM_349843.WedSep251309402024"
)
consensi=${consensi_fa[$SLURM_ARRAY_TASK_ID]}
out_fa=(
    #"Bombus_veteranus.hifi_asm_pl2.fa"
    "Bombus_veteranus.hifi_asm_pl3.fa"

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

