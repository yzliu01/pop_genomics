#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 20
#SBATCH --mem 50g
##SBATCH --time=00:20:00
##SBATCH --time=25:00:00
#SBATCH --time=25:00:00 # PorSca
#SBATCH --array=2%1
##SBATCH --array=0-9%10
#SBATCH --error=2_gene_annotation_repeat_softmask_2025_30_NotGla_pl2_masked.%A_%a.e
#SBATCH --output=2_gene_annotation_repeat_softmask_2025_30_NotGla_pl2_masked.%A_%a.o
#SBATCH --job-name=2_gene_annotation_repeat_softmask_2025_30_NotGla_pl2_masked
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## from ***********************    Step I: prepare protein sequences for prothint.py ***********************
## /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/data_2025_downsample/Scripts/05_gene_annotation/1_gene_annotation_braker3_prothint_selectClade_snakemake.sh

## conda installation
## alternatively, start BRAKER with hints already produced by ProtHint (Step III), by providing ProtHint's prothint_augustus.gff output
gene_rediction_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation
cd $gene_rediction_dir

## test
##SLURM_ARRAY_TASK_ID=0

## array index stats with 0
species_list=(
    "Aphodius_sticticus"
    "Ephemera_danica" 
    "Notonecta_glauca" #x      # self_annotated
    "Stenurella_melanura" #x

    #"Chorthippus_brunneus" # self_annotated: 14Gb
    ##"Pseudochorthippus_parallelus" # no ref & no reads
    #"Chorthippus_parallelus" # self_annotated: 14Gb
    #"Panurgus_banksianus"  # self_annotated

    "Agelastica_alni"
    "Leptopterna_dolobrata"
    "Mystacides_longicornis"
    "Porcellio_scaber" #x
    "Tholera_decimalis" #x
    "Xestia_c-nigrum"
)
## Ste_mel need more mem and time to be done

ref_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
ref_list=(
    "Aphodius_sticticus-GCA_963966075.1.fa" # >ENA|OZ014506|OZ014506.1 Aphodius sticticus genome assembly, chromosome: 1
    "Ephemera_danica-GCA_000507165.2.fa" # >KZ497563.1 UNVERIFIED_CONTAM: Ephemera danica
    "Notonecta_glauca.hifi_asm_pl2.fa.masked" # >ptg000001l
    "Stenurella_melanura-GCA_963583905.1.fa" # >ENA|OY757309|OY757309.1 Stenurella melanura genome assembly, chromosome: 1

    #"Chorthippus_brunneus.hifi_asm_pl2.fa" # assembling: 14Gb
    ##"Pseudochorthippus_parallelus.hifi_asm_pl2.fa" # no data
    #"Chorthippus_parallelus.hifi_asm_pl2.fa" # assembling: 14Gb
    #"Panurgus_banksianus.hifi_asm_pl2.fa" # assembling

    "Agelastica_alni-GCA_950111635.2.fa" # >ENA|OX467709|OX467709.1 Agelastica alni genome assembly, chromosome: 2
    "Leptopterna_dolobrata-GCA_954871275.1.fa" # >ENA|OX940975|OX940975.1 Leptopterna dolabrata genome assembly, chromosome: 1
    "Mystacides_longicornis-GCA_963576905.1.fa" # >ENA|OY756420|OY756420.1 Mystacides longicornis genome assembly, chromosome: 1
    "Porcellio_scaber-GCA_034700385.1.fa" # >ENA|JAQIXM010000001|JAQIXM010000001.1 Porcellio scaber isolate Gr-Myr-00683 scaffold3_size17937, whole genome shotgun sequence.
    "Tholera_decimalis-GCA_943138885.2.fa" # >ENA|OW964549|OW964549.2 Tholera decimalis genome assembly, chromosome: 1
    "Xestia_c-nigrum-GCA_916618015.1.fa" # >ENA|OU745244|OU745244.1 Xestia c-nigrum genome assembly, chromosome: 1
)

species=${species_list[$SLURM_ARRAY_TASK_ID]}
species_ref=${ref_list[$SLURM_ARRAY_TASK_ID]}

