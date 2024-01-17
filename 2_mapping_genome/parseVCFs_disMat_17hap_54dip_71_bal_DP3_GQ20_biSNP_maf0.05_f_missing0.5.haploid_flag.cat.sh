#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 18
#SBATCH -t 2-10:30:00
#SBATCH -J geno_dist.gatk_17haploid_54diploid_B_syl.DP3_GQ20_biSNP_maf0.05_f_missing0.5.ploidy_flag
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=geno_dist.gatk_17haploid_54diploid_B_syl.DP3_GQ20_biSNP_maf0.05_f_missing0.5.ploidy_flag.%A.e
#SBATCH --output=geno_dist.gatk_17haploid_54diploid_B_syl.DP3_GQ20_biSNP_maf0.05_f_missing0.5.ploidy_flag.%A.o

module load bioinfo-tools
module load python/3.9.5
module load bcftools

INPUT_FILE=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/BAL/new_variant_calling_ploidy/combined_vcf_genotyping
Ploidy_File=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/BAL/PloidyFile_17hap_54dip_71Bbal.list

cd $INPUT_FILE
HAP_DIP=gatk_17haploid_54diploid_B_bal.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.05_f_missing0.5.vcf.gz

#time bcftools index $HAP_DIP
GENO=gatk_17haploid_54diploid_B_bal.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.05_f_missing0.5.geno.gz

#--minQual 30 --gtf flag=DP min=5 max=100
time python /home/yzliu/bin/parseVCFs.py -i $HAP_DIP --ploidyFile $Ploidy_File \
--ploidyMismatchToMissing --skipIndels --threads 10 | bgzip > $GENO

DIST=gatk_17haploid_54diploid_B_bal.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.05_f_missing0.5.ploidy_flag.geno.cat_dist

#https://github.com/simonhmartin/genomics_general/issues/29
# -g input.geno.gz -f phased --windType cat -o output.dist
#time python /home/yzliu/bin/distMat.py -f phased -g $GENO --windType cat -T 18 \
#--haploid M_L075 M_L093 M_L113 M_L130 M_L131 M_L133 M_L136 M_L140 M_L143 M_L146 M_L150 M_L152 M_L153 M_L159 M_L166 M_L167 M_L172 WO_002 BH_01 BH_02 BH_03 BH_04 BH_05 BH_06 BH_14 BH_15 BH_17 M_L008 M_L057 M_L071 M_L072 M_L074 M_L076 M_L077 M_L081 M_L082 M_L083 M_L084 M_L086 M_L087 M_L088 M_L090 M_L091 M_L092 M_L095 M_L109 M_L110 M_L111 M_L112 M_L114 M_L115 M_L116 M_L117 M_L120 M_L121 M_L122 M_L123 M_L124 M_L125 M_L127 M_L139 M_L144 M_L145 M_L148 M_L154 M_L157 M_L171 M_L173 M_L174 M_L175 M_L176 M_L183 M_L184 M_L185 M_L186 M_L187 M_L193 WO_007 WO_358 WO_815 WO_865 BH_10 BH_12 BH_18 M_L199 M_L200 M_L215 M_L216 M_L226 \
#-o $DIST

time python /home/yzliu/bin/distMat.py -f phased -g $GENO --windType cat -T 18 --ploidyFile $Ploidy_File -o $DIST



