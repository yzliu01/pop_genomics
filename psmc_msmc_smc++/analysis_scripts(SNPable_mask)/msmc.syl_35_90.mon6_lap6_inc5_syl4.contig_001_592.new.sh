#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
##SBATCH -p node
#SBATCH -n 1
# 10*6.4GB
##SBATCH -C mem1TB
#SBATCH -t 10:30:00
#SBATCH -J msmc2.syl_35_90.mon6_lap6_inc5_syl4.contig_001_592
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=msmc2.syl_35_90.mon6_lap6_inc5_syl4.contig_001_592.%A.%a.e
#SBATCH --output=msmc2.syl_35_90.mon6_lap6_inc5_syl4.contig_001_592.%A.%a.o

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

SNPable_multihetsep_phased_vcf=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/merged_vcf_per_contig/phased_sample_msmc/contig_001_592_multihetseq

cd $SNPable_multihetsep_phased_vcf
out_dir=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/merged_vcf_per_contig/phased_sample_msmc
## make program executable: chmod +x msmc_2.0.0_linux64bit
# /home/yzliu/bin/msmc/msmc_2.0.0_linux64bit -t 18 -s -I 0,1,2,3 -o ./mon_6hap_out_prefix.new2 ./mon6_lap6_inc5_syl4.contig_001_002.multihetseq.txt

# It is not useful to use more CPUs than the number of chromosomes times the number of haplotype pairs, because that is the number of parallelised likelihood evaluations.

# AVOID input other non-target multihetseq.txt files
# mon6_lap6_inc5_syl4.contig_$chr.multihetseq.txt

multihetseq=`ls -l *txt | awk -F " +" '{if($5 > 0) print $9}'`

time msmc -s -I 0,1,2,3,4,5,6,7,8,9,10,11 -o $out_dir/mon_12hap_out_prefix.mon6_lap6_inc5_syl4.contig_001_592 ./$multihetseq
time msmc -s -I 12,13,14,15,16,17,18,19,20,21,22,23 -o $out_dir/lap_12hap_out_prefix.mon6_lap6_inc5_syl4.contig_001_592 ./$multihetseq
time msmc -s -I 24,25,26,27,28,29,30,31,32,33 -o $out_dir/inc_10hap_out_prefix.mon6_lap6_inc5_syl4.contig_001_592 ./$multihetseq
time msmc -s -I 34,35,36,37,38,39,40,41 -o $out_dir/syl_8hap_out_prefix.mon6_lap6_inc5_syl4.contig_001_592 ./$multihetseq

# 6mon: 0,1,2,3,4,5,6,7,8,9,10,11
# 4syl: 34,35,36,37,38,39,40,41
time msmc -s -I \
0-34,0-35,0-36,0-37,0-38,0-39,0-40,0-41,\
1-34,1-35,1-36,1-37,1-38,1-39,1-40,1-41,\
2-34,2-35,2-36,2-37,2-38,2-39,2-40,2-41,\
3-34,3-35,3-36,3-37,3-38,3-39,3-40,3-41,\
4-34,4-35,4-36,4-37,4-38,4-39,4-40,4-41,\
5-34,5-35,5-36,5-37,5-38,5-39,5-40,5-41,\
6-34,6-35,6-36,6-37,6-38,6-39,6-40,6-41,\
7-34,7-35,7-36,7-37,7-38,7-39,7-40,7-41,\
8-34,8-35,8-36,8-37,8-38,8-39,8-40,8-41,\
9-34,9-35,9-36,9-37,9-38,9-39,9-40,9-41,\
10-34,10-35,10-36,10-37,10-38,10-39,10-40,10-41,\
11-34,11-35,11-36,11-37,11-38,11-39,11-40,11-41,\
 -o $out_dir/cross_12mon_8syl_96hap_out_prefix.mon6_lap6_inc5_syl4.contig_001_592 ./$multihetseq

# 6lap: 12,13,14,15,16,17,18,19,20,21,22,23
# 4syl: 34,35,36,37,38,39,40,41
time msmc -s -I \
12-34,12-35,12-36,12-37,12-38,12-39,12-40,12-41,\
13-34,13-35,13-36,13-37,13-38,13-39,13-40,13-41,\
14-34,14-35,14-36,14-37,14-38,14-39,14-40,14-41,\
15-34,15-35,15-36,15-37,15-38,15-39,15-40,15-41,\
16-34,16-35,16-36,16-37,16-38,16-39,16-40,16-41,\
17-34,17-35,17-36,17-37,17-38,17-39,17-40,17-41,\
18-34,18-35,18-36,18-37,18-38,18-39,18-40,18-41,\
19-34,19-35,19-36,19-37,19-38,19-39,19-40,19-41,\
20-34,20-35,20-36,20-37,20-38,20-39,20-40,20-41,\
21-34,21-35,21-36,21-37,21-38,21-39,21-40,21-41,\
22-34,22-35,22-36,22-37,22-38,22-39,22-40,22-41,\
23-34,23-35,23-36,23-37,23-38,23-39,23-40,23-41 \
-o $out_dir/cross_12lap_8syl_96hap_out_prefix.mon6_lap6_inc5_syl4.contig_001_592 ./$multihetseq

# 6lap: 12,13,14,15,16,17,18,19,20,21,22,23
# 5inc: 24,25,26,27,28,29,30,31,32,33
time msmc -s -I \
12-24,12-25,12-26,12-27,12-28,12-29,12-30,12-31,12-32,12-33,\
13-24,13-25,13-26,13-27,13-28,13-29,13-30,13-31,13-32,13-33,\
14-24,14-25,14-26,14-27,14-28,14-29,14-30,14-31,14-32,14-33,\
15-24,15-25,15-26,15-27,15-28,15-29,15-30,15-31,15-32,15-33,\
16-24,16-25,16-26,16-27,16-28,16-29,16-30,16-31,16-32,16-33,\
17-24,17-25,17-26,17-27,17-28,17-29,17-30,17-31,17-32,17-33,\
18-24,18-25,18-26,18-27,18-28,18-29,18-30,18-31,18-32,18-33,\
19-24,19-25,19-26,19-27,19-28,19-29,19-30,19-31,19-32,19-33,\
20-24,20-25,20-26,20-27,20-28,20-29,20-30,20-31,20-32,20-33,\
21-24,21-25,21-26,21-27,21-28,21-29,21-30,21-31,21-32,21-33,\
22-24,22-25,22-26,22-27,22-28,22-29,22-30,22-31,22-32,22-33,\
23-24,23-25,23-26,23-27,23-28,23-29,23-30,23-31,23-32,23-33 \
-o $out_dir/cross_12lap_10inc_120hap_out_prefix.mon6_lap6_inc5_syl4.contig_001_592 ./$multihetseq

# 5inc: 24,25,26,27,28,29,30,31,32,33
# 4syl: 34,35,36,37,38,39,40,41 
time msmc -s -I \
24-34,24-35,24-36,24-37,24-38,24-39,24-40,24-41,\
25-34,25-35,25-36,25-37,25-38,25-39,25-40,25-41,\
26-34,26-35,26-36,26-37,26-38,26-39,26-40,26-41,\
27-34,27-35,27-36,27-37,27-38,27-39,27-40,27-41,\
28-34,28-35,28-36,28-37,28-38,28-39,28-40,28-41,\
29-34,29-35,29-36,29-37,29-38,29-39,29-40,29-41,\
30-34,30-35,30-36,30-37,30-38,30-39,30-40,30-41,\
31-34,31-35,31-36,31-37,31-38,31-39,31-40,31-41,\
32-34,32-35,32-36,32-37,32-38,32-39,32-40,32-41,\
33-34,33-35,33-36,33-37,33-38,33-39,33-40,33-41 \
-o $out_dir/cross_10inc_8syl_80hap_out_prefix.mon6_lap6_inc5_syl4.contig_001_592 ./$multihetseq




