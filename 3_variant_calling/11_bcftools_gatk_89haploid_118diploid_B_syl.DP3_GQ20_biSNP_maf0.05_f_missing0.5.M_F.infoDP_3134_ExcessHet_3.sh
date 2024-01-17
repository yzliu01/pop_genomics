#!/bin/bash -l

#SBATCH -A snic2021-22-195
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 02:00:00
#SBATCH -J DP3_GQ20_biSNP_maf0.05_f_missing0.5.infoDP5_3134Excehet_3
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=bcftools_DP3_GQ20_biSNP_maf0.05_f_missing0.5.infoDP5_3134Excehet_3.dist.%A.e
#SBATCH --output=bcftools_DP3_GQ20_biSNP_maf0.05_f_missing0.5.infoDP5_3134Excehet_3.dist.%A.o

# input dir
INPUT_DIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy/combined_vcf_genotyping

cd $INPUT_DIR

INPUT_FILE=gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.05_f_missing0.5.vcf.gz
OUTPUT_FILE=gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.05_f_missing0.5.infoDP5_3134Excesshet_3.vcf.gz

module load bioinfo-tools
module load python
module load bcftools/1.14

# not used -v snps --max-missing 0.7 --maf 0.15 -f PASS
bcftools view -e 'INFO/DP > 3134 | INFO/ExcessHet > 3' $INPUT_FILE -Oz -o $OUTPUT_FILE

#time /home/yzliu/bin/VCF2Dis-master/VCF2Dis-1.46/bin/VCF2Dis -InPut $OUTPUT_FILE \
#-OutPut remove_heterozygous_sites_in_male_monticola_lapponicus_207_B_syl.infoDP5.dist.txt


