#!/bin/bash -l

#SBATCH -A snic2021-22-195
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 01:00:00
#SBATCH -J mon_lapp_missingness_0.3.B_syl.dist
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=remove_common_heterozygous_sites_in_M_F_mon_lapp_207_missingness_0.3.B_syl.dist.%A.e
#SBATCH --output=remove_common_heterozygous_sites_in_M_F_mon_lapp_207_missingness_0.3.B_syl.dist.%A.o

# Input dir
INPUT_DIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/DB_VCF/vcftools_filtered_concat_phased
cd $INPUT_DIR

module load bioinfo-tools
module load python
module load bcftools/1.14

INPUT_FILE=remove_heterozygous_sites_in_male_monticola_lapponicus_207_B_syl.vcf.gz

time bcftools view $INPUT_FILE -i "F_MISSING<0.3" -Oz -o remove_heterozygous_sites_in_male_monticola_lapponicus_207_B_syl_remove_missingness_0.3.vcf.gz

time /home/yzliu/bin/VCF2Dis-master/VCF2Dis-1.46/bin/VCF2Dis -InPut remove_heterozygous_sites_in_male_monticola_lapponicus_207_B_syl_remove_missingness_0.3.vcf.gz \
-OutPut remove_heterozygous_sites_in_male_monticola_lapponicus_207_B_syl_remove_missingness_0.3.dist.txt


