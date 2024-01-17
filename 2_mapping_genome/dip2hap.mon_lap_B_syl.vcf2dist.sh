#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 06:00:00
#SBATCH -J gatk_325_converted_hap_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.02_f_missing0.2.imp.dist
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=gatk_325_converted_hap_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.02_f_missing0.2.imp.dist.%A.e
#SBATCH --output=gatk_325_converted_hap_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.02_f_missing0.2.imp.dist.%A.o

# Main directories as variables
INPUT=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy/combined_vcf_genotyping

cd $INPUT

#module load bioinfo-tools
#module load vcftools
#module load python
#module load bcftools

DIP2HAP=gatk_325_converted_hap_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.02_f_missing0.2.imputation.with_header_meta.vcf
OUT=gatk_325_converted_hap_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.02_f_missing0.2.imputation.with_header_meta.dis
#time python /home/yzliu/bin/parseVCFs.py -i $DIP2HAP --ploidyFile all_haploid_1.list

time /home/yzliu/bin/VCF2Dis-master/VCF2Dis-1.46/bin/VCF2Dis \
-InPut $DIP2HAP -OutPut $OUT


