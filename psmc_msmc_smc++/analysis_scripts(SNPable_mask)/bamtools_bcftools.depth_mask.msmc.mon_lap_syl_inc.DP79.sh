#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 20:30:00
#SBATCH -J bam_mask.DP79.lap_mon_inc_syl
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=bam_mask.DP79.lap_mon_inc_syl.%A.%a.e
#SBATCH --output=bam_mask.DP79.lap_mon_inc_syl.%A.%a.o

module load bioinfo-tools python samtools bcftools

## calculate depth for mon and lap, syl and inc
REF=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/Bombus_sylvicola_v1.fna
BAM_INPATH_mon_lap_syl_inc=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL
cd $BAM_INPATH_mon_lap_syl_inc

## create soft link to bam of inc and syl in MC's directory
############# .bam
# ln -f -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/inco_bams/120_S_Bor_6_W.sorted.marked_dupes.rg.bam 120_S_Bor_6_W.sorted.marked_dupes.rg.bam

## also need bam index 
############# .bai
# ln -f -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/inco_bams/120_S_Bor_6_W.sorted.marked_dupes.rg.bam.bai 120_S_Bor_6_W.sorted.marked_dupes.rg.bam.bai

## new output to "Sweden_Colorado" folder; before it's SYL folder
OUT_PUT_mon_lap_inc_syl=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/samtools_bam_depth_mask

## avoid duplicate: M_L013.sorted_marked_dups.bam,M_L054.sorted_marked_dups.bam,M_L211.sorted_marked_dups.bam,M_L224.sorted_marked_dups.bam,AC-106.sorted_marked_dups.bam,AC-129.sorted_marked_dups.bam,BH_08.sorted_marked_dups.bam,BH_16.sorted_marked_dups.bam,\
## M_L018.sorted_marked_dups.bam,M_L028.sorted_marked_dups.bam,M_L043.sorted_marked_dups.bam,M_L060.sorted_marked_dups.bam,AC-012.sorted_marked_dups.bam,AC-071.sorted_marked_dups.bam,WO_004.sorted_marked_dups.bam,

#for bam in {WO_448.sorted_marked_dups.bam,\
#120_S_Bor_6_W.sorted.marked_dupes.rg.bam,150_S_Bor_3_W.sorted.marked_dupes.rg.bam,262_S_Hor_10_W.sorted.marked_dupes.rg.bam,471_S_Eva_14_W.sorted.marked_dupes.rg.bam,612_S_Pen_18_W.sorted.marked_dupes.rg.bam,727_S_Qua_21_W.sorted.marked_dupes.rg.bam,859_S_Niw_25_W.sorted.marked_dupes.rg.bam,949_S_Niw_27_W.sorted.marked_dupes.rg.bam,\
#8_S_Dem_1_W.sorted.marked_dupes.rg.bam,70_S_Dem_1_W.sorted.marked_dupes.rg.bam,72_S_Bor_2_W.sorted.marked_dupes.rg.bam,149_S_Bor_3_W.sorted.marked_dupes.rg.bam,300_S_Hor_10_W.sorted.marked_dupes.rg.bam,441_S_Eva_14_W.sorted.marked_dupes.rg.bam,586_S_Pen_17_W.sorted.marked_dupes.rg.bam,780_S_Qua_22_W.sorted.marked_dupes.rg.bam,908_S_Niw_25_W.sorted.marked_dupes.rg.bam}; do
#	for chr in {001..592}; do
#	samtools depth -r contig_$chr $bam | awk '{sum += $3} END {print sum / NR}' >> $OUT_PUT_mon_lap_inc_syl/$bam.Depth.txt
#	done
#done

## test
#for bam in {120_S_Bor_6_W.sorted.marked_dupes.rg.bam,}; do
#	for chr in {001..002}; do
#	samtools depth -r contig_$chr $bam | awk '{sum += $3} END {print sum / NR}' >> $OUT_PUT_mon_lap_inc_syl/$bam.Depth.txt
#	done
#done

# use bcftools instead samtools - https://github.com/samtools/bcftools/issues/1129
#for chr in {001..592};do
#	for bam in {M_L013.sorted_marked_dups.bam,M_L054.sorted_marked_dups.bam,M_L028.sorted_marked_dups.bam,M_L060.sorted_marked_dups.bam};do
#	bcftools mpileup -q 20 -Q 20 -C 50 -r contig_$chr -f $REF $BAM_INPATH_mon_lap_syl_inc/$bam | bcftools call -c -V indels |
#	/home/yzliu/bin/msmc/msmc-tools/bamCaller.py 10 $bam.contig_$chr.out_mask.bed.gz | gzip -c > $bam.contig_$chr.out.vcf.gz
#	done
#done

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

## test
#for chr in {001..002};do
#	for bam in {120_S_Bor_6_W.sorted.marked_dupes.rg.bam,}; do
#	bcftools mpileup -q 20 -Q 20 -C 50 -r contig_$chr -f $REF $BAM_INPATH_mon_lap_syl_inc/$bam | bcftools call -c -V indels |
#	/home/yzliu/bin/msmc/msmc-tools/bamCaller.py 10 $OUT_PUT_mon_lap_inc_syl/$bam.contig_$chr.out_mask.bed.gz | gzip -c > $OUT_PUT_mon_lap_inc_syl/$bam.contig_$chr.out.vcf.gz
#	done
#done

## make bed mask file for mon and lap
#for chr in {001..592};do
#	for bam in {M_L013.sorted_marked_dups.bam,M_L054.sorted_marked_dups.bam,M_L028.sorted_marked_dups.bam,M_L060.sorted_marked_dups.bam};do
#	bcftools mpileup -q 20 -Q 20 -C 50 -r contig_$chr -f $REF $BAM_INPATH_mon_lap_syl_inc/$bam | bcftools call -c -V indels |
#	/home/yzliu/bin/msmc/msmc-tools/bamCaller.py 10 $bam.$chr.out_mask.bed.gz | gzip -c > $bam.$chr.out.vcf.gz
#	done
#done


## genome mapbility
# https://lh3lh3.users.sourceforge.net/snpable.shtml