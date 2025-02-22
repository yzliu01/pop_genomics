#!/bin/sh
#SBATCH --account eDNA
#SBATCH --time=2-10:00:00
#SBATCH --cpus-per-task 20
#SBATCH --mem 20g
#SBATCH --job-name=clustalo_busco_all_CDS_seq.new
#SBATCH --error=clustalo_busco_all_CDS_seq.%A.e
#SBATCH --output=clustalo_busco_all_CDS_seq.%A.o
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

source /home/yzliu/miniforge3/etc/profile.d/conda.sh

## align multiple sequences
## https://www.biostars.org/p/425485/; https://mafft.cbrc.jp/alignment/software/; https://github.com/rcedgar/muscle
## reasons to choose different program: https://help.geneious.com/hc/en-us/articles/360044627712-Which-multiple-alignment-algorithm-should-I-use
conda activate myproject
##conda install bioconda::mafft

CDS_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS
cd $CDS_dir
##cat *seq.fa > busco_all_CDS_seq.fa

clustalo --infmt fa --outfmt phy --thread 20 --in busco_all_CDS_seq.fa --out busco_all_CDS_seq.clustalo_output.phy
