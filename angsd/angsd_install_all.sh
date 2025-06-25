#!/bin/sh
#SBATCH --cpus-per-task 20
#SBATCH --mem 50g
#SBATCH --array=1-4%4
##SBATCH --array=12%1
##SBATCH --time=00:10:00
#SBATCH --time=06:00:00
#SBATCH --error=angsd_likelihood_sfs_all.%A_%a.e
#SBATCH --output=angsd_likelihood_sfs_all.%A_%a.o
#SBATCH --job-name=angsd_likelihood_sfs_all
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
#source /home/yzliu/miniforge3/etc/profile.d/mamba.sh

## https://docs.hpc.qmul.ac.uk/apps/bio/angsd/
#mamba create --quiet --yes --name angsd
#mamba activate angsd
conda activate angsd
#mamba install bioconda::angsd

#SLURM_ARRAY_TASK_ID=2

## path to your ref genome
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
#REF=$REF_DIR/Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa
#bombus_andrena_ref_bed_list=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bombus_andrena_bam.kist

ref_list=(
Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa
Andrena_marginata_GCA_963932335.1-softmasked.fa
Bombus_pascuorum-GCA_905332965.1-softmasked.fa
Bombus_veteranus.hifi_asm_pl2.fa
)

ref=$(echo ${ref_list[@]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)

#/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/4_6_concate_vcf_filtering_genome_fraction_depth_pgzip_gzip_decompress/6_get_vcf_ind_DP_3x_5x_7x_filtering_fun.sh
REF_MASKED_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed
ref_bed_list=(
Andrena_haemorrhoa-GCA_910592295.1-softmasked_ref_gene.conca_sorted.bed
Andrena_marginata_GCA_963932335.1-softmasked_ref_gene.conca_sorted.bed
Bombus_pascuorum-GCA_905332965.1-softmasked_ref_gene.conca_sorted.bed
Bombus_veteranus.hifi_asm_pl2-softmasked_ref_gene.conca_sorted.bed
)

ref_bed=$(echo ${ref_bed_list[@]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)

## the location of bam-files
BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam
#SAMPLE=Andhae.New_REF_AndHae.sort.marked_dups.bam
cd $BAM_DIR
#bombus_andrena_bam_list=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bombus_andrena_bam.kist
bam_list=(
Andhae.New_REF_AndHae.sort.marked_dups.bam
Andmar.New_REF_AndMar.sort.marked_dups.bam
Bompas.New_REF_BomPas.sort.marked_dups.bam
Bomvet.New_REF_BomVet.sort.marked_dups.bam
)

bam=$(echo ${bam_list[@]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)

## output SAF
SAF_OUT_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data/angsd

sfs_out_list=(
Andhae
Andmar
Bompas
Bomvet
)

sfs_out=$(echo ${sfs_out_list[@]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)

#Quick Start
#The process of estimating the SFS and multidimensional has improved a lot in the newer versions.
#Assuming you have a bam/cram file list in the file 'file.list' and you have your ancestral state in ancestral.fasta, then the process is: 

#no filtering
#./angsd -gl 1 -anc ancestral -dosaf 1

#or alot of filtering
#./angsd -gl 1 -anc ancestral -dosaf 1 -baq 1 -C 50 -minMapQ 30 -minQ 20

## -doMaf          Estimate allele frequencies
#        1: Frequency (fixed major and minor)
#        2: Frequency (fixed major unknown minor)
#        4: Frequency from genotype probabilities

## -doSaf   1: SAF calculation integrating over possible minor alleles
##          2: SAF calculation incorporating inbreeding
#           3: Calculate genotype probabilities using SAF (DEPRECATED; use -doPost 3)
#           4: SAF calculation from genotype posteriors (input is beagle text 
##          -GL 2 :for better handling of low-coverage data.
##          -ref/-anc  :Read reference or ancestral genome
## -r file:regions.txt
angsd -bam <(echo $bam) -rf $REF_MASKED_DIR/$ref_bed -doSaf 1 -anc $REF_DIR/$ref -out "$SAF_OUT_DIR/$sfs_out".all -GL 2 -P 20 -doMajorMinor 1 -minMapQ 1 -minQ 20

#Obtain a maximum likelihood estimate of the SFS using EM algorithm
realSFS "$sfs_out".all.saf.idx -maxIter 100 -P 20 >"$sfs_out".all.sfs

exit 0

# https://www.popgen.dk/angsd/index.php/SFS_Estimation
* NB the ancestral state needs to be supplied for the full SFS, but you can use the -fold 1 to estimate the folded SFS and then use the reference as ancestral.
* NB the output from the -doSaf 2 are not sample allele frequency likelihoods but sample alle posteriors.
And applying the realSFS to this output is therefore NOT the ML estimate of the SFS as described in the Nielsen 2012 paper,
but the 'Incorporating deviations from Hardy-Weinberg Equilibrium (HWE)' section of that paper.

************ Folded spectra **************
#If you don't have the ancestral state, you can instead estimate the folded SFS. This is done by supplying the -anc with the reference genome and applying -fold 1 to realSFS.

#The above example would then be

#first generate .saf file
angsd -bam bam.filelist -doSaf 1 -out smallFolded -anc  chimpHg19.fa -GL 2
#now try the EM optimization with 4 threads
realSFS smallFolded.saf.idx -maxIter 100 -P 4 >smallFolded.sfs
#in R
sfs<-scan("smallFolded.sfs")
barplot(sfs[-1])

******************************************

#this will generate 3 files
#1) angsdput.saf.idx 2) angsdput.saf.pos.gz 3) angsdput.saf.gz
#these are binary files that are formally defined in https://github.com/ANGSD/angsd/blob/newsaf/doc/formats.pdf

#To find the global SFS based on the run from above simply do
./realSFS angsdput.saf.idx
##or only use chromosome 22
./realSFS angsdput.saf.idx -r 22

## or specific regions
./realSFS angsdput.saf.idx -r 22:100000-150000000

##or limit to a fixed number of sites
./realSFS angsdput.saf.idx -r 17 -nSites 10000000

##or you can find the 2dim sf by
./realSFS ceu.saf.idx yri.saf.idx
##NB the program will find the intersect internally. No need for multiple runs with angsd main program.

##or you can find the 3dim sf by
./realSFS ceu.saf.idx yri.saf.idx MEX.saf.idx
