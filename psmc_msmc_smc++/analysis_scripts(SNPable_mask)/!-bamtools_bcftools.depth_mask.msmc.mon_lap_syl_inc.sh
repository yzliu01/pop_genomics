#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 15:30:00
#SBATCH -J bam_mask.lap_mon
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=bam_mask.lap_mon.%A.%a.e
#SBATCH --output=bam_mask.lap_mon.%A.%a.o

module load bioinfo-tools python samtools bcftools

## calculate depth for mon and lap, syl and inc
REF=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/Bombus_sylvicola_v1.fna
BAM_INPATH_mon_lap_syl_inc=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL
cd $BAM_INPATH_mon_lap_syl_inc
## create soft link to bam of inc and syl in MC's directory
##inc
#120_S_Bor_6_W.sorted.marked_dupes.rg.bam
#150_S_Bor_3_W.sorted.marked_dupes.rg.bam
#262_S_Hor_10_W.sorted.marked_dupes.rg.bam
#471_S_Eva_14_W.sorted.marked_dupes.rg.bam
#612_S_Pen_18_W.sorted.marked_dupes.rg.bam
#727_S_Qua_21_W.sorted.marked_dupes.rg.bam
#859_S_Niw_25_W.sorted.marked_dupes.rg.bam
#949_S_Niw_27_W.sorted.marked_dupes.rg.bam
##syl
#8_S_Dem_1_W.sorted.marked_dupes.rg.bam
#70_S_Dem_1_W.sorted.marked_dupes.rg.bam
#72_S_Bor_2_W.sorted.marked_dupes.rg.bam
#149_S_Bor_3_W.sorted.marked_dupes.rg.bam
#300_S_Hor_10_W.sorted.marked_dupes.rg.bam
#441_S_Eva_14_W.sorted.marked_dupes.rg.bam
#586_S_Pen_17_W.sorted.marked_dupes.rg.bam
#780_S_Qua_22_W.sorted.marked_dupes.rg.bam
#908_S_Niw_25_W.sorted.marked_dupes.rg.bam

## create soft link to bam of inc and syl in MC's directory
############# .bam
# ln -f -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/inco_bams/120_S_Bor_6_W.sorted.marked_dupes.rg.bam 120_S_Bor_6_W.sorted.marked_dupes.rg.bam

## also need bam index 
############# .bai
# ln -f -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/inco_bams/120_S_Bor_6_W.sorted.marked_dupes.rg.bam.bai 120_S_Bor_6_W.sorted.marked_dupes.rg.bam.bai


OUT_PUT_mon_lap_inc_syl=$BAM_INPATH_mon_lap_syl_inc/samtools_bam_depth
## better output to "Sweden_Colorado" folder; before it's SYL folder
OUT_PUT_mon_lap_inc_syl=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/samtools_bam_depth_mask

## already make before so exclude here(M_L013.sorted_marked_dups.bam,M_L054.sorted_marked_dups.bam,
## M_L028.sorted_marked_dups.bam,M_L060.sorted_marked_dups.bam,)

for bam in {M_L211.sorted_marked_dups.bam,M_L224.sorted_marked_dups.bam,AC-106.sorted_marked_dups.bam,AC-129.sorted_marked_dups.bam,BH_08.sorted_marked_dups.bam,BH_16.sorted_marked_dups.bam,\
	M_L018.sorted_marked_dups.bam,M_L043.sorted_marked_dups.bam,AC-012.sorted_marked_dups.bam,AC-071.sorted_marked_dups.bam,WO_004.sorted_marked_dups.bam,WO_448.sorted_marked_dups.bam,\
	120_S_Bor_6_W.sorted.marked_dupes.rg.bam,150_S_Bor_3_W.sorted.marked_dupes.rg.bam,262_S_Hor_10_W.sorted.marked_dupes.rg.bam,471_S_Eva_14_W.sorted.marked_dupes.rg.bam,612_S_Pen_18_W.sorted.marked_dupes.rg.bam,727_S_Qua_21_W.sorted.marked_dupes.rg.bam,859_S_Niw_25_W.sorted.marked_dupes.rg.bam,949_S_Niw_27_W.sorted.marked_dupes.rg.bam,\
8_S_Dem_1_W.sorted.marked_dupes.rg.bam,70_S_Dem_1_W.sorted.marked_dupes.rg.bam,72_S_Bor_2_W.sorted.marked_dupes.rg.bam,149_S_Bor_3_W.sorted.marked_dupes.rg.bam,300_S_Hor_10_W.sorted.marked_dupes.rg.bam,441_S_Eva_14_W.sorted.marked_dupes.rg.bam,586_S_Pen_17_W.sorted.marked_dupes.rg.bam,780_S_Qua_22_W.sorted.marked_dupes.rg.bam,908_S_Niw_25_W.sorted.marked_dupes.rg.bam}; do
	for chr in {001..592}; do
	samtools depth -r contig_$chr $BAM_INPATH_mon_lap_syl_inc/$bam | awk '{sum += $3} END {print sum / NR}' >> $OUT_PUT_mon_lap_inc_syl/$bam.Depth.txt
	done
