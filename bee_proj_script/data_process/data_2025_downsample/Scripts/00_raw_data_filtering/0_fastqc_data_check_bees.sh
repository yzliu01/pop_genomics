#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 6
#SBATCH --mem 20g
#SBATCH --array=1-3%3
#SBATCH --time=12:04:00
#SBATCH --error=fastqc_bee_proj.%A.e.txt
#SBATCH --output=fastqc_bee_proj.%A.o.txt
#SBATCH --job-name=fastqc_bee_proj
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

# fastq sequence dir
SEQDIR=/faststorage/project/eDNA/yzliu/BACKUP/pool_raw_data
#mkdir emp_dro_mel_fastqc/temp
OUTPUT=/faststorage/project/eDNA/yzliu/DK_proj/data/bee_proj_data/fastq_clean
cd $SEQDIR
seq1=$(ls *fastq1.fq.gz | sed -n ${SLURM_ARRAY_TASK_ID}p) # forward sequence
seq2=$(ls *fastq2.fq.gz | sed -n ${SLURM_ARRAY_TASK_ID}p) # reverse sequence

## call env
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
conda activate fastqc
## local
#fastqc=/home/yzliu/bin/fastqc/FastQC/fastqc

## conda
## create temp folder
#fastqc=/home/yzliu/miniforge3/envs/variant_calling_mapping/bin/fastqc
fastqc --extract $seq1 $seq2 --outdir=$OUTPUT --dir $OUTPUT/temp --threads 6
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

## default parameter: -q 15 -n 4 -u 40 -l 15 -A default (specify --disable_adapter_trimming)
fastp -w 6 -z 5 -n 10 -l 50 -i $seq1 -I $seq2 -o $File1 -O $File2 -h xxx