#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 02:00:00
#SBATCH -J beagle_phase_bcftools_55_B_bal
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=beagle_phase_bcftools_55_B_bal.infoDP5_3134Excesshet_25.%A.e
#SBATCH --output=beagle_phase_bcftools_55_B_bal.infoDP5_3134Excesshet_25.%A.o

# Main directories as variables
# Path to dir with the concatenated vcf-file
SEQDIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/BAL/new_variant_calling_ploidy/combined_vcf_genotyping
input_vcf=gatk_17haploid_54diploid_B_bal.SNP_hard_filtered.DP3_GQ20_biSNP_maf005_f_missing05.infoDP3_1000Excesshet_25.sort_chr.vcf.gz
out_vcf=gatk_17haploid_54diploid_B_bal.SNP_hard_filtered.DP3_GQ20_biSNP_maf005_f_missing05.infoDP3_1000Excesshet_25.sort_chr.phased
cd $SEQDIR

module load bioinfo-tools Beagle/5.1

# run beagle
# attention to the requested memory
time java -Xmx25g -jar /sw/apps/bioinfo/Beagle/5.1/rackham/beagle.jar gt=$input_vcf out=$out_vcf

