#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 8
#SBATCH --mem 10g
##SBATCH --array=1-6%6
#SBATCH --time=15:00:00
#SBATCH --error=gene_annotation_AndMar.%A.e
#SBATCH --output=gene_annotation_AndMar.%A
#SBATCH --job-name=gene_annotation_AndMar
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## conda installation
## alternatively, start BRAKER with hints already produced by ProtHint (Step III), by providing ProtHint's prothint_augustus.gff output
#braker_output_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/braker_results_new
#cd $braker_output_dir
mkdir /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/braker_AndMar_results_for_protseq
braker_output_dir_for_protseq=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/braker_AndMar_results_for_protseq
cd $braker_output_dir_for_protseq

## reference genome
Andrena_marginata_softmask_simple_header_genome=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Andrena_marginata_GCA_963932335.1-softmasked.simple_header_new.fa
Andrena_marginata_softmask_simple_header_genome_old=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Andrena_marginata_GCA_963932335.1-softmasked.simple_header.fa
Apodiea_gene_AA=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prepare_protein_db/orthodb/Apodiea_gene_AA.fa

## gff file from Prothint
prothint_augustus_gff=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prothint_results/prothint_augustus.gff
prothint_augustus_gff_old=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/prothint_results/prothint_augustus.old.gff

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
braker.pl --genome="$Andrena_marginata_softmask_simple_header_genome" --prot_seq="$Apodiea_gene_AA" \
    --workingdir=$braker_output_dir_for_protseq --threads 8 \
    --PROTHINT_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes/ProtHint/bin \
    --GENEMARK_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes \
    --makehub --email=yuanzhen.liu2@gmail.com

exit 0
## use the final "baker.gtf" file for applying neutral variants
## /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/braker_AndMar_results_for_protseq/braker.gtf
## /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data/AndMar_GCA_963932335.1/genes.gtf.gz
>>>>>>>>>> method II gave results <<<<<<<<<<
## run braker3 with prothint result gff file
braker.pl --genome="$Andrena_marginata_softmask_simple_header_genome" --hints="$prothint_augustus_gff" \
    --workingdir=$braker_output_dir --threads 4 \
    --PROTHINT_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes/ProtHint/bin \
    --GENEMARK_PATH=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/gmetp_linux_64/bin/gmes
