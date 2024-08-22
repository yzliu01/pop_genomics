

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


***************** for pas new 2024 at Aarhus University ****************
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

#***************************  NEW REF ********************************************
1. # index fasta file - bwa index -a bwtsw reference.fa 
conda create -n variant_calling bwa samtools bamtools freebayes
conda create -n variant_calling picard gatk vcftools bcftools plink
conda install picard gatk vcftools bcftools plink
conda rename -n variant_calling variant_calling_mapping

#bwa/0.7.17

conda activate variant_calling_mapping
ref_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/
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
for masked_ref in `ls *softmasked.fa`
for masked_ref in `ls -t *softmasked.fa | head -4`
for masked_ref in ${ref_list[@]}
    do
#    echo $masked_ref
#done
    bwa index -a bwtsw $masked_ref
done

## use self softmasked REF
bwa index -a bwtsw Andrena_marginata_GCA_963932335.1-softmasked.fa

## alternative ref
bwa index -a bwtsw Bombus_muscorum-GCA_963971125.1.fa

2.
samtools/1.2
samtools-1.19
#samtools faidx reference.fa 
samtools faidx D_melanogaster.7509v1.md_chr.fa

samtools faidx iyAndHaem1_1.md_chr.fa
samtools faidx iyAndHatt_8785v1_2.md_chr.fa
samtools faidx iyBomPasc1_1.md_chr.fa
samtools faidx iyBomHypn_7925v1_2.md_chr.fa
samtools faidx Amel_HAv3_1.md_chr.fa

for masked_ref in `ls *softmasked.fa`
for masked_ref in `ls -t *softmasked.fa | head -4`
for masked_ref in ${ref_list[@]}
    do
    samtools faidx $masked_ref
done

## use self softmasked REF
samtools faidx Andrena_marginata_GCA_963932335.1-softmasked.fa
samtools faidx Bombus_muscorum-GCA_963971125.1.fa

3. Create dictionary for gatk
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
for masked_ref in ${ref_list[@]}
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


