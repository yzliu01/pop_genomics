
**  preparation step **

## identify repeative regions using RepeatModeler
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/0_RepeatModeler

repeatmodeler_install_use_array.sh


## create masked reference genome bed file in two steps
## https://www.danielecook.com/enerate-a-bedfile-of-masked-ranges-a-fasta-file/

## I - replace bases in lowercase into N
softmasked_genome_Amel=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Amel_HAv3_1.fa
*********
less -S .
>NC_037638.1 Apis mellifera strain DH4 linkage group LG1, Amel_HAv3.1, whole genome shotgun sequence
GAGAGAATTAACTACCTTAACCTGAACCTAAACCTACCGATAACCTAACTCTAAACTATACCTTTAACCCCTAAACCCTA (80)
CACCTAAGTCCTAAACCAATAACCTTAACCCTAACAACTATATAAAACACTAACCTATAACCTAATCCCCTAACTACTAA (160)
ActactaacctaacctaaaactatatacctaacctaaaccttaCCCTAACCATAACCTATTACTCTAACCCTACCAAGAG
*********
## convert ref genome to the one with N
out_softmasked_genome_Amel=${softmasked_genome_Amel/.fa/}
grep -v "^>"tr $softmasked_genome_Amel | tr "[atcg]" "N" > $softmasked_genome_Amel.N.fa

## II - generate bed file using converted fasta file
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/1_create_ref_genome_mask_regions
python generate_masked_region_md.py $out_softmasked_genome_Amel > Amel_masked.bed
*********
less Amel_masked.bed
NC_037638.1	161	203
NC_037638.1	312	334
NC_037638.1	369	403

BED_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed/
cd $BED_DIR
less Bombus_pascuorum-GCA_905332965.1-softmasked.bed
1	0	32253
1	32258	32265
1	32485	32514
*********

## hard mask reference genome in loop
## Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa
rename Amel Apis_mellifera Amel_HAv-GCF*

REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
cd $REF_DIR
generate_masked_region_md_py=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/1_create_ref_genome_mask_regions/enerate_masked_region_md.py

for masked_ref in `ls *softmasked.fa`
    do
    out_softmasked_genome=${masked_ref/.fa/}
    grep -v "^>"tr $masked_ref | tr "[atcg]" "N" > $out_softmasked_genome.N.fa
    python $generate_masked_region_md_py $out_softmasked_genome.N.fa > ./ref_masked_bed/$out_softmasked_genome.bed
done

for masked_ref in `ls Drosophila_melanoganster-GCF_000001215.4_Release_6_plus_ISO1_MT_genomic-softmasked.fa`
    do
    out_softmasked_genome=${masked_ref/.fa/}
    grep -v "^>"tr $masked_ref | tr "[atcg]" "N" > $out_softmasked_genome.N.fa
    python $generate_masked_region_md_py $out_softmasked_genome.N.fa > ./ref_masked_bed/$out_softmasked_genome.bed
done
Drosophila_melanoganster-GCF_000001215.4_Release_6_plus_ISO1_MT_genomic-softmasked.fa





****************************** step I: obtain repeative regions ****************************************************
## path to ref directory
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
cd $REF_DIR
generate_masked_region_md_py=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/1_create_ref_genome_mask_regions/enerate_masked_region_md.py

## get softmasked regions (final)
** Andrena marginata and more species **
#for masked_ref in `ls Andrena_marginata_GCA_963932335.1-softmasked.fa`
for masked_ref in `ls -t *-softmasked.fa | head -4`
mv Andrena_bicolor-GCA_960531205.1.fa.masked Andrena_bicolor-GCA_960531205.1-softmasked.fa
mv Bombus_muscorum-GCA_963971125.1.fa.masked Bombus_muscorum-GCA_963971125.1-softmasked.fa

for masked_ref in `ls -t *-softmasked.fa | head -2`
for masked_ref in `ls -t Bombus_sylvestris*-softmasked.fa | head -2`
for masked_ref in `ls -t Bombus_veteranus.hifi_asm_pl2-softmasked.fa`
for masked_ref in `ls -t Bombus_veteranus.hifi_asm_pl2-softmasked.fa`

