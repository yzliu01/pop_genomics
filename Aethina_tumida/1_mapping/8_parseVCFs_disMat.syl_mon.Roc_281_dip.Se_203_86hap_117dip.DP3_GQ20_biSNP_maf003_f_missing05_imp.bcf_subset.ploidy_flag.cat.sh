#!/bin/bash -l
#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 18
#SBATCH -t 5-04:20:00
#SBATCH -J syl_imp_bcf_subsetAll_geno_dist.484.combined
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=geno_dist.Roc_214syl_67inc_F.DP3_GQ20_biSNP_maf003_f_mis05_gap10_rmMonoSNP_oneway_mHet.imp_bcf_subsetAll.ploidy_flag.%A.e
#SBATCH --output=geno_dist.Roc_214syl_67inc_F.DP3_GQ20_biSNP_maf003_f_mis05_gap10_rmMonoSNP_oneway_mHet.imp_bcf_subsetAll.ploidy_flag.%A.o

module load bioinfo-tools
module load python/3.9.5
module load bcftools

#
INPUT_DIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/merged_vcf_per_contig

cd $INPUT_DIR
vcf_hap_dip=Roc_214syl_67inc_F.DP3_GQ20_biSNP_maf003_f_mis05_gap10_rmMonoSNP_oneway_mHet.imp_bcf_subsetAll.vcf.gz
# regenerate imputed vcf with bcftools view to add header and INFO; only work if subset samples
Ploidy_File=PloidyFile.Roc_281_dip.Se_203_86hap_117dip.list

time bcftools index $vcf_hap_dip

GENO=Roc_214syl_67inc_F.DP3_GQ20_biSNP_maf003_f_mis05_gap10_rmMonoSNP_oneway_mHet.imp_bcf_subsetAll.geno.gz

#--minQual 30 --gtf flag=DP min=5 max=100
time python /home/yzliu/bin/parseVCFs.py -i $vcf_hap_dip --ploidyFile $Ploidy_File \
--ploidyMismatchToMissing --skipIndels --threads 12 | bgzip > $GENO

#https://github.com/simonhmartin/genomics_general/issues/29
# -g input.geno.gz -f phased --windType cat -o output.dist
#time python /home/yzliu/bin/distMat.py -f phased -g $GENO --windType cat -T 18 \
#--haploid M_L075 M_L093 M_L113 M_L130 M_L131 M_L133 M_L136 M_L140 M_L143 M_L146 M_L150 M_L152 M_L153 M_L159 M_L166 M_L167 M_L172 WO_002 BH_01 BH_02 BH_03 BH_04 BH_05 BH_06 BH_14 BH_15 BH_17 M_L008 M_L057 M_L071 M_L072 M_L074 M_L076 M_L077 M_L081 M_L082 M_L083 M_L084 M_L086 M_L087 M_L088 M_L090 M_L091 M_L092 M_L095 M_L109 M_L110 M_L111 M_L112 M_L114 M_L115 M_L116 M_L117 M_L120 M_L121 M_L122 M_L123 M_L124 M_L125 M_L127 M_L139 M_L144 M_L145 M_L148 M_L154 M_L157 M_L171 M_L173 M_L174 M_L175 M_L176 M_L183 M_L184 M_L185 M_L186 M_L187 M_L193 WO_007 WO_358 WO_815 WO_865 BH_10 BH_12 BH_18 M_L199 M_L200 M_L215 M_L216 M_L226 \
#-o $DIST

DIST=Roc_214syl_67inc_F.DP3_GQ20_biSNP_maf003_f_mis05_gap10_rmMonoSNP_oneway_mHet.imp_bcf_subsetAll.geno.dist
# 74 geno - 190 min dist + 
time python /home/yzliu/bin/distMat.py -f phased -g $GENO --windType cat -T 18 --ploidyFile $Ploidy_File -o $DIST


