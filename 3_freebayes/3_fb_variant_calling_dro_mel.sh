#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 12
#SBATCH --mem 250g
#SBATCH --time=02:14:00
#SBATCH --error=fb_dro_mel_variant_fb_calling.%A_%a.e.txt
#SBATCH --output=fb_dro_mel_variant_fb_calling.%A_%a.o.txt
#SBATCH --job-name=fb_dro_mel_variant_fb_calling
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification


REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/
#REF_Index=$REF/D_melanogaster.7509v1.md_chr.fa.fai
BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate
OUT_DIR=$REF/fb_cov2region_dro_mel
OUT_VCF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_freebayes_vcf
#mkdir $REF/fb_cov2region_dro_mel

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## one example bam file
EXAMPLE_BAM=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate/SRR24680763.sort.bam

## job submission folder
JOB_SUB_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/job_submittion
cd $JOB_SUB_DIR

#bamtools coverage -in $EXAMPLE_BAM | coverage_to_regions.py $REF/D_melanogaster.7509v1.md_chr.fa.fai 500 > $OUT_DIR/D_melanogaster.7509v1.md_chr.fa.500.regions

##fasta_generate_regions.py $REF_DIR/Bombus_sylvicola_v1.fna.fai 100000 > $REF_DIR/syl.ref.fa.100kbp.regions.freebayes
## https://github.com/freebayes/freebayes/issues/73

## https://github.com/vcflib/vcflib/issues/389
## conda install -c bioconda vcflib=1.0.3 tabixpp=1.1.0
GVCF_MQ=empirical_dro_mel_68samples.gvcf
ls *sort.bam > $BAM_DIR/dro_mel_68samples.bam.list

freebayes-parallel $REF_REGION 18 --fasta-reference $REF/D_melanogaster.7509v1.md_chr.fa.fai --bam-list $BAM_DIR/dro_mel_68samples.bam.list \
--ploidy 2 --strict-vcf --gvcf | vcffilter -f "QUAL > 20" > $OUT_VCF_DIR/$GVCF_MQ
