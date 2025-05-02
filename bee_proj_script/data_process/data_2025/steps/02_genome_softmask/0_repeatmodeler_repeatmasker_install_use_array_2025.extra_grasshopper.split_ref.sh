#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 30
#SBATCH --mem 500g
##SBATCH --time=00:10:00 # 1-RepeatModeler
##SBATCH --time=3-00:00:00 # 1-RepeatModeler
#SBATCH --time=1-10:00:00 # 1-RepeatModeler
##SBATCH --time=1-10:00:00  # 2-RepeatMasker
##SBATCH --array=0-9%10
#SBATCH --array=6-9%4
##SBATCH --array=0-1%2
#SBATCH --error=0_RepeatMasker_detect_2025_Ref_softmask_grasshopper_split_ref.%A_%a.e
#SBATCH --output=0_RepeatMasker_detect_2025_Ref_softmask_grasshopper_split_ref.%A_%a.o
#SBATCH --job-name=0_RepeatMasker_detect_2025_Ref_softmask_grasshopper_split_ref
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate repeatmodeler
## https://www.animalgenome.org/bioinfo/resources/manuals/RepeatMasker.html

REF_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/split_ref_genome_fa
cd $REF_dir

## step I: build database - split genomes into 10 pieces

## array index stats with 0
species_list=(
    Chorthippus_brunneus_1
    Chorthippus_brunneus_2
    Chorthippus_brunneus_3
    Chorthippus_brunneus_4
    Chorthippus_brunneus_5
    Chorthippus_brunneus_6
    Chorthippus_brunneus_7
    Chorthippus_brunneus_8
    Chorthippus_brunneus_9
    Chorthippus_brunneus_10

    Chorthippus_parallelus_1
    Chorthippus_parallelus_2
    Chorthippus_parallelus_3
    Chorthippus_parallelus_4
    Chorthippus_parallelus_5
    Chorthippus_parallelus_6
    Chorthippus_parallelus_7
    Chorthippus_parallelus_8
    Chorthippus_parallelus_9
    Chorthippus_parallelus_10
)

ref_list=(
    Chorthippus_brunneus.hifi_asm_pl3.part_001.fa
    Chorthippus_brunneus.hifi_asm_pl3.part_002.fa
    Chorthippus_brunneus.hifi_asm_pl3.part_003.fa
    Chorthippus_brunneus.hifi_asm_pl3.part_004.fa
    Chorthippus_brunneus.hifi_asm_pl3.part_005.fa
    Chorthippus_brunneus.hifi_asm_pl3.part_006.fa
    Chorthippus_brunneus.hifi_asm_pl3.part_007.fa
    Chorthippus_brunneus.hifi_asm_pl3.part_008.fa
    Chorthippus_brunneus.hifi_asm_pl3.part_009.fa
    Chorthippus_brunneus.hifi_asm_pl3.part_010.fa

    Chorthippus_parallelus.hifi_asm_pl3.part_001.fa
    Chorthippus_parallelus.hifi_asm_pl3.part_002.fa
    Chorthippus_parallelus.hifi_asm_pl3.part_003.fa
    Chorthippus_parallelus.hifi_asm_pl3.part_004.fa
    Chorthippus_parallelus.hifi_asm_pl3.part_005.fa
    Chorthippus_parallelus.hifi_asm_pl3.part_006.fa
    Chorthippus_parallelus.hifi_asm_pl3.part_007.fa
    Chorthippus_parallelus.hifi_asm_pl3.part_008.fa
    Chorthippus_parallelus.hifi_asm_pl3.part_009.fa
    Chorthippus_parallelus.hifi_asm_pl3.part_010.fa
)

## chatgpt
species=${species_list[$SLURM_ARRAY_TASK_ID]}
species_ref=${ref_list[$SLURM_ARRAY_TASK_ID]}

#BuildDatabase -name $species $species_ref

## step II: detect repeats

## run RepeatModeler
#RepeatModeler -database Andrena_marginata -threads 20 > Andrena_marginata_repeat_out.new.log
#echo "running RepeatModeler for $species" > "$species"_repeat_out.log
#RepeatModeler -database "$species" -threads 30 >> "$species"_repeat_out.log
# -LTRStruct (optional)

#exit 0

## Step III: mask regions run after step II is done to have a consensi_fa id

#mkdir MaskerOutput

## combined consensi_fa file
consensi_fa=(
merged_Chorthippus_brunneus_consensi_fa
merged_Chorthippus_parallelus_consensi_fa
)

#consensi=${consensi_fa[$SLURM_ARRAY_TASK_ID]}
out_fa=(
Chorthippus_brunneus.hifi_asm_pl3.fa
Chorthippus_parallelus.hifi_asm_pl3.fa
)

#out=${out_fa[$SLURM_ARRAY_TASK_ID]}

