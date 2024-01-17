#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p node
#SBATCH -n 1
#SBATCH -t 04:00:00
#SBATCH -J beagle_atum
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=7_beagle_phase_atum_EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.%A.e
#SBATCH --output=7_beagle_phase_atum_EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.%A.o

## vcf file
VCF=/crex/proj/snic2020-6-58/private/yzliu/test/fastq_bt/gVCF/DB_VCF/merged_gvcf_genotyping
cd $VCF
input_vcf_atum=merged_49Atum.SNP.H_F.EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.vcf.gz
#input_vcf_mon=merged_49Atum_1Agla_2Dpon_1Amel.SNP.H_F.FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.vcf.gz
out_vcf_atum=merged_49Atum.SNP.H_F.EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.phased
#out_vcf_mon=merged_49Atum_1Agla_2Dpon_1Amel.SNP.H_F.FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.phased

module load bioinfo-tools Beagle/5.1

## run beagle
## attention to the requested memory (need more mem)
time java -Xmx110g -jar /sw/apps/bioinfo/Beagle/5.1/rackham/beagle.jar gt=$input_vcf_atum out=$out_vcf_atum
#time java -Xmx20g -jar /sw/apps/bioinfo/Beagle/5.1/rackham/beagle.jar gt=$input_vcf_mon out=$out_vcf_mon