done


# use bcftools instead samtools - https://github.com/samtools/bcftools/issues/1129
#for chr in {001..592};do
#	for bam in {M_L013.sorted_marked_dups.bam,M_L054.sorted_marked_dups.bam,M_L028.sorted_marked_dups.bam,M_L060.sorted_marked_dups.bam};do
#	bcftools mpileup -q 20 -Q 20 -C 50 -r contig_$chr -f $REF $BAM_INPATH_mon_lap_syl_inc/$bam | bcftools call -c -V indels |
#	/home/yzliu/bin/msmc/msmc-tools/bamCaller.py 10 $bam.$chr.out_mask.bed.gz | gzip -c > $bam.$chr.out.vcf.gz
#	done
#done

## attention to set path of output: out_mask.bed.gz 
## formal for 8 samples ca (2+6 for mon and lap, 8 for syl and inc)
## avoid duplicate: M_L013.sorted_marked_dups.bam,M_L054.sorted_marked_dups.bam,M_L211.sorted_marked_dups.bam,M_L224.sorted_marked_dups.bam,AC-106.sorted_marked_dups.bam,AC-129.sorted_marked_dups.bam,BH_08.sorted_marked_dups.bam,BH_16.sorted_marked_dups.bam,\
M_L018.sorted_marked_dups.bam,M_L028.sorted_marked_dups.bam,M_L043.sorted_marked_dups.bam,M_L060.sorted_marked_dups.bam,AC-012.sorted_marked_dups.bam,AC-071.sorted_marked_dups.bam,WO_004.sorted_marked_dups.bam,

# selected samples with mean DP 7.9 for all
# M_L013.sorted_marked_dups.bam,M_L054.sorted_marked_dups.bam,M_L211.sorted_marked_dups.bam,M_L224.sorted_marked_dups.bam,BH_08.sorted_marked_dups.bam,BH_16.sorted_marked_dups.bam,\
# M_L028.sorted_marked_dups.bam,M_L043.sorted_marked_dups.bam,M_L060.sorted_marked_dups.bam,AC-012.sorted_marked_dups.bam,WO_004.sorted_marked_dups.bam
## 5 inc and 4 syl
## attention to set path of output: out_mask.bed.gz 
for chr in {001..592};do
	for bam in {M_L013.sorted_marked_dups.bam,M_L054.sorted_marked_dups.bam,M_L211.sorted_marked_dups.bam,M_L224.sorted_marked_dups.bam,BH_08.sorted_marked_dups.bam,BH_16.sorted_marked_dups.bam,\
M_L028.sorted_marked_dups.bam,M_L043.sorted_marked_dups.bam,M_L060.sorted_marked_dups.bam,AC-012.sorted_marked_dups.bam,WO_004.sorted_marked_dups.bam,WO_448.sorted_marked_dups.bam,\
120_S_Bor_6_W.sorted.marked_dupes.rg.bam,262_S_Hor_10_W.sorted.marked_dupes.rg.bam,612_S_Pen_18_W.sorted.marked_dupes.rg.bam,727_S_Qua_21_W.sorted.marked_dupes.rg.bam,859_S_Niw_25_W.sorted.marked_dupes.rg.bam,\
72_S_Bor_2_W.sorted.marked_dupes.rg.bam,300_S_Hor_10_W.sorted.marked_dupes.rg.bam,586_S_Pen_17_W.sorted.marked_dupes.rg.bam,780_S_Qua_22_W.sorted.marked_dupes.rg.bam}; do
	bcftools mpileup -q 20 -Q 20 -C 50 -r contig_$chr -f $REF $BAM_INPATH_mon_lap_syl_inc/$bam | bcftools call -c -V indels |
	/home/yzliu/bin/msmc/msmc-tools/bamCaller.py 7.9 $OUT_PUT_mon_lap_inc_syl/$bam.contig_$chr.out_mask.bed.gz | gzip -c > $OUT_PUT_mon_lap_inc_syl/$bam.contig_$chr.out.vcf.gz
	done
