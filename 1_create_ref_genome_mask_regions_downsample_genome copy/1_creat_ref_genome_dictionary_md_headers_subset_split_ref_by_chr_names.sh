#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 6
#SBATCH --mem 200g
#SBATCH --array=0-23%24
#SBATCH --time=15:00:00
#SBATCH --error=index_ref.%A_%a.e
#SBATCH --output=index_ref.%A_%a.o
#SBATCH --job-name=index_ref
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## call env
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
conda activate variant_calling_mapping

# test
#SLURM_ARRAY_TASK_ID=1

ref_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
cd $ref_dir

ref_list=(
# first 10 ref
    #"Aphodius_sticticus-GCA_963966075.1.fa"
    ##"Aphodius_sticticus-GCA_963966075.1-softmasked.fa"

    #"Stenurella_melanura-GCA_963583905.1.fa"
    ##"Stenurella_melanura-GCA_963583905.1-softmasked.fa"

    #"Phragmatobia_fuliginosa-GCA_932526445.1-softmasked.fa"
    #"Megachile_leachella-GCA_963576845.1-softmasked.fa"
    #"Ochropleura_plecta-GCA_905475445.1-softmasked.fa"
    #"Cerceris_rybyensis-GCA_910591515.1-softmasked.fa"
    #"Bombylius_major-GCA_932526495.1-softmasked.fa"
    
    #"Ephemera_danica-GCA_000507165.2.fa"
    ##"Ephemera_danica-GCA_000507165.2-softmasked.fa"

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

## check number of array
#echo ${!ref_list[@]}
#0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23

## array jobs
bwa index -a bwtsw ${ref_list[SLURM_ARRAY_TASK_ID]}
samtools faidx ${ref_list[SLURM_ARRAY_TASK_ID]}

exit 0

#for masked_ref in `ls *softmasked.fa`
#for masked_ref in `ls -t *softmasked.fa | head -4`

for masked_ref in ${ref_list[@]}
    do
#    echo $masked_ref
#done
    bwa index -a bwtsw $masked_ref
done

#for masked_ref in `ls *softmasked.fa`
#for masked_ref in `ls -t *softmasked.fa | head -4`

for masked_ref in ${ref_list[@]}
    do
    samtools faidx $masked_ref
done


##https://github.com/broadgsa/gatk/blob/master/doc_archive/deprecated/(howto)_Prepare_a_reference_for_use_with_BWA_and_GATK.md

# Ref contig name issue
sed 's/,.*$//' New_Mbel.fa > New_Mbel_midified_contig_name.fa

1. # index fasta file - bwa index -a bwtsw reference.fa 
module load bioinfo-tools
module load bwa/0.7.17

bwa index -a bwtsw /crex/proj/snic2021-23-365/nobackup/tuuli/termites/M_bel/New_ref_Mbel/New_Mbel_midified_contig_name.fa

# -p New_Mbel

2.
module load samtools/1.2
#samtools faidx reference.fa 
## fai file: https://manpages.ubuntu.com/manpages/trusty/en/man5/faidx.5.html
samtools faidx /crex/proj/snic2021-23-365/nobackup/tuuli/termites/M_bel/New_ref_Mbel/New_Mbel_midified_contig_name.fa

3. Create dictionary
module load bioinfo-tools
module load GATK/4.0.8.0

java -jar /sw/bioinfo/GATK/4.0.8.0/rackham/gatk-package-4.0.8.0-local.jar CreateSequenceDictionary \
-R /crex/proj/snic2021-23-365/nobackup/tuuli/termites/M_bel/New_ref_Mbel/New_Mbel_midified_contig_name.fa \
-O /crex/proj/snic2021-23-365/nobackup/tuuli/termites/M_bel/New_ref_Mbel/New_Mbel_midified_contig_name.fa.dict

# balteatus
java -jar /sw/bioinfo/GATK/4.0.8.0/rackham/gatk-package-4.0.8.0-local.jar CreateSequenceDictionary \
-R /crex/proj/snic2020-6-58/private/yzliu/reference_genome/Bombus_balteatus_v1.sorted.fna \
-O /crex/proj/snic2020-6-58/private/yzliu/reference_genome/Bombus_balteatus_v1.sorted.fna.dict


#java -jar picard.jar CreateSequenceDictionary \
#    REFERENCE=reference.fa \ 
#    OUTPUT=reference.dict


***************** pas new 2024 at Aarhus University ****************
# >ENA|HG995284|HG995284.1 Bombus pascuorum genome assembly, chromosome: 17
# >ENA|HG995285|HG995285.1 Bombus pascuorum genome assembly, organelle: mitochondrion
## Bombus pascuorum
less iyBomPasc1_1.fa | grep ">"
grep '>' iyBomPasc1_1.fa | sed -e 's/ENA.*chromosome:\s/chr/' -e 's/ENA.*organelle:\smitochondrion/mt/'
sed -e 's/ENA.*chromosome:\s/chr/' -e 's/ENA.*organelle:\smitochondrion/mt/' iyBomPasc1_1.fa > iyBomPasc1_1.md_chr.fa

## Bombus terrestri
less iyBomTerr1_2.fa | grep ">"
grep '>' iyBomTerr1_2.fa | sed -e 's/ENA.*chromosome:\s/chr/' -e 's/ENA.*organelle:\smitochondrion/mt/'
sed -e 's/ENA.*chromosome:\s/chr/' -e 's/ENA.*organelle:\smitochondrion/mt/' iyBomTerr1_2.fa > iyBomTerr1_2.md_chr.fa

## Andrena haemorrhoa
less iyAndHaem1_1.fa | grep ">"
sed -e 's/NW.*chromosome:\s/chr/' -e 's/ENA.*organelle:\smitochondrion/mt/' iyAndHaem1_1.fa > iyAndHaem1_1.md_chr.fa

## Apis mellifera

grep '>' Amel_HAv3_1.fa | sed -e '/LG2/'
grep '>' Amel_HAv3_1.fa | sed -e 's/NW.*unplaced.*Amel_HAv3.1\s//g' -e 's/,\swhole.*sequence//' -e 's/NC.*linkage\sgroup\s//g' -e 's/,\sAmel_HAv3.1//' -e 's/NW.*unlocalized.*scaffold\s//' -e 's/_associated_to//' -e 's/NC.*complete\sgenome/mt/'

sed -e 's/NW.*unplaced.*Amel_HAv3.1\s//g' -e 's/,\swhole.*sequence//' -e 's/NC.*linkage\sgroup\s//g' -e 's/,\sAmel_HAv3.1//' -e 's/NW.*unlocalized.*scaffold\s//' -e 's/_associated_to//' -e 's/NC.*complete\sgenome/mt/' Amel_HAv3_1.fa \
> Amel_HAv3_1.md_chr.fa

## Drosophila melanogaster
https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_029775095.1/
## check
grep '>' D_melanogaster.7509v1.fa | sed -e 's/CP.*chromosome\s/chr/'
## output
sed -e 's/CP.*chromosome\s/chr/' D_melanogaster.7509v1.fa > D_melanogaster.7509v1.md_chr.fa

## Bombus hypnorm -> ref download issue
## v1
wget https://ftp.ensembl.org/pub/rapid-release/species/Andrena_hattorfiana/GCA_944738655.1/ensembl/genome/Andrena_hattorfiana-GCA_944738655.1-softmasked.fa.gz
wget https://ftp.ensembl.org/pub/rapid-release/species/Bombus_hypnorum/GCA_911387925.1/ensembl/genome/Bombus_hypnorum-GCA_911387925.1-softmasked.fa.gz
gunzip Bombus_hypnorum-GCA_911387925.1-softmasked.fa.gz
mv Bombus_hypnorum-GCA_911387925.1-softmasked.fa iyBomHypn_7925v1_1.fa

grep ">" iyBomHypn_7925v1_1.fa | sed -e 's/\ssoft*.*:1$//g' -e 's/^>/>chr/g'

## v2 (Mac download)
# https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_911387925.2/
grep ">" /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/iyBomHypn_7925v1_2.fa
grep ">" iyBomHypn_7925v1_2.fa | sed -e 's/OU.*.chromosome:\s/chr/' -e 's/OU.*.mitochondrion/mt/' -e 's/\sBombus.*.sequence//'
## save as new .fa file
sed -e 's/OU.*.chromosome:\s/chr/' -e 's/OU.*.mitochondrion/mt/' -e 's/\sBombus.*.sequence//' iyBomHypn_7925v1_2.fa > iyBomHypn_7925v1_2.md.fa

## Andrena hattorfiana
# https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_944738785.2/
grep '>' iyAndHatt_8785v1_2.fa | sed -e 's/\sAndrena.*.sequence//'
sed -e 's/\sAndrena.*.sequence//' iyAndHatt_8785v1_2.fa > iyAndHatt_8785v1_2.md.fa

***************************  NEW REF ****************************
1. # index fasta file - bwa index -a bwtsw reference.fa 
conda create -n variant_calling bwa samtools bamtools freebayes
conda create -n variant_calling picard gatk vcftools bcftools plink
conda install picard gatk vcftools bcftools plink
conda rename -n variant_calling variant_calling_mapping

#bwa/0.7.17

conda activate variant_calling_mapping
ref_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
cd $ref_dir

bwa index -a bwtsw D_melanogaster.7509v1.md_chr.fa

bwa index -a bwtsw iyAndHaem1_1.md_chr.fa
bwa index -a bwtsw iyAndHatt_8785v1_2.md_chr.fa

bwa index -a bwtsw iyBomPasc1_1.md_chr.fa
bwa index -a bwtsw iyBomHypn_7925v1_2.md_chr.fa

bwa index -a bwtsw Amel_HAv3_1.md_chr.fa

## softmasked reference genome
ref_list=(
            "Bombus_muscorum-GCA_963971185.1.fa"
            "Andrena_bicolor-GCA_960531205.1.fa"
            "Bombus_sylvestris-GCA_911622165.2-softmasked.fa"
)

*************************** 10 new pool data ***************************

# uncompress .gz files
Leptopterna_dolobrata-GCA_954871275.1.fasta.gz
Aelia_acuminata-GCA_911387785.2-softmasked.fa.gz
Gerris_lacustris-GCA_951217055.1-softmasked.fa.gz
Noctua_pronuba-GCA_905220335.1-softmasked.fa.gz
Amphimallon_solstitiale-GCA_963170755.1-softmasked.fa.gz
Malachius_bipustulatus-GCA_910589415.1-softmasked.fa.gz
Dorcus_parallelipipedus-GCA_958336345.1-softmasked.fa.gz
Phosphuga_atrata-GCA_944588485.1-softmasked.fa.gz
Pterostichus_niger-GCA_947425015.1-softmasked.fa.gz
Tachina_fera-GCA_905220375.1-softmasked.fa.gz
Eristalis_intricaria-GCA_964034865.1-softmasked.fa.gz
Rhagonycha_fulva-GCA_905340355.1-softmasked.fa.gz
Lasioglossum_morio-GCA_916610235.2-softmasked.fa.gz
Eristalis_pertinax-GCA_907269125.1-softmasked.fa.gz
Bibio_marci-GCA_910594885.2-softmasked.fa.gz

ls -t *.gz | head -15 | less -N

fa_gz_list=`ls -t *.gz | head -15 | tr "\n" " "`
for fa_gz in $fa_gz_list
#do echo $fa_gz
do gunzip -d $fa_gz

done
## make consistent ref file names
rename ".fasta" ".fa" Leptopterna_dolobrata-GCA_954871275.1.fasta


## use self softmasked REF
bwa index -a bwtsw Andrena_marginata_GCA_963932335.1-softmasked.fa

## alternative ref
bwa index -a bwtsw Bombus_muscorum-GCA_963971125.1.fa

## self assemblied genome
## order in header assending order
bwa index -a bwtsw Bombus_veteranus.hifi_asm_pl2.sorted.fa
## order in length
bwa index -a bwtsw Bombus_veteranus.hifi_asm_pl2.fa

## Notonecta glauca
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
bwa index -a bwtsw Notonecta_glauca.hifi_asm_pl2.fa


*************************** 2. samtools index ***************************
samtools/1.2
samtools-1.19
#samtools faidx reference.fa 
samtools faidx D_melanogaster.7509v1.md_chr.fa

samtools faidx iyAndHaem1_1.md_chr.fa
samtools faidx iyAndHatt_8785v1_2.md_chr.fa
samtools faidx iyBomPasc1_1.md_chr.fa
samtools faidx iyBomHypn_7925v1_2.md_chr.fa
samtools faidx Amel_HAv3_1.md_chr.fa

## self assemblied genome
samtools faidx Bombus_veteranus.hifi_asm_pl2.sorted.fa
samtools faidx Bombus_veteranus.hifi_asm_pl2.fa

## use self softmasked REF
samtools faidx Andrena_marginata_GCA_963932335.1-softmasked.fa
samtools faidx Bombus_muscorum-GCA_963971125.1.fa

*************************** 3. Create dictionary for gatk ***************************
GATK_4.5.0.0 requires Java 17 (after gatk_4.3.0.0)
## download
https://github.com/broadinstitute/gatk/releases

## vision (gatk and java-openjdk) issures
## https://www.jianshu.com/p/f45166a88289
## https://gatk.broadinstitute.org/hc/en-us/articles/360035889851--How-to-Install-and-use-Conda-for-GATK4
## https://gatk.broadinstitute.org/hc/en-us/articles/360036194592-Getting-started-with-GATK4
mkdir gatk_4.5.0.0
cd gatk_4.5.0.0/
wget https://github.com/broadinstitute/gatk/releases/download/4.5.0.0/gatk-4.5.0.0.zip
unzip gatk-4.5.0.0.zip 
cd gatk-4.5.0.0/
rm gatk-4.5.0.0.zip

gatk
cd /home/yzliu/bin/gatk_4.x.x.x/gatk-4.x.x.x
conda env create -n gatk_4.5.0.0 -f gatkcondaenv.yml
conda env create -n gatk_4.2.6.0 -f gatkcondaenv.yml

conda env create -n gatk_4.3.0.0 -f /home/yzliu/bin/gatk_4.3.0.0/gatk-4.3.0.0/gatkcondaenv.yml

#conda install -c conda-forge openjdk=17.0.9
## both 4.2.6.0 and 4.2.4.1 work
conda activate gatk_4.2.6.0
conda activate gatk_4.2.4.1

ref_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/
cd $ref_dir

## envoke the path
export PATH="/home/yzliu/bin/gatk_4.2.6.0/gatk-4.2.6.0/:$PATH"

conda activate gatk_4.3.0.0
gatk CreateSequenceDictionary \
-R D_melanogaster.7509v1.md_chr.fa \
-O D_melanogaster.7509v1.md_chr.fa.dict

## alternative ref
conda activate gatk_4.3.0.0
gatk CreateSequenceDictionary \
-R Bombus_muscorum-GCA_963971125.1.fa \
-O Bombus_muscorum-GCA_963971125.1.fa.dict

## Bombus vestranus
conda activate gatk_4.3.0.0
gatk CreateSequenceDictionary \
-R Bombus_veteranus.hifi_asm_pl2.fa \
-O Bombus_veteranus.hifi_asm_pl2.dict


## Ref with chr not modified
## out name should be noted
## D_melanogaster.7509v1.md_chr.fa -> D_melanogaster.7509v1.md_chr.dict
for masked_ref in `ls *softmasked.fa`
    do
    out_masked_ref=${masked_ref/.fa/}
    gatk CreateSequenceDictionary \
    -R "$masked_ref" \
    -O "$out_masked_ref.dict"
done

## use self softmasked REF
conda activate gatk_4.3.0.0
for masked_ref in `ls Andrena_marginata*softmasked.fa`
for masked_ref in `ls -t *softmasked.fa | head -4`
for masked_ref in `ls -t *.fa | head -10` # 10 new pools in Jan 2025
#for masked_ref in ${ref_list[@]}
    do
    out_masked_ref=${masked_ref/.fa/}
    gatk CreateSequenceDictionary \
    -R "$masked_ref" \
    -O "$out_masked_ref.dict"
done

## test
for masked_ref in `ls *softmasked.N.fa`
    do
    echo $masked_ref
done


4. freebayes
freebayes-1.3.7

picard 2.20.4



*************************** ref genome repeatmask: subset reference genome fasta sequences based on chr names *************
# /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/fsc_sim_stairway_plot_2024/scripts/msprime/
3_update_ref_genome_subset_ref_by_chr_names.sh

conda activate variant_calling_mapping
seqkit -h
# faidx           create the FASTA index file and extract subsequences

ref_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
cd $ref_dir
out_subset_fa=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/split_ref_genome_fa

large_fa=(
Chorthippus_brunneus.hifi_asm_pl3.fa
Chorthippus_parallelus.hifi_asm_pl3.fa
)
## index ref fasta files
for fa in ${large_fa[@]}
do
echo $fa
samtools faidx $fa
done

## split the genome into smaller files, each containing a specific number of sequences:
## This splits the genome into 10 separate FASTA files.
Usage:
  seqkit split [flags] 

Flags:
  -i, --by-id                     split squences according to sequence ID
      --by-id-prefix string       file prefix for --by-id
  -p, --by-part int               split sequences into N parts
      --by-part-prefix string     file prefix for --by-part
  -r, --by-region string          split squences according to subsequence of given region. e.g 1:12 for
                                  first 12 bases, -12:-1 for last 12 bases. type "seqkit split -h" for
                                  more examples

seqkit split -p 10 Chorthippus_brunneus.hifi_asm_pl3.fa -O $out_subset_fa
# Chorthippus_brunneus.hifi_asm_pl3.part_010.fa
#[INFO] split into 10 parts
#[INFO] read sequences ...
#[INFO] read 7459 sequences
#[INFO] write 746 sequences to file: /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/split_ref_genome_fa/Chorthippus_brunneus.hifi_asm_pl3.part_001.fa
#[INFO] write 746 sequences to file: /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/split_ref_genome_fa/Chorthippus_brunneus.hifi_asm_pl3.part_002.fa

#grep '>' Chorthippus_brunneus.hifi_asm_pl3.part_009.fa | wc -l
745
# grep '>' Chorthippus_brunneus.hifi_asm_pl3.part_010.fa | wc -l
746

seqkit split -p 10 Chorthippus_parallelus.hifi_asm_pl3.fa -O $out_subset_fa
# Chorthippus_parallelus.hifi_asm_pl3.part_010.fa
#[INFO] split into 10 parts
#[INFO] read sequences ...
#[INFO] read 13355 sequences
#[INFO] write 1336 sequences to file: /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/split_ref_genome_fa/Chorthippus_parallelus.hifi_asm_pl3.part_001.fa
#[INFO] write 1336 sequences to file: /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/split_ref_genome_fa/Chorthippus_parallelus.hifi_asm_pl3.part_002.fa

*************************************************************************


ref_chr_md=($(ls ref_genome_md_chr_*.fasta | sort -V | awk '{print $0}'))

for i in ${!ref_chr_md[*]}
do
echo ${ref_chr_md[i]}
#bgzip -k ${ref_chr_md[i]}
#samtools faidx ${ref_chr_md[i]}
#done
#echo $i
# remove prefix text using #
chr_n=${ref_chr_md[i]#ref_genome_md_chr_}
# remove suffix text using %
chr_n=${chr_n%.fasta}
echo $chr_n
#done
# use 'samtools faidx' to subset sequences based on header names
samtools faidx ${ref_chr_md[i]} $chr_n -o ref_genome_md_chr_$chr_n.final.fasta
done



exit 0

## test samtools faidx
## https://www.biostars.org/p/469520/#9534676
samtools faidx reference.fasta chr1
samtools faidx reference_genome_md_chr_1.new.fasta -o reference_genome_md_chr_1.final.fasta
## not working
#seqkit subseq -r 1: reference_genome_md_chr_1.new.fasta.gz -o reference_genome_md_chr_1.final.fasta.gz
# seqkit -h
