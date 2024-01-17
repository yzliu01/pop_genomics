#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 6
##SBATCH --mem 50g
#SBATCH --array=1-136%20
#SBATCH --time=06:04:00
#SBATCH --error=fastp_dro_mel.%A.e.txt
#SBATCH --output=fastp_dro_mel.%A.o.txt
#SBATCH --job-name=fastp_dro_mel
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

# fastq sequence dir
SEQDIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/empirical_drosophila_fastq
#mkdir emp_dro_mel_fastqc/temp
OUTPUT=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/emp_dro_mel_fastqc
cd $SEQDIR
seq1=$(ls SRR*_1.fastq.gz | sed -n ${SLURM_ARRAY_TASK_ID}p) # forward sequence
seq2=$(ls SRR*_2.fastq.gz | sed -n ${SLURM_ARRAY_TASK_ID}p) # reverse sequence

## call env
#source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
#conda activate variant_calling_mapping
## local
#fastqc=/home/yzliu/bin/fastqc/FastQC/fastqc

## conda
#fastqc=/home/yzliu/miniforge3/envs/variant_calling_mapping/bin/fastqc
#$fastqc --extract $seq1 $seq2 --outdir=$OUTPUT --dir $OUTPUT/temp --threads 6
#/home/yzliu/bin/fastqc/FastQC/fastqc --extract SRR24680780_1.fastq.gz SRR24680780_2.fastq.gz --outdir=$OUTPUT --dir $OUTPUT/temp --threads 6

#exit
## https://www.hadriengourle.com/tutorials/qc/
#conda create -n MultiQC -c conda-forge multiqc -y
#conda activate MultiQC
#multiqc .

## https://github.com/OpenGene/fastp
#conda create -n fastp -c bioconda fastp -y

clean_seq1=${seq1/.fastq.gz/.fastq.clean.gz} ### SRR13647737_1.fastq.clean.gz
clean_seq2=${seq2/.fastq.gz/.fastq.clean.gz} ### SRR13647737_2.fastq.clean.gz
out_html=${seq2/_2.fastq.gz/.html}
## default parameter: -q 15 -n 4 -u 40 -l 15 -A default (specify --disable_adapter_trimming)
fastp -w 6 -z 5 -n 10 -l 50 -i $seq1 -I $seq2 -o $clean_seq1 -O $clean_seq2 -h $out_html
