#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 6
#SBATCH --mem 700g
#SBATCH --array=1-4%4
##SBATCH --time=00:05:00
#SBATCH --time=2-10:30:00
##SBATCH --time=3-04:04:00
#SBATCH --error=1_REF2_mapping_sort_markDup_bee_4_pools.%A_%a.e.txt
#SBATCH --output=1_REF2_mapping_sort_markDup_bee_4_pools.%A_%a.o.txt
#SBATCH --job-name=1_REF2_mapping_bee_pools
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## read fastq files and Read group lines
FASTQ_CLEAN=/faststorage/project/eDNA/yzliu/DK_proj/data/bee_proj_data/fastq_clean
cd $FASTQ_CLEAN
seq1=$(ls *fastq1.fq.clean.gz | sed -n ${SLURM_ARRAY_TASK_ID}p) # forward sequence
seq2=$(ls *fastq2.fq.clean.gz | sed -n ${SLURM_ARRAY_TASK_ID}p) # reverse sequence

## Read group
Sorted_ReadGroup_FILE=/faststorage/project/eDNA/yzliu/DK_proj/data/bee_proj_data/bam/ReadGroup_pooled.tab.list
ReadGroup=$(cat $Sorted_ReadGroup_FILE | sed -n ${SLURM_ARRAY_TASK_ID}p)

## mapping output
OUT_BAM=/faststorage/project/eDNA/yzliu/DK_proj/data/bee_proj_data/bam
## reference dir
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome

REF2_list=("iyAndHatt_8785v1_2.md_chr.fa" "iyAndHatt_8785v1_2.md_chr.fa" "iyBomHypn_7925v1_2.md_chr.fa" "iyBomHypn_7925v1_2.md_chr.fa")
REF2=$(echo ${REF2_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)

#REF1=$(cat $REF_DIR/REF1.list | sed -n ${SLURM_ARRAY_TASK_ID}p)

## modify output file names
#File1=${seq1/.fastq.clean.gz/.bam}				 ### SRR13647737_1.bam
#File2=${File1/.bam/_sort.bam}				 ### SRR13647737_1_sort.bam
File1=${seq1/_fastq1.fq.clean.gz/.sort.bam}

OUT_NAME_list=("REF_AndHatt" "REF_AndHatt" "REF_BomHypn" "REF_BomHypn")
OUT_NAME=$(echo ${OUT_NAME_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)
File1=${seq1/_fastq1.fq.clean.gz/}

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## read mapping, convert sam file to bam file, and sort reads
## not necessary to view and generate those files
## https://www.biostars.org/p/319730/
#bwa mem -t 8 $REF $seq1 $seq1 | samtools view -b -@ 8 | samtools sort -@ 8 -m 5G -o $OUTPUT/$File2

script_path=/faststorage/project/eDNA/yzliu/DK_proj/population_genomics/bee_proj_script/data_process

#rm $script_path/dro_mel_aligning_sorting.log
#rm $script_path/dro_mel_bam_index.log

cd $OUT_BAM

echo -e "aligning: $seq1 $seq2\n" >> $script_path/bee_REF2_aligning_sorting.log
bwa mem -t 6 -R $ReadGroup $REF_DIR/$REF2 $FASTQ_CLEAN/$seq1 $FASTQ_CLEAN/$seq2 | samtools sort -m 700G -o $OUT_BAM/$File1.$OUT_NAME".sort.bam"
#bwa mem -t 6 -R $ReadGroup $REF $SEQDIR/$seq1 $SEQDIR/$seq2 | samtools view -b -@ 6 -o $File1
#samtools sort -@ 6 -m 40G -o $File2 $File1

## indexing sorted
echo -e "\nindexing: $File1\n" >> $script_path/bee_REF2_sort_marked_bam_index.log
samtools index $File1.$OUT_NAME".sort.bam"

exit 0

## mark duplicates
SORTED_BAM=$(ls SRR*.sort.bam | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p) # forward sequence
MARKED_BAM=${SORTED_BAM/.sort.bam/.sort.marked_dups.bam}

echo -e ${SORTED_BAM[*]}"\t"${MARKED_BAM[*]} >> Mark_dups.1-68.log
picard MarkDuplicates \
    I=$SORTED_BAM \
    O=$MARKED_BAM \
    M=$MARKED_BAM".metrics.csv" >& $MARKED_BAM.log

SORTED_BAM=SRR24680788.sort.bam
MARKED_BAM=SRR24680788.sort.marked_dups.issue.bam
picard MarkDuplicates \
    I=$SORTED_BAM \
    O=$MARKED_BAM \
    M=$MARKED_BAM".metrics.csv" >& $MARKED_BAM.log

## indexing marked_dups
echo -e "\nindexing: $MARKED_BAM" >> $script_path/dro_mel_sort_marked_bam_index.log
samtools index $MARKED_BAM

## stats
printf "\n######  bamtools stats: $MARKED_BAM ######" >> bamtools_stats_marked_dups_68samples.txt
bamtools stats -in $MARKED_BAM >> bamtools_stats_marked_dups_68samples.txt
#echo -e "\n###### Job Done! #####\n" >> bamtools_stats_68samples.txt

exit

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

# ref list
REF1_list=("iyAndHaem1_1.md_chr.fa" "iyAndHaem1_1.md_chr.fa" "iyBomPasc1_1.md_chr.fa" "iyBomPasc1_1.md_chr.fa")
REF2_list=("iyAndHatt_8785v1_2.md_chr.fa" "iyAndHatt_8785v1_2.md_chr.fa" "iyBomHypn_7925v1_2.md_chr.fa" "iyBomHypn_7925v1_2.md_chr.fa")
REF3_list=("iyBomPasc1_1.md_chr.fa" "iyBomPasc1_1.md_chr.fa" "Amel_HAv3_1.md_chr.fa" "Amel_HAv3_1.md_chr.fa")

# fastq list
iyAndHaem1_1.md_chr.fa
iyAndHatt_8785v1_2.md_chr.fa
iyBomPasc1_1.md_chr.fa
iyBomHypn_7925v1_2.md_chr.fa
Amel_HAv3_1.md_chr.fa

-rw-rw-r-- 1 yzliu eDNA 2212495360 Feb 11 01:49 Andhae_fastq1.fq.clean.gz
-rw-rw-r-- 1 yzliu eDNA 2190475264 Feb 11 01:49 Andhae_fastq2.fq.clean.gz
-rw-rw-r-- 1 yzliu eDNA 2212495360 Feb 11 01:49 Andmar_fastq1.fq.clean.gz
-rw-rw-r-- 1 yzliu eDNA 2183135232 Feb 11 01:49 Andmar_fastq2.fq.clean.gz
-rw-rw-r-- 1 yzliu eDNA 2208301056 Feb 11 01:49 Bompas_fastq1.fq.clean.gz
-rw-rw-r-- 1 yzliu eDNA 2202009600 Feb 11 01:49 Bompas_fastq2.fq.clean.gz
-rw-rw-r-- 1 yzliu eDNA 2220883968 Feb 11 01:49 Bomvet_fastq1.fq.clean.gz
-rw-rw-r-- 1 yzliu eDNA 2196766720 Feb 11 01:49 Bomvet_fastq2.fq.clean.gz