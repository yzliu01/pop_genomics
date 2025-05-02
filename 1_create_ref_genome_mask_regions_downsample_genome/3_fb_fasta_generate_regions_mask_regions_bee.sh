#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 2
#SBATCH --mem 40g
#SBATCH --time=08:14:00
#SBATCH --error=fb_cov2region_dro_mel.%A_%a.e.txt
#SBATCH --output=fb_cov2region_dro_mel.%A_%a.o.txt
##SBATCH --output=dro_mel_variant_fb_calling.%A_%a.o.txt
#SBATCH --job-name=fb_cov2region_dro_mel
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification


REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
#REF_Index=$REF/D_melanogaster.7509v1.md_chr.fa.fai
#BAM=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate
#OUT_DIR=$REF/fb_cov2region_dro_mel
OUT_DIR=$REF/fasta_generate_regions

#mkdir $REF/fb_cov2region_dro_mel

## install freebayes
##https://github.com/freebayes/freebayes/tree/master/scripts
#conda install -c bioconda freebayes=1.3.6 vcflib=1.0.3 tabixpp=1.1.0

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping
## one example bam file
#EXAMPLE_BAM=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate/SRR24680763.sort.bam
#EXAMPLE_BAM=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate/test_sort1/SRR24680726.sort.bam
EXAMPLE_BAM=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate/test_sort/SRR24680726.sort.bam.mark_dups.bam
## job submission folder
JOB_SUB_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/job_submittion
cd $JOB_SUB_DIR

## estimate coverage of a bam file
#bamtools coverage -in $EXAMPLE_BAM | coverage_to_regions.py $REF/D_melanogaster.7509v1.md_chr.fa.fai 500 > $OUT_DIR/D_melanogaster.7509v1.md_chr.fa.500.regions

## reference genome fasta_generate_regions
cd $OUT_DIR
fasta_generate_regions.py $REF/D_melanogaster.7509v1.md_chr.fa 10000 > $OUT_DIR/D_melanogaster.7509v1.md_chr.fa.10kbp.regions.fb
fasta_generate_regions.py $REF/D_melanogaster.7509v1.md_chr.fa 100000 > $OUT_DIR/D_melanogaster.7509v1.md_chr.fa.100kbp.regions.fb

## create genomic regions for all ref
## https://unix.stackexchange.com/questions/450944/bash-loop-through-list-of-strings#:~:text=1%20You%20can%20loop%20over%20a%20list%20of,%22more%20with%20spaces%22%3B%20do%20echo%20%22%27%24%20%7Bitem%7D%27%22%20done
cd $OUT_DIR
for ref in "Amel_HAv3_1.md_chr.fa" "iyAndHaem1_1.md_chr.fa" "iyAndHatt_8785v1_2.md_chr.fa" "iyBomHypn_7925v1_2.md_chr.fa" "iyBomPasc1_1.md_chr.fa";
    #do echo -e "$ref \n";
    do fasta_generate_regions.py $REF/$ref 10000 > $OUT_DIR/$ref.10kbp.regions.fb;
done

for i in {a,b,c,d}
    do echo $i
done 

## split long chromosomes into 60 small chunks
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
REF_BomHypn=$REF_DIR/iyBomHypn_7925v1_2.md_chr.fa
REF_BomPas=$REF_DIR/iyBomPasc1_1.md_chr.fa
REF_AndHae=$REF_DIR/iyAndHaem1_1.md_chr.fa
REF_AndHat=$REF_DIR/iyAndHatt_8785v1_2.md_chr.fa
REF_ApisMel=$REF_DIR/Amel_HAv3_1.md_chr.fa

OUT_DIR_CHUNK=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/fasta_generate_regions/chr_chunks
OUT_DIR_REGION=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/fasta_generate_regions/chr_regions
fasta_generate_regions=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/fasta_generate_regions
OUT_DIR_CHUNK_BomHypn=$OUT_DIR/BomHypn
OUT_DIR_CHUNK_BomPas=$OUT_DIR/BomPas
OUT_DIR_CHUNK_AndHae=$OUT_DIR/AndHae
OUT_DIR_CHUNK_ApisMel=$OUT_DIR/ApisMel

