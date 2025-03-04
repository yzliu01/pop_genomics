#!/bin/bash
#SBATCH --account eDNA
##SBATCH --cpus-per-task 12
#SBATCH --mem 40g
#SBATCH --array=1-100%100
##SBATCH --array=1-1%1
#SBATCH --time=08:14:00
#SBATCH --error=illumina_read_sim.%A_%a.e
#SBATCH --output=illumina_read_sim.%A_%a.o
#SBATCH --job-name=illumina_read_sim
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## call env
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
#conda create -n art_illumina art -c bioconda
conda activate art_illumina
#paired-end read simulation
#https://manpages.debian.org/testing/art-nextgen-simulation-tools/art_illumina.1.en.html

## default
#art_illumina -sam -i reference.fa -p -l 150 -ss HS25 -f 20 -m 200 -s 10 -o paired_dat 
## pools
ind_ref_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/simulated_reference_genomes/concat_ind_vcf
cd $ind_ref_dir
#test_ref=chr_1_tsk_99_300lines_consensus_genome.fa

#SLURM_ARRAY_TASK_ID=1
out_dir=../sim_reads
ind_ref=$(ls tsk_*_consensus_genome.fa | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
# tsk_99_consensus_genome.fa
ind_name=${ind_ref/_consensus_genome.fa/}
for n in {2..4}
do
#echo $n
#done
art_illumina -sam -i "$ind_ref" -p -l 150 -ss HS25 -f "$n" -m 200 -s 2 -o $out_dir/"$ind_name".DP_"$n".sim_illumina_PE_data
done


exit 0

#art_illumina [options] -sam -i <seq_ref_file> -l <read_length> -f <fold_coverage> -ss <sequencing_system> -o <outfile_prefix>
art_illumina -sam -i <seq_ref_file> -l <read_length> -f <fold_coverage> -ss <sequencing_system> -o <outfile_prefix>

