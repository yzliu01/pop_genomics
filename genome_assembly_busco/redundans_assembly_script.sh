#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 20
#SBATCH --mem 500g
##SBATCH --time=00:15:00
#SBATCH --time=7-00:00:00
#SBATCH --error=redundans_assembly_BomVet.%A_%a.e
#SBATCH --output=redundans_assembly_BomVet.%A_%a.o
#SBATCH --job-name=redundans_assembly_BomVet
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com


## Step II: reorder the chromosome order
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate redundans
#redundans.py -h

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/fastq_clean
result_out=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/redundans_example_data/redundans/test/Bombus_veteranus
redundans.py -v -t 16 -i ./Bomvet_fastq1.fq.clean.gz Bomvet_fastq2.fq.clean.gz --resume -o $result_out/run.denovo --log BomVet.redundans_assembly.log

exit 0

## install reduncans
## https://github.com/Gabaldonlab/redundans
# create new Python3 >=3.8,<3.11 environment
conda create -n redundans python=3.10
# activate it
conda activate redundans
# and install redundans
#conda install -c bioconda redundans
mamba install -c conda-forge -c bioconda redundans

## faster with mamba
## mamba install -c conda-forge -c bioconda busco=5.7.1

## test with example data
## yzliu in 🌐 fe-open-02 in redundans/test on  master via 🅒 redundans 
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/redundans_example_data/redundans/test
../redundans.py -v -i ./*_?.fq.gz -o test_assembly/run.denovo
## check results
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/redundans_example_data/redundans/test/test_assembly/run.denovo

