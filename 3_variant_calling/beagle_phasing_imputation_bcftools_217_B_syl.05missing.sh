#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 03:00:00
#SBATCH -J beagle_bcf_207_B_syl
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=beagle_phase_bcftools_207_B_syl.05missing.infoDP3_3134Excesshet_25.%A.e
#SBATCH --output=beagle_phase_bcftools_207_B_syl.05missing.infoDP3_3134Excesshet_25.%A.o

# Main directories as variables
# Path to dir with the concatenated vcf-file
SEQDIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy/combined_vcf_genotyping
input_vcf=gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP.missing05_DP3_3134_Excesshet25.vcf.gz
out_vcf=gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP.missing05_DP3_3134_Excesshet25.phased
cd $SEQDIR

module load bioinfo-tools Beagle/5.1

# run beagle
# attention to the requested memory
time java -Xmx50g -jar /sw/apps/bioinfo/Beagle/5.1/rackham/beagle.jar gt=$input_vcf out=$out_vcf