OUT_DIR_region_BomHyp=$OUT_DIR_REGION/BomHyp
OUT_DIR_region_BomPas=$OUT_DIR_REGION/BomPas
OUT_DIR_region_AndHae=$OUT_DIR_REGION/AndHae
OUT_DIR_region_AndHat=$OUT_DIR_REGION/AndHat
OUT_DIR_region_ApisMel=$OUT_DIR_REGION/ApisMel

#fasta_generate_regions.py $REF_BomHypn --chunks 20 \
#    --chromosomes chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 \
#    > $OUT_DIR/iyBomHypn_7925v1_2.md_chr.fa.chr1_12to6_20chunks.fb

fasta_generate_regions.py $REF_BomHypn --chunks 60 \
    --chromosomes chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 \
    > $OUT_DIR_CHUNK_BomHypn/iyBomHypn_7925v1_2.md_chr.fa.chr1_12to60_chunks.fb

fasta_generate_regions.py $REF_BomPas --chunks 60 \
    --chromosomes chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 \
    > $OUT_DIR_CHUNK_BomPas/iyBomPasc1_1.md_chr.fa.chr1_17to60_chunks.fb

fasta_generate_regions.py $REF_AndHae --chunks 60 \
    --chromosomes chr1 chr2 chr3 chr4 chr5 chr6 chr7 \
    > $OUT_DIR_CHUNK_AndHae/iyAndHaem1_1.md_chr.fa.chr1_7to60_chunks.fb

fasta_generate_regions.py $REF_ApisMel --chunks 60 \
    --chromosomes LG1 LG2 LG3 LG4 LG5 LG6 LG7 LG8 LG9 LG10 LG11 LG12 LG13 LG14 LG15 LG16 \
    > $OUT_DIR_CHUNK_ApisMel/Amel_HAv3_1.md_chr.fa.chr1_16to60_chunks.fb

## new Ref-softmasked-no-modification
Pas_Ref_New=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_pascuorum-GCA_905332965.1-softmasked.fa

Regions_New=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/fasta_generate_regions/chr_regions
## spilt fast into N length pieces
fasta_generate_regions.py $Pas_Ref_New 2000000 > $Regions_New/Pas_New.fb_2Mb.regions

for Ref_New in `ls *-softmasked.fa`
    do
    Out_Region_Name=${Ref_New/.fa/.fb_2Mb.regions}
    fasta_generate_regions.py $Ref_New 2000000 > $Regions_New/$Out_Region_Name
done

## final plan
for Ref_New in `ls *-softmasked.fa`
    do
    Out_Region_Name=${Ref_New/.fa/.fb_100kb.regions}
    fasta_generate_regions.py $Ref_New 100000 > $Regions_New/$Out_Region_Name
done

## AndMar
for Ref_New in `ls Andrena_marginata*-softmasked.fa`
    do
    Out_Region_Name=${Ref_New/.fa/.fb_100kb.regions}
    fasta_generate_regions.py $Ref_New 100000 > $Regions_New/$Out_Region_Name
done
## count=2976 segments

conda activate variant_calling_mapping
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
Regions_New=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/fasta_generate_regions/chr_regions

REF_list=(
            #"Andrena_fulva-GCA_946251845.1-softmasked.fa"
            #"Andrena_trimmerana-GCA_951215215.1-softmasked.fa"
            #"Bombus_hortorum-GCA_905332935.1-softmasked.fa"
            #"Bombus_hortorum-GCA_905332935.1-softmasked.fa"
            #"Bombus_confusus-GCA_014737475.1_ASM1473747v1-softmasked.fa"
            #"Bombus_confusus-GCA_014737475.1_ASM1473747v1-softmasked.fa"
            #"Bombus_muscorum-GCA_963971185.1.fa"
            #"Andrena_bicolor-GCA_960531205.1.fa"
            #"Bombus_sylvestris-GCA_911622165.2-softmasked.fa"
            "Bombus_veteranus.hifi_asm_pl2.fa"
            )
