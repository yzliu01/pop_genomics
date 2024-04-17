
https://github.com/Gaius-Augustus/BRAKER
## http://xuzhougeng.com/archives/genome-annotation-with-braker2
## https://blog.csdn.net/Sunday1016/article/details/134255599

## install braker
conda create --name braker3 braker3
conda activate braker3
## install dependancies
## https://genemark.bme.gatech.edu/GeneMark/license_download.cgi
## geneMark-ETP
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare
## download from the offical website into local PC and copy it to server
gunzip gm_key.gz
tar -xvzf gmetp_linux_64.tar.gz

export PATH="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/tools/:$PATH"
#export PATH="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/:$PATH"
export GENEMARK_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/tools/

# You can check whether GeneMark-ES/ET/EP is installed properly by running the check_install.bash and/or executing examples in GeneMark-E-tests directory.
# GeneMark-ETP is downward compatible, i.e. it covers the functionality of GeneMark-EP and GeneMark-ET in BRAKER, too.
/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes/check_install.bash

## cannot install Protint with conda
## conda install -c bioconda 

## check genemark when braker3 is activated
/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes/check_install.bash
## check ProtHint
## https://github.com/gatech-genemark/ProtHint?tab=readme-ov-file#installation
/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes/ProtHint/bin/prothint.py

usage: prothint.py [-h] [--workdir WORKDIR] [--geneSeeds GENESEEDS] [--geneMarkGtf GENEMARKGTF] [--fungus]
                   [--nonCanonicalSpliceSites] [--diamondPairs DIAMONDPAIRS] [--maxProteinsPerSeed MAXPROTEINSPERSEED]
                   [--evalue EVALUE] [--minExonScore MINEXONSCORE] [--longGene LONGGENE] [--longProtein LONGPROTEIN]
                   [--cleanup] [--pbs] [--threads THREADS] [--version] [--prevGeneSeeds PREVGENESEEDS]
                   [--prevSpalnGff PREVSPALNGFF]
                   genome.fasta proteins.fasta
prothint.py: error: the following arguments are required: genome.fasta, proteins.fasta

## prepare protein sequences




