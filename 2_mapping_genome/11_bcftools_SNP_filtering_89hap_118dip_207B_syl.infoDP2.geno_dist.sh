#!/bin/bash -l

#SBATCH -A snic2021-22-195
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 1-01:00:00
#SBATCH -J infoDP2.geno_dist.B_syl_bcftools_filtering
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=bcftools_filtering_maf0.01_missing0.1_infoDP2_B_syl.geno.dist.%A.e
#SBATCH --output=bcftools_filtering_maf0.01_missing0.1_infoDP2_B_syl.geno.dist.%A.o

# input dir
INPUT_DIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy/combined_vcf_genotyping

Ploidy_File=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/PloidyFile_89hap_118dip_207Bsyl.list

cd $INPUT_DIR

INPUT_FILE=gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.vcf.gz
OUTPUT_FILE=gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.biallelic_Maf0.01Missing0.1infoDP2.vcf.gz

module load bioinfo-tools
module load python
module load bcftools/1.14

# not used -v snps --max-missing 0.7 --maf 0.15 -f PASS --min-ac 5
bcftools view -v snps -m 2 -M 2 -f PASS -i 'MAF > 0.01 & F_MISSING < 0.1 & MIN(INFO/DP) > 2' $INPUT_FILE -Oz -o $OUTPUT_FILE


HAP_DIP=gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.biallelic_Maf0.01Missing0.1infoDP2.vcf.gz

time bcftools index $HAP_DIP

#--minQual 30 --gtf flag=DP min=5 max=100
time python /home/yzliu/bin/parseVCFs.py -i $HAP_DIP --ploidyFile $Ploidy_File \
--ploidyMismatchToMissing --skipIndels --threads 4 | bgzip > gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.biallelic_Maf0.01Missing0.1infoDP2.geno.gz


GENO=gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.biallelic_Maf0.01Missing0.1infoDP2.geno.gz
OUT_PUT=gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.biallelic_Maf0.01Missing0.1infoDP2.geno.dist

module load python/3.9.5
#https://github.com/simonhmartin/genomics_general/issues/29
# -g input.geno.gz -f phased --windType cat -o output.dist
time python /home/yzliu/bin/distMat.py -f phased -g $GENO --windType coordinate -w 5000 -T 4 --ploidyFile $Ploidy_File -o $OUT_PUT


