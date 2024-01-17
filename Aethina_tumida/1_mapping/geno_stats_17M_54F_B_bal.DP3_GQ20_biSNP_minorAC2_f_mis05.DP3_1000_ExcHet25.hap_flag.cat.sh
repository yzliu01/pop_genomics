#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 12:20:00
#SBATCH -J minorAC2_geno_stats.DP3_1000_ExHet25
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=geno_stats_17M_54F_Bbal.GQ20_biSNP_minorAC2_missing05.DP3_1000ExHet_25.ploidy_flag.%A.e
#SBATCH --output=geno_stats_17M_54F_Bbal.GQ20_biSNP_minorAC2_missing05.DP3_1000ExHet_25.ploidy_flag.%A.o

module load bioinfo-tools python bcftools

INPUT_DIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/BAL/new_variant_calling_ploidy/combined_vcf_genotyping
Ploidy_File=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/BAL/PloidyFile_17hap_54dip_71Bbal.list

cd $INPUT_DIR

alp=gatk_bcftools.SNP_hard_filtered.GQ20_biSNP.missing05_DP3_1000_ExHet25_minorAC2.alp.rm_non_var.phased.vcf.header.vcf.gz
bal=gatk_bcftools.SNP_hard_filtered.GQ20_biSNP.missing05_DP3_1000_ExHet25_minorAC2.bal.rm_non_var.phased.vcf.header.vcf.gz
hyp=gatk_bcftools.SNP_hard_filtered.GQ20_biSNP.missing05_DP3_1000_ExHet25_minorAC2.hyp.rm_non_var.phased.vcf.header.vcf.gz
pol=gatk_bcftools.SNP_hard_filtered.GQ20_biSNP.missing05_DP3_1000_ExHet25_minorAC2.pol.rm_non_var.phased.vcf.header.vcf.gz

#time bcftools index $vcf
#GENO=.geno.gz

## This function is to run the jobs in parallel
	function pwait() {
	while [ $(jobs -p | wc -l) -ge $1 ]; do
	sleep $2
	done
	}

vcf=($alp $bal $hyp $pol)
species=(alp bal hyp pol)
###################################   for loop to run batch jobs   ######################
function geno_bal_alp_hyp_pol() {
	pwait 1 10s
	for n in {0,1,2,3}; do
	#--minQual 30 --gtf flag=DP min=5 max=100
	time python /home/yzliu/bin/parseVCFs.py -i ${vcf[n]} --ploidyFile $Ploidy_File \
--ploidyMismatchToMissing --skipIndels --threads 8 | bgzip > gatk_bcftools.SNP_hard_filtered.GQ20_biSNP.missing05_DP3_1000_ExHet25_minorAC2.${species[n]}.rm_non_var.phased.header.geno.gz
	done
}
geno_bal_alp_hyp_pol

wait
#DIST=
#https://github.com/simonhmartin/genomics_general/issues/29
# -g input.geno.gz -f phased --windType cat -o output.dist
#time python /home/yzliu/bin/distMat.py -f phased -g $GENO --windType cat -T 18 \
#--haploid M_L075 M_L093 M_L113 M_L130 M_L131 M_L133 M_L136 M_L140 M_L143 M_L146 M_L150 M_L152 M_L153 M_L159 M_L166 M_L167 M_L172 WO_002 BH_01 BH_02 BH_03 BH_04 BH_05 BH_06 BH_14 BH_15 BH_17 M_L008 M_L057 M_L071 M_L072 M_L074 M_L076 M_L077 M_L081 M_L082 M_L083 M_L084 M_L086 M_L087 M_L088 M_L090 M_L091 M_L092 M_L095 M_L109 M_L110 M_L111 M_L112 M_L114 M_L115 M_L116 M_L117 M_L120 M_L121 M_L122 M_L123 M_L124 M_L125 M_L127 M_L139 M_L144 M_L145 M_L148 M_L154 M_L157 M_L171 M_L173 M_L174 M_L175 M_L176 M_L183 M_L184 M_L185 M_L186 M_L187 M_L193 WO_007 WO_358 WO_815 WO_865 BH_10 BH_12 BH_18 M_L199 M_L200 M_L215 M_L216 M_L226 \
#-o $DIST

# 74 geno - 190 min dist + 
#time python /home/yzliu/bin/distMat.py -f phased -g $GENO --windType cat -T 18 --ploidyFile $Ploidy_File -o $DIST

#popFile=./subpop_list/popsFile_43bal_12alp_10hyp_6pol.list
popFile=./subpop_list/popsFile_43bal_12alp_10hyp_6pol.short.list

# have issue - solution - index geno.gz file
# Traceback (most recent call last):   File "/usr/lib64/python2.7/multiprocessing/process.py", line 258, in _bootstrap     self.run()
# https://github.com/simonhmartin/genomics_general/issues/14

# calculate Fst pi Dxy
function stats_bal_alp_hyp_pol() {
	pwait 4 10s
	for n in {0,1,2,3}; do
	tabix -p vcf gatk_bcftools.SNP_hard_filtered.GQ20_biSNP.missing05_DP3_1000_ExHet25_minorAC2.${species[n]}.rm_non_var.phased.header.geno.gz
	python /home/yzliu/bin/simon_martin/popgenWindows.py --ploidyFile $Ploidy_File -w 30000 -m 10 \
-g gatk_bcftools.SNP_hard_filtered.GQ20_biSNP.missing05_DP3_1000_ExHet25_minorAC2.${species[n]}.rm_non_var.phased.header.geno.gz \
-o gatk_bcftools.SNP_hard_filtered.GQ20_biSNP.missing05_DP3_1000_ExHet25_minorAC2.${species[n]}.rm_non_var.phased.header.csv.gz \
-p ${species[n]} -f phased -T 6 --popsFile $popFile --addWindowID
	done
}
stats_bal_alp_hyp_pol

# run on one contig
# contig_file
#python /home/yzliu/bin/simon_martin/popgenWindows.py --ploidyFile $Ploidy_File -w 1 --include ./contig_file \
#-g gatk_bcftools.SNP_hard_filtered.GQ20_biSNP.missing05_DP3_1000_ExHet25_minorAC2.pol.rm_non_var.phased.header.geno.gz \
#-o gatk_bcftools.SNP_hard_filtered.GQ20_biSNP.missing05_DP3_1000_ExHet25_minorAC2.pol.rm_non_var.phased.header.csv.win1_contig_008.gz \
#-p pol -f phased -T 6 --popsFile $popFile --addWindowID

# vcftools - calculate pi and Tajima's DIST
# females
alp_F=subset_12alpinus.list
bal_F=balteatus_26female.list
hyp_F=subset_10hyperboreus.list
pol_F=subset_6polaris.list
female=($alp_F $bal_F $hyp_F $pol_F)

function pi_bal_alp_hyp_pol() {
	pwait 4 10s
	for n in {0,1,2,3}; do
	vcftools --gzvcf ${vcf[n]} --window-pi 30000 --keep ./subpop_list/${female[n]} --out ./vcftools_stats/gatk_bcftools.SNP_hard_filtered.GQ20_biSNP.missing05_DP3_1000_ExHet25_minorAC2.${species[n]}.rm_non_var.phased.vcf.header
	done
}

#pi_bal_alp_hyp_pol

function tajima_bal_alp_hyp_pol() {
	pwait 4 10s
	for n in {0,1,2,3}; do
	vcftools --gzvcf ${vcf[n]} --TajimaD 30000 --keep ./subpop_list/${female[n]} --out ./vcftools_stats/gatk_bcftools.SNP_hard_filtered.GQ20_biSNP.missing05_DP3_1000_ExHet25_minorAC2.${species[n]}.rm_non_var.phased.vcf.header
	done
}
#tajima_bal_alp_hyp_pol
pi_bal_alp_hyp_pol & tajima_bal_alp_hyp_pol
