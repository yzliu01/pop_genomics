#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 05:30:00
#SBATCH -J PopLDdecay
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=PopLDdecay.syl_inc_lap_mon.%A.%a.e
#SBATCH --output=PopLDdecay.syl_inc_lap_mon.%A.%a.o

# module load bioinfo-tools
# module load vcftools

VCF_DIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/merged_vcf_per_contig
cd $VCF_DIR
VCF=Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.oneway.vcf.gz
OUTPUT_DIR=LDdecay/Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.oneway

# sub={sub_128lap.list sub_214syl.list sub_67inc.list sub_75mon.list}
# for i in $sub;do cut -f 1 $i > $i.list;done
# OUT_FILE=${INPUT_FILE/.vcf.gz/.40k}
# sub=`ls sub*.new.list`
# new_sub=${sub/.list.list/}
for group in {se_48F_mon,se_66F_lap}; do
~/bin/PopLDdecay/bin/PopLDdecay \
-InVCF $VCF -OutStat $OUTPUT_DIR.$group \
-SubPop $group
done

# plot multiple pop with multiple chr
# pop_LDdecay_result_path
# Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.oneway.sub_128lap.stat.gz	sub_128lap
perl ~/bin/PopLDdecay/bin/Plot_MultiPop.pl -inList ./LDdecay/LDdecay_result_pop_path.list \
-output ./$OUTPUT_DIR.mon_lap_inc_syl.LDdecat_stat
