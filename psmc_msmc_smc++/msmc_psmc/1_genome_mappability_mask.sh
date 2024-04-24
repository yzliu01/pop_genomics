


## msmc tool dir
MSMC_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/msmc-tools-master
#cd $MSMC_DIR
Generate_Multihetsep=./generate_multihetsep.py
MappabilityMask=./makeMappabilityMask.py

## make bed mask file for mon and lap
#for chr in {001..592};do
#    for bam in {M_L013.sorted_marked_dups.bam,M_L054.sorted_marked_dups.bam,M_L028.sorted_marked_dups.bam,M_L060.sorted_marked_dups.bam};do
#    bcftools mpileup -q 20 -Q 20 -C 50 -r contig_$chr -f $REF $BAM_INPATH_mon_lap_syl_inc/$bam | bcftools call -c -V indels |
#    /home/yzliu/bin/msmc/msmc-tools/bamCaller.py 10 $bam.$chr.out_mask.bed.gz | gzip -c > $bam.$chr.out.vcf.gz
#    done
#done

## ref
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
REF_AndHae=$REF_DIR/Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa
REF_AndHat=$REF_DIR/Andrena_hattorfiana-GCA_944738655.1-softmasked.fa
REF_BomPas=$REF_DIR/Bombus_pascuorum-GCA_905332965.1-softmasked.fa
REF_BomHyp=$REF_DIR/Bombus_hypnorum-GCA_911387925.1-softmasked.fa
REF_ApisMel=$REF_DIR/Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa
REF_AndMar=$REF_DIR/Andrena_marginata_GCA_963932335.1-softmasked.fa

## genome mapbility
## https://lh3lh3.users.sourceforge.net/snpable.shtml
## install
#cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare
#wget https://lh3lh3.users.sourceforge.net/download/seqbility-20091110.tar.bz2
#tar -xvjf seqbility-20091110.tar.bz2
#make
#/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/seqbility-20091110/splitfa -h

# Extract all overlapping k-mer subsequences as read sequences
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
SNPable_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/SNPable
cd $SNPable_DIR
#mkdir REF_AndHae REF_BomPas REF_AndMar REF_AndHat REF_BomHyp REF_ApisMel

REF_list=(
    "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa"
    "Andrena_marginata_GCA_963932335.1-softmasked.fa"
    "Bombus_pascuorum-GCA_905332965.1-softmasked.fa"
    "Andrena_hattorfiana-GCA_944738655.1-softmasked.fa"
    "Bombus_hypnorum-GCA_911387925.1-softmasked.fa"
    "Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa"
    #"Drosophila_melanoganster-GCF_000001215.4_Release_6_plus_ISO1_MT_genomic-softmasked.fa"
)

REF_SNPable_DIR_list=("REF_AndHae" "REF_AndMar" "REF_BomPas" "REF_AndHat" "REF_BomHyp" "REF_ApisMel")

for i in ${!REF_list[*]}
do
    #echo $REF
    #done
    ## navigate dir to species folder
    cd $SNPable_DIR/${REF_SNPable_DIR_list[i]}
    /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/seqbility-20091110/splitfa $REF_DIR/${REF_list[i]} 35 | split -l 20000000
    ## return parental folder
    cd $SNPable_DIR
done
 
# Align all reads to the genome with BWA to generate .sai files
# bwa aln <reference genome> <fastq file with reads> > <name of the output file>
# bwa samse ref.fa aln_sa.sai short_read.fq > aln-se.sam 
# bwa aln -R 1000000 -O 3 -E 3 ../Bombus_sylvicola_v1.fna xaa

## test
#SNPable_AndHae=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/SNPable/REF_AndHae
#cd $SNPable_AndHae
#REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
#REF_AndHae_DIR=$REF_DIR/Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa

for i in ${!REF_list[*]}
do
cd $SNPable_DIR/${REF_SNPable_DIR_list[i]}
    for read in `ls xa[b-z]`;do
        # Align all reads to the genome with BWA to generate .sai files
        bwa aln -R 1000000 -O 3 -E 3 $REF_DIR/${REF_list[i]} $read > $read.sai
        # convert .sai to .sam file
        bwa samse $REF_DIR/${REF_list[i]} $read.sai $read | gzip > $read.sam.gz
    done
cd $SNPable_DIR
done

