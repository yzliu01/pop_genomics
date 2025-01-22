
>>>>>>>>>>>>>>>>>>>>>  reverse order:  Step III: run braker3 with protein data from Step I <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
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



*********************************** necessary steps ****************************************
# https://github.com/Gaius-Augustus/BRAKER?tab=readme-ov-file#running-braker
In case of GeneMark-ES/ET/EP/ETP and AUGUSTUS, softmasking 
(i.e. putting repeat regions into lower case letters and all other regions into upper case letters) 
leads to better results than hardmasking (i.e. replacing letters in repetitive regions by the letter N for unknown nucleotide).



***********************    Step II: generating prothint_augustus.gff ***********************
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
## identify repeative regions for Andrena marginata first
Andrena_marginata_softmask_genome=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/MaskerOutput/Andrena_marginata_GCA_963932335.1.fa.masked
Bombus_muscuorum_softmask_genome=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_muscorum-GCA_963971185.1.fa
Andrena_bicolor_softmask_genome=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Andrena_bicolor-GCA_960531205.1.fa
Bombus_confusus_softmask_genome=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_confusus-GCA_014737475.1_ASM1473747v1-softmasked.fa

#Bombus_veteranus_genome=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_veteranus.hifi_asm_pl2.fa
Bombus_veteranus_softmask_genome=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_veteranus.hifi_asm_pl2-softmasked.simple_headers.fa

## protein_database
Apodiea_gene_AA=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prepare_protein_db/orthodb/Apodiea_gene_AA.fa
Hymenoptera_gene_AA=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prepare_protein_db_1/orthodb/Hymenoptera_gene_AA.fa

output_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation

# if folder does not exist it will be created
output_dir_BomVet=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prothint_results_BomVet
output_dir_softmask_BomVet=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prothint_results_softmask_BomVet

cd $output_dir
conda activate braker3

## run prothint.py
## self_annotated genome
time $prothint_py $Bombus_veteranus_softmask_genome $Apodiea_gene_AA --workdir $output_dir_softmask_BomVet



***********************    Step I: prepare protein sequences for prothint.py ***********************
conda activate braker3

## prepare protein sequences for prothint.py in above step
## snakemake flow
https://github.com/tomasbruna/orthodb-clades?tab=readme-ov-file
https://snakemake.readthedocs.io/en/stable/executing/cli.html
## save selectClade.py and make it executable
chmod +x /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/0_gene_annotation/selectClade.py
chmod +x /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prepare_protein_db_1/selectClade.py
## check if it shows help menu
old_selectClade_py=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/0_gene_annotation/selectClade.py
selectClade_py=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prepare_protein_db_1/selectClade.py
## install it in braker3 env
#conda install snakemake
#cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prepare_protein_db
mkdir /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prepare_protein_db_1
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prepare_protein_db_1
## downloaded files will be saved in ./orthodb
## place Snakefile and selectClade_py in the same dir
## snakemake file can be updated, use the latest one or it cannot be downloaded: https://github.com/tomasbruna/orthodb-clades?tab=readme-ov-file
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

## make species.tab list of close species myself; the clade mean the names (29 species) of species clade, e.g. Apoidea, in level.tab file
## level.tab: 34735	Apoidea	256897	12430	25

## make a backup fle
cp species.tab species_copy.tab

## manual select the target species from the originally generated species.tab file
grep -E 'Apis|Bombus|Osmia|Colletes|Ceratina|Dufourea|Eufriesea|Euglossa|Frieseomelitta|Habropoda|Lasioglossum|Megachile|Megalopta|Melipona|Nomia' species_copy.tab > species.tab

## run the script to generate protein database
$selectClade_py --species species.tab raw.fasta levels.tab level2species.tab Apoidea > Apodiea_gene_AA.fa
