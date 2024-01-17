#!/bin/bash -l
#SBATCH -A snic2022-22-258
#SBATCH -p node
##SBATCH -w r23
##SBATCH --nodelist=r[1-32]
##SBATCH -n 10
#SBATCH -C "mem256G&usage_mail"
##SBATCH -C mem256GB
##SBATCH --ntasks=1
##SBATCH --cpus-per-task=10
##SBATCH --mem-per-cpu=16g
##SBATCH --qos=short
#SBATCH -C usage_mail
#SBATCH -t 03:10:00
#SBATCH -J beagle_49Atum_1Agla_1Amel
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=7_beagle_phase_49Atum_1Agla_1Amel.EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.phased_specific1.%A.e
#SBATCH --output=7_beagle_phase_49Atum_1Agla_1Amel.EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.phased_specific1.%A.o

module load bioinfo-tools bcftools Beagle/5.1

#272 nodes with 128 GB memoryi (r33-r304,6.4GB/core) and 32 nodes with 256 GB (r1-r32, 16GB/core)
#Noder
#-w r[100] for submit to Rackham node number 100.
#Features – memory
#-C thin / -C 128GB
#-C fat / -C 256GB, -C 1TB


## vcf file
VCF=/crex/proj/snic2020-6-58/private/yzliu/test/fastq_bt/gVCF/DB_VCF/merged_gvcf_genotyping
cd $VCF
input_vcf_with_outgroup=merged_49Atum_1Agla_2Dpon_1Amel.SNP.H_F.EH_50_FMT_DP3_50_GQ20_BiSNP.vcf.gz
output_vcf_with_outgroup=merged_49Atum_1Agla_1Amel.SNP.H_F.EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.vcf.gz
output_vcf_with_outgroup_phased=merged_49Atum_1Agla_1Amel.SNP.H_F.EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.phased_specific1.vcf.gz
# include samples: -s comma_separated_sample_name (^sample_name to exclude)

#time bcftools view --min-ac 2:minor -s ^DP_M,DP_M2 -e 'F_MISSING > 0.5 || AC==0 || AC == AN' $input_vcf_with_outgroup -Oz -o $output_vcf_with_outgroup

## run beagle
## attention to the requested memory (need more mem)
time java -Xmx160g -jar /sw/apps/bioinfo/Beagle/5.1/rackham/beagle.jar gt=$output_vcf_with_outgroup out=$output_vcf_with_outgroup_phased
#time java -Xmx20g -jar /sw/apps/bioinfo/Beagle/5.1/rackham/beagle.jar gt=$input_vcf_mon out=$out_vcf_mon

