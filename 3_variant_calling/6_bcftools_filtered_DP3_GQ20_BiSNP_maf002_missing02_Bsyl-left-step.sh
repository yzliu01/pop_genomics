#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 10
#SBATCH -t 4:00:00
#SBATCH -J bcftools_filtered_DP3_GQ20_BiSNP_maf002_missing02_Bsyl
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=bcftools_filtered_DP3_GQ20_BiSNP_maf002_missing02_Bsyl.%A.e
#SBATCH --output=bcftools_filtered_DP3_GQ20_BiSNP_maf002_missing02_Bsyl.%A.o

# Main directories as variables
INPUT_DIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy/combined_vcf_genotyping

cd $INPUT_DIR

Input_vcf=gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.vcf.gz
SNP_DP3_GQ20=gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20.vcf.gz
DP3_GQ20_BiSNP=gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP.vcf.gz
DP3_GQ20_BiSNP_maf002_f_missing02=gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.02_f_missing0.2.vcf.gz

Beagle_imputating1=gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP.imputation.vcf
Beagle_imputating2=gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.02_f_missing0.2.imputation.vcf

#Compress_vcf=gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.biallelic_SNP_imputation.vcf.gz

module load bioinfo-tools
module load python
module load bcftools/1.14
#module load Beagle/5.1

# keep only biallelic SNPs

#bcftools view -i 'FORMAT/DP > 3 | FORMAT/GQ > 20' $Input_vcf -Oz -o $SNP_DP3_GQ20

# Keep passed filters; remove multiallelic SNPs and indels, monomorphic SNPs, and SNPs in the close proximity of indels
#bcftools view -v snps -m 2 -M 2 -f PASS $SNP_DP3_GQ20 | bcftools filter -e 'AC==0 || AC == AN' --SnpGap 10 -Oz -o $DP3_GQ20_BiSNP

#check the filtering results
#bcftools query -i 'MIN(FORMAT/DP) > 3 | MIN(FORMAT/GQ) > 20' -f '%CHROM\t%POS[\t%SAMPLE:DP=%DP GQ=%GQ]\n' $Input_vcf

#bcftools filter -e 'MAF <= 0.02 || F_MISSING > 0.2' $DP3_GQ20_BiSNP -Oz -o $DP3_GQ20_BiSNP_maf002_f_missing02

# run beagle no further filtering
#java -Xmx75g -jar /sw/apps/bioinfo/Beagle/5.1/rackham/beagle.jar gt=$DP3_GQ20_BiSNP out=$Beagle_imputating1

# run beagle filtering missing and maf
java -Xmx60g -jar /sw/apps/bioinfo/Beagle/5.1/rackham/beagle.jar gt=$DP3_GQ20_BiSNP_maf002_f_missing02 out=$Beagle_imputating2


# compress vcf for bcftools
#bgzip -c $Beagle_imputating > $Compress_vcf

# filter missing data etc.
# example: -i 'MAF > 0.01 & F_MISSING < 0.1 & MIN(FORMAT/DP) > 5'
#bcftools view -i 'MAF > 0.05 && F_MISSING < 0.5 | MIN(FORMAT/DP) > 2 | MIN(FORMAT/GQ) > 20' $Input_vcf -Oz -o $Output_vcf
#bcftools query -i 'MAF > 0.05 && F_MISSING < 0.5 | MIN(FORMAT/DP) > 2 | MIN(FORMAT/GQ) > 20' -f '%POS[\tSAMPLE:MAF=MAF% F_MISSING=%F_MISSING DP=%DP  GQ=%GQ]\n' $Input_vcf | head
#bcftools query -i 'MAF > 0.05 && F_MISSING < 0.5 && MIN(FORMAT/DP) > 2 | MIN(FORMAT/GQ) > 20' -f '%CHROM\t%POS[\t%SAMPLE:DP=%DP GQ=%GQ]\n' $Input_vcf | head -30 | less -S

