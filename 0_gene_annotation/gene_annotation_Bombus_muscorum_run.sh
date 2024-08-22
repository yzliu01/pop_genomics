#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 8
#SBATCH --mem 50g
#SBATCH --time=15:00:00
#SBATCH --error=gene_annotation_BomMus.%A.e
#SBATCH --output=gene_annotation_BomMus.%A.o
#SBATCH --job-name=gene_annotation_BomMus
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## conda installation
## alternatively, start BRAKER with hints already produced by ProtHint (Step III), by providing ProtHint's prothint_augustus.gff output
gene_rediction_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation

cd $gene_rediction_dir
## folder of $braker_output_dir_for_protseq must be not existing before
rm -r braker_BomMus_results_for_protseq

mkdir /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/braker_BomMus_results_for_protseq
braker_output_dir_for_protseq=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/braker_BomMus_results_for_protseq
cd $braker_output_dir_for_protseq

## reference genome
#Andrena_marginata_softmask_simple_header_genome=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Andrena_marginata_GCA_963932335.1-softmasked.simple_header_new.fa
Bombus_muscorum_softmask_simple_header_genome=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_muscorum-GCA_963971185.1.simple_header_new.fa
#Bombus_muscorum_softmask_simple_header_genome=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_muscorum-GCA_963971125.1.simple_header_new.fa
Apodiea_gene_AA=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prepare_protein_db/orthodb/Apodiea_gene_AA.fa

## the fasta header name affect GeneMark
#sed -e 's/|/_/g' -e 's/\.1.*/.1/g' /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_muscorum-GCA_963971185.1.fa > /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_muscorum-GCA_963971185.1.simple_header_new.fa
#sed -e 's/|/_/g' -e 's/\.1.*/.1/g' /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_muscorum-GCA_963971125.1.fa > /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_muscorum-GCA_963971125.1.simple_header_new.fa
# ENA|OZ020127|OZ020127.1 Bombus muscorum genome assembly, chromosome: 1 ---> ENA_OZ020127_OZ020127.1
# ENA|OZ010659|OZ010659.1	--->  ENA_OZ010659_OZ010659.1 (working with this form)

## activate Braker3 Env
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
conda activate braker3

#>>>>>>>>>> method I  <<<<<<<<<<
## having BRAKER run ProtHint
## suggest number of core is less than 8
braker.pl --genome="$Bombus_muscorum_softmask_simple_header_genome" --prot_seq="$Apodiea_gene_AA" \
    --workingdir=$braker_output_dir_for_protseq --threads 8 \
    --PROTHINT_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes/ProtHint/bin \
    --GENEMARK_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes \
    --makehub --email=yuanzhen.liu2@gmail.com

exit 0

## use the final "baker.gtf" file for applying neutral variants
## /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/braker_BomCon_results_for_protseq/braker.gtf

## 
cd /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data/BomMus-GCA_963971185.1
## copy braker.gtf to snpeff data folder
cp /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/braker_BomCon_results_for_protseq/braker.gtf .
## compress the file
## pigz is faster than gzip
## https://www.baeldung.com/linux/gzip-and-gunzip
bgzip /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data/BomMus-GCA_963971185.1/genes.gtf
pigz
gzip

>>>>>>>>>> method II gave results <<<<<<<<<<
## run braker3 with prothint result gff file

## gff file from Prothint
prothint_augustus_gff=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prothint_results_BomMus/prothint_augustus.gff
#prothint_augustus_gff_old=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prothint_results/prothint_augustus.old.gff

braker.pl --genome="$Bombus_muscorum_softmask_simple_header_genome" --hints="$prothint_augustus_gff" \
    --workingdir=$braker_output_dir --threads 4 \
    --PROTHINT_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes/ProtHint/bin \
    --GENEMARK_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes
