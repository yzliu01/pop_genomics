#!/bin/sh
#SBATCH --account eDNA
#SBATCH --time=06:00:00
##SBATCH --cpus-per-task 20
#SBATCH --ntasks=1
#SBATCH --mem 20g
#SBATCH --job-name=pep_id_tra_id_14bee_species
#SBATCH --error=pep_id_tra_id_14bee_species.%A.e
#SBATCH --output=pep_id_tra_id_14bee_species.%A.o

primary_transcripts=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts
cd $primary_transcripts

new_transcript_id_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id

species_list=(
    #"And_ful" # done separately
    "And_hae"
    "And_hat"
    "And_tri"
    "Apis_mel"
    "Bom_hor"
    "Bom_hyp"
    "Bom_pas"
    "Bom_syl"
    "Ves_vul"
)

#ls | grep -v -e "braker" -e "\.fa$"

gtf_list=(
    #"Andrena_fulva-GCA_946251845.1-2023_02-genes.gtf" # done separately
    "Andrena_haemorrhoa-GCA_910592295.1-2021_11-genes.gtf"
    "Andrena_hattorfiana-GCA_944738655.1-2022_08-genes.gtf"
    "Andrena_trimmerana-GCA_951215215.1-2023_07-genes.gtf"
    "Apis_mellifera-GCF_003254395.2_Amel_HAv3.1-genes.gtf"
    "Bombus_hortorum-GCA_905332935.1-2021_11-genes.gtf"
    "Bombus_hypnorum-GCA_911387925.1-2021_11-genes.gtf"
    "Bombus_pascuorum-GCA_905332965.1-2021_11-genes.gtf"
    "Bombus_sylvestris-GCA_911622165.2-2023_03-genes.gtf"
    "Vespula_vulgaris-GCA_905475345.1-2021_11-genes.gtf"

)

#ls | grep -v -e "braker" -e "\.gtf$"

fa_list=(
    #"Andrena_fulva-GCA_946251845.1-2023_02-pep.fa" # done separately
    "Andrena_haemorrhoa-GCA_910592295.1-2021_11-pep.fa"
    "Andrena_hattorfiana-GCA_944738655.1-2022_08-pep.fa"
    "Andrena_trimmerana-GCA_951215215.1-2023_07-pep.fa"
    "Apis_mellifera-GCF_003254395.2_Amel_HAv3.1-pep.fa"
    "Bombus_hortorum-GCA_905332935.1-2021_11-pep.fa"
    "Bombus_hypnorum-GCA_911387925.1-2021_11-pep.fa"
    "Bombus_pascuorum-GCA_905332965.1-2021_11-pep.fa"
    "Bombus_sylvestris-GCA_911622165.2-2023_03-pep.fa"
    "Vespula_vulgaris-GCA_905475345.1-2021_11-pep.fa"

)

## set column separators [ ";"] multiple
## transcript_id $4 - XM_623972.6, protein_id $14 - XP_623975.1
#less -S ${gtf_list[4]} | awk -F '["]+' '/protein_id/ {print $14,"\t",$4}' > protein_transcript_map.txt
#less -S ${gtf_list[0]} | \awk -F '( \"|\"; )' '/protein_id/ {print $14,"\t",$4}' > protein_transcript_map.txt
#'( \"|\"; )'

## adapted one based on chatgpt
for i in $(seq 1 8)
do
echo -e "editing id: " $i "\t" ${species_list[i]} "\t" ${gtf_list[i]} "\t" ${fa_list[i]} "\n"

#done

less -S ${gtf_list[i]} | \
    awk -F '[ ";]+' '/protein_id/ && /transcript_id/ {protein_id="";
                     transcript_id="";
                     for(i=1;i<=NF;i++){
                        if($i=="protein_id") protein_id=$(i+1); 
                        if($i=="transcript_id") transcript_id=$(i+1);}
                        print protein_id".1", transcript_id".1";}' | sort -V | uniq | less -S  \
    > ./protein_transcript_map/protein_transcript_map.${species_list[i]}.txt

# Read the mapping file and replace protein_id with transcript_id in the FASTA file
## create temporary file that can be edited directly
cp ../${fa_list[i]} ../${fa_list[i]}.transcript_id.fa
while read -r protein_id transcript_id; do
  sed -i "s/>$protein_id/>$transcript_id/g" ../${fa_list[i]}.transcript_id.fa
done < ./protein_transcript_map/protein_transcript_map.${species_list[i]}.txt

done

# mv ../${fa_list[0]}.tmp ../${fa_list[0]}.transcript_id.fa

exit 0