done


## make bed mask file for mon and lap
#for chr in {001..592};do
#	for bam in {M_L013.sorted_marked_dups.bam,M_L054.sorted_marked_dups.bam,M_L028.sorted_marked_dups.bam,M_L060.sorted_marked_dups.bam};do
#	bcftools mpileup -q 20 -Q 20 -C 50 -r contig_$chr -f $REF $BAM_INPATH_mon_lap_syl_inc/$bam | bcftools call -c -V indels |
#	/home/yzliu/bin/msmc/msmc-tools/bamCaller.py 10 $bam.$chr.out_mask.bed.gz | gzip -c > $bam.$chr.out.vcf.gz
#	done
#done


## genome mapbility
# https://lh3lh3.users.sourceforge.net/snpable.shtml
# Extract all overlapping k-mer subsequences as read sequences
REF=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/Bombus_sylvicola_v1.fna
SNPable_path=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/SNPable_syl
cd $SNPable_path

/home/yzliu/bin/SNPable/seqbility-20091110/splitfa ../Bombus_sylvicola_v1.fna 35 | split -l 20000000
 
# Align all reads to the genome with BWA to generate .sai files
# Syntax: bwa aln <reference genome> <fastq file with reads> > <name of the output file>
bwa aln -R 1000000 -O 3 -E 3 ../Bombus_sylvicola_v1.fna xaa

#
for read in `ls xa[b-z]`;do
bwa aln -R 1000000 -O 3 -E 3 $REF $read | bwa samse $REF $read | gzip > $SNPable_path/$read.sam.gz
done

# convert .sai to .sam file
# https://scilifelab.github.io/courses/ngsintro/1505/labs/filetypes
# Syntax: bwa samse <reference genome> <the .sai file> <the fastq reads file> > <the sam file>
bwa samse ../Bombus_sylvicola_v1.fna xaa.sai xaa | gzip > xaa.sam.gz
/home/yzliu/bin/SNPable/seqbility-20091110/gen_raw_mask.pl xaa.sam > xaa_rawMask_35.fa

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


# II - use phased vcf files separated by bcftools +split 
# prepare phased individual samples from combined vcf, and then convert into individuals
# https://www.biostars.org/p/138694/
# 4 samples (2 monticola vs 2 lapponicus)
#M_L013
#M_L054
#M_L028
#M_L060
cd /crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/merged_vcf_per_contig
vcf=Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.oneway.imp.with_header.vcf.gz

# bcftools +split 
bcftools +split -S ./phased_sample_msmc/Four_samples_for_MSMC.list $vcf -Oz -o ./phased_sample_msmc

called_mask_path=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/samtools_bam_depth
map_path=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/SNPable_syl
SNPable_multihetsep_phased_vcf=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/merged_vcf_per_contig/phased_sample_msmc

cd $SNPable_multihetsep_phased_vcf
/home/yzliu/bin/msmc/msmc-tools/generate_multihetsep.py --chr contig_001 --mask $called_mask_path/M_L013.sorted_marked_dups.bam.001.out_mask.bed.gz --mask $called_mask_path/M_L054.sorted_marked_dups.bam.001.out_mask.bed.gz --mask $called_mask_path/M_L028.sorted_marked_dups.bam.001.out_mask.bed.gz --mask $called_mask_path/M_L060.sorted_marked_dups.bam.001.out_mask.bed.gz --mask $map_path/xaa_chrcontig_001.mask.bed.gz ./M_L013.vcf.gz ./M_L054.vcf.gz ./M_L028.vcf.gz ./M_L060.vcf.gz > ./M_L013_M_L054_M_L028_M_L060.contig_001.multihetseq.txt

#/home/yzliu/bin/msmc/msmc-tools/generate_multihetsep.py --chr contig_001 \
#--mask $called_mask_path/M_L013.sorted_marked_dups.bam.contig_001.out_mask.bed.gz \
#--mask $called_mask_path/M_L054.sorted_marked_dups.bam.contig_001.out_mask.bed.gz \
#--mask $called_mask_path/M_L028.sorted_marked_dups.bam.contig_001.out_mask.bed.gz \
#--mask $called_mask_path/M_L060.sorted_marked_dups.bam.contig_001.out_mask.bed.gz \
#--mask $mapability_path/syl_35_90.contig_001.mask.bed.gz \
#./M_L013.vcf.gz \
#./M_L054.vcf.gz \
#./M_L028.vcf.gz \
#./M_L060.vcf.gz \
#> ./mon6_lap6_inc5_syl4.contig_001.multihetseq.txt

