#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 8
#SBATCH --mem 50g
#SBATCH --array=1-68%20
##SBATCH --time=3-04:04:00
##SBATCH --time=00:05:00
#SBATCH --time=07:30:00
#SBATCH --error=1_NEW_mapping_sort_markDup_dro_mel_68inds.%A_%a.e.txt
#SBATCH --output=1_NEW_mapping_sort_markDup_dro_mel_68inds.%A_%a.o.txt
#SBATCH --job-name=1_NEW_mapping_dro_mel
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

# scancel 30218861_[69-136]

## clean fastq sequence dir
SEQDIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/empirical_drosophila_clean_fastq
## mapping output
OUT_BAM=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate
## reference dir
#REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/D_melanogaster.7509v1.md_chr.fa
REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Drosophila_melanoganster-GCF_000001215.4_Release_6_plus_ISO1_MT_genomic-softmasked.fa
## read fastq files and Read group lines
cd $SEQDIR
seq1=$(ls SRR*_1.fastq.clean.gz | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p) # forward sequence
seq2=$(ls SRR*_2.fastq.clean.gz | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p) # reverse sequence
## Read group
Sorted_ReadGroup_FILE=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/2_mapping_genome/dro_mel_readGroup.sort.new1.list
ReadGroup=$(cat $Sorted_ReadGroup_FILE | sed -n ${SLURM_ARRAY_TASK_ID}p)

## read fastq files and Read group lines
#Read1=$(find $DIR -print | grep '.*_1.fastq.gz' | sort | sed -n ${SLURM_ARRAY_TASK_ID}p)
#Read2=$(find $DIR -print | grep '.*_2.fastq.gz' | sort | sed -n ${SLURM_ARRAY_TASK_ID}p)
## /crex/proj/snic2020-6-58/private/yzliu/test/fastq_bt/SRR13647737_1.fastq.gz
#ReadGroup=$(cat ReadGroup_new.txt | sed -n ${SLURM_ARRAY_TASK_ID}p)
## @RG\tID:SRR13647737\tPL:Illumina_NovaSeq_S4\t:SA_4

## modify output file names
File1=${seq1/_1.fastq.clean.gz/.sort.bam}

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## read mapping, convert sam file to bam file, and sort reads
## not necessary to view and generate those files
## https://www.biostars.org/p/319730/
#bwa mem -t 8 $REF $seq1 $seq1 | samtools view -b -@ 8 | samtools sort -@ 8 -m 5G -o $OUTPUT/$File2

cd $OUT_BAM

## attention to REF variable
bwa mem -t 8 -R $ReadGroup $REF $SEQDIR/$seq1 $SEQDIR/$seq1 | samtools sort -@ 8 -m 45G -o $OUT_BAM/$File1
#bwa mem -t 6 -R $ReadGroup $REF $SEQDIR/$seq1 $SEQDIR/$seq1 | samtools view -b -@ 6 -o $File1
#samtools sort -@ 6 -m 40G -o $File2 $File1

## indexing sorted
samtools index $File1

## mark duplicates
SORTED_BAM=$File1
MARKED_BAM=${SORTED_BAM/.sort.bam/.sort.marked_dups.bam}

picard MarkDuplicates \
    I=$SORTED_BAM \
    O=$MARKED_BAM \
    M=$MARKED_BAM".metrics.csv" >& $MARKED_BAM.log

## index marked_dups
samtools index $MARKED_BAM

## stats
STATS_BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate/stats
bamtools stats -in $MARKED_BAM > $STATS_BAM_DIR/bamtools_stats/$MARKED_BAM
samtools stats -in $MARKED_BAM > $STATS_BAM_DIR/samtools_stats/$MARKED_BAM

exit 0

## indexing marked_dups
echo -e "\nindexing: $MARKED_BAM" >> $script_path/dro_mel_sort_marked_bam_index.log
samtools index $MARKED_BAM

## stats
printf "\n######  bamtools stats: $MARKED_BAM ######" >> bamtools_stats_marked_dups_68samples.txt
bamtools stats -in $MARKED_BAM >> bamtools_stats_marked_dups_68samples.txt
#echo -e "\n###### Job Done! #####\n" >> bamtools_stats_68samples.txt
***************************************************************************
# view bam files
#samtools view $OUT_BAM/SRR24680741.sort.bam | less -S
/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate/test_sort/
samtools view SRR24680726.sort.bam | less -S

# view RG in bam
samtools view -h SRR24680726.sort.bam | less -S
@HD     VN:1.6  SO:coordinate
@SQ     SN:chrX LN:23542271
@SQ     SN:chr2L        LN:23513712
@SQ     SN:chr2R        LN:25286936
@SQ     SN:chr3L        LN:28110227
@SQ     SN:chr3R        LN:32079331
@SQ     SN:chr4 LN:1348131
@RG     ID:SRR24680726  LB:S67  PL:Illumina_NovaSeq_6000        PU:gDNA SM:SB_SE_02
@PG     ID:bwa  PN:bwa  VN:0.7.17-r1188 CL:bwa mem -t 6 -R @RG\tID:SRR24680726\tLB:S67\tPL:Illumina_NovaSeq_6000\tPU:gDNA\tSM:SB_>
: