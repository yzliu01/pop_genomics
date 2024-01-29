#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 2
#SBATCH --mem 40g
#SBATCH --time=08:14:00
#SBATCH --error=fb_cov2region_dro_mel.%A_%a.e.txt
#SBATCH --output=fb_cov2region_dro_mel.%A_%a.o.txt
##SBATCH --output=dro_mel_variant_fb_calling.%A_%a.o.txt
#SBATCH --job-name=fb_cov2region_dro_mel
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification


REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
REF_Index=$REF/D_melanogaster.7509v1.md_chr.fa.fai
#BAM=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate
#OUT_DIR=$REF/fb_cov2region_dro_mel
OUT_DIR=$REF/fasta_generate_regions

#mkdir $REF/fb_cov2region_dro_mel

## install freebayes
##https://github.com/freebayes/freebayes/tree/master/scripts
#conda install -c bioconda freebayes=1.3.6 vcflib=1.0.3 tabixpp=1.1.0

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping
## one example bam file
#EXAMPLE_BAM=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate/SRR24680763.sort.bam
#EXAMPLE_BAM=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate/test_sort1/SRR24680726.sort.bam
EXAMPLE_BAM=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate/test_sort/SRR24680726.sort.bam.mark_dups.bam
## job submission folder
JOB_SUB_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/job_submittion
cd $JOB_SUB_DIR

## estimate coverage of a bam file
bamtools coverage -in $EXAMPLE_BAM | coverage_to_regions.py $REF/D_melanogaster.7509v1.md_chr.fa.fai 500 > $OUT_DIR/D_melanogaster.7509v1.md_chr.fa.500.regions

## reference genome fasta_generate_regions
cd $OUT_DIR
fasta_generate_regions.py $REF/D_melanogaster.7509v1.md_chr.fa 10000 > $OUT_DIR/D_melanogaster.7509v1.md_chr.fa.100kbp.regions.fb
