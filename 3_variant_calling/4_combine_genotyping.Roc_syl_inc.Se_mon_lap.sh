#!/bin/bash -l
#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 6-00:00:00
##SBATCH -a 1-100%50
#SBATCH -J Roc_Se_syl_inc_mon_lap_merging_genotyping
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=Roc_214syl_67inc_F.SE_76mon_27M_49F_128lap_62M_66F_merging_genotyping.%A.e
#SBATCH --output=Roc_214syl_67inc_F.SE_76mon_27M_49F_128lap_62M_66F_merging_genotyping.%A.o

# Main directories as variables
File_list_dir=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon
vcf_list=Roc_214syl_67inc.gvcf.SE_76mon_128lap.gvcf_gz.list
# Reference sequence
REF=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/Bombus_sylvicola_v1.fna

# Create directory for DataBase and VCF fiels

cd $File_list_dir
#mkdir combined_vcf_genotyping
output_dir=./combined_vcf_genotyping
output_vcf=Roc_214syl_67inc.SE_76mon_128lap.combined-.g.vcf.gz
# load modules
module load bioinfo-tools
module load GATK

time gatk CombineGVCFs -R $REF -V $File_list_dir/$vcf_list -O $output_dir/$output_vcf

time gatk --java-options "-Xmx4g -Xms4g" GenotypeGVCFs -R $REF \
-V Roc_214syl_67inc.SE_76mon_128lap.combined.g.vcf.gz \
-O $output_dir/Roc_214syl_67inc.SE_76mon_128lap.combined_genotyped-.g.vcf.gz

