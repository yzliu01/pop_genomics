#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 10
#SBATCH --mem 300g
#SBATCH --array=1-6%6
##SBATCH --time=00:15:00
#SBATCH --time=15:30:00
#SBATCH --error=2_REF23_markDup_stats_bee_pools.java_mem.%A_%a.e
#SBATCH --output=2_REF23_markDup_stats_bee_pools.java_mem.%A_%a.o
#SBATCH --job-name=2_REF23_markDup_stats_bee_pools.java_mem
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## mark duplicates
BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam
cd $BAM_DIR

## bam list to be marked_dups
BAM_list_left=(
            "Andhae.New_REF_AndFul.sort.bam"  
            "Andmar.New_REF_AndTri.sort.bam"
            "Bompas.New_REF_BomHor.sort.bam"
            "Bomvet.New_REF_BomHor.sort.bam"
            "Bompas.New_REF_BomCon.sort.bam"
            "Bomvet.New_REF_BomCon.sort.bam"
            )
## make array job and output each item from each line
SORTED_BAM_list=$(echo ${BAM_list_left[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)

## rename output file names
MARKED_BAM=${SORTED_BAM_list/.sort.bam/.sort.marked_dups.bam}

## note the java mem issue if request too much mem
## jobinfo 35014628_1
## SBATCH --cpus-per-task 10
## SBATCH --mem 300g

## Mem reserved        : 300G
## Max Mem used        : 37.18G (cn-1043,cn-1040)
## Max Disk Write      : 184.85M (cn-1043,cn-1040)
## Max Disk Read       : 3.87G (cn-1043,cn-1040)

picard "-Xmx200G" MarkDuplicates \
    I=$SORTED_BAM_list \
    O=$MARKED_BAM \
    M=$MARKED_BAM".metrics.csv" >& $MARKED_BAM.log

## index marked_dups
samtools index $MARKED_BAM
## stats
bamtools stats -in $MARKED_BAM > ./bam_stats/bamtools_stats/$MARKED_BAM
samtools stats -in $MARKED_BAM > ./bam_stats/samtools_stats/$MARKED_BAM

exit 0

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