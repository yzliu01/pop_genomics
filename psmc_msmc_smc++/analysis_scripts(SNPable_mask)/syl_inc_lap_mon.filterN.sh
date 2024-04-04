#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:30:00
#SBATCH -J filter_N
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=filter_N.syl_inc_lap_mon.%A.%a.e
#SBATCH --output=filter_N.syl_inc_lap_mon.%A.%a.o

module load bioinfo-tools vcftools

VCF_DIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/merged_vcf_per_contig
cd $VCF_DIR
VCF=Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.oneway.vcf.gz
OUTPUT_VCF=Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.oneway_filterN.vcf.gz

vcftools --gzvcf $VCF --max-missing 1 --recode --stdout | gzip > ./$OUTPUT_VCF