#bwa samse $REF_AndHae_DIR xac.sai xac | gzip > $SNPable_AndHae/xac.sam.gz

## generate rawMask
gen_raw_mask=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/seqbility-20091110/gen_raw_mask.pl
cd $SNPable_DIR
for i in ${!REF_SNPable_DIR_list[*]}
do
cd $SNPable_DIR/${REF_SNPable_DIR_list[i]}
    for sam in `ls xa*.sam.gz`;do
        gzip -dc $sam | $gen_raw_mask >> rawMask_k35.fa
    done
cd $SNPable_DIR
done

## generate final mask
gen_final_mask=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/seqbility-20091110/gen_mask
#$gen_final_mask -l 35 -r 0.9 syl_rawMask_35.fa > syl_rawMask_35_90.fa

for i in ${!REF_SNPable_DIR_list[*]}
do
cd $SNPable_DIR/${REF_SNPable_DIR_list[i]}
    for raw_fa in `ls rawMask_k35.fa`;do
        $gen_final_mask -l 35 -r 0.5 $raw_fa > rawMask_k35_r50.fa
    done
cd $SNPable_DIR
done


# compile 'gen_mask.c' program using: make; <gcc gen_mask.c -o gen_mask> not work
# vi /home/yzliu/bin/msmc/msmc-tools/makeMappabilityMask.py
# change path to 'xaa_rawMask_35_50.fa' in Line 26 and output dir for each chr in Line 30
# line26: with open("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/SNPable/xx/rawMask_k35_r50.fa", "r") as f:
# line30: mask = MaskGenerator("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/SNPable/xx/xaa_chr{}.mask.bed.gz".format(chr), chr)
## little script to convert the mask from fast to bed format
## https://github.com/stschiff/msmc/issues/10
# -r 0.5
#python /home/yzliu/bin/msmc/msmc-tools/makeMappabilityMask.py
# -r 0.9
#python /home/yzliu/bin/msmc/msmc-tools/makeMappabilityMask3590.py

## modified
/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/msmc-tools-master/makeMappabilityMask_k35_r50.py


*************************************** old ************************************************
# convert .sai to .sam file
# https://scilifelab.github.io/courses/ngsintro/1505/labs/filetypes
# Syntax: bwa samse <reference genome> <the .sai file> <the fastq reads file> > <the sam file>
## test
bwa samse ../Bombus_sylvicola_v1.fna xaa.sai xaa | gzip > xaa.sam.gz
/home/yzliu/bin/SNPable/seqbility-20091110/gen_raw_mask.pl xaa.sam > xaa_rawMask_35.fa

## run
#
for read in `ls xa[b-z]`;do
bwa samse /crex/proj/snic2020-6-58/private/yzliu/reference_genome/Bombus_sylvicola_v1.fna $read.sai $read | gzip > $SNPable_path/$read.sam.gz
done
#
for sam in `ls xa*.sam.gz`;do
gzip -dc $sam | /home/yzliu/bin/SNPable/seqbility-20091110/gen_raw_mask.pl >> $SNPable_path/syl_rawMask_35.fa
done 


# gzip -dc xx??.sam.gz | gen_raw_mask.pl > rawMask_35.fa

# compile 'gen_mask.c' program using: make; <gcc gen_mask.c -o gen_mask> not work
# vi /home/yzliu/bin/msmc/msmc-tools/makeMappabilityMask.py
# change path to 'xaa_rawMask_35_50.fa' and output dir for each chr
# with open("/crex/proj/snic2020-6-58/private/yzliu/reference_genome/SNPable_syl/xaa_rawMask_35_50.fa", "r") as f:
# mask = MaskGenerator("/crex/proj/snic2020-6-58/private/yzliu/reference_genome/SNPable_syl/xaa_chr{}.mask.bed.gz".format(chr), chr)
/home/yzliu/bin/SNPable/seqbility-20091110/gen_mask -l 35 -r 0.5 xaa_rawMask_35.fa > xaa_rawMask_35_50.fa
/home/yzliu/bin/SNPable/seqbility-20091110/gen_mask -l 35 -r 0.9 syl_rawMask_35.fa > syl_rawMask_35_90.fa

## little script to convert the mask from fast to bed format
## https://github.com/stschiff/msmc/issues/10
# -r 0.5
python /home/yzliu/bin/msmc/msmc-tools/makeMappabilityMask.py 
# -r 0.9
python /home/yzliu/bin/msmc/msmc-tools/makeMappabilityMask3590.py

