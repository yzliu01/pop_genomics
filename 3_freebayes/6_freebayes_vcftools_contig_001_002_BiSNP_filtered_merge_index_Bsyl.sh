#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 00:30:00
#SBATCH -J freebayes_vcftools_BiSNP_filtered.contig_001_002_merge_M_F.Bsyl
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=freebayes_vcftools_BiSNP_filtered.contig_001_002_merge_M_F.Bsy.%A.e
#SBATCH --output=freebayes_vcftools_BiSNP_filtered.contig_001_002_merge_M_F.Bsy.%A.o

## lode modules
module load bioinfo-tools
module load python
module load bcftools/1.14
#module load vcftools

input_dir=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/freebayes_variant_calling/gVCF

cd $input_dir
out_male=freeBayes_male_27monticola_62lapponicus.contig_001_002.bi_snp_thin_DP3_maf005_missing05.g.vcf.gz
out_female=freeBayes_female_52monticola_66lapponicus.contig_001_002.bi_snp_thin_DP3_maf005_missing05.g.vcf.gz
out_merge_F_M=bcftools_freebayes_vcftools_filtered_DP3_GQ20_BiSNP_maf005_missing05_Bsyl.contig_001_002_merge_M_F.vcf.gz
out_merge_filter_maf005_missing05_F_M=bcftools_freebayes_vcftools_filtered_DP3_GQ20_BiSNP_maf005_missing05_Bsyl.contig_001_002_merge_M_F.maf005_missing05.vcf.gz

## index the file
for i in `ls free*contig_001_002.bi_snp_thin_DP3_maf005_missing05.g.vcf.gz`; do
time bcftools index $i
done

time bcftools merge $out_male $out_female -Oz -o $out_merge_F_M

bcftools index $out_merge_F_M

bcftools filter -e 'MAF <= 0.05 | F_MISSING > 0.5' $out_merge_F_M -Oz -o $out_merge_filter_maf005_missing05_F_M

bcftools index $out_merge_filter_maf005_missing05_F_M