## 2025 new ref
run_trial_list=(
    # originally softmasked
    #"Cerceris_rybyensis-GCA_910591515.1-softmasked.fa" # test for stairway plot
    #"Megachile_leachella-GCA_963576845.1-softmasked.fa" # test for stairway plot
    #"Rutpela_maculata-GCA_936432065.2-softmasked.fa" # test for stairway plot
    Bombylius_major-GCA_932526495.1-softmasked.fa
    Phragmatobia_fuliginosa-GCA_932526445.1-softmasked.fa
    Ochropleura_plecta-GCA_905475445.1-softmasked.fa

    # self softmasked
    "Aphodius_sticticus-GCA_963966075.1-softmasked.fa"
    "Ephemera_danica-GCA_000507165.2-softmasked.fa"
    #"Notonecta_glauca.hifi_asm_pl2-softmasked.fa" # self assembly: not the best
    "Notonecta_glauca.hifi_asm_pl3-softmasked.fa" # self assembly: best
    "Stenurella_melanura-GCA_963583905.1-softmasked.fa"

    # more
    "Chorthippus_brunneus.hifi_asm_pl2-softmasked.fa" # assembling
    #"Pseudochorthippus_parallelus.hifi_asm_pl2-softmasked.fa" # no data
    "Chorthippus_parallelus.hifi_asm_pl2-softmasked.fa" # assembling
    "Panurgus_banksianus.hifi_asm_pl3-softmasked.fa" # assembling

    # self softmasked
    "Agelastica_alni-GCA_950111635.2-softmasked.fa"
    "Leptopterna_dolobrata-GCA_954871275.1-softmasked.fa"
    "Mystacides_longicornis-GCA_963576905.1-softmasked.fa"
    "Porcellio_scaber-GCA_034700385.1-softmasked.fa"
    "Tholera_decimalis-GCA_943138885.2-softmasked.fa"
    "Xestia_c-nigrum-GCA_916618015.1-softmasked.fa"

    # originally softmasked
    "Amphimallon_solstitiale-GCA_963170755.1-softmasked.fa"
    "Aelia_acuminata-GCA_911387785.2-softmasked.fa"
    "Bibio_marci-GCA_910594885.2-softmasked.fa"
    "Dorcus_parallelipipedus-GCA_958336345.1-softmasked.fa"
    "Eristalis_intricaria-GCA_964034865.1-softmasked.fa"
    "Eristalis_pertinax-GCA_907269125.1-softmasked.fa"
    "Gerris_lacustris-GCA_951217055.1-softmasked.fa"
    "Malachius_bipustulatus-GCA_910589415.1-softmasked.fa"
    "Noctua_pronuba-GCA_905220335.1-softmasked.fa"
    "Phosphuga_atrata-GCA_944588485.1-softmasked.fa"
    "Pterostichus_niger-GCA_947425015.1-softmasked.fa"
    "Tachina_fera-GCA_905220375.1-softmasked.fa"
    "Rhagonycha_fulva-GCA_905340355.1-softmasked.fa"
    "Lasioglossum_morio-GCA_916610235.2-softmasked.fa"
    





)

for masked_ref in `echo ${run_trial_list[*]}`
#    do echo $masked_ref
#done
    do
    out_softmasked_genome=${masked_ref/.fa/}
    #grep -v "^>"tr $masked_ref | tr "[atcg]" "N" > $out_softmasked_genome.N.fa ## wrong
    sed '/^>/! s/[atcg]/N/' $masked_ref > $out_softmasked_genome.N.fa
    #awk '/^>/ {print; next} {gsub(/[atcgATCG]/, "N"); print}' $masked_ref
    python $generate_masked_region_md_py $out_softmasked_genome.N.fa > ./ref_masked_bed/$out_softmasked_genome.bed
done


## 2025 new ref genomes
ls -t *softmasked*fa | head -20
Phragmatobia_fuliginosa-GCA_932526445.1-softmasked.fa
Megachile_leachella-GCA_963576845.1-softmasked.fa
Ochropleura_plecta-GCA_905475445.1-softmasked.fa
Cerceris_rybyensis-GCA_910591515.1-softmasked.fa
Bombylius_major-GCA_932526495.1-softmasked.fa
Rutpela_maculata-GCA_936432065.2-softmasked.fa

************************************** step II: obtain gene regions *******************************************
## mask gene regions
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
cd $REF_DIR
fasta_generate_regions_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/fasta_generate_regions
REF_PAS_softmasked_region=$fasta_generate_regions_DIR/Bombus_pascuorum-GCA_905332965.1-softmasked.fb_2Mb.regions
head $REF_PAS_softmasked_region
1:0-2000000
1:2000000-4000000

## make the same chromosome names for the fb region file
sed 's/^/chr/' $REF_PAS_softmasked_region > $fasta_generate_regions_DIR/Bombus_pascuorum-GCA_905332965.1-softmasked.fb_2Mb_chr.regions

## make subtract and complement region bed file using bedtools
## https://ithub.com/davetang/defining_genomic_regions
OUT_BED_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed
REF_PAS_GTF=/home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data/BomPas_GCA_905332965.1/enes.gtf.gz

## self assemblied
REF_VET_GTF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/ene_annotation/braker_BomVet_results_for_protseq/braker.gtf
REF_VET_GTF_new=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/ene_annotation/braker_BomVet_results_for_protseq/braker.new_chr.gtf
## get gene regions
## chr GTF bed file should be less than that of the reference insex file 
less -S $REF_PAS_GTF | awk 'BEGIN{OFS="\t"} {if ($3=="gene") {print $1,$4,$5}}' | sed -e 's/^/chr/' -e '/chrCAJ/d' > $OUT_BED_DIR/BomPas_GCA_905332965.1_gene_region.bed

