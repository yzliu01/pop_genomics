#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 20
#SBATCH --mem 1000g
#SBATCH --array=1-16%16
##SBATCH --time=00:10:00
#SBATCH --time=1-15:30:00
#SBATCH --error=1_bwa_samtools_16REF_clean_fa_2step_sambamba_markDup_stats.%A_%a.e
#SBATCH --output=1_bwa_samtools_16REF_clean_fa_2step_sambamba_markDup_stats.%A_%a.o
#SBATCH --job-name=1_bwa_samtools_16REF_clean_fa_2step_sambamba_markDup_stats
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## read fastq files and Read group lines
FASTQ_CLEAN=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/fastq_clean
cd $FASTQ_CLEAN

#FASTQ_RAW=/home/yzliu/eDNA/faststorage/yzliu/BACKUP/pool_raw_data/pool_01_2025
#cd $FASTQ_RAW
# Aphsti_R1_001.fastq.gz
# Aphsti_R2_001.fastq.gz
## examples of clean data
# Andmar_fastq1.fq.clean.gz
# Andmar_fastq2.fq.clean.gz
## single batch
seq1=$(ls -t *R1_001.fq.clean.gz | head -16 | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p) # forward sequence
seq2=$(ls -t *R1_001.fq.clean.gz | head -16 | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p) # reverse sequence

## concatenated fastq files
#seq1=$(ls *R1_000.fq.clean.gz | sed -n ${SLURM_ARRAY_TASK_ID}p) # forward sequence
#seq2=$(ls *R2_000.fq.clean.gz | sed -n ${SLURM_ARRAY_TASK_ID}p) # reverse sequence

## Read group
Sorted_ReadGroup_FILE=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/ReadGroup_16pools.tab.list
ReadGroup=$(cat $Sorted_ReadGroup_FILE | sed -n ${SLURM_ARRAY_TASK_ID}p)
# 01_04_2025
# @RG\tID:AphSti\tLB:Col_AphSti\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Col_AphSti
# @RG\tID:BomMaj\tLB:Dip_BomMaj\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Dip_BomMaj
# @RG\tID:CerRyb\tLB:Hym_CerRyb\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Hym_CerRyb
# @RG\tID:EphDan\tLB:Eph_EphDan\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Eph_EphDan
# @RG\tID:MegLea\tLB:Hym_MegLea\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Hym_MegLea
# @RG\tID:NotGla\tLB:Hem_NotGla\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Hem_NotGla
# @RG\tID:OchPle\tLB:Lep_OchPle\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Lep_OchPle
# @RG\tID:PhrFul\tLB:Lep_PhrFul\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Lep_PhrFul
# @RG\tID:RutMac\tLB:Col_RutMac\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Col_RutMac
# @RG\tID:SteMel\tLB:Col_SteMel\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Col_SteMel

# 05_2025
#@RG\tID:AelAcu\tLB:Hem_AelAcu\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Hem_AelAcu
#@RG\tID:AgeAln\tLB:Col_AgeAln\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Col_AgeAln
#@RG\tID:AmpSol\tLB:Col_AmpSol\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Col_AmpSol
#@RG\tID:EriInt\tLB:Dip_EriInt\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Dip_EriInt
#@RG\tID:EriPer\tLB:Dip_EriPer\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Dip_EriPer
#@RG\tID:GerLac\tLB:Hem_GerLac\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Hem_GerLac
#@RG\tID:LasMor\tLB:Hym_LasMor\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Hym_LasMor
#@RG\tID:LepDol\tLB:Hem_LepDol\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Hem_LepDol
#@RG\tID:MalBip\tLB:Col_MalBip\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Col_MalBip
#@RG\tID:MysLon\tLB:Tri_MysLon\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Tri_MysLon
#@RG\tID:PhoAtr\tLB:Col_PhoAtr\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Col_PhoAtr
#@RG\tID:PorSca\tLB:Iso_PorSca\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Iso_PorSca
#@RG\tID:RhaFul\tLB:Col_RhaFul\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Col_RhaFul
#@RG\tID:TacFer\tLB:Dip_TacFer\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Dip_TacFer
#@RG\tID:ThoDec\tLB:Lep_ThoDec\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Lep_ThoDec
#@RG\tID:XesC-n\tLB:Lep_XesC-n\tPL:Azenta_NovaSeq2x150\tPU:gDNA\tSM:Lep_XesC-n