## need to index reference genomes before run the genome split

REF_list=(
## hifi_asm - self assemblies
# first 10 ref
    #"Aphodius_sticticus-GCA_963966075.1.fa"
    #"Stenurella_melanura-GCA_963583905.1.fa"
    #"Phragmatobia_fuliginosa-GCA_932526445.1-softmasked.fa"
    #"Megachile_leachella-GCA_963576845.1-softmasked.fa"
    #"Ochropleura_plecta-GCA_905475445.1-softmasked.fa"
    #"Cerceris_rybyensis-GCA_910591515.1-softmasked.fa"
    #"Bombylius_major-GCA_932526495.1-softmasked.fa"
    #"Ephemera_danica-GCA_000507165.2.fa"
    #"Rutpela_maculata-GCA_936432065.2-softmasked.fa"
    ##"Notonecta_glauca.hifi_asm_pl2.fa"
    "Notonecta_glauca.hifi_asm_pl3.fa.masked"

# rest ref 23
    Chorthippus_brunneus.hifi_asm_pl3.fa.masked
    Chorthippus_parallelus.hifi_asm_pl3.fa.masked
    Agelastica_alni-GCA_950111635.2.fa.masked

    Amphimallon_solstitiale-GCA_963170755.1-softmasked.fa
    Dorcus_parallelipipedus-GCA_958336345.1-softmasked.fa
    Malachius_bipustulatus-GCA_910589415.1-softmasked.fa
    Phosphuga_atrata-GCA_944588485.1-softmasked.fa
    Pterostichus_niger-GCA_947425015.1-softmasked.fa
    Rhagonycha_fulva-GCA_905340355.1-softmasked.fa

    Lasioglossum_morio-GCA_916610235.2-softmasked.fa
    Panurgus_banksianus.hifi_asm_pl3.fa.masked

    Bibio_marci-GCA_910594885.2-softmasked.fa
    Eristalis_intricaria-GCA_964034865.1-softmasked.fa
    Eristalis_pertinax-GCA_907269125.1-softmasked.fa
    Tachina_fera-GCA_905220375.1-softmasked.fa

    Aelia_acuminata-GCA_911387785.2-softmasked.fa
    Gerris_lacustris-GCA_951217055.1-softmasked.fa
    Leptopterna_dolobrata-GCA_954871275.1.fa.masked

    Noctua_pronuba-GCA_905220335.1-softmasked.fa

    Tholera_decimalis-GCA_943138885.2.fa.masked
    Xestia_c-nigrum-GCA_916618015.1.fa.masked

    Mystacides_longicornis-GCA_963576905.1.fa.masked

# Crustaces
    Porcellio_scaber-GCA_034700385.1.fa.masked
)

for Ref_New in `ls -t *-softmasked.fa | head -4`
for Ref_New in `ls Bombus_muscorum-GCA_963971125.1.fa`
for Ref_New in `ls Bombus_veteranus.hifi_asm_pl2.fa`

# 10 new pools in Jan 2025
for Ref_New in ${REF_list[@]}
    do
    #echo $Ref_New
#done
    Out_Region_Name=${Ref_New/.fa/.fb_100kb.regions}
    fasta_generate_regions.py $Ref_New 100000 > $Regions_New/$Out_Region_Name
done



## check number of regions
less $Regions_New/Bombus_veteranus.hifi_asm_pl2.fb_100kb.regions | wc -l
3979

##
AndHat_Ref_Regions=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/fasta_generate_regions/chr_regions/Andrena_hattorfiana-GCA_944738655.1-softmasked.fb_2Mb.regions
1:0-2000000
1:2000000-4000000
1:4000000-6000000
1:6000000-8000000

ApisMel_Ref_Regions=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/fasta_generate_regions/chr_regions/Apis_mellifera_HAv-GCF_003254395.2-softmasked.fb_2Mb.regions
## chr name in the region bed file
head $ApisMel_Ref_Regions
NC_037638.1:0-2000000
NC_037638.1:2000000-4000000
NC_037638.1:4000000-6000000
NC_037638.1:6000000-8000000
## the chr name in fasta file for ApisMel
less -S /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa
>NC_037638.1 Apis mellifera strain DH4 linkage group LG1, Amel_HAv3.1, whole genome shotgun sequence




# 10 0r 32 pools
for region in $(ls ./fasta_generate_regions/chr_regions/*.regions* -t | head -24 | sort)
do
# head -2 $region
# Extract filename without the path
#file_name=${region/"./fasta_generate_regions/chr_regions/"/}
file_name=${region/\.\/fasta_generate_regions\/chr_regions\//}
#printf "$file_name\t"
#count=`wc -l $region`

#output=${count/"./fasta_generate_regions/chr_regions/"/}
#echo $output

# a bit more neat
# Print line count and filename
awk -v file="$file_name" 'END{print NR "\t" file}' "$region"
#count=`awk 'END{print NR}' $region`
#printf "$count \t $file_name \n"
done

${region##*/}
# Breakdown of ${region##*/}:

    ${region}:
    Refers to the value of the variable region.

    ##:
    This is a shell pattern-matching operator. The ## variant removes the longest match of the specified pattern from the beginning of the string.

    */:
    The pattern to be matched. Here:
        * matches any sequence of characters (zero or more).
        / ensures the match stops at the last /.
# results
6327     Aphodius_sticticus-GCA_963966075.1.fb_100kb.regions 
3122     Bombylius_major-GCA_932526495.1-softmasked.fb_100kb.regions 
4567     Cerceris_rybyensis-GCA_910591515.1-softmasked.fb_100kb.regions 
11842    Ephemera_danica-GCA_000507165.2.fb_100kb.regions 
5876     Megachile_leachella-GCA_963576845.1-softmasked.fb_100kb.regions 
14281    # Notonecta_glauca.hifi_asm_pl2.fb_100kb.regions 
6458     Ochropleura_plecta-GCA_905475445.1-softmasked.fb_100kb.regions 
6311     Phragmatobia_fuliginosa-GCA_932526445.1-softmasked.fb_100kb.regions 
20308    Rutpela_maculata-GCA_936432065.2-softmasked.fb_100kb.regions 
16283    Stenurella_melanura-GCA_963583905.1.fb_100kb.regions

# rest ref 24
11745   Aelia_acuminata-GCA_911387785.2-softmasked.fb_100kb.regions
7005    Agelastica_alni-GCA_950111635.2.fb_100kb.regions.masked
16121   Amphimallon_solstitiale-GCA_963170755.1-softmasked.fb_100kb.regions
3402    Bibio_marci-GCA_910594885.2-softmasked.fb_100kb.regions
160301  Chorthippus_brunneus.hifi_asm_pl3.fb_100kb.regions.masked # very long
148664  Chorthippus_parallelus.hifi_asm_pl3.fb_100kb.regions.masked # very long
4774    Dorcus_parallelipipedus-GCA_958336345.1-softmasked.fb_100kb.regions
6045    Eristalis_intricaria-GCA_964034865.1-softmasked.fb_100kb.regions
4958    Eristalis_pertinax-GCA_907269125.1-softmasked.fb_100kb.regions
9432    Gerris_lacustris-GCA_951217055.1-softmasked.fb_100kb.regions
6135    Lasioglossum_morio-GCA_916610235.2-softmasked.fb_100kb.regions
10107   Leptopterna_dolobrata-GCA_954871275.1.fb_100kb.regions.masked
5472    Malachius_bipustulatus-GCA_910589415.1-softmasked.fb_100kb.regions
6673    Mystacides_longicornis-GCA_963576905.1.fb_100kb.regions.masked
5317    Noctua_pronuba-GCA_905220335.1-softmasked.fb_100kb.regions
13243   # Notonecta_glauca.hifi_asm_pl3.fb_100kb.regions.masked
4788    Panurgus_banksianus.hifi_asm_pl3.fb_100kb.regions.masked
12353   Phosphuga_atrata-GCA_944588485.1-softmasked.fb_100kb.regions
455076  Porcellio_scaber-GCA_034700385.1.fb_100kb.regions.masked # fragmented ref
6837    Pterostichus_niger-GCA_947425015.1-softmasked.fb_100kb.regions
4254    Rhagonycha_fulva-GCA_905340355.1-softmasked.fb_100kb.regions
7525    Tachina_fera-GCA_905220375.1-softmasked.fb_100kb.regions
13390   Tholera_decimalis-GCA_943138885.2.fb_100kb.regions.masked
7630    Xestia_c-nigrum-GCA_916618015.1.fb_100kb.regions.masked

