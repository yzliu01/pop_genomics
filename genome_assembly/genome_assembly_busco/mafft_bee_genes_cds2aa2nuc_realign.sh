#!/bin/sh
#SBATCH --account eDNA
#SBATCH --time=00:10:00
#SBATCH --cpus-per-task 20
#SBATCH --ntasks=1
#SBATCH --mem 50g
##SBATCH --mem 100g
##SBATCH --array=1-3%3
#SBATCH --array=1-2546%100
#SBATCH --job-name=mafft_bee_genes_cds2aa2nuc_realign
#SBATCH --error=mafft_bee_genes_cds2aa2nuc_realign.%A_%a.e
#SBATCH --output=mafft_bee_genes_cds2aa2nuc_realign.%A_%a.o
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

source /home/yzliu/miniforge3/etc/profile.d/conda.sh

revtrans=/home/yzliu/miniforge3/envs/RevTrans/bin/revtrans.py
conda activate RevTrans # contains maffteDNA/faststorage/yzliu/DK_proj/population_genomics/genome_assembly_busco/revtrans_bee_genes_cds2aa2nuc.sh

revtrans_align_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/shared_CDS_with_M_seq_align/revtrans_align
cd $revtrans_align_dir

aligned_nuc_file=$(ls *.gff.combined_share.13species.revtrans.fasta | sort -V |  sed -n ${SLURM_ARRAY_TASK_ID}p)

realigned_nuc_file_name=${aligned_nuc_file/revtrans.fasta/revtrans_realign.fasta}
mafft --localpair --maxiterate 1000 --thread 10 $aligned_nuc_file > $realigned_nuc_file_name
echo  "mafft_realigned: "$realigned_nuc_file_name
realigned_nuc_file_new_name=${realigned_nuc_file_name/revtrans_realign.fasta/revtrans_realign.header_md.fasta}
#sed 's/>\(.*\)busco_/>/' $realigned_nuc_file_name > $realigned_nuc_file_new_name
## keep only patterns between gff and .combined
sed -E 's/(.*busco_)([^.]*)(\.combined.*)/>\2/' $realigned_nuc_file_name > $realigned_nuc_file_new_name
echo  "header_md: "$realigned_nuc_file_new_name


