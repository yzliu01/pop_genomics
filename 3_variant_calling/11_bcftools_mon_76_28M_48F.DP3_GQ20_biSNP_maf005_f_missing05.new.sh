#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 02:00:00
#SBATCH -J mon_76_28M_48F.rm_non_var
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=bcftools_mon_76_28M_48F.DP3_GQ20_biSNP_maf005_f_missing05.rm_non_var.%A.e
#SBATCH --output=bcftools_mon_76_28M_48F.DP3_GQ20_biSNP_maf005_f_missing05.rm_non_var.%A.o

# input dir
INPUT_DIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy/combined_vcf_genotyping

cd $INPUT_DIR

INPUT_FILE=gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.05_f_missing0.5.vcf.gz
OUTPUT_FILE1=mon_76_28M_48F.DP3_GQ20_biSNP_maf005_f_missing05.vcf.gz
OUTPUT_FILE2=mon_76_28M_48F.DP3_GQ20_biSNP_maf005_f_missing05.rm_non_var.vcf.gz

#OUTPUT_FILE3=mon_76_28M_48F.DP3_GQ20_biSNP_maf005_f_missing05.infoDP4_3134Excesshet_25.rm_non_var.dist.gz
pop_mon=./Fst_pop_list/mon_76_28M_48F.list

module load bioinfo-tools
module load vcftools
module load python
module load bcftools/1.14

#vcf-subset -c $pop_mon $vcf -e | fill-an-ac | bgzip -c > mon_76_28M_48F.DP3_GQ20_biSNP_maf005_f_missing05.rm_non_var.vcf.gz &


# not used -v snps --max-missing 0.7 --maf 0.15 -f PASS
#'AC==0 || AC == AN'
#bcftools view -S $pop_mon -e 'INFO/DP > 3134 | INFO/ExcessHet > 25 | AC==0 || AC == AN' $INPUT_FILE -Oz -o $OUTPUT_FILE

bcftools view -S $pop_mon $INPUT_FILE -Oz -o $OUTPUT_FILE1
bcftools view -e 'AC==0 || AC == AN' $OUTPUT_FILE1 -Oz -o $OUTPUT_FILE2



