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
#REF_Index=$REF/D_melanogaster.7509v1.md_chr.fa.fai
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
#bamtools coverage -in $EXAMPLE_BAM | coverage_to_regions.py $REF/D_melanogaster.7509v1.md_chr.fa.fai 500 > $OUT_DIR/D_melanogaster.7509v1.md_chr.fa.500.regions

## reference genome fasta_generate_regions
cd $OUT_DIR
fasta_generate_regions.py $REF/D_melanogaster.7509v1.md_chr.fa 10000 > $OUT_DIR/D_melanogaster.7509v1.md_chr.fa.10kbp.regions.fb
fasta_generate_regions.py $REF/D_melanogaster.7509v1.md_chr.fa 100000 > $OUT_DIR/D_melanogaster.7509v1.md_chr.fa.100kbp.regions.fb

## create genomic regions for all ref
## https://unix.stackexchange.com/questions/450944/bash-loop-through-list-of-strings#:~:text=1%20You%20can%20loop%20over%20a%20list%20of,%22more%20with%20spaces%22%3B%20do%20echo%20%22%27%24%20%7Bitem%7D%27%22%20done
cd $OUT_DIR
for ref in "Amel_HAv3_1.md_chr.fa" "iyAndHaem1_1.md_chr.fa" "iyAndHatt_8785v1_2.md_chr.fa" "iyBomHypn_7925v1_2.md_chr.fa" "iyBomPasc1_1.md_chr.fa";
    #do echo -e "$ref \n";
    do fasta_generate_regions.py $REF/$ref 10000 > $OUT_DIR/$ref.10kbp.regions.fb;
done

for i in {a,b,c,d}
    do echo $i
done 