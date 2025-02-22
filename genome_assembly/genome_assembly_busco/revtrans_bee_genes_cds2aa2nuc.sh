#!/bin/sh
#SBATCH --account eDNA
#SBATCH --time=04:10:00
##SBATCH --cpus-per-task 10
#SBATCH --mem 5g
##SBATCH --mem 100g
##SBATCH --array=1-1%60
##SBATCH --array=1-2546%100
#SBATCH --job-name=revtrans_bee_genes_cds2aa2nuc
#SBATCH --error=revtrans_bee_genes_cds2aa2nuc.%A_%a.e
#SBATCH --output=revtrans_bee_genes_cds2aa2nuc.%A_%a.o
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

source /home/yzliu/miniforge3/etc/profile.d/conda.sh

revtrans=/home/yzliu/miniforge3/envs/RevTrans/bin/revtrans.py
conda activate RevTrans # contains mafft
## 1. align amino acid sequences 
shared_CDS_with_M_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/shared_CDS_with_M
busco_id=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/busco_id
revtrans_align_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/shared_CDS_with_M_seq_align/revtrans_align
cd $busco_id
## assign an array instead of string
id=($(ls *new_header.faa | sort -V | sed 's/\.shared.*//')) ## the first two have issue so they were run separately (| sort -V | head -2 | ...)
echo ${id[1]}
## check the length of an array
echo ${#id[@]}
length=${#id[@]}

for ((index=0; index < length; index++))
do
cd $busco_id
echo -e "\n"$index
aa_seq_file=${id[index]}.shared_aa.new_header.faa   # 0at7399.shared_aa.new_header.faa
nuc_seq_file=${id[index]}.gff.combined_share.13species.fa  # (ls -t *share*fa | head) 32320at7399.gff.combined_share.13species.fa
echo -e "aa: "$aa_seq_file"\nnuc: "$nuc_seq_file

## aligh aa sequence
aligned_file_name=${aa_seq_file/faa/mafft.fasta}  # 0at7399.shared_aa.new_header.mafft.fasta
mafft --localpair --maxiterate 1000 --thread 20 $busco_id/$aa_seq_file > $revtrans_align_dir/$aligned_file_name
echo  "mafft_aligned: "$aligned_file_name

## run revtrans: control of the alignment process by supplying a pre-computed peptide alignment.
## RevTrans will then use this as the scaffold for the DNA alignment.
cd $revtrans_align_dir
revtrans_out_nuc_name=${nuc_seq_file/fa/revtrans.fasta}
$revtrans $shared_CDS_with_M_dir/$nuc_seq_file $aligned_file_name -match name > $revtrans_out_nuc_name
echo $revtrans_out_nuc_name

done
