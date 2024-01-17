#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J bcftools_subset_samples.rm_non_var
#SBATCH --mail-type=all
##SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=bcftools_subset_samples.bal.rm_non_var.%A.e
#SBATCH --output=bcftools_subset_samples.bal.rm_non_var.%A.o

module load bioinfo-tools python bcftools vcftools

path=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/BAL/new_variant_calling_ploidy/combined_vcf_genotyping

cd $path

vcf_maf0=gatk_17haploid_54diploid_B_bal.SNP_hard_filtered.DP3_GQ20_biSNP.missing05_DP3_1000_Excesshet25.vcf.gz
vcf_maf002=gatk_17haploid_54diploid_B_bal.SNP_hard_filtered.DP3_GQ20_biSNP.maf002_missing05_DP3_1000_Excesshet25.vcf.gz

bal=./subpop_list/subset_balteatus_43.list
alp=./subpop_list/subset_12alpinus.list
hyp=./subpop_list/subset_10hyperboreus.list
pol=./subpop_list/subset_6polaris.list

species_list=($bal $alp $hyp $pol)
vcf_list=($vcf_maf0 $vcf_maf002)

out_name=(gatk_17haploid_54diploid_B_bal.SNP_hard_filtered.DP3_GQ20_biSNP.missing05_DP3_1000_Excesshet25 \
gatk_17haploid_54diploid_B_bal.SNP_hard_filtered.DP3_GQ20_biSNP.maf002_missing05_DP3_1000_Excesshet25)

species_name=(bal alp hyp pol)

# This function is to run the jobs in parallel
	function pwait() {
	while [ $(jobs -p | wc -l) -ge $1 ]; do
	sleep $2
	done
	}

function subset_vcf() {
pwait 4 10s
for n in {0,1,2,3}; do
	for i in {0,1}; do
	# create and use array
	bcftools view ${vcf_list[i]} -S ${species_list[n]} | bcftools view -e 'AC==0 || AC == AN' -Oz -o "$out_name.${species_name[n]}.rm_non_vars.gz"
	vcftools --gzvcf "$out_name.${species_name[n]}.rm_non_vars.gz" --FILTER-summary --out "$out_name.${species_name[n]}.rm_non_vars"
	wait
	done
	
done
}
subset_vcf


#for i in {$bal,$alp,$hyp,$pol}; do
#for j in {$vcf_maf0,$vcf_maf002}; do
#for k in {bal,alp,hyp,pol}; do
##		out_vcf=${j/vcf.gz/$i.vcf.gz}
bcftools view $j -S $i -Oz -o "$j##$k.gz"
#done
#done
#done


#function suset_vcf() {

#	module load bioinfo-tools python bcftools
#	out_vcf=${j/vcf.gz/$i.vcf.gz}
#	for i in {bal,alp,hyp,pol}; do
#		for j in {vcf_maf0,vcf_maf002}; do

#			bcftools view -S $i $j | bcftools view -e 'AC==0 || AC == AN' -Oz -o $out_vcf
#			done
#		done
#}

#suset_vcf



