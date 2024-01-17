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

sed -e 's/NW.*unplaced.*Amel_HAv3.1\s//g' -e 's/,\swhole.*sequence//' -e 's/NC.*linkage\sgroup\s//g' -e 's/,\sAmel_HAv3.1//' -e 's/NW.*unlocalized.*scaffold\s//' -e 's/_associated_to//' -e 's/NC.*complete\sgenome/mt/' \
> Amel_HAv3_1.md_chr.fa

## Drosophila melanogaster
https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_029775095.1/
## check
grep '>' D_melanogaster.7509v1.fa | sed -e 's/CP.*chromosome\s/chr/'
## output
sed -e 's/CP.*chromosome\s/chr/' D_melanogaster.7509v1.fa > D_melanogaster.7509v1.md_chr.fa

**************

1. # index fasta file - bwa index -a bwtsw reference.fa 
conda create -n variant_calling bwa samtools bamtools freebayes
conda create -n variant_calling picard gatk vcftools bcftools plink
conda install picard gatk vcftools bcftools plink
conda rename -n variant_calling variant_calling_mapping

bwa/0.7.17

conda activate variant_calling_mapping
ref_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/
cd $ref_dir
bwa index -a bwtsw D_melanogaster.7509v1.md_chr.fa
bwa index -a bwtsw iyAndHaem1_1.md_chr.fa
bwa index -a bwtsw iyBomPasc1_1.md_chr.fa
bwa index -a bwtsw iyBomTerr1_2.md_chr.fa
bwa index -a bwtsw Amel_HAv3_1.md_chr.fa

2.
samtools/1.2
samtools-1.19
#samtools faidx reference.fa 
samtools faidx D_melanogaster.7509v1.md_chr.fa

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

4. freebayes
freebayes-1.3.7

picard 2.20.4


