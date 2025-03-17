#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 10:30:00
#SBATCH -J msmc.Bompas_Bomvet_REF_BomPas
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=msmc.Bompas_Bomvet_REF_BomPas.%A.%a.e
#SBATCH --output=msmc.Bompas_Bomvet_REF_BomPas.%A.%a.o

# run msmc2
conda activate conda_msmc2
## run msmc2 (weird)
#msmc2_Linux

msmc_output=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output
multihetsep_output=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/msmc_bam_mask/multihetsep_output/non_empty
cd $multihetsep_output
# It is not useful to use more CPUs than the number of chromosomes times the number of haplotype pairs, because that is the number of parallelised likelihood evaluations.
## pas & vet
time msmc2_Linux -t 4 -s -I 0,1 -o $msmc_output/pas_REF_pas_out_non_empty $multihetsep_output/Bompas.New_REF_BomPas.*.multihetseq.txt
time msmc2_Linux -t 4 -s -I 0,1 -o $msmc_output/vet_REF_pas_out_non_empty $multihetsep_output/Bomvet.New_REF_BomPas.*.multihetseq.txt
#time msmc -t 4 -s -I 0-4,0-5,0-6,0-7,1-4,1-5,1-6,1-7,2-4,2-5,2-6,2-7,3-4,3-5,3-6,3-7 -o ./cross_mon_lap_8hap_out_prefix ./M_L013_M_L054_M_L028_M_L060.contig_001.multihetseq.txt

bootstrap_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap
bootstrap_output=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap_output
cd $bootstrap_output

for bootstrap in {1..20}
    do 
    time msmc2_Linux -t 4 -s -I 0,1 -o $bootstrap_output/pas_REF_pas_out_non_empty_20bootstrap_chr"$bootstrap" $bootstrap_dir/BomPas_REF_bootstrap_"$bootstrap"/bootstrap_multihetsep.chr*.txt
    time msmc2_Linux -t 4 -s -I 0,1 -o $bootstrap_output/vet_REF_pas_out_non_empty_20bootstrap_chr"$bootstrap" $bootstrap_dir/BomVet_REF_bootstrap_"$bootstrap"/bootstrap_multihetsep.chr*.txt
done

msmc_output=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output
multihetsep_output=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/msmc_bam_mask/multihetsep_output/non_empty
cd $multihetsep_output
# hae & mar
time msmc2_Linux -t 4 -s -I 0,1 -o $msmc_output/hae_REF_hae_out_non_empty $multihetsep_output/Andhae.New_REF_AndHae.*.multihetseq.txt
time msmc2_Linux -t 4 -s -I 0,1 -o $msmc_output/mar_REF_mar_out_non_empty $multihetsep_output/Andmar.New_REF_AndHae.*.multihetseq.txt
#time msmc -t 4 -s -I 0-4,0-5,0-6,0-7,1-4,1-5,1-6,1-7,2-4,2-5,2-6,2-7,3-4,3-5,3-6,3-7 -o ./cross_mon_lap_8hap_out_prefix ./M_L013_M_L054_M_L028_M_L060.contig_001.multihetseq.txt

bootstrap_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap
bootstrap_output=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap_output
cd $bootstrap_output

for bootstrap in {1..20}
    do 
    time msmc2_Linux -t 4 -s -I 0,1 -o $bootstrap_output/hae_REF_hae_out_non_empty_20bootstrap_chr"$bootstrap" $bootstrap_dir/AndHae_REF_AndHae_bootstrap_"$bootstrap"/bootstrap_multihetsep.chr*.txt
    time msmc2_Linux -t 4 -s -I 0,1 -o $bootstrap_output/mar_REF_mar_out_non_empty_20bootstrap_chr"$bootstrap" $bootstrap_dir/AndMar_REF_AndHae_bootstrap_"$bootstrap"/bootstrap_multihetsep.chr*.txt
done
