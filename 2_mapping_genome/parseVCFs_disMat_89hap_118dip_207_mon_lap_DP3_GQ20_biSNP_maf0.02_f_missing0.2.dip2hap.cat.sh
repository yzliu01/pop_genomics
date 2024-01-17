#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 18
#SBATCH -t 6-25:30:00
#SBATCH -J geno_dist.gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.02_f_missing0.2.dip2hap
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=geno_dist.gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.02_f_missing0.2.dip2hap.%A.e
#SBATCH --output=geno_dist.gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.02_f_missing0.2.dip2hap.%A.o

module load bioinfo-tools
module load python/3.9.5
module load bcftools

INPUT_FILE=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy/combined_vcf_genotyping
#Ploidy_File=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/PloidyFile_89hap_118dip_207Bsyl.list

cd $INPUT_FILE
DIP2HAP=gatk_325_converted_hap_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.02_f_missing0.2.imputation.with_header_meta.vcf

time bcftools index $DIP2HAP

GENO=gatk_325_converted_hap_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.02_f_missing0.2.imputation.with_header_meta.geno.gz

##--minQual 30 --gtf flag=DP min=5 max=100 --ploidyFile $Ploidy_File --ploidyMismatchToMissing --skipIndels
time python /home/yzliu/bin/parseVCFs.py -i $DIP2HAP \
--threads 10 | bgzip > $GENO

DIST=gatk_325_converted_hap_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.02_f_missing0.2.imputation.with_header_meta.geno.cat_dist

##https://github.com/simonhmartin/genomics_general/issues/29
## -g input.geno.gz -f phased --windType cat -o output.dist
time python /home/yzliu/bin/distMat.py -f phased -g $GENO --windType cat -T 18 -o $DIST


