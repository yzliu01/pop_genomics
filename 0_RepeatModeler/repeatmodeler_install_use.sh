#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 20
#SBATCH --mem 2g
#SBATCH --time=16:00:00
#SBATCH --error=Andrena_marginata_Ref_softmask.%A.e
#SBATCH --output=Andrena_marginata_Ref_softmask.%A.o
#SBATCH --job-name=Andrena_marginata_Ref_softmask
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate repeatmodeler

REF_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
cd $REF_dir

#BuildDatabase -name Andrena_marginata Andrena_marginata_GCA_963932335.1.fa
RepeatModeler -database Andrena_marginata -threads 20 > Andrena_marginata_repeat_out.new.log
# -LTRStruct (optional)
mkdir MaskerOutput
#consensi_fa_classified_dir=./RM_1536747.WedApr101949002024
RepeatMasker -pa 20 -gff -lib ./RM_1536747.WedApr101949002024/consensi.fa.classified -dir MaskerOutput Andrena_marginata_GCA_963932335.1.fa \
    -html -xsmall

exit 0

## installment
## https://bioinformaticsworkbook.org/dataAnalysis/ComparativeGenomics/RepeatModeler_RepeatMasker.html#upgrade-repeatmodeler
conda create -n repeatmodeler -c bioconda repeatmodeler

conda activate repeatmodeler

RepeatModeler -h 
BuildDatabase  -h 

BuildDatabase -name Andrena_marginata Andrena_marginata_GCA_963932335.1.fa

