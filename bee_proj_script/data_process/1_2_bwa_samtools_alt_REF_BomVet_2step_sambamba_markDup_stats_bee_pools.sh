#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 20
#SBATCH --mem 800g
#SBATCH --array=1%1
##SBATCH --time=02:10:00
#SBATCH --time=24:30:00
#SBATCH --error=1_bwa_samtools_REF_BomVet_2step_sambamba_markDup_stats.%A_%a.e
#SBATCH --output=1_bwa_samtools_REF_BomVet_2step_sambamba_markDup_stats.%A_%a.o
#SBATCH --job-name=1_bwa_samtools_REF_BomVet_2step_sambamba_markDup_stats
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## read fastq files and Read group lines
FASTQ_CLEAN=/faststorage/project/eDNA/yzliu/DK_proj/data/bee_proj_data/fastq_clean
cd $FASTQ_CLEAN
# Andhae_fastq1.fq.clean.gz
# Andhae_fastq2.fq.clean.gz
# Andmar_fastq1.fq.clean.gz
# Andmar_fastq2.fq.clean.gz
seq1=$(ls Bomvet*fastq1.fq.clean.gz | sed -n ${SLURM_ARRAY_TASK_ID}p) # forward sequence
seq2=$(ls Bomvet*fastq2.fq.clean.gz | sed -n ${SLURM_ARRAY_TASK_ID}p) # reverse sequence

## Read group
Sorted_ReadGroup_FILE=/faststorage/project/eDNA/yzliu/DK_proj/data/bee_proj_data/bam/ReadGroup_pooled.tab.list
ReadGroup=$(cat $Sorted_ReadGroup_FILE | sed -n ${SLURM_ARRAY_TASK_ID}p)
# @RG\tID:SN8522312001291\tLB:Andhae_pool1\tPL:BGI_DNBSEQ\tPU:gDNA\tSM:Andhae_pool1
# @RG\tID:SN8522312001292\tLB:Andmar_pool1\tPL:BGI_DNBSEQ\tPU:gDNA\tSM:Andmar_pool1
# @RG\tID:SN8522312001289\tLB:Bompas_pool1\tPL:BGI_DNBSEQ\tPU:gDNA\tSM:Bompas_pool1
# @RG\tID:SN8522312001290\tLB:Bomvet_pool1\tPL:BGI_DNBSEQ\tPU:gDNA\tSM:Bomvet_pool1

## mapping output
OUT_BAM=/faststorage/project/eDNA/yzliu/DK_proj/data/bee_proj_data/bam
## reference dir
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
# Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa
# Andrena_hattorfiana-GCA_944738655.1-softmasked.fa
# Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa
# Bombus_hypnorum-GCA_911387925.1-softmasked.fa
# Bombus_pascuorum-GCA_905332965.1-softmasked.fa

#"Andrena_fulva-GCA_946251845.1-softmasked.fa"
#"Andrena_trimmerana-GCA_951215215.1-softmasked.fa"
#"Bombus_hortorum-GCA_905332935.1-softmasked.fa"
#"Bombus_confusus-GCA_014737475.1_ASM1473747v1-softmasked.fa"

REF1_list=(
            #"Andrena_bicolor-GCA_960531205.1.fa"
            #"Andrena_bicolor-GCA_960531205.1.fa"
            
            #"Bombus_muscorum-GCA_963971125.1.fa"
            #"Bombus_sylvestris-GCA_911622165.2-softmasked.fa"
            "Bombus_veteranus.hifi_asm_pl2.fa"
            )
REF1=$(echo ${REF1_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)

OUT_NAME_list=(
            #"New_REF_AndBic"
            #"New_REF_AndBic"
            
            #"New_alt_REF_BomMus"
            #"New_REF_BomSyl"
            "New_REF_BomVet"
            )
OUT_NAME=$(echo ${OUT_NAME_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)
## out bam file name
File1=${seq1/_fastq1.fq.clean.gz/}

## activate (env) tools of variant_calling_mapping to use sambamba markdup
## https://lomereiter.github.io/sambamba/docs/sambamba-markdup.html#OPTIONS
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## read mapping, convert sam file to bam file, and sort reads
## not necessary to view and generate those files
## https://www.biostars.org/p/319730/
#bwa mem -t 8 $REF $seq1 $seq2 | samtools view -b -@ 8 | samtools sort -@ 8 -m 5G -o $OUTPUT/$File2

cd $OUT_BAM

## attention to REF variable
bwa mem -t 20 -R $ReadGroup $REF_DIR/$REF1 $FASTQ_CLEAN/$seq1 $FASTQ_CLEAN/$seq2 | samtools sort  -@ 8 -m 100G -o $OUT_BAM/$File1.$OUT_NAME".sort.bam"

## index sorted bam
samtools index $File1.$OUT_NAME".sort.bam"

## mark duplicates
SORTED_BAM=$File1.$OUT_NAME".sort.bam"
MARKED_BAM=${SORTED_BAM/.sort.bam/.sort.marked_dups.bam}

#picard MarkDuplicates \
#    I=$SORTED_BAM \
#    O=$MARKED_BAM \
#    M=$MARKED_BAM".metrics.csv" >& $MARKED_BAM.log

## less mem intensive
sambamba markdup $SORTED_BAM $MARKED_BAM --nthreads=20 --tmpdir=$TEMPDIR
#--show-progress

## index marked_dups
samtools index $MARKED_BAM
## stats
bamtools stats -in $MARKED_BAM > ./bam_stats/bamtools_stats/$MARKED_BAM
samtools stats -in $MARKED_BAM > ./bam_stats/samtools_stats/$MARKED_BAM

exit 0

*********************************************************
## stats
bam_list=(
    "Bompas.New_REF_BomHor-.sort.marked_dups.bam"
    "Bomvet.New_REF_BomHor-.sort.marked_dups.bam"
)

for bam in "${bam_list[@]}" # print out all items
    do
    printf $bam"\n"
    #done
    bamtools stats -in $bam > ./bam_stats/bamtools_stats/$bam
    samtools stats -in $bam > ./bam_stats/samtools_stats/$bam
done

*********************************************************
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