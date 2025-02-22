#!/bin/sh
#SBATCH --account eDNA
#SBATCH --time=00:10:00
#SBATCH --cpus-per-task 20
#SBATCH --mem 80g
#SBATCH --mem 100g
##SBATCH --array=1-1%60
#SBATCH --array=2-2159%60
#SBATCH --job-name=mafft_busco_all_CDS_seq
#SBATCH --error=mafft_busco_all_CDS_seq.%A_%a.e
#SBATCH --output=mafft_busco_all_CDS_seq.%A_%a.o
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## align multiple sequences
## https://www.biostars.org/p/425485/; https://mafft.cbrc.jp/alignment/software/; https://github.com/rcedgar/muscle
## reasons to choose different program: https://help.geneious.com/hc/en-us/articles/360044627712-Which-multiple-alignment-algorithm-should-I-use
conda activate myproject
##conda install bioconda::mafft

shared_CDS_with_M_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/shared_CDS_with_M
cd $shared_CDS_with_M_dir

## check the number of fasta files
# ls *gff.combined_share.fa | wc -l
# 2159

seq=$(ls *gff.combined_share.fa | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
    ## seq file name: 31737at7399.gff.combined_share.fa
    ## seq header: >32320at7399.gff.busco_Ves_vul.
    
    ## rename output files
align_name=${seq/fa/mafft_L_INS_i.fasta}
    ## run mafft
## accurate strategy: L-INS-i
mafft --localpair --maxiterate 1000 --thread 20 $seq > ../shared_CDS_with_M_seq_align/$align_name

    ## modify headers of fasta sequences
    ## >32320at7399.gff.busco_Bom_syl.combined -> >busco_Bom_syl
sed -i 's/>.*gff\.\(.*\)\.combined/>\1/' ../shared_CDS_with_M_seq_align/$align_name
