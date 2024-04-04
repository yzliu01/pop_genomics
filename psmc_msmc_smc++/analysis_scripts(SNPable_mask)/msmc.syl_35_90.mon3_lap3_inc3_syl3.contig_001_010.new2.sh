#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
##SBATCH -p node
#SBATCH -n 2
# 10*6.4GB
##SBATCH -C mem512GB
#SBATCH -t 00:25:00
#SBATCH -J msmc2.syl_35_90.mon3_lap3_inc3_syl3
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=msmc2.syl_35_90.mon3_lap3_inc3_syl3.%A.%a.e
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

## make program executable: chmod +x msmc_2.0.0_linux64bit
# /home/yzliu/bin/msmc/msmc_2.0.0_linux64bit -t 18 -s -I 0,1,2,3 -o ./mon_6hap_out_prefix.new2 ./mon6_lap6_inc5_syl4.contig_001_002.multihetseq.txt

# It is not useful to use more CPUs than the number of chromosomes times the number of haplotype pairs, because that is the number of parallelised likelihood evaluations.

# AVOID input other non-target multihetseq.txt files
# mon6_lap6_inc5_syl4.contig_$chr.multihetseq.txt
# -t 16
#  * [36/36] Expectation Step
time msmc -s -I 0-1,2-3,4-5 -o ./mon_6hap_out_prefix.mon3_lap3_inc3_syl3 ./mon6_lap6_inc5_syl4.contig_*.multihetseq.txt
#,6,7,8,9,10,11
time msmc -s -I 12-13,14-15,16-17 -o ./lap_6hap_out_prefix.mon3_lap3_inc3_syl3 ./mon6_lap6_inc5_syl4.contig_*.multihetseq.txt
#,18,19,20,21,22,23
time msmc -s -I 24-25,26-27,28-29 -o ./inc_6hap_out_prefix.mon3_lap3_inc3_syl3 ./mon6_lap6_inc5_syl4.contig_*.multihetseq.txt
#,30,31,32,33
time msmc -s -I 34-35,36-37,38-39 -o ./syl_6hap_out_prefix.mon3_lap3_inc3_syl3 ./mon6_lap6_inc5_syl4.contig_*.multihetseq.txt
#,40,41

time msmc -s -I 24-34,24-35,24-36,24-37,24-38,24-39,25-34,25-35,25-36,25-37,25-38,25-39,\
26-34,26-35,26-36,26-37,26-38,26-39,27-34,27-35,27-36,27-37,27-38,27-39,\
28-34,28-35,28-36,28-37,28-38,28-39,29-34,29-35,29-36,29-37,29-38,29-39 \
-o ./cross_3inc_3syl_36hap_out_prefix ./mon6_lap6_inc5_syl4.contig_*.multihetseq.txt

time msmc -t 16 -s -I \
0-34,0-35,0-36,0-37,0-38,0-39,\
1-34,1-35,1-36,1-37,1-38,1-39,\
2-34,2-35,2-36,2-37,2-38,2-39,\
3-34,3-35,3-36,3-37,3-38,3-39,\
4-34,4-35,4-36,4-37,4-38,4-39,\
5-34,5-35,5-36,5-37,5-38,5-39 \
-o ./cross_3lap_3syl_36hap_out_prefix ./mon6_lap6_inc5_syl4.contig_*.multihetseq.txt


#time msmc -t 16 -s -I 0-34,0-35,0-36,0-37,0-38,0-39,0-40,0-41,1-34,1-35,1-36,1-37,1-38,1-39,1-40,1-41,\
#2-34,2-35,2-36,2-37,2-38,2-39,2-40,2-41,3-34,3-35,3-36,3-37,3-38,3-39,3-40,3-41,\
#4-34,4-35,4-36,4-37,4-38,4-39,4-40,4-41,5-34,5-35,5-36,5-37,5-38,5-39,5-40,5-41,\
#6-34,6-35,6-36,6-37,6-38,6-39,6-40,6-41,7-34,7-35,7-36,7-37,7-38,7-39,7-40,7-41,\
#8-34,8-35,8-36,8-37,8-38,8-39,8-40,8-41,9-34,9-35,9-36,9-37,9-38,9-39,9-40,9-41,\
#10-34,10-35,10-36,10-37,10-38,10-39,10-40,10-41,11-34,11-35,11-36,11-37,11-38,11-39,11-40,11-41,\
# -o ./cross_lap_syl_8hap_out_prefix ./mon6_lap6_inc5_syl4.contig_*.multihetseq.txt