## output in file for each chr
# cp mon6_lap6_inc5_syl4.contig_*.multihetseq.txt ./contig_001_592_multihetseq/
for chr in {011..592};do /home/yzliu/bin/msmc/msmc-tools/generate_multihetsep.py --chr contig_$chr --mask $called_mask_path/M_L013.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/M_L054.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/M_L211.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/M_L224.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/BH_08.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/BH_16.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/M_L028.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/M_L043.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/M_L060.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/AC-012.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/WO_004.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/WO_448.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/120_S_Bor_6_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/262_S_Hor_10_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/612_S_Pen_18_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/727_S_Qua_21_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/859_S_Niw_25_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/72_S_Bor_2_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/300_S_Hor_10_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/586_S_Pen_17_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/780_S_Qua_22_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz --mask $mapability_path/syl_35_90.contig_$chr.mask.bed.gz ./M_L013.vcf.gz ./M_L054.vcf.gz ./M_L211.vcf.gz ./M_L224.vcf.gz ./BH_08.vcf.gz ./BH_16.vcf.gz ./M_L028.vcf.gz ./M_L043.vcf.gz ./M_L060.vcf.gz ./AC-012.vcf.gz ./WO_004.vcf.gz ./WO_448.vcf.gz ./120_S_Bor_6_W.vcf.gz ./262_S_Hor_10_W.vcf.gz ./612_S_Pen_18_W.vcf.gz ./727_S_Qua_21_W.vcf.gz ./859_S_Niw_25_W.vcf.gz ./72_S_Bor_2_W.vcf.gz ./300_S_Hor_10_W.vcf.gz ./586_S_Pen_17_W.vcf.gz ./780_S_Qua_22_W.vcf.gz > ./contig_001_592_multihetseq/mon6_lap6_inc5_syl4.contig_$chr.multihetseq.txt; done

## output in one file: not working in msmc
#for chr in {001..010};do /home/yzliu/bin/msmc/msmc-tools/generate_multihetsep.py --chr contig_$chr --mask $called_mask_path/M_L013.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/M_L054.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/M_L211.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/M_L224.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/BH_08.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/BH_16.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/M_L028.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/M_L043.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/M_L060.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/AC-012.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/WO_004.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/WO_448.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/120_S_Bor_6_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/262_S_Hor_10_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/612_S_Pen_18_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/727_S_Qua_21_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/859_S_Niw_25_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/72_S_Bor_2_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/300_S_Hor_10_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/586_S_Pen_17_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz --mask $called_mask_path/780_S_Qua_22_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz --mask $mapability_path/syl_35_90.contig_$chr.mask.bed.gz ./M_L013.vcf.gz ./M_L054.vcf.gz ./M_L211.vcf.gz ./M_L224.vcf.gz ./BH_08.vcf.gz ./BH_16.vcf.gz ./M_L028.vcf.gz ./M_L043.vcf.gz ./M_L060.vcf.gz ./AC-012.vcf.gz ./WO_004.vcf.gz ./WO_448.vcf.gz ./120_S_Bor_6_W.vcf.gz ./262_S_Hor_10_W.vcf.gz ./612_S_Pen_18_W.vcf.gz ./727_S_Qua_21_W.vcf.gz ./859_S_Niw_25_W.vcf.gz ./72_S_Bor_2_W.vcf.gz ./300_S_Hor_10_W.vcf.gz ./586_S_Pen_17_W.vcf.gz ./780_S_Qua_22_W.vcf.gz >> ./mon6_lap6_inc5_syl4.contig_001_010.multihetseq.txt; done


# run msmc2 for a single chr
module load msmc2
msmc -t 8 -s -I 0,1,2,3 -o ./mon_4hap_out_prefix ./M_L013_M_L054_M_L028_M_L060.contig_001.multihetseq.txt
msmc -t 8 -s -I 4,5,6,7 -o ./lap_4hap_out_prefix ./M_L013_M_L054_M_L028_M_L060.contig_001.multihetseq.txt
msmc -t 8 -s -I 0-4,0-5,0-6,0-7,1-4,1-5,1-6,1-7,2-4,2-5,2-6,2-7,3-4,3-5,3-6,3-7 -o ./cross_mon_lap_8hap_out_prefix ./M_L013_M_L054_M_L028_M_L060.syl_35_90.contig_001.multihetseq.txt

