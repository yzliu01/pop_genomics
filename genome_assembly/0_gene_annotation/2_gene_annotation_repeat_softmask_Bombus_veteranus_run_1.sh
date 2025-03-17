#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 20
#SBATCH --mem 30g
##SBATCH --array=1-6%6
#SBATCH --time=15:00:00
#SBATCH --error=2_gene_annotation_repeat_softmask_Bombus_veteranus_run_1
#SBATCH --output=2_gene_annotation_repeat_softmask_Bombus_veteranus_run_1
#SBATCH --job-name=2_gene_annotation_repeat_softmask_Bombus_veteranus_run_1
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## conda installation
## alternatively, start BRAKER with hints already produced by ProtHint (Step III), by providing ProtHint's prothint_augustus.gff output
gene_rediction_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation

cd $gene_rediction_dir
## folder of $braker_output_dir_for_protseq must be not existing before
#rm -r braker_BomVet_results_for_protseq
rm -r braker_softmask_BomVet_results_for_protseq_1

mkdir /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/braker_softmask_BomVet_results_for_protseq_1
braker_output_dir_for_protseq=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/braker_softmask_BomVet_results_for_protseq_1
cd $braker_output_dir_for_protseq

## reference genome
#Andrena_marginata_softmask_simple_header_genome=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Andrena_marginata_GCA_963932335.1-softmasked.simple_header_new.fa
#Andrena_marginata_softmask_simple_header_genome_old=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Andrena_marginata_GCA_963932335.1-softmasked.simple_header.fa

#Bombus_veteranus_genome=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_veteranus.hifi_asm_pl2.fa
#Bombus_veteranus_header_genome=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_veteranus.hifi_asm_pl2.simple_header.fa
Bombus_veteranus_softmask_simple_header_genome=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_veteranus.hifi_asm_pl2-softmasked.simple_headers.fa

Apodiea_gene_AA=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prepare_protein_db/orthodb/Apodiea_gene_AA.fa

## gff file from Prothint
# wrong: prothint_augustus_gff=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prothint_results/prothint_augustus.gff
prothint_augustus_gff=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prothint_results_BomVet/prothint_augustus.gff
#prothint_augustus_gff_old=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prothint_results/prothint_augustus.old.gff

## the fasta header name affect GeneMark
#sed 's/|/_/g' /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Andrena_marginata_GCA_963932335.1-softmasked.simple_header.fa > /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Andrena_marginata_GCA_963932335.1-softmasked.simple_header_new.fa
#e.g., ENA|OZ010659|OZ010659.1	--->  ENA_OZ010659_OZ010659.1 (working with this form)

## activate Braker3 Env
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
conda activate braker3

#>>>>>>>>>> method I  <<<<<<<<<<
## having BRAKER run ProtHint
## suggest number of core is less than 8
braker.pl --genome="$Bombus_veteranus_softmask_simple_header_genome" --prot_seq="$Apodiea_gene_AA" \
    --workingdir=$braker_output_dir_for_protseq --threads 20 \
    --PROTHINT_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes/ProtHint/bin \
    --GENEMARK_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes \
    --makehub --email=yuanzhen.liu2@gmail.com

exit 0


**********      prepare reference with simple header names  **************
# [^.]* matches any characters except a dot, ensuring we capture the part of the header
softmask_ref=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_veteranus.hifi_asm_pl2-softmasked.fa
softmask_ref_simplied_headers=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_veteranus.hifi_asm_pl2-softmasked.simple_headers.fa

sed -E 's/(^>*[^ ]*) .*/\1/' $softmask_ref > $softmask_ref_simplied_headers



## use the final "baker.gtf" file for applying neutral variants
## /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/braker_BomCon_results_for_protseq/braker.gtf

## 
cd /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data/BomCon-GCA_014737475.1
## copy braker.gtf to snpeff data folder
cp /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/braker_BomCon_results_for_protseq/braker.gtf .
## compress the file
## pigz is faster than gzip
## https://www.baeldung.com/linux/gzip-and-gunzip
bgzip /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data/BomCon-GCA_014737475.1/genes.gtf
pigz
gzip

>>>>>>>>>> method II gave results <<<<<<<<<<
## run braker3 with prothint result gff file
braker.pl --genome="$Bombus_confusus_softmask_simple_header_genome" --hints="$prothint_augustus_gff" \
    --workingdir=$braker_output_dir --threads 4 \
    --PROTHINT_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes/ProtHint/bin \
    --GENEMARK_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes
