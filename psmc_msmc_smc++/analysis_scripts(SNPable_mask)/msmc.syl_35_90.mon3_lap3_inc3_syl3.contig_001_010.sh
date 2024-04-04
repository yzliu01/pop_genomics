#!/bin/bash -l

#SBATCH -A snic2022-22-258
##SBATCH -p core
#SBATCH -p node
##SBATCH -n 10
# 10*6.4GB
##SBATCH -C mem1TB
#SBATCH -C mem512GB
#SBATCH -t 15:30:00
#SBATCH -J msmc2.syl_35_90.mon3_lap3_inc3_syl3
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=msmc2.syl_35_90.mon3_lap3_inc3_sy3.%A.%a.e
#SBATCH --output=msmc2.syl_35_90.mon3_lap3_inc3_syl3.%A.%a.o

# run msmc2
module load bioinfo-tools msmc2

## formal for 8 samples ca (2+6 for mon and lap, 8 for syl and inc)
#	mon	M_L013
#	6	M_L054
#		M_L211
#		M_L224
#		BH_08
#		BH_16
#		
#	lap	M_L028
#	6	M_L043
#		M_L060
#		AC-012
#		WO_004
#		WO_448
#		
#	inc	120_S_Bor_6_W
#	5	262_S_Hor_10_W
#		612_S_Pen_18_W
#		727_S_Qua_21_W
#		859_S_Niw_25_W
#		
#	syl	72_S_Bor_2_W
#	4	300_S_Hor_10_W
#		586_S_Pen_17_W
#		780_S_Qua_22_W

SNPable_multihetsep_phased_vcf=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/merged_vcf_per_contig/phased_sample_msmc

cd $SNPable_multihetsep_phased_vcf
# It is not useful to use more CPUs than the number of chromosomes times the number of haplotype pairs, because that is the number of parallelised likelihood evaluations.

time msmc -s -I 0,1,2,3,4,5 -o ./mon_6hap_out_prefix ./mon6_lap6_inc5_syl4.syl_35_90.contig_001_010.multihetseq.txt
#AAAAAAAAAAAAAAAAAAAAAAAAGGGGGGGGGGAAAAAAAA
#,6,7,8,9,10,11
time msmc -s -I 12,13,14,15,16,17 -o ./lap_6hap_out_prefix ./mon6_lap6_inc5_syl4.syl_35_90.contig_001_010.multihetseq.txt
#,18,19,20,21,22,23
time msmc -s -I 24,25,26,27,28,29 -o ./inc_6hap_out_prefix ./mon6_lap6_inc5_syl4.contig_001_010.syl_35_90.multihetseq.txt
#,30,31,32,33
time msmc -s -I 34,35,36,37,38,39 -o ./syl_6hap_out_prefix ./mon6_lap6_inc5_syl4.contig_001_010.syl_35_90.multihetseq.txt
#,40,41 

time msmc -s -I 24-34,24-35,24-36,24-37,24-38,24-39,25-34,25-35,25-36,25-37,25-38,25-39,\
26-34,26-35,26-36,26-37,26-38,26-39,27-34,27-35,27-36,27-37,27-38,27-39,\
28-34,28-35,28-36,28-37,28-38,28-39,29-34,29-35,29-36,29-37,29-38,29-39 \
-o ./cross_inc_syl_36hap_out_prefix ./inc3_syl3.contig_001_010.syl_35_90.multihetseq.txt

time msmc -s -I 12-34,12-35,12-36,12-37,12-38,12-39,13-34,13-35,13-36,13-37,13-38,13-39,\
14-34,14-35,14-36,14-37,14-38,14-39,15-34,15-35,15-36,15-37,15-38,15-39,\
16-34,16-35,16-36,16-37,16-38,16-39,17-34,17-35,17-36,17-37,17-38,17-39 \
-o ./cross_lap_syl_36hap_out_prefix ./lap3_syl3.contig_001_010.syl_35_90.multihetseq.txt

time msmc -s -I 12-24,12-25,12-26,12-27,12-28,12-29,13-24,13-25,13-26,13-27,13-28,13-29,\
14-24,14-25,14-26,14-27,14-28,14-29,15-24,15-25,15-26,15-27,15-28,15-29,\
16-24,16-25,16-26,16-27,16-28,16-29,17-24,17-25,17-26,17-27,17-28,17-29 \
-o ./cross_lap_inc_36hap_out_prefix ./lap3_inc3.contig_001_010.syl_35_90.multihetseq.txt
