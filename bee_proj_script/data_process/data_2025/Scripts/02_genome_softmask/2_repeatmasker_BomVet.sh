#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 20
#SBATCH --mem 50g
#SBATCH --time=02:00:00
#SBATCH --array=0%1
#SBATCH --error=2_RepeatMasker_detect_BomVet_Ref_softmask.%A_%a.e
#SBATCH --output=2_RepeatMasker_detect_BomVet_Ref_softmask.%A_%a.o
#SBATCH --job-name=2_RepeatMasker_detect_BomVet_Ref_softmask
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate repeatmodeler

REF_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
cd $REF_dir

## Step III: mask regions run after step II is done to have a consensi_fa id

# -LTRStruct (optional)
mkdir MaskerOutput

consensi_fa=(
    "RM_2298508.ThuSep121905222024"
)
consensi=${consensi_fa[$SLURM_ARRAY_TASK_ID]}
out_fa=(
    "Bombus_veteranus.hifi_asm_pl2.fa"
)
out=${out_fa[$SLURM_ARRAY_TASK_ID]}

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

