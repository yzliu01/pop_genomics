#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 6
#SBATCH -t 20:30:00
#SBATCH -J Roc_inc_syl.Se_lap_mon
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=popgenWindow.Roc_inc_syl.Se_lap_mon.%A.e
#SBATCH --output=popgenWindow.Roc_inc_syl.Se_lap_mon.%A.o

module load bioinfo-tools python
#bcftools

dir=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/merged_vcf_per_contig
cd $dir
geno=Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.DP3_GQ20_biSNP_maf003_f_mis05_gap10_rmMonoSNP_oneway_mHet.imp.with_header.geno.gz
ploidy=PloidyFile.Roc_281_dip.Se_203_86hap_117dip.list
popFile=popsFile.214syl_67inc_128lap_75mon.list
out_csv=./simon_martin/Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.DP3_GQ20_biSNP_maf003_f_mis05_gap10_rmMonoSNP_oneway_mHet.geno_csv.gz

# have issue - solution - index geno.gz file
# Traceback (most recent call last):   File "/usr/lib64/python2.7/multiprocessing/process.py", line 258, in _bootstrap     self.run()
# https://github.com/simonhmartin/genomics_general/issues/14
#module load bioinfo-tools python bcftools
#tabix -p vcf Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.DP3_GQ20_biSNP_maf003_f_mis05_gap10_rmMonoSNP_oneway_mHet.imp.with_header.geno.gz

# way to prepare pop file
python /home/yzliu/bin/simon_martin/popgenWindows.py --ploidyFile $ploidy -w 30000 -m 10 -g $geno -o $out_csv -p lapponicus -p monticola -p incognitus -p sylvicola -f phased -T 6 --popsFile $popFile --addWindowID



awk '$0=$0 "\tmonticola"' se_75_mon.list | head
awk '$NF=$NF "\tmonticola"' se_75_mon.list | head
awk '$(NF+1)="\tmonticola"' se_75_mon.list | head 
sed 's/$/\tmonticola/' se_75_mon.list | head
perl -pe 's/$/\tmonticola/' se_75_mon.list | head

awk '$(NF+1)="\tmonticola"' se_75_mon.list > popsFile.214syl_67inc_128lap_75mon..list && awk '$(NF+1)="\tlapponicus"' se_128_lap.list >> popsFile.214syl_67inc_128lap_75mon..list

sed 's/$/\tmonticola/' se_75_mon.list > popsFile.214syl_67inc_128lap_75mon.list && sed 's/$/\tlapponicus/' se_128_lap.list >> popsFile.214syl_67inc_128lap_75mon.list && sed 's/$/\tincognitus/' rocky_67_inc.list >> popsFile.214syl_67inc_128lap_75mon.list && sed 's/$/\tsylvicola/' rocky_214_syl.new.list >> popsFile.214syl_67inc_128lap_75mon.list