# run msmc2 for all chr referred to the MSMC2 published manual
# mon6_lap6_inc5_syl4.contig_$chr.multihetseq.txt
time msmc -s -I 0,1,2,3,4,5,6,7,8,9,10,11 -o ./mon_12hap_out_prefix ./mon6_lap6_inc5_syl4.contig_*.multihetseq.txt
time msmc -s -I 12,13,14,15,16,17,18,19,20,21,22,23 -o ./lap_12hap_out_prefix ./mon6_lap6_inc5_syl4.contig_*.multihetseq.txt
time msmc -s -I 24,25,26,27,28,29,30,31,32,33 -o ./inc_10hap_out_prefix ./mon6_lap6_inc5_syl4.contig_*.multihetseq.txt
time msmc -s -I 34,35,36,37,38,39,40,41 -o ./syl_8hap_out_prefix ./mon6_lap6_inc5_syl4.contig_*.multihetseq.txt
time msmc -s -I 0-34,0-35,0-36,0-37,0-38,0-39,0-40,0-41,1-34,1-35,1-36,1-37,1-38,1-39,1-40,1-41,\
2-34,2-35,2-36,2-37,2-38,2-39,2-40,2-41,3-34,3-35,3-36,3-37,3-38,3-39,3-40,3-41,\
4-34,4-35,4-36,4-37,4-38,4-39,4-40,4-41,5-34,5-35,5-36,5-37,5-38,5-39,5-40,5-41,\
6-34,6-35,6-36,6-37,6-38,6-39,6-40,6-41,7-34,7-35,7-36,7-37,7-38,7-39,7-40,7-41,\
8-34,8-35,8-36,8-37,8-38,8-39,8-40,8-41,9-34,9-35,9-36,9-37,9-38,9-39,9-40,9-41,\
10-34,10-35,10-36,10-37,10-38,10-39,10-40,10-41,11-34,11-35,11-36,11-37,11-38,11-39,11-40,11-41,\
 -o ./cross_lap_syl_8hap_out_prefix ./mon6_lap6_inc5_syl4.contig_*.multihetseq.txt


#{M_L013.sorted_marked_dups.bam,M_L054.sorted_marked_dups.bam,M_L211.sorted_marked_dups.bam,M_L224.sorted_marked_dups.bam,BH_08.sorted_marked_dups.bam,BH_16.sorted_marked_dups.bam,\
M_L028.sorted_marked_dups.bam,M_L043.sorted_marked_dups.bam,M_L060.sorted_marked_dups.bam,AC-012.sorted_marked_dups.bam,WO_004.sorted_marked_dups.bam,WO_448.sorted_marked_dups.bam,\
120_S_Bor_6_W.sorted.marked_dupes.rg.bam,262_S_Hor_10_W.sorted.marked_dupes.rg.bam,612_S_Pen_18_W.sorted.marked_dupes.rg.bam,727_S_Qua_21_W.sorted.marked_dupes.rg.bam,859_S_Niw_25_W.sorted.marked_dupes.rg.bam,\
72_S_Bor_2_W.sorted.marked_dupes.rg.bam,300_S_Hor_10_W.sorted.marked_dupes.rg.bam,586_S_Pen_17_W.sorted.marked_dupes.rg.bam,780_S_Qua_22_W.sorted.marked_dupes.rg.bam}

# corss
SNPable_multihetsep_phased_vcf=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/merged_vcf_per_contig/phased_sample_msmc
cd $SNPable_multihetsep_phased_vcf
/home/yzliu/bin/msmc/msmc-tools/combineCrossCoal.py ./cross_10inc_8syl_80hap_out_prefix.mon6_lap6_inc5_syl4.final.txt \
./inc_10hap_out_prefix.mon6_lap6_inc5_syl4.final.txt \
./syl_8hap_out_prefix.mon6_lap6_inc5_syl4.final.txt > ./inc_syl.combined.msmc2.final.txt


## bootstrap
input_dir=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/analysis_scripts
msmc_input=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/merged_vcf_per_contig/phased_sample_msmc
input1=$msmc_input/mon6_lap6_inc5_syl4.contig_001.multihetseq.txt
input2=$msmc_input/mon6_lap6_inc5_syl4.contig_002.multihetseq.txt
out_dir=$msmc_input/bootstrap_from_msmc_input_file

cd $input_dir
./multihetsep_bootstrap.py $out_dir/out_dir_prefix $input1 $input2
# out: out_dir_prefix_1,out_dir_prefix_2

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

