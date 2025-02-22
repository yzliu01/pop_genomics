#!/bin/sh
#SBATCH --account eDNA
#SBATCH --time=00:15:00
#SBATCH --cpus-per-task 20 #default no. of cpu
#SBATCH --mem 500g
#SBATCH --array=1-1%5
#SBATCH --job-name=muscle_busco_all_CDS_seq.mem
#SBATCH --error=muscle_busco_all_CDS_seq_1.%A_%a.e
#SBATCH --output=muscle_busco_all_CDS_seq_1.%A_%a.o
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

#seq=$(ls *gff.combined_share.fa | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
seq="1at7399.gff.combined_share.fa"
    ## seq file name: 31737at7399.gff.combined_share.fa
    ## seq header: >32320at7399.gff.busco_Ves_vul.
    
    ## rename output files
align_name=${seq/fa/muscle.fasta}
    ## run muscle
muscle -align $seq -output ../shared_CDS_with_M_seq_align/$align_name
muscle -super5 $seq -output ../shared_CDS_with_M_seq_align/$align_name

    ## modify headers of fasta sequences
    ## >32320at7399.gff.busco_Bom_syl.combined -> >busco_Bom_syl
sed -i 's/>.*gff\.\(.*\)\.combined/>\1/' ../shared_CDS_with_M_seq_align/$align_name

    # Input: 14 seqs, length avg 19272 max 25276

    # Input: 14 seqs, avg length 14915, max 15534
    # 00:00 19Mb   CPU has 64 cores, defaulting to 20 threads
    # 00:51 172Gb    42.9% Calc posteriors
    # 02:44 90.1Gb  100.0% Calc posteriors
    # 03:20 5.1Gb   100.0% Consistency (1/2)
    # 03:24 4.2Gb   100.0% Consistency (2/2)
    # 03:24 1.5Gb   100.0% UPGMA5           
    # 04:37 1.5Gb   100.0% Refining

exit 0

muscle -align $seq -maxiters 2 -output ../shared_CDS_with_M_seq_align/1at7399.gff.combined_share.muscle_super5.fasta