## reference genome with simple header lines
#sed -e 's/|/_/g' -e 's/\.1.*/.1/g' $ref_dir/$species_ref > $ref_dir/$species_ref.simple_header.fa

## the fasta header name affect GeneMark
##sed -e 's/|/_/g' -e 's/\.1.*/.1/g' /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_muscorum-GCA_963971185.1.fa > /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_muscorum-GCA_963971185.1.simple_header_new.fa
##sed -e 's/|/_/g' -e 's/\.1.*/.1/g' /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_muscorum-GCA_963971125.1.fa > /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_muscorum-GCA_963971125.1.simple_header_new.fa
## ENA|OZ020127|OZ020127.1 Bombus muscorum genome assembly, chromosome: 1 ---> ENA_OZ020127_OZ020127.1
## ENA|OZ010659|OZ010659.1	--->  ENA_OZ010659_OZ010659.1 (working with this form)

##sed -e 's/|/_/g' -e 's/\.1.*/.1/g' $ref_dir/Porcellio_scaber-GCA_034700385.1.fa | less -S
## >ENA|JAQIXM010000001|JAQIXM010000001.1 Porcellio scaber isolate Gr-Myr-00683 scaffold3_size17937, whole genome shotgun sequence.


## folder of $braker_output_dir_for_protseq must be not existing before
rm -r braker_softmask_"$species"_results_for_protseq

mkdir braker_softmask_"$species"_results_for_protseq
braker_output_dir_for_protseq=braker_softmask_"$species"_results_for_protseq

## protein database
##Apodiea_gene_AA=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prepare_protein_db/orthodb/Apodiea_gene_AA.fa
Insecta_gene_AA=$gene_rediction_dir/prepare_protein_db_1/orthodb/Insecta_gene_AA.fa

## gff file from Prothint
## wrong: prothint_augustus_gff=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prothint_results/prothint_augustus.gff
##prothint_augustus_gff=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prothint_results_BomVet/prothint_augustus.gff
##prothint_augustus_gff_old=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prothint_results/prothint_augustus.old.gff

## activate Braker3 Env
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
conda activate braker3

## >>>>>>>>>> method I  <<<<<<<<<<
## having BRAKER run ProtHint
## suggest number of core is less than 8; 

## IMPORTANT SETTINGS FOR ARRAY SUBMISSIONS
## "--species=sname" Species name. Existing species will not be overwritten. Uses Sp_1 etc., if no species is assigned

## Thu Mar 20 08:46:37 2025: ERROR: in file /home/yzliu/miniforge3/envs/braker3/bin/braker.pl at line 3488
## /home/yzliu/miniforge3/envs/braker3/config//species/Sp_1 already exists. Choose another species name, delete this directory 
## or use the existing species with the option "--useexisting". Be aware that existing parameters will then be overwritten during training.
##  --threads 20
braker.pl --genome="$ref_dir/$species_ref".simple_header.fa --prot_seq="$Insecta_gene_AA" \
    --workingdir=$braker_output_dir_for_protseq --species="$species" --useexisting --threads=20 \
    --PROTHINT_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes/ProtHint/bin \
    --GENEMARK_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes \
    --makehub --email=yuanzhen.liu2@gmail.com

exit 0

## test with a single species worked
braker.pl --genome=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Aphodius_sticticus-GCA_963966075.1.fa.simple_header.fa --prot_seq=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prepare_protein_db_1/orthodb/Insecta_gene_AA.fa \
    --workingdir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/test_Aph_sti --threads 20 \
    --PROTHINT_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes/ProtHint/bin \
    --GENEMARK_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes \
    --makehub --email=yuanzhen.liu2@gmail.com
    
## use the final "baker.gtf" file for following snalyses

## >>>>>>>>>> method II gave results <<<<<<<<<<
## run braker3 with prothint result gff file
braker.pl --genome="$Bombus_confusus_softmask_simple_header_genome" --hints="$prothint_augustus_gff" \
    --workingdir=$braker_output_dir --threads 4 \
    --PROTHINT_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes/ProtHint/bin \
    --GENEMARK_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes
