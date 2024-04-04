#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 02:30:00
##should be SBATCH -t 4-08:30:00
#SBATCH -J 32mu_smc++.vcf2smc
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=smc++.vcf2smc.syl_35_90.mon3_lap3_inc3_sy3.%A.e
#SBATCH --output=smc++.vcf2smc.syl_35_90.mon3_lap3_inc3_sy3.%A.o

# 2.Convert your VCF(s) to the SMC++ input format with vcf2smc
module load bioinfo-tools SMC++/1.15.4
# python bcftools
# python/3.9.5 bcftools/1.14

VCF=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/merged_vcf_per_contig
VCF_FILE=Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.oneway.imp.with_header.vcf.gz

OUT=$VCF/smc
REF=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/
chr=`awk '{print $1}' $REF/Bombus_sylvicola_v1.fna.fai | sort -V`

mapability_bed=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/SNPable_syl/syl_35_50.contig_001_592.mask.bed.gz

## index the vcf file
# bcftools index $VCF/$VCF_FILE

cd $OUT

## index vcf and bed.gz files
# samtools tabix
# tabix $VCF_FILE
# tabix syl_35_50.contig_001_592.mask.bed.gz

#for species in {mon_3ind,lap_3ind,syl_3ind,inc_3ind};do
#mkdir $species
#done

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

# This function is to run the jobs in parallel
	function pwait() {
	while [ $(jobs -p | wc -l) -ge $1 ]; do
	sleep $2
	done
	}

## use multiple variables in for loop
## https://stackoverflow.com/questions/11215088/bash-shell-script-two-variables-in-for-loop


function mon_smc_parallel() {

		pwait 100 10s

# use multiple variables in for loop
# (BH_16 AC-020) or {BH_16,AC-020}

	for i in $chr; do
		for j in {M_L013,M_L054,M_L211}; do
		smc++ vcf2smc -d $j $j $VCF/$VCF_FILE \
		--mask $mapability_bed \
		$OUT/mon_3ind/"mon_3ind.$i.$j.txt" $i \
		mon_3ind:M_L013,M_L054,M_L211
		done

	done
}
#mon_smc_parallel

function lap_smc_parallel() {

		pwait 100 10s

# use multiple variables in for loop
	for i in $chr; do
		for j in {M_L028,M_L043,M_L060}; do
		smc++ vcf2smc -d $j $j $VCF/$VCF_FILE \
		--mask $mapability_bed \
		$OUT/lap_3ind/"lap_3ind.$i.$j.txt" $i \
		lap_3ind:M_L028,M_L043,M_L060
		done

	done
}
#lap_smc_parallel

function syl_smc_parallel() {

		pwait 100 10s

# use multiple variables in for loop
	for i in $chr; do
		for j in {72_S_Bor_2_W,300_S_Hor_10_W,586_S_Pen_17_W}; do
		smc++ vcf2smc -d $j $j $VCF/$VCF_FILE \
		--mask $mapability_bed \
		$OUT/syl_3ind/"syl_3ind.$i.$j.txt" $i \
		syl_3ind:72_S_Bor_2_W,300_S_Hor_10_W,586_S_Pen_17_W
		done

	done
}
#syl_smc_parallel

function inc_smc_parallel() {

		pwait 100 10s

# use multiple variables in for loop
	for i in $chr; do
		for j in {120_S_Bor_6_W,262_S_Hor_10_W,612_S_Pen_18_W}; do
		smc++ vcf2smc -d $j $j $VCF/$VCF_FILE \
		--mask $mapability_bed \
		$OUT/inc_3ind/"inc_3ind.$i.$j.txt" $i \
		inc_3ind:120_S_Bor_6_W,262_S_Hor_10_W,612_S_Pen_18_W
		done

	done
}
#inc_smc_parallel


## run four functions simutaneously
mon_smc_parallel & lap_smc_parallel & syl_smc_parallel & inc_smc_parallel
wait

# 3.Fit the model using estimate
#for results in {Atum_BF1,Atum_BF2,Atum_LB,Atum_GZ,Atum_SA,Atum_TZ}; do
# ./mon_3ind/mon_3ind.contig_592.M_L013.txt
# pandas.errors.EmptyDataError: No columns to parse from file

# change file names to exclude them
#for results in {mon_3ind,lap_3ind,inc_3ind,syl_3ind}; do
#	cd $results
#		for chr in {293,448,486,584};do
#		rename $results _$results *contig_$chr*.txt
##		rename lap_3ind _lap_3ind  *contig_$chr*.txt; done
##		mv $results.contig_$chr*.txt _$results.contig_$chr*.txt
#		done
#	cd ..
#done

#for results in {mon_3ind,lap_3ind,syl_3ind,inc_3ind}; do
		# run parallel jobs
#		smc++ estimate --cores 4 3.60e-9 --timepoints 1e1 1e6 --spline cubic --knots 40 $OUT/$results/$results.contig*.txt -o $OUT/$results
		# better parameter
		# --ftol 1e-3
		# --knots 24
		# --timepoints 10 100000000
		# --timepoints 1e1 1e7
		# 0.89e-10 better https://www.nature.com/articles/s42003-020-1060-8
		# 3.60e-9 for bumblebee based on other insect
		# 2.10e-9 https://doi.org/10.1093/molbev/msac016
		
#		done
