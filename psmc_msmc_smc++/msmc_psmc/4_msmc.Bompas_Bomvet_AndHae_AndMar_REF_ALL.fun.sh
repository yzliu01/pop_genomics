#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 4
#SBATCH --mem 5g
#SBATCH --time=12:00:00
#SBATCH --array=1-6%6
#SBATCH --job-name=4_msmc.Bompas_Bomvet_AndHae_AndMar_REF_ALL.fun
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=4_msmc.Bompas_Bomvet_AndHae_AndMar_REF_ALL.fun.%A_%a.e
#SBATCH --output=4_msmc.Bompas_Bomvet_AndHae_AndMar_REF_ALL.fun.%A_%a.o

# run msmc2
conda activate conda_msmc2
## run msmc2 (weird)
#msmc2_Linux

## single run
msmc_output=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output
multihetsep_output=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/msmc_bam_mask/multihetsep_output/non_empty
cd $multihetsep_output

# It is not useful to use more CPUs than the number of chromosomes times the number of haplotype pairs, because that is the number of parallelised likelihood evaluations.

## pas & vet
msmc_pas_REF_pas() {
time msmc2_Linux -t 4 -s -I 0,1 -o $msmc_output/msmc.pas_REF_pas_out_non_empty $multihetsep_output/Bompas.New_REF_BomPas.*.multihetseq.txt
}

msmc_vet_REF_pas() {
time msmc2_Linux -t 4 -s -I 0,1 -o $msmc_output/msmc.vet_REF_pas_out_non_empty $multihetsep_output/Bomvet.New_REF_BomPas.*.multihetseq.txt
}

# hae & mar
msmc_hae_REF_hae() {
time msmc2_Linux -t 4 -s -I 0,1 -o $msmc_output/msmc.hae_REF_hae_out_non_empty $multihetsep_output/Andhae.New_REF_AndHae.*.multihetseq.txt
}

msmc_mar_REF_hat() {
time msmc2_Linux -t 4 -s -I 0,1 -o $msmc_output/msmc.mar_REF_hat_out_non_empty $multihetsep_output/Andmar.New_REF_AndHat.*.multihetseq.txt
}

msmc_mar_REF_hae() {
time msmc2_Linux -t 4 -s -I 0,1 -o $msmc_output/msmc.mar_REF_hae_out_non_empty $multihetsep_output/Andmar.New_REF_AndHae.*.multihetseq.txt
}

msmc_mar_REF_mar() {
time msmc2_Linux -t 4 -s -I 0,1 -o $msmc_output/msmc.mar_REF_mar_out_non_empty $multihetsep_output/Andmar.New_REF_AndMar.*.multihetseq.txt
}
#time msmc -t 4 -s -I 0-4,0-5,0-6,0-7,1-4,1-5,1-6,1-7,2-4,2-5,2-6,2-7,3-4,3-5,3-6,3-7 -o ./cross_mon_lap_8hap_out_prefix ./M_L013_M_L054_M_L028_M_L060.contig_001.multihetseq.txt

## bootstrap runs

#bootstrap_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap
#bootstrap_output=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap_output
#cd $bootstrap_output

msmc_bootstrap() {
for bootstrap in {1..20}
    do

    bootstrap_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap
    bootstrap_output=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap_output
    cd $bootstrap_output

    time msmc2_Linux -t 4 -s -I 0,1 -o $bootstrap_output/msmc.pas_REF_pas_out_non_empty.20bootstrap_chr"$bootstrap" $bootstrap_dir/BomPas_REF_BomPas_bootstrap_"$bootstrap"/bootstrap_multihetsep.chr*.txt
    time msmc2_Linux -t 4 -s -I 0,1 -o $bootstrap_output/msmc.vet_REF_pas_out_non_empty.20bootstrap_chr"$bootstrap" $bootstrap_dir/BomVet_REF_BomPas_bootstrap_"$bootstrap"/bootstrap_multihetsep.chr*.txt
    time msmc2_Linux -t 4 -s -I 0,1 -o $bootstrap_output/msmc.hae_REF_hae_out_non_empty.20bootstrap_chr"$bootstrap" $bootstrap_dir/AndHae_REF_AndHae_bootstrap_"$bootstrap"/bootstrap_multihetsep.chr*.txt
    time msmc2_Linux -t 4 -s -I 0,1 -o $bootstrap_output/msmc.mar_REF_hae_out_non_empty.20bootstrap_chr"$bootstrap" $bootstrap_dir/AndMar_REF_AndHae_bootstrap_"$bootstrap"/bootstrap_multihetsep.chr*.txt
    time msmc2_Linux -t 4 -s -I 0,1 -o $bootstrap_output/msmc.mar_REF_hat_out_non_empty.20bootstrap_chr"$bootstrap" $bootstrap_dir/AndMar_REF_AndHat_bootstrap_"$bootstrap"/bootstrap_multihetsep.chr*.txt
    time msmc2_Linux -t 4 -s -I 0,1 -o $bootstrap_output/msmc.mar_REF_mar_out_non_empty.20bootstrap_chr"$bootstrap" $bootstrap_dir/AndMar_REF_AndMar_bootstrap_"$bootstrap"/bootstrap_multihetsep.chr*.txt
done
}

msmc_fun_list=(
    "msmc_pas_REF_pas"
    "msmc_vet_REF_pas"
    "msmc_hae_REF_hae"
    "msmc_mar_REF_hae"
    "msmc_mar_REF_hat"
    "msmc_mar_REF_mar"
)
msmc_fun=$(echo ${msmc_fun_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)
## msmc_fun=$(echo ${msmc_fun_list[*]} | tr ' ' '\n' | sed -n 6p)
## execute function from a list
echo $($msmc_fun)
## execute function directly
msmc_bootstrap