## use this in freebayes for each region
## print the first line
Each_Region_And_Hat_Ref=$(cat $And_Hat_Ref_Regions | sed -n 1p)
## each line depending on task ID
Each_Region_And_Hat_Ref=$(cat $And_Hat_Ref_Regions | sed -n ${SLURM_ARRAY_TASK_ID}p)


**************************************************************************************
## create individual chr fb
for chr in `cut -d ":" -f 1 $OUT_DIR/iyBomHypn_7925v1_2.md_chr.fa.chr1_12to6_chunks.fb`;do
    for order in {1..6};do
        grep "$chr" $OUT_DIR/iyBomHypn_7925v1_2.md_chr.fa.chr1_12to6_chunks.fb > $OUT_DIR/iyBomHypn_7925v1_2.md_chr.fa.chr1_12to6_chunks."$chr"_"$order".fb;
    done
done


ls iy*_40chunks.*[0-9]fb | xargs rm
ls iy*60chunks.*[0-9].fb | xargs rm

## split fb file into multiple files with 10 lines in each, 6 files for each long chr
split -l 10  $OUT_DIR/iyBomHypn_7925v1_2.md_chr.fa.chr1_12to60_chunks.fb $OUT_DIR/iyBomHypn_7925v1_2.md_chr.fa.chr1_12to60_chunks. --numeric-suffixes=1 --additional-suffix=.fb
/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/fasta_generate_regions/Amel_HAv3_1.md_chr.fa.10kbp.regions.fb

split -l 300  $fasta_generate_regions/Amel_HAv3_1.md_chr.fa.10kbp.regions.fb \
    $OUT_DIR_region_ApisMel/Amel_HAv3_1.md_chr.fa.10kbp.regions. \
    --numeric-suffixes=1 --additional-suffix=.fb

split -l 300  $fasta_generate_regions/iyAndHaem1_1.md_chr.fa.10kbp.regions.fb \
    $OUT_DIR_region_AndHae/iyAndHaem1_1.md_chr.fa.10kbp.regions. \
    --numeric-suffixes=1 --additional-suffix=.fb

split -l 60  $fasta_generate_regions/iyAndHatt_8785v1_2.md_chr.fa.10kbp.regions.fb \
    $OUT_DIR_region_AndHat/iyAndHatt_8785v1_2.md_chr.fa.10kbp.regions. \
    --numeric-suffixes=1 --additional-suffix=.fb

split -l 300  $fasta_generate_regions/iyBomPasc1_1.md_chr.fa.10kbp.regions.fb \
    $OUT_DIR_region_BomPas/iyBomPasc1_1.md_chr.fa.10kbp.regions. \
    --numeric-suffixes=1 --additional-suffix=.fb
##  -a, --suffix-length=N   generate suffixes of length N (default 2)
split -a 3 -l 300  $fasta_generate_regions/iyBomHypn_7925v1_2.md_chr.fa.10kbp.regions.fb \
    $OUT_DIR_region_BomHyp/iyBomHypn_7925v1_2.md_chr.fa.10kbp.regions. \
    --numeric-suffixes=1 --additional-suffix=.fb
## delete duplicates
ls $OUT_DIR_region_BomHyp/* | egrep *.regions.[0-9]\{1,2\}.fb | xargs rm