#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 10
#SBATCH --mem 20g
#SBATCH --time=06:15:00
##SBATCH --array=1-13%13
#SBATCH --array=1%1
#SBATCH --error=busco_genome_assembly_Bom_And.%A_%a.e
#SBATCH --output=busco_genome_assembly_Bom_And.%A_%a.o
#SBATCH --job-name=busco_genome_assembly_Bom_And
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## Step II: reorder the chromosome order
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate busco_v5.7.1

## run busco
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
## early
REF_AndHae=$REF_DIR/Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa
REF_AndHat=$REF_DIR/Andrena_hattorfiana-GCA_944738655.1-softmasked.fa
REF_BomPas=$REF_DIR/Bombus_pascuorum-GCA_905332965.1-softmasked.fa
REF_BomHyp=$REF_DIR/Bombus_hypnorum-GCA_911387925.1-softmasked.fa
REF_ApisMel=$REF_DIR/Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa
REF_AndMar=$REF_DIR/Andrena_marginata_GCA_963932335.1-softmasked.fa
## new
REF_BomCon=$REF_DIR/Bombus_confusus-GCA_014737475.1_ASM1473747v1-softmasked.fa
REF_BomHor=$REF_DIR/Bombus_hortorum-GCA_905332935.1-softmasked.fa
REF_AndTri=$REF_DIR/Andrena_trimmerana-GCA_951215215.1-softmasked.fa
REF_AndFul=$REF_DIR/Andrena_fulva-GCA_946251845.1-softmasked.fa
## new
REF_AndBic=$REF_DIR/Andrena_bicolor-GCA_960531205.1.fa
REF_BomMus=$REF_DIR/Bombus_muscorum-GCA_963971125.1.fa
REF_BomSyl=$REF_DIR/Bombus_sylvestris-GCA_911622165.2-softmasked.fa

REF_VesVul=$REF_DIR/Vespula_vulgaris-GCA_905475345.1-softmasked.fa
#REF_BomSyl=$REF_DIR/Bombus_sylvestris-GCA_911622165.2-softmasked.fa

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test

## function list of array jobs
species_list=(
    "REF_BomPas"
    #"REF_BomVet" # not published
    "REF_BomHyp"
    "REF_BomCon"
    "REF_BomHor"
    "REF_BomMus"
    "REF_BomSyl"
    #
    "REF_AndHae"
    "REF_AndHat"    
    "REF_AndMar"
    "REF_AndTri"
    "REF_AndFul"
    "REF_AndBic"
    "REF_ApisMel"
    "REF_VesVul"
)

## make array jobs
##species_array=$(echo ${species_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)
species_var=${species_list[$SLURM_ARRAY_TASK_ID-1]}
#function_array=$(echo ${function_list[*]} | tr ' ' '\n' | sed -n 3p)
## execute array jon function
## https://www.cyberciti.biz/faq/unixlinux-bash-shell-script-function-call-in-echo-command/
#echo $($function_array)

## Species Selection: species_var selects the variable name based on SLURM_ARRAY_TASK_ID, and species_path retrieves the actual path using the indirect expansion ${!species_var}
species_path=${!species_var}

busco -i $species_path -m genome -c 10 --lineage_dataset hymenoptera_odb10 --restart

## busco -i $REF_BomSyl -m genome --lineage_dataset hymenoptera_odb10 --restart
## -i or --in defines the input file to analyse which is either a nucleotide fasta file or a protein fasta file, depending on the BUSCO mode.
## -m or --mode sets the assessment MODE: genome, proteins, transcriptome


exit 0

## install busco
## https://busco.ezlab.org/busco_userguide.html
mamba create -n busco_v5.7.1 -c bioconda busco=5.7.1

## A full list of available datasets can be viewed 
busco --list-datasets

- metazoa_odb10
         - arthropoda_odb10
             - arachnida_odb10
             - insecta_odb10
                 - endopterygota_odb10
                     - diptera_odb10
                     - hymenoptera_odb10
                     - lepidoptera_odb10
                 - hemiptera_odb10
         - mollusca_odb10
         - nematoda_odb10
         - vertebrata_odb10

## https://www.orthodb.org/
# hymenoptera_odb10