** $4-1 **
less -S $REF_PAS_GTF | awk 'BEGIN{OFS="\t"} {if ($3=="gene") {print $1,$4-1,$5}}' | sed -e 's/^/chr/' -e '/chrCAJ/d' > $OUT_BED_DIR/BomPas_GCA_905332965.1_gene_region_1.bed


less -S $REF_VET_GTF | awk 'BEGIN{OFS="\t"} {if ($3=="gene") {print $1,$4-1,$5}}' | sed -e 's/^/chr/' -e '/chrCAJ/d' > $OUT_BED_DIR/BomVet_hifi_asm.gene_region_1.bed
# ptg000001l_[Bombuseteranus]     AUGUSTUS        gene 
# ptg000001l     AUGUSTUS        gene 
sed -E 's/_\[Bombus_veteranus\]//' $REF_VET_GTF > $REF_VET_GTF_new

*********************** step II: new added species **************************
## decompress the files, replace _ with |, and compress the files
for gene_gtf in `ls -t | head -3`
do 
    echo $gene_gtf
    gunzip -d $gene_gtf/enes.gtf.gz
    file=$gene_gtf/enes.gtf.gz
    out=${file/enes.gtf.gz/enes.gtf}
    sed -i 's/_/|/' $out
    gzip ./$out
done

cd /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data/BomSyl-GCA_911622165.2/
gunzip -d Bombus_sylvestris-GCA_911622165.2-2023_03-genes.gtf.gz
mv Bombus_sylvestris-GCA_911622165.2-2023_03-genes.gtf genes.gtf
gzip genes.gtf

******* find codes *******
genes_gtf_dir=/home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data
cd $genes_gtf_dir
OUT_BED_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed

#ref_folder=`find . -maxdepth 2 -print | grep 'genes.gtf.gz' | ls -t | head -3`
ref_folder=`find . -maxdepth 2 -print | grep 'genes.gtf.gz' | ls -t | head -28`

for ref in $ref_folder
    do
