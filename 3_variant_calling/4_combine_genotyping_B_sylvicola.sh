#!/bin/bash -l

#SBATCH -A snic2021-22-195
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 4-00:00:00
##SBATCH -a 1-100%50
#SBATCH -J B_syl_89haploid_118diploid_genotyping
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=B_syl_haploid_diploid_genotyping.%A.e
#SBATCH --output=B_syl_haploid_diploid_genotyping.%A.o

# Main directories as variables
SEQDIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy

# Reference sequence
REF=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/Bombus_sylvicola_v1.fna

# Create directory for DataBase and VCF fiels

cd $SEQDIR; mkdir combined_vcf_genotyping
OUTPUT=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy/combined_vcf_genotyping
# load modules
module load bioinfo-tools
module load GATK

time gatk CombineGVCFs -R $REF -V $SEQDIR/haploid_diploid_vcf.monticola_lapponicus.B_syl.list -O $OUTPUT/combined_89haploid_118diploid_B_syl.g.vcf.gz

time gatk --java-options "-Xmx4g -Xms4g" GenotypeGVCFs -R $REF \
-V combined_89haploid_118diploid_B_syl.g.vcf.gz \
-O genotyping_output_89haploid_118diploid_B_syl.g.vcf.gz