# /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/RM_3898646.WedJun261101442024 -> BomMus-alt
#RepeatMasker -pa 30 -gff -lib ./$consensi/consensi.fa.classified -dir MaskerOutput /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/$out \
#    -html -xsmall

#exit 0


## merge the output libraries:
## This approach avoids merging databases and instead merges results.
#cat RM_*ThuMar*/consensi.fa > merged_repeats.fa

## brun
consensi_fa_brun=(

    RM_868167.WedMar262326332025
    RM_91782.WedMar262326422025
    RM_91773.WedMar262326372025
    RM_3250899.WedMar262326322025
    RM_3250890.WedMar262326272025
    RM_832185.WedMar262326092025
    RM_283669.WedMar262326192025
    RM_283659.WedMar262326162025
    RM_3734691.WedMar262326142025
    RM_3734679.WedMar262326122025

)
## concate all splits into one
#mkdir merged_Chorthippus_brunneus_consensi_fa
#for consensi in ${consensi_fa[@]}
#do
#cat $consensi/consensi.fa >> ./merged_Chorthippus_brunneus_consensi_fa/Chorthippus_brunneus.hifi_asm_pl3.consensi.fa
#done

consensi=${consensi_fa_brun[$SLURM_ARRAY_TASK_ID]}
input_fa_list=(

    Chorthippus_brunneus.hifi_asm_pl3.part_001.fa
    Chorthippus_brunneus.hifi_asm_pl3.part_002.fa
    Chorthippus_brunneus.hifi_asm_pl3.part_003.fa
    Chorthippus_brunneus.hifi_asm_pl3.part_004.fa
    Chorthippus_brunneus.hifi_asm_pl3.part_005.fa
    Chorthippus_brunneus.hifi_asm_pl3.part_006.fa
    Chorthippus_brunneus.hifi_asm_pl3.part_007.fa
    Chorthippus_brunneus.hifi_asm_pl3.part_008.fa
    Chorthippus_brunneus.hifi_asm_pl3.part_009.fa
    Chorthippus_brunneus.hifi_asm_pl3.part_010.fa

)
input_fa=${input_fa_list[$SLURM_ARRAY_TASK_ID]}

#RepeatMasker -pa 30 -gff -lib ./$consensi/consensi.fa.classified -dir ./MaskerOutput ./$input_fa \
#    -html -xsmall


## para
#ls *par*mod.log | sort -V | xargs grep 'RM_'
#ls *par*mod.log | sort -V | xargs grep 'RM_' | cut -d '/' -f 10
consensi_fa_para=(

    RM_3036937.WedMar262340552025
    RM_1096519.ThuMar270012032025
    RM_1096508.ThuMar270011572025
    RM_3598294.ThuMar270020362025
    RM_4001735.ThuMar270028332025
    RM_2098160.ThuMar270228222025
    # neglected
    RM_243929.ThuMar270237402025
    
    RM_2481572.ThuMar270244342025
    RM_3262874.ThuMar270247222025
    RM_2231083.ThuMar270258322025

)
## concate all splits into one
#mkdir merged_Chorthippus_parallelus_consensi_fa
#for consensi in ${consensi_fa[@]}
#do
#cat $consensi/consensi.fa >>  ./merged_Chorthippus_parallelus_consensi_fa/Chorthippus_parallelus.hifi_asm_pl3.consensi.fa
#done


consensi=${consensi_fa_para[$SLURM_ARRAY_TASK_ID]}
input_fa_list=(

    Chorthippus_parallelus.hifi_asm_pl3.part_001.fa
    Chorthippus_parallelus.hifi_asm_pl3.part_002.fa
    Chorthippus_parallelus.hifi_asm_pl3.part_003.fa
    Chorthippus_parallelus.hifi_asm_pl3.part_004.fa
    Chorthippus_parallelus.hifi_asm_pl3.part_005.fa
    Chorthippus_parallelus.hifi_asm_pl3.part_006.fa
    Chorthippus_parallelus.hifi_asm_pl3.part_007.fa
    Chorthippus_parallelus.hifi_asm_pl3.part_008.fa
    Chorthippus_parallelus.hifi_asm_pl3.part_009.fa
    Chorthippus_parallelus.hifi_asm_pl3.part_010.fa

)
input_fa=${input_fa_list[$SLURM_ARRAY_TASK_ID]}


RepeatMasker -pa 30 -gff -lib ./$consensi/consensi.fa.classified -dir ./MaskerOutput ./$input_fa \
    -html -xsmall


exit 0

## concatenate split ref
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/split_ref_genome_fa/MaskerOutput
ls *para*part*fa.masked
cat *para*part*fa.masked > ../../Chorthippus_parallelus.hifi_asm_pl3.fa.masked
cat *brunn*part*fa.masked > ../../Chorthippus_brunneus.hifi_asm_pl3.fa.masked

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