## initial run for generate_multihetsep
called_mask_path=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/samtools_bam_depth
map_path=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/SNPable_syl
SNPable_multihetsep_phased_vcf=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/phased_sample_msmc
# I - use unphased vcf files
/home/yzliu/bin/msmc/msmc-tools/generate_multihetsep.py --chr contig_001 --mask $called_mask_path/M_L013.sorted_marked_dups.bam.001.out_mask.bed.gz --mask $called_mask_path/M_L060.sorted_marked_dups.bam.001.out_mask.bed.gz --mask $map_path/xaa_chrcontig_001.mask.bed.gz $called_mask_path/M_L013.sorted_marked_dups.bam.001.out_mf.vcf.gz $called_mask_path/M_L060.sorted_marked_dups.bam.001.out.vcf.gz > $SNPable_multihetsep_phased_vcf/M_L013_M_L060.contig_001.multihetseq.txt


# prepare phased individual samples from combined vcf, and then convert into individuals
# https://www.biostars.org/p/138694/
# 4 samples (2 monticola vs 2 lapponicus)
#M_L013
#M_L054
#M_L028
#M_L060
cd /crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/merged_vcf_per_contig
vcf=Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.oneway.imp.with_header.vcf.gz
bcftools +split -S ./phased_sample_msmc/Four_samples_for_MSMC.list $vcf -Oz -o ./phased_sample_msmc

# II - use phased vcf files
called_mask_path=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/samtools_bam_depth
map_path=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/SNPable_syl
SNPable_multihetsep_phased_vcf=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/phased_sample_msmc

cd $SNPable_multihetsep_phased_vcf
/home/yzliu/bin/msmc/msmc-tools/generate_multihetsep.py --chr contig_001 --mask $called_mask_path/M_L013.sorted_marked_dups.bam.001.out_mask.bed.gz --mask $called_mask_path/M_L054.sorted_marked_dups.bam.001.out_mask.bed.gz --mask $called_mask_path/M_L028.sorted_marked_dups.bam.001.out_mask.bed.gz --mask $called_mask_path/M_L060.sorted_marked_dups.bam.001.out_mask.bed.gz --mask $map_path/xaa_chrcontig_001.mask.bed.gz ./M_L013.vcf.gz ./M_L054.vcf.gz ./M_L028.vcf.gz ./M_L060.vcf.gz > ./M_L013_M_L054_M_L028_M_L060.contig_001.multihetseq.txt

# run msmc2
module load msmc2
msmc -t 8 -s -I 0,1,2,3 -o ./mon_4hap_out_prefix ./M_L013_M_L054_M_L028_M_L060.contig_001.multihetseq.txt
msmc -t 8 -s -I 4,5,6,7 -o ./lap_4hap_out_prefix ./M_L013_M_L054_M_L028_M_L060.contig_001.multihetseq.txt
msmc -t 8 -s -I 0-4,0-5,0-6,0-7,1-4,1-5,1-6,1-7,2-4,2-5,2-6,2-7,3-4,3-5,3-6,3-7 -o ./cross_mon_lap_8hap_out_prefix ./M_L013_M_L054_M_L028_M_L060.contig_001.multihetseq.txt


###### test

for bam in {P23261_254_sort.X.bam,P23261_277_sort.X.bam,P23261_259_sort.X.bam,P23261_341_sort.X.bam}
do
samtools index -b $BAM_INPATH_mon_lap/$bam
done

for bam in {M_L013.sorted_marked_dups.bam,M_L054.sorted_marked_dups.bam,M_L028.sorted_marked_dups.bam,M_L060.sorted_marked_dups.bam}
do
for chr in {001..592}
do
samtools depth -r contig_$chr $BAM_INPATH_mon_lap/$bam | awk '{sum += $3} END {print sum / NR}' > $OUT_PUT/$bam.$chr.depth.txt
done
done

for bam in {M_L054.sorted_marked_dups.bam,M_L028.sorted_marked_dups.bam,M_L060.sorted_marked_dups.bam}; do
for chr in {001..592}; do
samtools depth -r contig_$chr $BAM_INPATH_mon_lap/$bam | awk '{sum += $3} END {print sum / NR}' >> $OUT_PUT/$bam.depth.txt
done
done

