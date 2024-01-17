#!/bin/bash -l

#SBATCH -A snic2021-22-195
#SBATCH -p core
#SBATCH -n 12
#SBATCH -t 15:00:00
#SBATCH -J gatk_remove_bcftools_combined_vcf_dist_phased.SNP_biallelic
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=gatk_remove_bcftools_combined_vcf_dist_phased.SNP_biallelic.B_syl.%A.e
#SBATCH --output=gatk_remove_bcftools_combined_vcf_dist_phased.SNP_biallelic.B_syl.%A.o

# Main directories as variables
VCF_1=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/DB_VCF/vcftools_filtered_concat_phased

VCF_2=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/DB_VCF_false_samples/vcftools_filtered_concat_phased

OUT_PUT=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/merged_vcf

REF=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/Bombus_sylvicola_v1.fna

module load bioinfo-tools
module load python
module load bcftools/1.14
module load vcftools
module load GATK
module load Beagle/5.1

#cd $VCF_1

#time bcftools view -v snps -m 2 -M 2 -f PASS B.syl_bcftools_SNP_no_filter_concat.vcf.gz \
#-Oz -o B.syl_bcftools_SNP_biallelic_no_filter_concat.vcf.gz

#time gatk IndexFeatureFile -I B.syl_bcftools_SNP_biallelic_no_filter_concat.vcf.gz

#time gatk SelectVariants -V B.syl_bcftools_SNP_biallelic_no_filter_concat.vcf.gz \
#-R /crex/proj/snic2020-6-58/private/yzliu/reference_genome/Bombus_sylvicola_v1.fna \
#-xl-sn false_2individuals.list --exclude-non-variants \
#-O B.bal_bcftools_SNP_biallelic.gatk_207_B_syl.gatk_remove_non_variant.vcf 	# generate a .idx file from gatk

# time bgzip -c B.bal_bcftools_SNP_biallelic.gatk_207_B_syl.gatk_remove_non_variant.vcf > B.bal_bcftools_SNP_biallelic.gatk_207_B_syl.gatk_remove_non_variant.vcf.gz

#time gatk IndexFeatureFile -I B.bal_bcftools_SNP_biallelic.gatk_207_B_syl.gatk_remove_non_variant.vcf.gz

cd $VCF_2
# time gatk IndexFeatureFile -I B.syl_bcftools_SNP_biallelic_no_filter_concat.16false_samples.vcf.gz

time gatk SelectVariants -V B.syl_bcftools_SNP_biallelic_no_filter_concat.16false_samples.vcf.gz \
-R /crex/proj/snic2020-6-58/private/yzliu/reference_genome/Bombus_sylvicola_v1.fna \
-sn include_8_from_bal_to_syl.list --exclude-non-variants \
-O B.syl_bcftools_SNP_biallelic_no_filter_concat.8false_samples.vcf.gz 	# generate a .idx file from gatk

# time gatk IndexFeatureFile -I B.syl_bcftools_SNP_biallelic_no_filter_concat.8false_samples.vcf.gz

cd $OUT_PUT
# merge vcf files (dit not work)
# time gatk CombineGVCFs \
#   -R $REF \
#   --variant $VCF_1/B.bal_bcftools_SNP_biallelic.gatk_207_B_syl.gatk_remove_non_variant.vcf.gz \
#   --variant $VCF_2/B.syl_bcftools_SNP_biallelic_no_filter_concat.15false_samples.vcf.gz \
#   -O removed_merged_B_syl.g.vcf.gz

# bcftools merge vcf files
time bcftools merge $VCF_1/B.bal_bcftools_SNP_biallelic.gatk_207_B_syl.gatk_remove_non_variant.vcf.gz \
$VCF_2/B.syl_bcftools_SNP_biallelic_no_filter_concat.8false_samples.vcf.gz \
-Oz -o gatk_removed_bcftools_merged_215_B_syl.g.vcf.gz

# calculate distance using vcf file   
time /home/yzliu/bin/VCF2Dis-master/VCF2Dis-1.46/bin/VCF2Dis -InPut gatk_removed_bcftools_merged_215_B_syl.g.vcf.gz \
-OutPut gatk_removed_bcftools_merged_215_B_syl.p_dis_for_NJ_tree.mat
   
# attention to the requested memory
# time java -Xmx75g -jar /sw/apps/bioinfo/Beagle/5.1/rackham/beagle.jar gt=gatk_removed_bcftools_merged_215_B_syl.g.vcf.gz \
#out=gatk_removed_bcftools_merged_215_B_syl.g.vcf.gz.phased
   