#!/bin/sh
#SBATCH --account eDNA
#SBATCH --time=02:25:00
#SBATCH --cpus-per-task 20
#SBATCH --ntasks=1
#SBATCH --mem 100g
##SBATCH --mem 100g
##SBATCH --array=1-1%60
##SBATCH --array=2-2159%60
#SBATCH --job-name=prank_translate_busco_10027at7399_CDS_seq
#SBATCH --error=prank_translate_busco_10027at7399_CDS_seq.%A_%a.e
#SBATCH --output=prank_translate_busco_10027at7399_CDS_seq.%A_%a.o
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## PRANK can do translated alignments of protein-coding DNA sequences or align them using the codon model.
## https://ariloytynoja.github.io/prank-msa/#methods
conda activate myproject

busco_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test
shared_CDS_with_M_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/shared_CDS_with_M
cd $shared_CDS_with_M_dir

## ulimit -c unlimited
## different length
prank -d=10027at7399.gff.combined_share.fa -iterate=3 -verbose \
    -o=../shared_CDS_with_M_seq_align/10027at7399.gff.combined_share.prank_translated_uselogs.fa \
    -translate -F -uselogs

exit 0

prank -d=32232at7399.gff.combined_share.fa \
    -o=../shared_CDS_with_M_seq_align/32232at7399.gff.combined_share.prank_translated.fa \
    -translate -F

## srun --account eDNA -t 10:00:00 --mem 16g --pty bash
## srun --account eDNA -t 00:30:00 --mem 40g --pty bash