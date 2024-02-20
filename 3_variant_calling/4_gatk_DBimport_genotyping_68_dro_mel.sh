#!/bin/sh
#SBATCH --account eDNA
##SBATCH --cpus-per-task 6
#SBATCH --mem 120g
#SBATCH --array=1-6%6
##SBATCH --array=1-1342%40
#SBATCH -t 00:05:00
##SBATCH -t 1-10:00:00
##SBATCH -t 9-00:00:00
#SBATCH -J gatk_DBimport_genotyping_deo_mel
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=gatk_DBimport_genotyping_deo_mel_68_deo_mel.%A_%a.e
#SBATCH --output=gatk_DBimport_genotyping_deo_mel_68_deo_mel.%A_%a.o

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate gatk_4.3.0.0

## bam file directory
#BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate

## Main directories as variables
## Update this with the path to the directory where you have the sample-name-map from the previous step
VCF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_gatk_vcf/gVCF

## Reference sequence
## Update this with the name of the ref fasta file 
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
REF=$REF_DIR/D_melanogaster.7509v1.md_chr.fa

## The sample-name-map that you created in the previous step (tab-separated list of each sample name followed by the full path to its .g.vcf file. One line per sample.)
## example:
## M_L001	/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/PAS/gVCF/M_L001.sorted_marked_dups.bam.g.vcf.gz

## create map file
#MAP_FILE_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics
#sed '1d' $MAP_FILE_DIR/2_mapping_genome/dro_mel_readGroup.list | awk -F "\t"  '{print $4,""$1".sort.marked_dups.g.vcf.gz"}' OFS="\t" > $VCF_DIR/sample_name_map_dro_mel.txt

SAMP_NAME=$VCF_DIR/sample_name_map_dro_mel.txt

        ## The path to the directory where you want to have the output files
        ## I'd recommend you create a separate directory for this

## Create directory for DataBase and VCF fiels
GATK_VCF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_gatk_vcf
cd $GATK_VCF; mkdir DB_VCF; cd DB_VCF; mkdir vcfs_all_indv DB_scaffold
		
OUT_DIR=$GATK_VCF/DB_VCF/vcfs_all_indv
DB_DIR=$GATK_VCF/DB_VCF/DB_scaffold

## Get all the chr (contig or scaffold) names in array from the reference genome fasta file
FB_CHUNK=$REF_DIR/fasta_generate_regions/D_melanogaster.7509v1.md_chr.fa.100kbp.regions.fb
#scaffold_names=$(cut -f 1 $REF_DIR/D_melanogaster.7509v1.md_chr.fa.fai | sed -n ${SLURM_ARRAY_TASK_ID}p)
scaffold_names=$(cut -f 1 $FB_CHUNK | sed -n ${SLURM_ARRAY_TASK_ID}p)
scaffold_order=$(cut -d : -f 1 $FB_CHUNK | sed -n ${SLURM_ARRAY_TASK_ID}p)
        ## Create a database for each chr/contig/scaffold
        ## The following command is submitted in parallel on multiple cores

cd $VCF_DIR

echo "Running GenomicsDBImport for $scaffold_names"
gatk --java-options "-Xmx10g -Xms10g" GenomicsDBImport \
--sample-name-map $SAMP_NAME \
--genomicsdb-workspace-path $DB_DIR/${scaffold_names} \
--tmp-dir $TMPDIR \
--intervals ${scaffold_names}

        ## Use the databases for joint genotyping
        ## The following command is submitted in array on multiple cores

echo "Running GenotypeGVCFs for ${scaffold_names}"
gatk --java-options "-Xmx10g -Xms10g" GenotypeGVCFs \
-R $REF \
-V gendb://$DB_DIR/${scaffold_names} \
-new-qual true \
-O $OUT_DIR/${scaffold_order}_100kb_${SLURM_ARRAY_TASK_ID}.g.vcf.gz


