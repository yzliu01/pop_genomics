## create masked reference genome bed file in two steps
## https://www.danielecook.com/generate-a-bedfile-of-masked-ranges-a-fasta-file/

## I - replace bases in lowercase into N
softmasked_genome_Amel=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Amel_HAv3_1.fa
*********
less -S .
>NC_037638.1 Apis mellifera strain DH4 linkage group LG1, Amel_HAv3.1, whole genome shotgun sequence
GAGAGAATTAACTACCTTAACCTGAACCTAAACCTACCGATAACCTAACTCTAAACTATACCTTTAACCCCTAAACCCTA (80)
CACCTAAGTCCTAAACCAATAACCTTAACCCTAACAACTATATAAAACACTAACCTATAACCTAATCCCCTAACTACTAA (160)
ActactaacctaacctaaaactatatacctaacctaaaccttaCCCTAACCATAACCTATTACTCTAACCCTACCAAGAG
*********
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
generate_masked_region_md_py=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/1_create_ref_genome_mask_regions/generate_masked_region_md.py

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
## get softmasked regions (final)

** Andrena marginata and more species **
#for masked_ref in `ls Andrena_marginata_GCA_963932335.1-softmasked.fa`
for masked_ref in `ls -t *-softmasked.fa | head -4`
    do
    out_softmasked_genome=${masked_ref/.fa/}
    grep -v "^>"tr $masked_ref | tr "[atcg]" "N" > $out_softmasked_genome.N.fa
    python $generate_masked_region_md_py $out_softmasked_genome.N.fa > ./ref_masked_bed/$out_softmasked_genome.bed
done



************************************** obtain gene regions *******************************************
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
## https://github.com/davetang/defining_genomic_regions
OUT_BED_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed
REF_PAS_GTF=/home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data/BomPas_GCA_905332965.1/genes.gtf.gz

## get gene regions
## chr GTF bed file should be less than that of the reference insex file 
less -S $REF_PAS_GTF | awk 'BEGIN{OFS="\t"} {if ($3=="gene") {print $1,$4,$5}}' | sed -e 's/^/chr/' -e '/chrCAJ/d' > $OUT_BED_DIR/BomPas_GCA_905332965.1_gene_region.bed

** $4-1 **
less -S $REF_PAS_GTF | awk 'BEGIN{OFS="\t"} {if ($3=="gene") {print $1,$4-1,$5}}' | sed -e 's/^/chr/' -e '/chrCAJ/d' > $OUT_BED_DIR/BomPas_GCA_905332965.1_gene_region_1.bed

** new added species **
genes_gtf_dir=/home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data
cd $genes_gtf_dir
OUT_BED_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed

ref_folder=`find . -maxdepth 2 -print | grep 'genes.gtf.gz' | ls -t | head -4`

for ref in $ref_folder
    do
#    echo ./$ref/genes.gtf.gz
#done
    #less $ref/genes.gtf.gz | head -2
    ## $4-1 beginning pos
    less -S $ref/genes.gtf.gz | awk 'BEGIN{OFS="\t"} {if ($3=="gene") {print $1,$4-1,$5}}' \
        > $OUT_BED_DIR/"$ref"_gene_region_1.bed
done


************************************ step II: sort order of gene regions ****************************************
## use for loop
conda activate variant_calling_mapping
cd /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data

OUT_BED_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed

REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome

REF_list=(
    "./AndHae_GCA_910592295.1/genes.gtf.gz"
    "./AndHat_GCA_944738655.1/genes.gtf.gz"
    "./Amel_HAv3_1/genes.gtf.gz"
    "./BomHyp_GCA_911387925.1/genes.gtf.gz"
    "./BomPas_GCA_905332965.1/genes.gtf.gz"
    "./DroMel-GCF_000001215.4_Release_6_plus_ISO1_MT/genes.gtf.gz"
)
REF_list=(
    "./BomCon-GCA_014737475.1/genes.gtf.gz"
    "./AndTri-GCA_951215215.1/genes.gtf.gz"
    "./BomHor-GCA_905332935.1/genes.gtf.gz"
    "./AndFlu-GCA_946251845.1/genes.gtf.gz"
    #"./AndMar_GCA_963932335.1/genes.gtf.gz"
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

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
ls -t ./*.fai | head -4

REF_INDEX_list=(
    "Bombus_confusus-GCA_014737475.1_ASM1473747v1-softmasked.fa.fai"
    "Andrena_trimmerana-GCA_951215215.1-softmasked.fa.fai"
    "Bombus_hortorum-GCA_905332935.1-softmasked.fa.fai"
    "Andrena_fulva-GCA_946251845.1-softmasked.fa.fai"
    #"Andrena_marginata_GCA_963932335.1-softmasked.fa.fai"
)
#echo ${REF_INDEX_list[0]}
## Two variables in for-loop
## https://stackoverflow.com/questions/13210880/replace-one-substring-for-another-string-in-shell-script
## https://stackoverflow.com/questions/68358789/using-bash-to-get-two-variables-in-for-loop-form-two-different-lists
cd /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data

***********

for i in ${!REF_list[*]}
    ## input in the same index
    do
    ## "-1" means [start pos - 1]
    OUT_name=`echo ${REF_list[i]} | sed -e 's/\.\///' -e 's/\/genes.gtf.gz/_gene_region-1.sorted*.bed/'`
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

**************************************** final step III: softmasked + genic regions *********************************************
## for loop: to prepare softmask+gene region bed
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed
OUT_BED_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed
REF_gene_region_list=(
    "AndTri-GCA_951215215.1_gene_region-1.sorted.new.bed"
    "AndFlu-GCA_946251845.1_gene_region-1.sorted.bed"
    "BomHor-GCA_905332935.1_gene_region-1.sorted.bed"
    "BomCon-GCA_014737475.1_gene_region-1.sorted.bed"
    #"AndMar_GCA_963932335.1_gene_region-1.sorted.bed"
    #"Amel_HAv3_1_gene_region-1.sorted.bed"
    #"AndHae_GCA_910592295.1_gene_region-1.sorted.bed"
    #"AndHat_GCA_944738655.1_gene_region-1.sorted.bed"
    #"BomHyp_GCA_911387925.1_gene_region-1.sorted.bed"
    #"BomPas_GCA_905332965.1_gene_region-1.sorted.bed"
    #"DroMel_GCF_000001215.4_Release_6_plus_ISO1_MT_gene_region-1.sorted.bed"
)

REF_softmasked_region_list=(
    "Andrena_trimmerana-GCA_951215215.1-softmasked.bed"
    "Andrena_fulva-GCA_946251845.1-softmasked.bed"
    "Bombus_hortorum-GCA_905332935.1-softmasked.bed"
    "Bombus_confusus-GCA_014737475.1_ASM1473747v1-softmasked.bed"
    #"Andrena_marginata_GCA_963932335.1-softmasked.bed"
    #"Amel_HAv-GCF_003254395.2-softmasked.bed"
    #"Andrena_haemorrhoa-GCA_910592295.1-softmasked.bed"
    #"Andrena_hattorfiana-GCA_944738655.1-softmasked.bed"
    #"Bombus_hypnorum-GCA_911387925.1-softmasked.bed"
    #"Bombus_pascuorum-GCA_905332965.1-softmasked.bed"
    #"Drosophila_melanoganster-GCF_000001215.4_Release_6_plus_ISO1_MT_genomic-softmasked.bed"
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