#    echo ./$ref/enes.gtf.gz
#done
    #less $ref/enes.gtf.gz | head -2
    ## $4-1 beginning pos
    less -S $ref/*genes.gtf.gz | awk 'BEGIN{OFS="\t"} {if ($3=="gene") {print $1,$4-1,$5}}' \
        > $OUT_BED_DIR/"$ref"_gene_region_1.bed
done

***************************

less -S $REF_VET_GTF_new | awk 'BEGIN{OFS="\t"} {if ($3=="gene") {print $1,$4-1,$5}}' \
    > $OUT_BED_DIR/"Bombus_veteranus-hifiasm_gene_region-1.bed"

## check the number of new bed files and replace _ with |
for bed in `ls -t *.bed | head -3`
do sed -i 's/_/|/' $bed
done


************************************ step III: sort order of gene regions ****************************************
## use for loop
conda activate variant_calling_mapping
cd /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data
OUT_BED_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome

REF_list=(
    "./AndHae_GCA_910592295.1/enes.gtf.gz"
    "./AndHat_GCA_944738655.1/enes.gtf.gz"
    "./Amel_HAv3_1/enes.gtf.gz"
    "./BomHyp_GCA_911387925.1/enes.gtf.gz"
    "./BomPas_GCA_905332965.1/enes.gtf.gz"
    "./DroMel-GCF_000001215.4_Release_6_plus_ISO1_MT/enes.gtf.gz"
)

********* chr names in gtf file may differ from those in genome fasta file *********

REF_list=(
    #"./BomMus_alt-GCA_963971125.1/enes.gtf.gz"
    #"./BomSyl-GCA_911622165.2/enes.gtf.gz"
    #"./AndBic-GCA_960531205.1/enes.gtf.gz"

    #"./BomCon-GCA_014737475.1/enes.gtf.gz"
    #"./AndTri-GCA_951215215.1/enes.gtf.gz"
    #"./BomHor-GCA_905332935.1/enes.gtf.gz"
    #"./AndFlu-GCA_946251845.1/enes.gtf.gz"
    #"./AndMar_GCA_963932335.1/enes.gtf.gz"

    # 2025

    #"Aphodius_sticticus-GCA_963966075.1.xxxxxx"
    "./Bombylius_major-GCA_932526495.1/Bombylius_major-GCA_932526495.1-2022_07-genes.gtf.gz"
    "./Cerceris_rybyensis-GCA_910591515.1/Cerceris_rybyensis-GCA_910591515.1-2021_11-genes.gtf.gz"
    #"Ephemera_danica-GCA_000507165.2.fa.fai"
    "./Megachile_leachella-GCA_963576845.1/Megachile_leachella-GCA_963576845.1-2024_04-genes.gtf.gz"
    #"Notonecta_glauca.hifi_asm_pl2.xxxxx"
    "./Ochropleura_plecta-GCA_905475445.1/Ochropleura_plecta-GCA_905475445.1-2021_12-genes.gtf.gz"
    "./Phragmatobia_fuliginosa-GCA_932526445.1/Phragmatobia_fuliginosa-GCA_932526445.1-2022_07-genes.gtf.gz"
    #"./Rutpela_maculata-GCA_936432065.2/Rutpela_maculata-GCA_936432065.2-2023_05-genes.gtf.gz" ## chr names in gtf file differ from those in genome fasta file
    "./Rutpela_maculata-GCA_936432065.2/Rutpela_maculata-GCA_936432065.2-2023_05-issue_modified-genes.gtf.gz"
    #"Stenurella_melanura-GCA_963583905.1.xxxxx"


    #"./Aelia_acuminata-GCA_911387785.2/Aelia_acuminata-GCA_911387785.2-2023_05-genes.gtf.gz"
    #"./Amphimallon_solstitiale-GCA_963170755.1/Amphimallon_solstitiale-GCA_963170755.1-2024_03-genes.gtf.gz"
    #"./Bibio_marci-GCA_910594885.2/Bibio_marci-GCA_910594885.2-2024_05-genes.gtf.gz"
    #"./Dorcus_parallelipipedus-GCA_958336345.1/Dorcus_parallelipipedus-GCA_958336345.1-2024_03-genes.gtf.gz"
    #"./Eristalis_intricaria-GCA_964034865.1/Eristalis_intricaria-GCA_964034865.1-2024_05-genes.gtf.gz"
    #"./Eristalis_pertinax-GCA_907269125.1/Eristalis_pertinax-GCA_907269125.1-2021_12-genes.gtf.gz"
    #"./Gerris_lacustris-GCA_951217055.1/Gerris_lacustris-GCA_951217055.1-2023_07-genes.gtf.gz"
    #"./Lasioglossum_morio-GCA_916610235.2/Lasioglossum_morio-GCA_916610235.2-2022_03-genes.gtf.gz"
    #"./Malachius_bipustulatus-GCA_910589415.1/Malachius_bipustulatus-GCA_910589415.1-2022_02-genes.gtf.gz"
    #"./Noctua_pronuba-GCA_905220335.1/Noctua_pronuba-GCA_905220335.1-2021_12-genes.gtf.gz"
    #"./Phosphuga_atrata-GCA_944588485.1/Phosphuga_atrata-GCA_944588485.1-2022_08-genes.gtf.gz"
    #"./Pterostichus_niger-GCA_947425015.1/Pterostichus_niger-GCA_947425015.1-2024_04-genes.gtf.gz"
    #"./Rhagonycha_fulva-GCA_905340355.1/Rhagonycha_fulva-GCA_905340355.1-2021_12-genes.gtf.gz"
    #"./Tachina_fera-GCA_905220375.1/Tachina_fera-GCA_905220375.1-2021_12-genes.gtf.gz"
    #"./Tholera_decimalis-GCA_943138885.2/Tholera_decimalis-GCA_943138885.2-2023_07-genes.gtf.gz"

)

#echo ${REF_list[*]}
#REF_INDEX_list=(`ls *softmasked.fa.fai`)
## https://superuser.com/questions/121627/how-to-get-elements-from-list-in-bash
List="abcd 1234 jvm something"
set -- $List
echo $2
1234

REF_INDEX_list=(
    "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai"
    "Andrena_hattorfiana-GCA_944738655.1-softmasked.fa.fai"
    "Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa.fai"
    "Bombus_hypnorum-GCA_911387925.1-softmasked.fa.fai"
    "Bombus_pascuorum-GCA_905332965.1-softmasked.fa.fai"
    "Drosophila_melanoganster-GCF_000001215.4_Release_6_plus_ISO1_MT_genomic-softmasked.fa.fai"
)

# 2025
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
ls -t ./*.fai | head -10 | sort -n

REF_INDEX_list=(
    #"Bombus_muscorum-GCA_963971125.1.fa.fai"
    #"Bombus_sylvestris-GCA_911622165.2-softmasked.fa.fai"
    #"Andrena_bicolor-GCA_960531205.1.fa.fai"

    #"Bombus_confusus-GCA_014737475.1_ASM1473747v1-softmasked.fa.fai"
    #"Andrena_trimmerana-GCA_951215215.1-softmasked.fa.fai"
    #"Bombus_hortorum-GCA_905332935.1-softmasked.fa.fai"
    #"Andrena_fulva-GCA_946251845.1-softmasked.fa.fai"
    #"Andrena_marginata_GCA_963932335.1-softmasked.fa.fai"

    # 2025

    #"Aphodius_sticticus-GCA_963966075.1.fa.fai"
    "Bombylius_major-GCA_932526495.1-softmasked.fa.fai"
    "Cerceris_rybyensis-GCA_910591515.1-softmasked.fa.fai"
    #"Ephemera_danica-GCA_000507165.2.fa.fai"
    "Megachile_leachella-GCA_963576845.1-softmasked.fa.fai"
    #"Notonecta_glauca.hifi_asm_pl2.fa.fai"
    "Ochropleura_plecta-GCA_905475445.1-softmasked.fa.fai"
    "Phragmatobia_fuliginosa-GCA_932526445.1-softmasked.fa.fai"
    "Rutpela_maculata-GCA_936432065.2-softmasked.fa.fai"
    #"Stenurella_melanura-GCA_963583905.1.fa.fai"
)

#echo ${REF_INDEX_list[0]}
## Two variables in for-loop
## https://stackoverflow.com/questions/13210880/replace-one-substring-for-another-string-in-shell-script
## https://stackoverflow.com/questions/68358789/using-bash-to-get-two-variables-in-for-loop-form-two-different-lists

*********** gtf chr issue, different from that of fa.fai file (Rutpela_maculata) ***********
cd /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data
## gtf
gtf=/home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data/Rutpela_maculata-GCA_936432065.2/Rutpela_maculata-GCA_936432065.2-2023_05-genes_issue.gtf
modified_gtf=/home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data/Rutpela_maculata-GCA_936432065.2/Rutpela_maculata-GCA_936432065.2-2023_05-issue_modified-genes.gtf
#!genome-date 2022-10
#!genome-build-accession GCA_936432065.2
#!genebuild-last-updated 2023-05
1       ensembl gene    176474031       176475216

## fa.fai
fa_fai=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Rutpela_maculata-GCA_936432065.2-softmasked.fa.fai
OW386285.2	427500052	60	80	81

## fa file
fa=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Rutpela_maculata-GCA_936432065.2-softmasked.fa
>OW386285.2 Rutpela maculata genome assembly, chromosome: 1
>CAKZFB020000001.1 Rutpela maculata genome assembly, contig: SUPER_1_unloc_1, whole genome shotgun sequence
>OW386286.2 Rutpela maculata genome assembly, chromosome: 2
>OW386287.2 Rutpela maculata genome assembly, chromosome: 3
>OW386288.2 Rutpela maculata genome assembly, chromosome: 4
>CAKZFB020000002.1 Rutpela maculata genome assembly, contig: SUPER_4_unloc_1, whole genome shotgun sequence
>OW386289.2 Rutpela maculata genome assembly, chromosome: 5
>OW386290.2 Rutpela maculata genome assembly, chromosome: 6
>OW386291.2 Rutpela maculata genome assembly, chromosome: 7
>OW386292.2 Rutpela maculata genome assembly, chromosome: 8
>OW386293.2 Rutpela maculata genome assembly, chromosome: 9
>OW386294.2 Rutpela maculata genome assembly, chromosome: X

## only replace the number staarting the lines, not greedy way.
sed -e 's/^1\tensembl/OW386285.2\tensembl/' \
    -e 's/^2\tensembl/OW386286.2\tensembl/' \
    -e 's/^3\tensembl/OW386287.2\tensembl/' \
    -e 's/^4\tensembl/OW386288.2\tensembl/' \
    -e 's/^5\tensembl/OW386289.2\tensembl/' \
    -e 's/^6\tensembl/OW386290.2\tensembl/' \
    -e 's/^7\tensembl/OW386291.2\tensembl/' \
    -e 's/^8\tensembl/OW386292.2\tensembl/' \
    -e 's/^9\tensembl/OW386293.2\tensembl/' \
    -e 's/^X\tensembl/OW386294.2\tensembl/' $gtf > $modified_gtf
## compress the gtf file as genes.gtf.gz to be consistent with others
gzip $modified_gtf
## Rutpela_maculata-GCA_936432065.2-2023_05-issue_modified-genes.gtf.gz

# change chr names to  numbers
ref_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
ref=Rutpela_maculata-GCA_936432065.2-softmasked.fa
modified_ref=Rutpela_maculata-GCA_936432065.2-softmasked.chr2no.fa

sed -e 's/^>OW386285.2/1/' \
    -e 's/^>OW386286.2/2/' \
    -e 's/^>OW386287.2/3/' \
    -e 's/^>OW386288.2/4/' \
    -e 's/^>OW386289.2/5/' \
    -e 's/^>OW386290.2/6/' \
    -e 's/^>OW386291.2/7/' \
    -e 's/^>OW386292.2/8/' \
    -e 's/^>OW386293.2/9/' \
    -e 's/^>OW386294.2/X/' $ref > $modified_ref

******** other conditions: https://www.biostars.org/p/313561/

awk  '!/#/ {split($1, a, "_"); $1=a[2]}1'  OFS='\t' test.gtf
cat test.gtf 
##gff-version   null
CA_chr4_BGI-A2_v1.0 GLEAN   mRNA    123284514   123288477   0.999991-   .   ID=Cotton_A_18927_BGI-A2_v1.0;Name=Cotton_A_18927;source_id=CottonA_GLEAN_10022228;identical_support_id=CUFF67.1103.1;evid_id=Cot030308.1
CA_chr4_BGI-A2_v1.0 GLEAN   CDS 123288376   123288477   .   -0  Parent=Cotton_A_18927_BGI-A2_v1.0
CA_chr4_BGI-A2_v1.0 GLEAN   CDS 123287662   123287826   .   -0  Parent=Cotton_A_18927_BGI-A2_v1.0

awk  '!/#/ {split($1, a, "_"); $1=a[2]}1'  OFS='\t' test.gtf
##gff-version   null
chr4    GLEAN   mRNA    123284514   123288477   0.999991-   .   ID=Cotton_A_18927_BGI-A2_v1.0;Name=Cotton_A_18927;source_id=CottonA_GLEAN_10022228;identical_support_id=CUFF67.1103.1;evid_id=Cot030308.1
chr4    GLEAN   CDS 123288376   123288477   .   -0  Parent=Cotton_A_18927_BGI-A2_v1.0


*********** correct codes

for i in ${!REF_list[*]}
    ## input in the same index
    do
    ## "-1" means [start pos - 1]
    #OUT_name=`echo ${REF_list[i]} | sed -e 's/\.\///' -e 's/\/enes.gtf.gz/_gene_region-1.sorted.bed/'`
    OUT_name=`echo ${REF_list[i]} | sed -E 's/\.([12]).*genes.gtf.gz/\.\1-gene_region-1.sorted.bed/'`
    echo $OUT_name
#done
    less ${REF_list[i]} | head -2
    less ${REF_list[i]} | awk 'BEGIN{OFS="\t"} {if ($3=="gene") {print $1,$4-1,$5}}' | \
    bedtools sort -i stdin -g $REF_DIR/${REF_INDEX_list[i]} \
    > $OUT_BED_DIR/$OUT_name
    #| sed -e 's/^/chr/' -e '/chrCAJ/d' \
done

************* following one has problems

conda activate variant_calling_mapping
unset REF_list # remove an environment variable
REF_list=`ls -t ./*/*genes.gtf.gz | head -20 | sort -n`

for REF in `ls -t ./*/*genes.gtf.gz | head -20`
for REF in ${REF_list[*]}
    #do echo $REF
    do
    OUT_name=`echo $REF| sed -e 's/\.\/.*\///'
    #-e 's/enes.gtf.gz/ene_region-1.sorted.bed/'`
    echo $OUT_name
done
    echo $REF
    less $REF | awk 'BEGIN{OFS="\t"} {if ($3=="gene") {print $1,$4-1,$5}}' | \
    bedtools sort -i stdin -g $REF_DIR/${REF_INDEX_list[i]} \
    > $OUT_BED_DIR/$OUT_name
    #| sed -e 's/^/chr/' -e '/chrCAJ/d' \
done

done

for i in ${REF_list[*]}
    ## input in the same index
    do
    ## "-1" means [start pos - 1]
    OUT_name=`echo ${REF_list[i]} | sed -e 's/\.\///' -e 's/\/enes.gtf.gz/_gene_region-1.sorted.bed/'`
    echo $OUT_name
    echo ${REF_list[i]}
    less ${REF_list[i]} | awk 'BEGIN{OFS="\t"} {if ($3=="gene") {print $1,$4-1,$5}}' | \
    bedtools sort -i stdin -g $REF_DIR/${REF_INDEX_list[i]} \
    > $OUT_BED_DIR/$OUT_name
    #| sed -e 's/^/chr/' -e '/chrCAJ/d' \
done

## issue file
AndTri_bed=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed/AndTri-GCA_951215215.1_gene_region_1.bed
New_AndTri_bed=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed/AndTri-GCA_951215215.1_gene_region-1.sorted.new.bed

1	95256240	95263261
1	26469674	26471721
1	95225018	95228410

AndTri_fa_fai=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Andrena_trimmerana-GCA_951215215.1-softmasked.fa.fai

ENA|OX578059|OX578059.1	142895829	75	60	61
ENA|OX578060|OX578060.1	91870870	145277577	60	61
ENA|OX578061|OX578061.1	39856278	238679704	60	61
ENA|OX578062|OX578062.1	39551669	279200329	60	61
ENA|OX578063|OX578063.1	29784559	319411268	60	61
ENA|OX578064|OX578064.1	19771	349692323	60	61

replace the same numbers in the first column from a text file with the strings in the first column from a second file

first file

1	95256240	95263261
1	26469674	26471721
2	95225018	952284101
2	26469674	26471721
3	95225018	952284101
3	26469674	26471721
3	95225018	95228410

second file

OX578059.1
OX578060.1
OX578061.1

## test: replace number chr with long string
awk '$1 < 2 {print}' $AndTri_bed
awk 'OFS="\t"{if ($1 == 1) print $1="ENA|OX578059|OX578059.1",$2,$3}' $AndTri_bed

list2=(
    "ENA|OX578059|OX578059.1"
    "ENA|OX578060|OX578060.1"
    "ENA|OX578061|OX578061.1"
    "ENA|OX578061|OX578062.1"
    "ENA|OX578061|OX578063.1"
    "ENA|OX578061|OX578064.1"
)

# Loop over indices of list2
for x in "${!list2[@]}"; do
    
    # Use awk to modify lines based on condition
    awk -v i="$x" -v value="${list2[i]}" 'BEGIN {OFS="\t"} $1 == i + 1 { $1=value; print }' "$AndTri_bed"
done

for x in `echo ${!list2[*]}`
    do
    #echo $i ${list2[i]}
    awk -v i="$x" -v value="${list2[i]}" 'OFS="\t"{ if ($1 == i + 1) print $1=value,$2,$3 }' $AndTri_bed
done

## correct
for x in "${!list2[@]}"
do
    awk -v i="$x" -v value="${list2[$x]}" 'BEGIN { OFS="\t" } { if ($1 == i + 1) print value, $2, $3 }' "$AndTri_bed" >> $New_AndTri_bed
done

**************************************************************************************************
## Separate step
## sort the gene region according to reference genome
REF_PAS_INDEX=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/iyBomPasc1_1.md_chr.fa.fai
#bedtools sort -i $OUT_BED_DIR/BomPas_GCA_905332965.1_gene_region.bed -g $REF_PAS_INDEX >  $OUT_BED_DIR/BomPas_GCA_905332965.1_gene_region.sorted.bed
bedtools sort -i $OUT_BED_DIR/BomPas_GCA_905332965.1_gene_region_1.bed -g $REF_PAS_INDEX >  $OUT_BED_DIR/BomPas_GCA_905332965.1_gene_region_1.sorted.bed


less BomPas_GCA_905332965.1_gene_region.sorted.bed
chr1	37527	46635
chr1	47716	72086
chr1	54364	55765
## [start pos - 1]
less BomPas_GCA_905332965.1_gene_region_1.sorted.bed
chr1	37526	46635
chr1	47715	72086
chr1	54363	55765

## make the same chromosome names (optional)
REF_MASKED_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed
less Bombus_pascuorum-GCA_905332965.1-softmasked.bed
1	0	32253
1	32258	32265
1	32485	32514
REF_PAS_softmasked_region=Bombus_pascuorum-GCA_905332965.1-softmasked.bed
sed 's/^/chr/' $REF_MASKED_DIR/$REF_PAS_softmasked_region > $REF_MASKED_DIR/Bombus_pascuorum-GCA_905332965.1-softmasked_chr_name.bed

chr1	0	32253
chr1	32258	32265
chr1	32485	32514
...
chr1	36940	36982
chr1	37326	37365
chr1	37845	37879
chr1	38011	38049

## gene regions can be concated to the softmasked regions and used as input to freebayes
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed
cat BomPas_GCA_905332965.1_gene_region_1.sorted.bed Bombus_pascuorum-GCA_905332965.1-softmasked_chr_name.bed | \
    bedtools sort | bedtools merge -i - > BomPas_GCA_905332965.1_gene_region_1.softmasked_chr_name.sorted.bed
    
    | less 

chr1    0       32253
chr1    32258   32265
chr1    32485   32514
....
chr1    36940   36982
chr1    37326   37365
chr1    37526   46635

**************************************** final step III: softmasked + genic regions that will be excluded *********************************************
## for loop: to prepare softmask+gene region bed
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed
OUT_BED_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed
REF_gene_region_list=(
    #"BomMus_alt-GCA_963971125.1_gene_region-1.sorted.bed"
    #"BomSyl-GCA_911622165.2_gene_region-1.sorted.bed"
    #"AndBic-GCA_960531205.1_gene_region-1.sorted.bed"

    #"Bombus_veteranus-hifiasm_gene_region-1.bed"
    
    #"AndTri-GCA_951215215.1_gene_region-1.sorted.new.bed"
    #"AndFlu-GCA_946251845.1_gene_region-1.sorted.bed"
    #"BomHor-GCA_905332935.1_gene_region-1.sorted.bed"
    #"BomCon-GCA_014737475.1_gene_region-1.sorted.bed"
    #"AndMar_GCA_963932335.1_gene_region-1.sorted.bed"
    #"Amel_HAv3_1_gene_region-1.sorted.bed"
    #"AndHae_GCA_910592295.1_gene_region-1.sorted.bed"
    #"AndHat_GCA_944738655.1_gene_region-1.sorted.bed"
    #"BomHyp_GCA_911387925.1_gene_region-1.sorted.bed"
    #"BomPas_GCA_905332965.1_gene_region-1.sorted.bed"
    #"DroMel_GCF_000001215.4_Release_6_plus_ISO1_MT_gene_region-1.sorted.bed"

    # 2025

    #"Bombylius_major-GCA_932526495.1-gene_region-1.sorted.bed"
    "Cerceris_rybyensis-GCA_910591515.1-gene_region-1.sorted.bed"
    "Megachile_leachella-GCA_963576845.1-gene_region-1.sorted.bed"
    #"Ochropleura_plecta-GCA_905475445.1-gene_region-1.sorted.bed"
    #"Phragmatobia_fuliginosa-GCA_932526445.1-gene_region-1.sorted.bed"
    "Rutpela_maculata-GCA_936432065.2-gene_region-1.sorted.bed"

)

#ls -t *masked.bed | head -3
#Bombus_muscorum-GCA_963971125.1-softmasked.bed
#Bombus_sylvestris-GCA_911622165.2-softmasked.bed
#Andrena_bicolor-GCA_960531205.1-softmasked.bed

REF_softmasked_region_list=(

    #"Bombus_muscorum-GCA_963971125.1-softmasked.bed"
    #"Bombus_sylvestris-GCA_911622165.2-softmasked.bed"
    #"Andrena_bicolor-GCA_960531205.1-softmasked.bed"

    #"Bombus_veteranus.hifi_asm_pl2-softmasked.bed"
    
    #"Andrena_trimmerana-GCA_951215215.1-softmasked.bed"
    #"Andrena_fulva-GCA_946251845.1-softmasked.bed"
    #"Bombus_hortorum-GCA_905332935.1-softmasked.bed"
    #"Bombus_confusus-GCA_014737475.1_ASM1473747v1-softmasked.bed"
    #"Andrena_marginata_GCA_963932335.1-softmasked.bed"
    #"Amel_HAv-GCF_003254395.2-softmasked.bed"
    #"Andrena_haemorrhoa-GCA_910592295.1-softmasked.bed"
    #"Andrena_hattorfiana-GCA_944738655.1-softmasked.bed"
    #"Bombus_hypnorum-GCA_911387925.1-softmasked.bed"
    #"Bombus_pascuorum-GCA_905332965.1-softmasked.bed"
    #"Drosophila_melanoganster-GCF_000001215.4_Release_6_plus_ISO1_MT_genomic-softmasked.bed"

    # 2025
    
    "Cerceris_rybyensis-GCA_910591515.1-softmasked.bed"
    "Megachile_leachella-GCA_963576845.1-softmasked.bed"
    "Rutpela_maculata-GCA_936432065.2-softmasked.bed"


)

for i in ${!REF_gene_region_list[*]}
    ## input in the same index
    do
    REF_softmasked_region=${REF_softmasked_region_list[i]}

    ## use var as an agent in the substition expression
    OUT_name=${REF_softmasked_region/.bed/_ref_gene.conca_sorted.bed}

    #echo $OUT_name
    #echo ${REF_gene_region_list[i]} $REF_softmasked_region
    cat ${REF_gene_region_list[i]} $REF_softmasked_region | \
    bedtools sort | bedtools merge -i - > $OUT_BED_DIR/$OUT_name
done

*****************************************************************
## get intergenic regions
bedtools sort -i $OUT_BED_DIR/BomPas_GCA_905332965.1_intergenic_region.bed \
    -g $REF_PAS_INDEX | bedtools complement -i stdin -g $REF_PAS_INDEX | less |
    gzip > my_intergenic.bed.gz

## get mappability regions
bedtools sort -i $OUT_BED_DIR/BomPas_GCA_905332965.1_intergenic_region.bed \
    -g $REF_PAS_INDEX | 

conda activate variant_calling_mapping
ref_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
ref_pas_softmask_bed=$ref_dir/ref_masked_bed/Bombus_pascuorum-GCA_905332965.1-softmasked.bed
ref_hae_softmask_bed=$ref_dir/ref_masked_bed/Andrena_haemorrhoa-GCA_910592295.1-softmasked.bed
REF_PAS_INDEX=$ref_dir/Bombus_pascuorum-GCA_905332965.1-softmasked.fa.fai
REF_HAE_INDEX=$ref_dir/Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai
output_mappability_bed=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed

cd $output_mappability_bed
bedtools complement -i $ref_pas_softmask_bed -g $REF_PAS_INDEX | less |
    gzip > $output_mappability_bed/mappability_pas.bed.gz
bedtools complement -i $ref_hae_softmask_bed -g $REF_HAE_INDEX | less |
    gzip > $output_mappability_bed/mappability_hae.bed.gz



