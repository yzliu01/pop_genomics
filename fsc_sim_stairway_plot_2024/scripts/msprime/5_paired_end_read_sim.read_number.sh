#!/bin/bash
#SBATCH --account eDNA
##SBATCH --cpus-per-task 12
#SBATCH --mem 40g
#SBATCH --array=1-100%100
##SBATCH --array=1-1%1
#SBATCH --time=20:14:00
#SBATCH --error=illumina_read_sim.read_number.%A_%a.e
#SBATCH --output=illumina_read_sim.read_number.%A_%a.o
#SBATCH --job-name=illumina_read_sim.read_number
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

## test
#SLURM_ARRAY_TASK_ID=2

out_dir=../sim_reads_new
ind_ref=$(ls tsk_*_consensus_genome.fa | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
# tsk_99_consensus_genome.fa
ind_name=${ind_ref/_consensus_genome.fa/}
## simulate by depth
# for n in {2..5}
## simulate by read numbers
## corresponding to 100 diploid individuals (200x,300x,400x,500x) / 80% raw reads 
#total_DP=(1875000000 2750000000 3625000000 4125000000)
## for one ind
art_illumina -sam -i "$ind_ref" -p -l 150 -ss HS25 -c 37000000 -m 200 -s 10 -o $out_dir/"$ind_name"."DP_10x_chr".sim_illumina_PE_data

exit 0

total_DP=(18750000 27500000 36250000 41250000)
for index in ${!total_DP[*]}
do
echo -n "${total_DP[index]}" # do not output the trailing newline
#done
DP=(2 3 4 5)
echo -e "\tDP_${DP[index]}x_chr"
#done
# simulate illumina reads for each ind
# art_illumina -sam -i "$ind_ref" -p -l 150 -ss HS25 -f "$n" -m 200 -s 2 -o $out_dir/"$ind_name".DP_"$n".sim_illumina_PE_data

## Fatal Error: A mean fragment length and a standard deviation must be specified.
art_illumina -sam -i "$ind_ref" -p -l 150 -ss HS25 -c "${total_DP[index]}" -m 200 -s 10 -o $out_dir/"$ind_name"."DP_${DP[index]}x_chr".sim_illumina_PE_data

#bgzip -f $out_dir/"$ind_name"."DP_${DP[index]}x_chr".sim_illumina_PE_data*

#art_illumina -sam -i "$ind_ref" -p -l 150 -ss HS25 -f "$n" -m 200 -s 2 -o $out_dir/"$ind_name".DP_"$n".sim_illumina_PE_data.test
#bgzip -f $out_dir/"$ind_name".DP_"$n".sim_illumina_PE_data.test*
done


exit 0
## read check
conda activate fastqc
fastqc -h
fastqc --memory 100GB tsk_6.DP_2x_chr.sim_illumina_PE_data1.fq tsk_6.DP_2x_chr.sim_illumina_PE_data2.fq -o ../quality_check

#art_illumina [options] -sam -i <seq_ref_file> -l <read_length> -f <fold_coverage> -ss <sequencing_system> -o <outfile_prefix>
art_illumina -sam -i <seq_ref_file> -l <read_length> -f <fold_coverage> -ss <sequencing_system> -o <outfile_prefix>

## output_info
Parameters used during run
        Read Length:    150
        Genome masking 'N' cutoff frequency:    1 in 150
        Fold Coverage:            2X
        Mean Fragment Length:     200
        Standard Deviation:       2
        Profile Type:             Combined
        ID Tag:                   

Quality Profile(s)
        First Read:   HiSeq 2500 Length 150 R1 (built-in profile) 
        First Read:   HiSeq 2500 Length 150 R2 (built-in profile) 

Output files

  FASTQ Sequence Files:
         the 1st reads: ../sim_reads/tsk_0.DP_2.sim_illumina_PE_data.test1.fq
         the 2nd reads: ../sim_reads/tsk_0.DP_2.sim_illumina_PE_data.test2.fq

  ALN Alignment Files:
         the 1st reads: ../sim_reads/tsk_0.DP_2.sim_illumina_PE_data.test1.aln
         the 2nd reads: ../sim_reads/tsk_0.DP_2.sim_illumina_PE_data.test2.aln

  SAM Alignment File:
        ../sim_reads/tsk_0.DP_2.sim_illumina_PE_data.test.sam