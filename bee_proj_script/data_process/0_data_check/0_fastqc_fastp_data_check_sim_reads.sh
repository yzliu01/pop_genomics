#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 6
#SBATCH --mem 100g
#SBATCH --array=1-2%2
#SBATCH --time=12:00:00
#SBATCH --error=fastqc_fastp_sim_reads.%A_%a.e
#SBATCH --output=fastqc_fastp_sim_reads.%A_%a.o
#SBATCH --job-name=fastqc_fastp_sim_reads
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## call env
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
conda activate fastqc

# fastq sequence dir
INPUT_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/simulated_reference_genomes/sim_reads_new
#OUTPUT=quality_check
cd $INPUT_DIR
#seq1=$(ls *fq.clean.gz | sed -n ${SLURM_ARRAY_TASK_ID}p) # forward sequence
#seq2=$(ls *fq.clean.gz | sed -n ${SLURM_ARRAY_TASK_ID}p) # reverse sequence

seq1=(
    "tsk_0.DP_10x_chr.sim_illumina_PE_data1.fq"
    "tsk_2.DP_10x_chr.sim_illumina_PE_data1.fq"
    #"tsk_0.DP_2x_chr.sim_illumina_PE_data1.fq" # 41G
    #"tsk_0.DP_2x_chr.sim_illumina_PE_data1.fq"
    )
        
seq2=( 
    "tsk_0.DP_10x_chr.sim_illumina_PE_data2.fq"
    "tsk_2.DP_10x_chr.sim_illumina_PE_data2.fq"
    #"tsk_6.DP_2x_chr.sim_illumina_PE_data2.fq" # 41G
    #"tsk_6.DP_2x_chr.sim_illumina_PE_data2.fq"
    )
fastqc --extract ${seq1[$SLURM_ARRAY_TASK_ID-1]} ${seq2[$SLURM_ARRAY_TASK_ID-1]} --outdir=../quality_check --threads 6
#/home/yzliu/bin/fastqc/FastQC/fastqc --extract SRR24680780_1.fastq.gz SRR24680780_2.fastq.gz --outdir=$OUTPUT --dir $OUTPUT/temp --threads 6

exit 0

## https://www.hadriengourle.com/tutorials/qc/
#conda create -n MultiQC -c conda-forge multiqc -y
conda activate multiqc
multiqc .

## https://github.com/OpenGene/fastp
conda create -n fastp -c bioconda fastp -y

File1=${seq1/.fastq.gz/.fastq.clean.gz} ### SRR13647737_1.fastq.clean.gz
File2=${seq2/.fastq.gz/.fastq.clean.gz} ### SRR13647737_2.fastq.clean.gz
out_html=${seq2/_R2_001.fastq.gz/.fq.clean.html}
## default parameter: -q 15 -n 4 -u 40 -l 15 -A default (specify --disable_adapter_trimming)
fastp -w 6 -z 5 -n 10 -l 50 -i $seq1 -I $seq2 -o $File1 -O $File2 -h xxx

fastp -w 6 -z 5 -n 10 -l 50 -i $seq1 -I $seq2 -o $OUTPUT/$clean_seq1 -O $OUTPUT/$clean_seq2 -h $OUTPUT/$out_html

