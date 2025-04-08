#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 20
#SBATCH --mem 500g
#SBATCH --array=2-5%4
##SBATCH --array=1-100%100
##SBATCH --time=00:10:00
#SBATCH --time=2-05:30:00
#SBATCH --error=1_2_msprime_sim_samtools.sambamba_stats.sambamba_stats.%A_%a.e
#SBATCH --output=1_2_msprime_sim_samtools.sambamba_stats.sambamba_stats.%A_%a.o
#SBATCH --job-name=1_2_msprime_sim_samtools.sambamba_stats.sambamba_stats
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

# 10 min test job_id 52764774

## read fastq files and Read group lines
sim_sam=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/simulated_reference_genomes/sim_reads
cd $sim_sam

## activate (env) tools of variant_calling_mapping to use sambamba markdup
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate art_illumina

## step II: merge individual bam to a single one
#SLURM_ARRAY_TASK_ID=2
#bam_files=$(ls *DP_"$SLURM_ARRAY_TASK_ID".sim_illumina_PE*bam | sort -t '_' -k2,2n | tr "\n" " ")
#samtools merge -f "hap_100_DP_$SLURM_ARRAY_TASK_ID.sim_illumina_PE_data.bam" "${bam_files[@]}"
#rm hap_100_DP_2.sim_illumina_PE_data.bam
# use -b file list, one file name per line
ls *DP_"$SLURM_ARRAY_TASK_ID".sim_illumina_PE*bam | sort -t '_' -k2,2n > bam_files.list
samtools merge -f "hap_100_DP_$SLURM_ARRAY_TASK_ID.sim_illumina_PE_data.bam" -b bam_files.list



# | samtools view | less -S

exit 0

## step I: convert sam to bam
#SLURM_ARRAY_TASK_ID=1
sam_file_DP2=$(ls *DP_2*sam.gz | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
out_bam_DP2=${sam_file_DP2/sam.gz/bam}
sam_file_DP3=$(ls *DP_3*sam.gz | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
out_bam_DP3=${sam_file_DP3/sam.gz/bam}
sam_file_DP4=$(ls *DP_4*sam.gz | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
out_bam_DP4=${sam_file_DP4/sam.gz/bam}
sam_file_DP5=$(ls *DP_5*sam.gz | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
out_bam_DP5=${sam_file_DP5/sam.gz/bam}
#bwa mem -t 20 -R $ReadGroup $REF_DIR/$REF1 $FASTQ_CLEAN/$seq1 $FASTQ_CLEAN/$seq2 | samtools sort  -@ 8 -m 100G -o $OUT_BAM/$File1.$OUT_NAME".sort.bam"
samtools sort $sam_file_DP2 -@ 8 -m 50G -o $out_bam_DP2
samtools sort $sam_file_DP3 -@ 8 -m 50G -o $out_bam_DP3
samtools sort $sam_file_DP4 -@ 8 -m 50G -o $out_bam_DP4
samtools sort $sam_file_DP5 -@ 8 -m 50G -o $out_bam_DP5

exit 0

bam_list=$(ls *DP_2.sim_illumina_PE*bam | sort -t '_' -k2,2n)
samtools merge hap_100_DP_2.sim_illumina_PE_data.bam $bam_list | samtools view | less -S

#ls tsk_*: Lists all files starting with tsk_.
#sort -t '_': Uses _ as the field delimiter.
#-k2,2n: Sorts by the second field (the number after tsk_), treating it as a numeric value (n flag ensures numeric sorting instead of lexicographic).

## mark duplicates
SORTED_BAM=$File1.$OUT_NAME".sort.bam"
MARKED_BAM=${SORTED_BAM/.sort.bam/.sort.marked_dups.bam}

#picard MarkDuplicates \
#    I=$SORTED_BAM \
#    O=$MARKED_BAM \
#    M=$MARKED_BAM".metrics.csv" >& $MARKED_BAM.log

## less mem intensive
sambamba markdup $SORTED_BAM $MARKED_BAM --nthreads=20 --tmpdir=$TEMPDIR

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