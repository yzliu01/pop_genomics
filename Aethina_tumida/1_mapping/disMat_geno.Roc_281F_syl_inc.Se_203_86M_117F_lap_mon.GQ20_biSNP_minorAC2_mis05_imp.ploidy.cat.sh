#!/bin/bash -l
#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 10
##SBATCH -C mem256GB
#SBATCH -t 17:20:00
#SBATCH -J Roc_Se.geno_syl_inc_mon_lap.484
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=disMat_geno.Roc_281F_syl_inc.Se_203_86M_117F_lap_mon.GQ20_biSNP_minorAC2_mis05_imp.ploidy.cat.geno.%A.e
#SBATCH --output=disMat_geno.Roc_281F_syl_inc.Se_203_86M_117F_lap_mon.GQ20_biSNP_minorAC2_mis05_imp.ploidy.cat.geno.%A.o

module load bioinfo-tools python bcftools

# inout VCF directory
INPUT_DIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/merged_vcf_per_contig
cd $INPUT_DIR
vcf_M_F=Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.oneway.imp.vcf.gz
Ploidy_File=PloidyFile.Roc_281_dip.Se_203_86hap_117dip.list

time bcftools index $vcf_M_F

GENO=Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.oneway.imp.geno.gz
bal_fai=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/Bombus_sylvicola_v1.fna.fai

#--minQual 30 --gtf flag=DP min=5 max=100
time python /home/yzliu/bin/parseVCFs.py -i $vcf_M_F --ploidyFile $Ploidy_File \
--fai $bal_fai --ploidyMismatchToMissing --skipIndels --threads 10 | bgzip > $GENO

#https://github.com/simonhmartin/genomics_general/issues/29
# -g input.geno.gz -f phased --windType cat -o output.dist
#time python /home/yzliu/bin/distMat.py -f phased -g $GENO --windType cat -T 18 \
#--haploid M_L075 M_L093 M_L113 M_L130 M_L131 M_L133 M_L136 M_L140 M_L143 M_L146 M_L150 M_L152 M_L153 M_L159 M_L166 M_L167 M_L172 WO_002 BH_01 BH_02 BH_03 BH_04 BH_05 BH_06 BH_14 BH_15 BH_17 M_L008 M_L057 M_L071 M_L072 M_L074 M_L076 M_L077 M_L081 M_L082 M_L083 M_L084 M_L086 M_L087 M_L088 M_L090 M_L091 M_L092 M_L095 M_L109 M_L110 M_L111 M_L112 M_L114 M_L115 M_L116 M_L117 M_L120 M_L121 M_L122 M_L123 M_L124 M_L125 M_L127 M_L139 M_L144 M_L145 M_L148 M_L154 M_L157 M_L171 M_L173 M_L174 M_L175 M_L176 M_L183 M_L184 M_L185 M_L186 M_L187 M_L193 WO_007 WO_358 WO_815 WO_865 BH_10 BH_12 BH_18 M_L199 M_L200 M_L215 M_L216 M_L226 \
#-o $DIST

#DIST=Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.oneway.imp.geno.dist
# 74 geno - 190 min dist + 
#time python /home/yzliu/bin/distMat.py -f phased -g $GENO --windType cat --ploidyFile $Ploidy_File -o $DIST
# -T 18

