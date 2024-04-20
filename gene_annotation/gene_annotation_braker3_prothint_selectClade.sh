
## request slurm node
srun --account eDNA -t 05:00:00 --mem 16g --pty bash

>>>>>>>>>>>>>>>>>>>>>    Step III: run braker3 with protein data from Step I <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
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
export GENEMARK_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes

## better setting
export PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes
export PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes/gmes_petap.pl

# You can check whether GeneMark-ES/ET/EP is installed properly by running the check_install.bash and/or executing examples in GeneMark-E-tests directory.
# GeneMark-ETP is downward compatible, i.e. it covers the functionality of GeneMark-EP and GeneMark-ET in BRAKER, too.
/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes/check_install.bash

## Docker 
singularity build braker3.sif docker://teambraker/braker3:latest
singularity exec braker3.sif braker.pl

## run with example data
example_data=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/gene_annotation/example_data
braker_output_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/braker_results_example_data
cd 
(singularity exec braker3.sif braker.pl --genome=$example_data/genome.fa --prot_seq=$example_data/proteins.fa \
    --workingdir=$braker_output_dir --threads 2 \
    --PROTHINT_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes/ProtHint/bin \
    --GENEMARK_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes \
    --species=AndMar) &> $example_data/example_data_test.log
## test with A. marginata data
singularity exec braker3.sif braker.pl --genome="$Andrena_marginata_softmask_simple_header_genome" --prot_seq="$Apodiea_gene_AA" --species=Andrena_marginata \
    --workingdir=$braker_output_dir --threads 4 --PROTHINT_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes/ProtHint/bin --GENEMARK_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes


## conda installation
## alternatively, start BRAKER with hints already produced by ProtHint (Step III), by providing ProtHint's prothint_augustus.gff output
braker_output_dir_old=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/braker_results
cd $braker_output_dir_old

braker_output_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/braker_results_new
cd $braker_output_dir

braker_output_dir_for_protseq=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/braker_results_for_protseq
cd $braker_output_dir_for_protseq

## reference genome
Andrena_marginata_softmask_simple_header_genome=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Andrena_marginata_GCA_963932335.1-softmasked.simple_header_new.fa
Andrena_marginata_softmask_simple_header_genome_old=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Andrena_marginata_GCA_963932335.1-softmasked.simple_header.fa
Apodiea_gene_AA=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prepare_protein_db/orthodb/Apodiea_gene_AA.fa

## gff file from Prothint
prothint_augustus_gff=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prothint_results/prothint_augustus.gff
prothint_augustus_gff_old=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prothint_results/prothint_augustus.old.gff

## the fasta header name affect GeneMark
sed 's/|/_/g' /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Andrena_marginata_GCA_963932335.1-softmasked.simple_header.fa > /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Andrena_marginata_GCA_963932335.1-softmasked.simple_header_new.fa
e.g., ENA|OZ010659|OZ010659.1	--->  ENA_OZ010659_OZ010659.1 (working with this form)

>>>>>>>>>> method I  <<<<<<<<<<
conda activate braker3

## having BRAKER run ProtHint
## suggest number of core is less than 8
braker.pl --genome="$Andrena_marginata_softmask_simple_header_genome" --prot_seq="$Apodiea_gene_AA" \
    --workingdir=$braker_output_dir_for_protseq --threads 4 \
    --PROTHINT_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes/ProtHint/bin \
    --GENEMARK_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes \
    --makehub --email=yuanzhen.liu2@gmail.com

>>>>>>>>>> method II <<<<<<<<<<
## run braker3 with prothint result gff file
braker.pl --genome="$Andrena_marginata_softmask_simple_header_genome" --hints="$prothint_augustus_gff" \
    --workingdir=$braker_output_dir --threads 4 \
    --PROTHINT_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes/ProtHint/bin \
    --GENEMARK_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes

## test if fasta header matters (YES, causing problems)
conda activate braker3
cd $braker_output_dir_old
braker.pl --genome="$Andrena_marginata_softmask_simple_header_genome_old" --hints="$prothint_augustus_gff_old" \
    --workingdir=$braker_output_dir_old --threads 4 \
    --PROTHINT_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes/ProtHint/bin \
    --GENEMARK_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes


>>>>>>>>>>>>>>>>>>>>>    Step II: generating prothint_augustus.gff <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
## cannot install Protint with conda
## conda install -c bioconda 

## check genemark when braker3 is activated
/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes/check_install.bash
## check ProtHint
## https://github.com/gatech-genemark/ProtHint?tab=readme-ov-file#installation

usage: prothint.py [-h] [--workdir WORKDIR] [--geneSeeds GENESEEDS] [--geneMarkGtf GENEMARKGTF] [--fungus]
                   [--nonCanonicalSpliceSites] [--diamondPairs DIAMONDPAIRS] [--maxProteinsPerSeed MAXPROTEINSPERSEED]
                   [--evalue EVALUE] [--minExonScore MINEXONSCORE] [--longGene LONGGENE] [--longProtein LONGPROTEIN]
                   [--cleanup] [--pbs] [--threads THREADS] [--version] [--prevGeneSeeds PREVGENESEEDS]
                   [--prevSpalnGff PREVSPALNGFF]
                   genome.fasta proteins.fasta
prothint.py: error: the following arguments are required: genome.fasta, proteins.fasta

## variable for script
prothint_py=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes/ProtHint/bin/prothint.py
## file variables
Andrena_marginata_softmask_genome=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/MaskerOutput/Andrena_marginata_GCA_963932335.1.fa.masked
Apodiea_gene_AA=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prepare_protein_db/orthodb/Apodiea_gene_AA.fa
output_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prothint_results
cd $output_dir
conda activate braker3
## run prothint.py
$prothint_py $Andrena_marginata_softmask_genome $Apodiea_gene_AA --workdir $output_dir
## time
40m47s
44m8s

>>>>>>>>>>>>>>>>>>>>>    Step I: prepare protein sequences for prothint.py <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
## prepare protein sequences for prothint.py in above step
## snakemake flow
https://snakemake.readthedocs.io/en/stable/executing/cli.html
## save selectClade.py and make it executable
chmod +x /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/gene_annotation/selectClade.py
## check if it shows help menu
selectClade_py=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/gene_annotation/selectClade.py
## install it in braker3 env
#conda install snakemake
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prepare_protein_db
## downloaded files will be saved in ./orthodb
## place Snakefile in this dir
snakemake --cores 4
## re-run
snakemake --cores 4 --rerun-incomplete
##
##  rule download:
    output: orthodb/raw.fasta.gz, orthodb/species.tab.gz, orthodb/level2species.tab.gz, orthodb/levels.tab.gz
    jobid: 5
    reason: Forced execution
    resources: tmpdir=/scratch/usertmp

## selectClade
$selectClade_py --help

usage: selectClade.py [-h] [--exclude EXCLUDE]
                      [--excludeSpecies EXCLUDESPECIES]
                      [--species species.tab] [--dryrun]
                      proteins.fa levels.tab level2species.tab clade

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prepare_protein_db/orthodb
## orthoDB data structure
## https://v101.orthodb.org/download/README.txt

## make species.tab list of close species myself; the clade mean the name of species clade, e.g. Apoidea
cp species.tab species_copy.tab
grep -E 'Apis|Bombus|Osmia|Colletes|Ceratina|Dufourea|Eufriesea|Euglossa|Frieseomelitta|Habropoda|Lasioglossum|Megachile|Megalopta|Melipona|Nomia' species_copy.tab > species.tab
## m
$selectClade_py --species species.tab raw.fasta levels.tab level2species.tab Apoidea > Apodiea_gene_AA.fa



