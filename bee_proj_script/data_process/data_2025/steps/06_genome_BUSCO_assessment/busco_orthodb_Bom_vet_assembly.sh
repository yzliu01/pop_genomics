#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 20
#SBATCH --mem 60g
#SBATCH --time=00:15:00
#SBATCH --array=1-6%6
#SBATCH --error=busco_orthodb_Bom_vet_assembly.%A_%a.e
#SBATCH --output=busco_orthodb_Bom_vet_assembly.%A_%a.o
#SBATCH --job-name=busco_orthodb_Bom_vet_assembly

## Step II: reorder the chromosome order
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate busco_v5.7.1

## run busco
# fasta files
assembly_fa_stats=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/bombus_veteranus/filtered/assembly_fa_stats
## make array jobs
#fa_list=$(ls $assembly_fa_stats/Bombus_veteranus.pl*asm.bp.p_ctg.gfa.fa | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)
fa_list=$(ls $assembly_fa_stats/Bombus_veteranus.pl_3.asm.bp.p_ctg.gfa.fa | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)

#echo $fa_list

hifiasm_busco_out=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/hifi_asm
#cd $hifiasm_busco_out

## run busco: https://busco.ezlab.org/busco_userguide.html
## database dir
busco_data_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test
cd $busco_data_dir
## Interpreting the results
## BUSCO provides a quantitative assessment of the completeness in terms of expected gene content of a genome assembly, transcriptome, or annotated gene set. 
## The results are simplified into categories of Complete and single-copy, Complete and duplicated, Fragmented, or Missing BUSCOs, where "BUSCOs" is shorthand for "BUSCO marker genes".
busco -i $fa_list -m genome -c 20 --lineage_dataset hymenoptera_odb10 --restart --out_path $hifiasm_busco_out
## Bombus_veteranus.pl_0.asm.bp.p_ctg.gfa.fa
## Bombus_veteranus.pl_0.with_fail.asm.bp.p_ctg.gfa.fa

## busco -i $REF_BomSyl -m genome --lineage_dataset hymenoptera_odb10 --restart
## -i or --in defines the input file to analyse which is either a nucleotide fasta file or a protein fasta file, depending on the BUSCO mode.
## -m or --mode sets the assessment MODE: genome, proteins, transcriptome

exit 0

************* plot busco summaries ***********
# https://currentprotocols.onlinelibrary.wiley.com/doi/full/10.1002/cpz1.323

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/hifi_asm
busco_summaries=$(find . -maxdepth 2 -type f -name 'short_summary*.txt' | grep -v 'with_fail')
cp $busco_summaries ./busco_summary

conda activate busco_v5.7.1
# find out the plot script in the conda env
generate_plot=/home/yzliu/miniforge3/envs/busco_v5.7.1/bin/generate_plot.py
python3 $generate_plot -wd ./busco_summary


## install busco
## https://busco.ezlab.org/busco_userguide.html
mamba create -n busco_v5.7.1 -c bioconda busco=5.7.1

## A full list of available datasets can be viewed 
busco --list-datasets

- metazoa_odb10
         - arthropoda_odb10
             - arachnida_odb10
             - insecta_odb10
                 - endopterygota_odb10
                     - diptera_odb10
                     - hymenoptera_odb10
                     - lepidoptera_odb10
                 - hemiptera_odb10
         - mollusca_odb10
         - nematoda_odb10
         - vertebrata_odb10

## https://www.orthodb.org/
# hymenoptera_odb10

