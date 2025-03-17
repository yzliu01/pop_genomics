#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 10:30:00
#SBATCH -J msmc2.lap_mon
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=msmc2.lap_mon.%A.%a.e
#SBATCH --output=msmc2.lap_mon.%A.%a.o

# run msmc2
module load bioinfo-tools msmc2
# 4 samples (2 monticola vs 2 lapponicus)
#M_L013
#M_L054
#M_L028
#M_L060

SNPable_multihetsep_phased_vcf=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/merged_vcf_per_contig/phased_sample_msmc

cd $SNPable_multihetsep_phased_vcf
# It is not useful to use more CPUs than the number of chromosomes times the number of haplotype pairs, because that is the number of parallelised likelihood evaluations.
time msmc -t 4 -s -I 0,1,2,3 -o ./mon_4hap_out_prefix ./M_L013_M_L054_M_L028_M_L060.contig_001.multihetseq.txt
time msmc -t 4 -s -I 4,5,6,7 -o ./lap_4hap_out_prefix ./M_L013_M_L054_M_L028_M_L060.contig_001.multihetseq.txt
time msmc -t 4 -s -I 0-4,0-5,0-6,0-7,1-4,1-5,1-6,1-7,2-4,2-5,2-6,2-7,3-4,3-5,3-6,3-7 -o ./cross_mon_lap_8hap_out_prefix ./M_L013_M_L054_M_L028_M_L060.contig_001.multihetseq.txt
