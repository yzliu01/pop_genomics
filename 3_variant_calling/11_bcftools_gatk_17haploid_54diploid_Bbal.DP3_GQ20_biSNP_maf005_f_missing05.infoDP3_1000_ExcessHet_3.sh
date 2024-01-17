#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 04:00:00
#SBATCH -J DP3_GQ20_biSNP_maf0.05_f_missing0.5.infoDP3_1000Excesshet_3
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=bcftools_DP3_GQ20_biSNP_maf0.05_f_missing0.5.infoDP3_1000Excesshet_3.dist.%A.e
#SBATCH --output=bcftools_DP3_GQ20_biSNP_maf0.05_f_missing0.5.infoDP3_1000Excesshet_3.dist.%A.o

# input dir
INPUT_DIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/BAL/new_variant_calling_ploidy/combined_vcf_genotyping

cd $INPUT_DIR

INPUT_FILE=gatk_17haploid_54diploid_B_bal.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.05_f_missing0.5.vcf.gz
OUTPUT_FILE=gatk_17haploid_54diploid_B_bal.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.05_f_missing0.5.infoDP3_1000Excesshet_3.vcf.gz

module load bioinfo-tools
module load python
module load bcftools/1.14

sort=gatk_17haploid_54diploid_B_bal.SNP_hard_filtered.DP3_GQ20_biSNP_maf005_f_missing05.bcftools_sort_chr.vcf.gz

# not used -v snps --max-missing 0.7 --maf 0.15 -f PASS
bcftools view -e 'INFO/DP > 1000 | INFO/ExcessHet > 3' $INPUT_FILE -Oz -o $OUTPUT_FILE
bcftools index $OUTPUT_FILE
bcftools sort $OUTPUT_FILE -Oz -o $sort

#time /home/yzliu/bin/VCF2Dis-master/VCF2Dis-1.46/bin/VCF2Dis -InPut $OUTPUT_FILE \
#-OutPut remove_heterozygous_sites_in_male_monticola_lapponicus_207_B_syl.infoDP3.dist.txt


