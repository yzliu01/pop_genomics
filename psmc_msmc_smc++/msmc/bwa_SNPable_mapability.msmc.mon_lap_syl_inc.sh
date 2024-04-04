#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 15:30:00
#SBATCH -J bwa_SNPable.lap_mon
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=bwa_SNPable_mapability.msmc.lap_mon.%A.%a.e
#SBATCH --output=bwa_SNPable_mapability.msmc.lap_mon.%A.%a.o

module load bioinfo-tools bwa

## genome mapbility
## https://lh3lh3.users.sourceforge.net/snpable.shtml
## Extract all overlapping k-mer subsequences as read sequences
REF=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/Bombus_sylvicola_v1.fna
SNPable_path=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/SNPable_syl
cd $SNPable_path

#/home/yzliu/bin/SNPable/seqbility-20091110/splitfa ../Bombus_sylvicola_v1.fna 35 | split -l 20000000
 
## Align all reads to the genome with BWA to generate .sai files
## Syntax: bwa aln <reference genome> <fastq file with reads> > <name of the output file>
#bwa aln -R 1000000 -O 3 -E 3 ../Bombus_sylvicola_v1.fna xaa > xaa.sai

##
for read in `ls xa[c-z]`;do
bwa aln -R 1000000 -O 3 -E 3 $REF $read > $read.sai
bwa samse $REF $read.sai $read | gzip > $SNPable_path/$read.sam.gz
done



## convert .sai to .sam file
## https://scilifelab.github.io/courses/ngsintro/1505/labs/filetypes
## Syntax: bwa samse <reference genome> <the .sai file> <the fastq reads file> > <the sam file>
# bwa samse ../Bombus_sylvicola_v1.fna xaa.sai xaa | gzip > xaa.sam.gz
# /home/yzliu/bin/SNPable/seqbility-20091110/gen_raw_mask.pl xaa.sam > xaa_rawMask_35.fa

for sam in `ls xa*.sam.gz`;do
gzip -dc $sam | /home/yzliu/bin/SNPable/seqbility-20091110/gen_raw_mask.pl >> $SNPable_path/syl_rawMask_35.fa
done 

# gzip -dc xx??.sam.gz | gen_raw_mask.pl > rawMask_35.fa

## compile 'gen_mask.c' program using: make; <gcc gen_mask.c -o gen_mask> not work
## vi /home/yzliu/bin/msmc/msmc-tools/makeMappabilityMask.py
## change path to 'xaa_rawMask_35_50.fa' and output dir for each chr
## with open("/crex/proj/snic2020-6-58/private/yzliu/reference_genome/SNPable_syl/xaa_rawMask_35_50.fa", "r") as f:
## mask = MaskGenerator("/crex/proj/snic2020-6-58/private/yzliu/reference_genome/SNPable_syl/xaa_chr{}.mask.bed.gz".format(chr), chr)
/home/yzliu/bin/SNPable/seqbility-20091110/gen_mask -l 35 -r 0.5 xaa_rawMask_35.fa > xaa_rawMask_35_50.fa

/home/yzliu/bin/SNPable/seqbility-20091110/gen_mask -l 35 -r 0.9 syl_rawMask_35.fa > syl_rawMask_35_90.fa

## little script to convert the mask from fast to bed format
## https://github.com/stschiff/msmc/issues/10
# -r 0.5
python /home/yzliu/bin/msmc/msmc-tools/makeMappabilityMask.py 
# -r 0.9
python /home/yzliu/bin/msmc/msmc-tools/makeMappabilityMask3590.py
# with open("/crex/proj/snic2020-6-58/private/yzliu/reference_genome/SNPable_syl/syl_rawMask_35.fa", "r") as f:
# "/crex/proj/snic2020-6-58/private/yzliu/reference_genome/SNPable_syl/syl_35_90.{}.mask.bed.gz"
python /home/yzliu/bin/msmc/msmc-tools/makeMappabilityMask3590.py


