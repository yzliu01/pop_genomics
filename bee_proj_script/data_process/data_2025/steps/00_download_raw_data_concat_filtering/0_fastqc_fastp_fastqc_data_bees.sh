#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 6
#SBATCH --mem 20g
#SBATCH --array=1-10%10
#SBATCH --time=15:00:00
#SBATCH --error=fastqc_fastp_fastqc_10_bee_proj.%A_%a.e
#SBATCH --output=fastqc_fastp_fastqc_10_bee_proj.%A_%a.o
#SBATCH --job-name=fastqc_fastp_fastqc_10_bee_proj
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

# fastq sequence dir
SEQDIR=/home/yzliu/eDNA/faststorage/yzliu/BACKUP/pool_raw_data/pool_01_2025
cd $SEQDIR
# Aphsti_R1_001.fastq.gz
seq1=$(ls *_R1_001.fastq.gz | sed -n ${SLURM_ARRAY_TASK_ID}p) # forward sequence
seq2=$(ls *_R2_001.fastq.gz | sed -n ${SLURM_ARRAY_TASK_ID}p) # reverse sequence

#mkdir emp_dro_mel_fastqc/temp
OUTPUT=/faststorage/project/eDNA/yzliu/DK_proj/data/bee_proj_data/fastq_clean

## call env
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
#conda activate variant_calling_mapping
conda activate fastqc

## run for raw data
#fastqc=/home/yzliu/miniforge3/envs/variant_calling_mapping/bin/fastqc
#fastqc --extract $seq1 $seq2 --outdir=$OUTPUT/fastqc_raw --dir $OUTPUT/temp --threads 6

#conda activate fastp
clean_seq1=${seq1/_001.fastq.gz/.fq.clean.gz} ### SRR13647737_1.fastq.clean.gz
clean_seq2=${seq2/_001.fastq.gz/.fq.clean.gz} ### SRR13647737_2.fastq.clean.gz
out_html=${seq2/_R2_001.fastq.gz/.fq.clean.html}
## default parameter: -q 15 -n 4 -u 40 -l 15 -A default (specify --disable_adapter_trimming)
#fastp -w 6 -z 5 -n 10 -l 50 -i $seq1 -I $seq2 -o $OUTPUT/$clean_seq1 -O $OUTPUT/$clean_seq2 -h $OUTPUT/$out_html


## run for clean data
cd $OUTPUT
fastqc --extract $clean_seq1 $clean_seq2 --outdir=$OUTPUT/fastqc_fastp_clean --dir $OUTPUT/temp --threads 6

exit 0

## https://www.hadriengourle.com/tutorials/qc/
conda create -n MultiQC -c conda-forge multiqc -y
conda activate MultiQC
multiqc .