## mapping output
OUT_BAM=/faststorage/project/eDNA/yzliu/DK_proj/data/bee_proj_data/bam
## reference dir
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome

REF_list=(
# first and second batches
    #"Aphodius_sticticus-GCA_963966075.1.fa"
    #"Bombylius_major-GCA_932526495.1-softmasked.fa"
    #"Cerceris_rybyensis-GCA_910591515.1-softmasked.fa"
    #"Ephemera_danica-GCA_000507165.2.fa"
    #"Megachile_leachella-GCA_963576845.1-softmasked.fa"
    #######"Notonecta_glauca.hifi_asm_pl2.fa"
    #"Notonecta_glauca.hifi_asm_pl3.fa.masked"
    #"Ochropleura_plecta-GCA_905475445.1-softmasked.fa"
    #"Phragmatobia_fuliginosa-GCA_932526445.1-softmasked.fa"
    #"Rutpela_maculata-GCA_936432065.2-softmasked.fa"
    #"Stenurella_melanura-GCA_963583905.1.fa"

# third batch
    "Aelia_acuminata-GCA_911387785.2-softmasked.fa"
    "Agelastica_alni-GCA_950111635.2.fa.masked" # no gene bed    
    "Amphimallon_solstitiale-GCA_963170755.1-softmasked.fa"
    #"Aphodius_sticticus-GCA_963966075.1-softmasked.fa" # no gene bed
    #next"Bibio_marci-GCA_910594885.2-softmasked.fa"
    #"Bombylius_major-GCA_932526495.1-softmasked.fa"
    #"Cerceris_rybyensis-GCA_910591515.1-softmasked.fa" # test for stairway plot
    ####"Chorthippus_brunneus.hifi_asm_pl3.fa.masked" # grasshopper
    ####"Chorthippus_parallelus.hifi_asm_pl3.fa.masked" # grasshopper
    #next"Dorcus_parallelipipedus-GCA_958336345.1-softmasked.fa"
    #"Ephemera_danica-GCA_000507165.2-softmasked.fa" # no gene bed
    "Eristalis_intricaria-GCA_964034865.1-softmasked.fa"
    "Eristalis_pertinax-GCA_907269125.1-softmasked.fa"
    "Gerris_lacustris-GCA_951217055.1-softmasked.fa"
    "Lasioglossum_morio-GCA_916610235.2-softmasked.fa"
    "Leptopterna_dolobrata-GCA_954871275.1.fa.masked" # no gene bed
    "Malachius_bipustulatus-GCA_910589415.1-softmasked.fa"
    #"Megachile_leachella-GCA_963576845.1-softmasked.fa" # test for stairway plot
    "Mystacides_longicornis-GCA_963576905.1.fa.masked" # no gene bed
    #next"Noctua_pronuba-GCA_905220335.1-softmasked.fa"
    #"Notonecta_glauca.hifi_asm_pl3.fa.masked" # "Notonecta_glauca.hifi_asm_pl3-softmasked.fa" # self assembly: best -> same as: Notonecta_glauca.hifi_asm_pl3.fa.masked
    #"Ochropleura_plecta-GCA_905475445.1-softmasked.fa"
    #next"Panurgus_banksianus.hifi_asm_pl3.fa.masked" # assembling
    "Phosphuga_atrata-GCA_944588485.1-softmasked.fa"
    #"Phragmatobia_fuliginosa-GCA_932526445.1-softmasked.fa"
    "Porcellio_scaber-GCA_034700385.1.fa.masked" # no gene bed
    #next"Pterostichus_niger-GCA_947425015.1-softmasked.fa"
    "Rhagonycha_fulva-GCA_905340355.1-softmasked.fa"
    #"Rutpela_maculata-GCA_936432065.2-softmasked.fa" # test for stairway plot
    #"Stenurella_melanura-GCA_963583905.1-softmasked.fa" # no gene bed
    "Tachina_fera-GCA_905220375.1-softmasked.fa"
    "Tholera_decimalis-GCA_943138885.2.fa.masked"
    "Xestia_c-nigrum-GCA_916618015.1.fa.masked" # no gene bed

)

REF=$(echo ${REF_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)

OUT_NAME_list=(
# first and second batches
            #"REF_AphSti"
            #"REF_BomMaj"
            #"REF_CerRyb"
            #"REF_EphDan"
            #"REF_MegLea"
            #"REF_NotGla"
            #"REF_OchPle"
            #"REF_PhrFul"
            #"REF_RutMac"
            #"REF_SteMel"
# third batch
"REF_AelAcu"
"REF_AgeAln"
"REF_AmpSol"
"REF_EriInt"
"REF_EriPer"
"REF_GerLac"
"REF_LasMor"
"REF_LepDol"
"REF_MalBip"
"REF_MysLon"
"REF_PhoAtr"
"REF_PorSca"
"REF_RhaFul"
"REF_TacFer"
"REF_ThoDec"
"REF_XesC-n"
)
OUT_NAME=$(echo ${OUT_NAME_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)
## out bam file name
# Aphsti_R1_001.fastq.gz
File=${seq1/_R1_000.fq.clean.gz/}

## activate (env) tools of variant_calling_mapping to use sambamba markdup
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## read mapping, convert sam file to bam file, and sort reads
cd $OUT_BAM

## attention to REF variable
bwa mem -t 20 -R $ReadGroup $REF_DIR/$REF $FASTQ_CLEAN/$seq1 $FASTQ_CLEAN/$seq2 | samtools sort  -@ 8 -m 100G -o $OUT_BAM/$File.$OUT_NAME".sort.bam"
## Notgla.REF_NotGla.sort.bam

## mark duplicates
SORTED_BAM=$File.$OUT_NAME".sort.bam"
MARKED_BAM=${SORTED_BAM/.sort.bam/.sort.marked_dups.bam}

#picard MarkDuplicates \
#    I=$SORTED_BAM \
#    O=$MARKED_BAM \
#    M=$MARKED_BAM".metrics.csv" >& $MARKED_BAM.log

## less mem intensive
sambamba markdup $SORTED_BAM $MARKED_BAM --nthreads=20 --tmpdir=$TEMPDIR
## Notgla.REF_NotGla.sort.marked_dups.bam

## index marked_dups
samtools index $MARKED_BAM
## stats
bamtools stats -in $MARKED_BAM > ./bam_stats/bamtools_stats/$MARKED_BAM
samtools stats -in $MARKED_BAM > ./bam_stats/samtools_stats/$MARKED_BAM

exit 0

bamtools stats -in Cerryb.REF_CerRyb.sort.marked_dups.bam > ./bam_stats/bamtools_stats/Cerryb.REF_CerRyb.sort.mark
ed_dups.bamtools_stats

**********************************************
Stats for BAM file(s): 
**********************************************

Total reads:       704491434
Mapped reads:      703300556	(99.831%)
Forward strand:    354640086	(50.3399%)
Reverse strand:    349851348	(49.6601%)
Failed QC:         0	(0%)
Duplicates:        55292361	(7.84855%)
Paired-end reads:  704491434	(100%)
'Proper-pairs':    641175994	(91.0126%)
Both pairs mapped: 702940722	(99.7799%)
Read 1:            351697130
Read 2:            352794304
Singletons:        359834	(0.0510771%)

# samtools stats
# This file was produced by samtools stats (1.19+htslib-1.19) and can be plotted using plot-bamstats
# This file contains statistics for all reads.
# The command line was:  stats -in Cerryb.REF_CerRyb.sort.marked_dups.bam
# CHK, Checksum [2]Read Names   [3]Sequences    [4]Qualities
# CHK, CRC32 of reads which passed filtering followed by addition (32bit overflow)
CHK     61f6694d        2d69a206        7bbe641c
# Summary Numbers. Use `grep ^SN | cut -f 2-` to extract this part.
SN      raw total sequences:    682866380       # excluding supplementary and secondary reads
SN      filtered sequences:     0
SN      sequences:      682866380
SN      is sorted:      1
SN      1st fragments:  341433190
SN      last fragments: 341433190
SN      reads mapped:   681675502
SN      reads mapped and paired:        681372024       # paired-end technology bit set + both mates mapped
SN      reads unmapped: 1190878
SN      reads properly paired:  634404714       # proper-pair bit set
SN      reads paired:   682866380       # paired-end technology bit set
SN      reads duplicated:       55292361        # PCR or optical duplicate bit set
SN      reads MQ0:      209709349       # mapped and MQ=0