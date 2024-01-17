#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 00:10:00
#SBATCH -J bts_mon
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=bcftools_subset_79mon.%A.e
#SBATCH --output=bcftools_subset_79mon.%A.o

module load bioinfo-tools
module load python
module load bcftools/1.14

module load vcftools
# input dir
INPUT_DIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy/combined_vcf_genotyping

cd $INPUT_DIR
# mon
INPUT_FILE=gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.05_f_missing0.5.infoDP3_3134Excesshet_3.vcf.gz
SMP_LIST=$INPUT_DIR/Fst_pop_list/mon_79_Abisko_63_Jämtland_Härjedalen_16.list
OUTPUT_FILE=bcftools_subset_79mon_biSNP_mis05.vcf.gz

vcftools --gzvcf $INPUT_FILE --keep $SMP_LIST --recode --recode-INFO-all \
--mac 1 --non-ref-ac-any 1 --min-alleles 2 --max-alleles 2 --max-missing 0.5 \
--stdout | bgzip -c >  $OUTPUT_FILE &

# lap
INPUT_FILE=gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.05_f_missing0.5.infoDP3_3134Excesshet_3.vcf.gz
SMP_LIST=$INPUT_DIR/Fst_pop_list/lap_128_Abisko_109_Jämtland_Härjedalen_19.list
OUTPUT_FILE=bcftools_subset_128lap_biSNP_mis05.vcf.gz

vcftools --gzvcf $INPUT_FILE --keep $SMP_LIST --recode --recode-INFO-all \
--mac 1 --non-ref-ac-any 1 --min-alleles 2 --max-alleles 2 --max-missing 0.5 \
--stdout | bgzip -c >  $OUTPUT_FILE &

# --min-alleles 2 --max-alleles 2

# bcftools index $OUTPUT_FILE
bcftools view $INPUT_FILE -S $SMP_LIST -Oz -o $OUTPUT_FILE &



