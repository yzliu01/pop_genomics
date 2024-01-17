#!/bin/bash -l
#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:30:00
#SBATCH -J bcftools_pas_filtering
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=bcftools_14M_4F_B_pas.SNP_hard_filtered.GQ20_biSNP_05missing_DP3_1000_Excesshet25_minorAC2.%A.e
#SBATCH --output=bcftools_14M_4F_B_pas.SNP_hard_filtered.GQ20_biSNP_05missing_DP3_1000_Excesshet25_minorAC2.%A.o

# ATTENTION - no "/" after /bash, otherwise "slurmstepd: error: execve(): /var/spool/slurmd/job29778420/slurm_script: Not a directory"

module load bioinfo-tools python bcftools

cd /crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/PAS/new_variant_calling_ploidy/combined_vcf_genotyping

vcf_pas=genotyping_output_14haploid_41diploid_B_pas.SNP_hard_filtered.DP3_GQ20_biSNP_05missing_DP3_1000_Excesshet25.vcf.gz
out_vcf_pas=genotyping_output_14M_4F_B_pas.SNP_hard_filtered.GQ20_biSNP_05missing_DP3_1000_Excesshet25_minorAC2.vcf.gz
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

bcftools view ./$vcf_pas --min-ac 2:minor -e 'INFO/DP > 1000 | INFO/ExcessHet > 25' -Oz -o ./$out_vcf_pas

