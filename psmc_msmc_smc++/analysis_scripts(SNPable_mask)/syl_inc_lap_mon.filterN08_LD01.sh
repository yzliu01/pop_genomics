#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:30:00
#SBATCH -J filter_N08
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=filter_N08.syl_inc_lap_mon.%A.%a.e
#SBATCH --output=filter_N08.syl_inc_lap_mon.%A.%a.o

module load bioinfo-tools vcftools

VCF_DIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/merged_vcf_per_contig
cd $VCF_DIR
VCF=Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.oneway.vcf.gz
OUTPUT_VCF=Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.oneway_N08.vcf.gz
OUTPUT_LD01_VCF=Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.oneway_N08_plinkLD01

#vcftools --gzvcf $VCF --max-missing 0.8 --recode --stdout | gzip > ./$OUTPUT_VCF

plink --vcf $OUTPUT_VCF --double-id --allow-extra-chr \
--set-missing-var-ids @:# \
--indep-pairwise 50 10 0.1 --out OUTPUT_LD01_VCF

####### not good from plink file to vcf (double ID issue) ##########
plink --vcf $OUTPUT_VCF --double-id --allow-extra-chr \
--set-missing-var-ids @:# --make-bed \
--extract OUTPUT_LD01_VCF.prune.in --out $OUTPUT_LD01_VCF

plink --bfile $OUTPUT_LD01_VCF --recode vcf --allow-extra-chr --out $OUTPUT_LD01_VCF

######### better using vcftools #########
vcftools --gzvcf $OUTPUT_VCF --positions ./OUTPUT_LD01_VCF.prune_new.in --recode --stdout | gzip > $OUTPUT_LD01_VCF.vcf.gz
# prepare treemix input file using Stacks - populations
populations -V $OUTPUT_LD01_VCF.vcf.gz -O ./treemix -M ./mon_lap_syl_inc_females.list --treemix
## backup file and delete note line
cp Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.N08_plinkLD01.p.treemix Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.N08_plinkLD01.p.treemix.cp
sed -i '1d' Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.N08_plinkLD01.p.treemix.cp
# treeMix accept .gz file
gzip Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.N08_plinkLD01.p.treemix.cp

## treemix
cd treemix
treeMix_input=Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.N08_plinkLD01.p.treemix.cp.gz

for run in {0..5};do treemix -i ./$treeMix_input -m $run -o ./syl_inc_lap_mon.N08_plinkLD01.$run -root monticola --bootstrap -k 100 > ./treemix_${run}_log;done
