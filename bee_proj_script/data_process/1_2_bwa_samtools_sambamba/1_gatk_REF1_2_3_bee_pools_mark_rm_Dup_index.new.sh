#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 10
#SBATCH --mem 500g
#SBATCH --array=1-10%10
##SBATCH --time=00:05:00
#SBATCH --time=15:30:00
##SBATCH --time=3-04:04:00
#SBATCH --error=1_gatk_REF1_2_3_bee_pools_mark_rm_Dup_index.new.%A_%a.e.txt
#SBATCH --output=1_gatk_REF1_2_3_bee_pools_mark_rm_Dup_index.new.%A_%a.o.txt
#SBATCH --job-name=1_gatk_REF1_2_3_bee_pools_mark_rm_Dup_index
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## for bam in `ls -t *.bam | head -4`;do time samtools index $bam;done
## mark duplicates
BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam
cd $BAM_DIR

SORTED_BAM=$(ls *.sort.bam | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p) # forward sequence
MARKED_BAM=${SORTED_BAM/.sort.bam/.sort.marked_rm_dups.bam}

echo -e ${SORTED_BAM[*]}"\t"${MARKED_BAM[*]}
picard "-Xmx500G" MarkDuplicates \
    REMOVE_DUPLICATES=true \
    I=$SORTED_BAM \
    O=$MARKED_BAM \
    M=$MARKED_BAM".sort.marked_rm_dups.metrics.csv" >& $MARKED_BAM.sort.marked_rm_dups.log

## indexing marked_dups
samtools index $MARKED_BAM

## stats
# "\n######  bamtools stats: $MARKED_BAM ######" >> bamtools_stats_marked_rm_dups_4_pools.txt
bamtools stats -in $MARKED_BAM >> bamtools_stats_marked_rm_dups_4_pools.txt
#echo -e "\n###### Job Done! #####\n" >> bamtools_stats_marked_rm_dups_4_pools.txt

exit 0

picard MarkDuplicates -Xmx700G I=Andhae.REF_AndHatt.sort.bam \
    O=Andhae.REF_AndHatt.sort.marked_duplicates.test.bam \
    M=Andhae.REF_AndHatt.sort.marked_dup_metrics.test.txt


MarkDuplicates \
I=input.bam \
O=marked_duplicates.bam \
M=marked_dup_metrics.txt



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