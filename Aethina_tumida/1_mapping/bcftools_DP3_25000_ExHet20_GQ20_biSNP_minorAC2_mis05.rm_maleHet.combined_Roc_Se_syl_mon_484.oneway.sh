#!/bin/bash -l
#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 05:20:00
#SBATCH -J combined_DP3_25000_ExHet20_GQ20_biSNP_minorAC2_mis05
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.DP3_25000_ExHet20_GQ20_biSNP_minorAC2_mis05.rm_maleHet.%A.e
#SBATCH --output=Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.DP3_25000_ExHet20_GQ20_biSNP_minorAC2_mis05.rm_maleHet.%A.o

# ATTENTION - no "/" after /bash, otherwise "slurmstepd: error: execve(): /var/spool/slurmd/job29778420/slurm_script: Not a directory"

module load bioinfo-tools python bcftools

cd /crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/merged_vcf_per_contig

combined_vcf=Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.DP3_GQ20_biSNP_maf0_f_mis05.rm_maleHet_MonoSNPs.oneway.vcf.gz
out_combined_vcf=Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.oneway.vcf.gz
#male_Het_site_list=heterozygous_site_male_27monticola_62lapponicus.list

#vcf=($vcf_mon $vcf_lap)
#out_vcf=($out_mon_vcf $out_lap_vcf)

#bcftools view --min-ac 2:minor ./$vcf_mon | bcftools view -T ^./$male_Het_site_list \
#-e 'F_MISSING > 0.5 | INFO/DP > 3134 | INFO/ExcessHet > 25' -Oz -o ./$out_mon_vcf

#bcftools view --min-ac 2:minor ./$vcf_lap | bcftools view -T ^./$male_Het_site_list \
#-e 'F_MISSING > 0.5 | INFO/DP > 3134 | INFO/ExcessHet > 25' -Oz -o ./$out_lap_vcf


## This function is to run the jobs in parallel
	function pwait() {
	while [ $(jobs -p | wc -l) -ge $1 ]; do
	sleep $2
	done
	}

#for i in {0,1}; do
#	pwait 2 10s
#	bcftools view --min-ac 2:minor ./${vcf[i]} | bcftools view -T ^./$male_Het_site_list -e 'F_MISSING > 0.5 | INFO/DP > 3134 | INFO/ExcessHet > 25' -Oz -o ./${out_vcf[i]}
#
#done


# quick check using perl
#bcftools query -f '%CHROM\t%POS\t%AC\t%DP\t%ExcessHet\n' $out_mon_vcf | less -S | perl -lane 'print if $F[3] < 300'

#bcftools view ./$combined_vcf --min-ac 2:minor | bcftools view \
#-e 'INFO/DP > 3134 | INFO/ExcessHet > 25' -Oz -o ./$out_combined_vcf

bcftools view ./$combined_vcf --min-ac 2:minor -e 'INFO/DP > 25000 | INFO/ExcessHet > 20' -Oz -o ./$out_combined_vcf

