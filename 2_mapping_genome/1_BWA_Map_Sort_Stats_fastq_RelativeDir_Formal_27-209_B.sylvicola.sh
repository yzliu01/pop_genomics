#!/bin/bash -l

#SBATCH -A snic2021-22-195
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 04-04:00:00
#SBATCH --array=27-209
#SBATCH -J B.syl.all.sorted_bwa_mapping_SE
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --output=bwa_mapping_all_sorted_27-209_SE_B.sylvicola.%A.o
#SBATCH --error=bwa_mapping_all_sorted_27-209_SE_B.sylvicola.%A.e


# Main directories as variables
# SEQDIR assumed to contain all fastq-files

# Output:       Sorted, indexed BAM-file for each sample
#               BAM-stats for all samples written to the same file (bamtools_stats.txt in SEQDIR)

# Update this with the full path to the directory where you have the sample fastq files
SEQDIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL

# Seed files
# SEED=/crex/proj/snic2020-6-58/private/yzliu/swedish_bumblebee/1_mapping/B.balteatus

# mapping dir
# MAPDIR=$SEQDIR #/crex/proj/snic2020-6-58/private/yzliu/swedish_bumblebee/1_mapping

# Reference sequence
# Update this with the full path to the directory where you have the reference genome
REFDIR=/crex/proj/snic2020-6-58/private/yzliu/reference_genome
# Update this with the name of the ref fasta file
REF=$REFDIR/Bombus_sylvicola_v1.fna


# Load the bwa (/0.7.17) module to make bwa available
# Load samtools (/1.9), bamtools (/2.5.1) automatically the latest version

module load bioinfo-tools
module load bwa
module load samtools
module load bamtools

# defining the SEED files
cd $SEQDIR
SEEDFILE1=seed1_R1_new				### Read1.fastq.gz
SEEDFILE2=seed2_R2_new				### Read2.fastq.gz
SEEDFILE3=seed3_RG					### ReadGroup for bwa
SEEDFILE4=seed4_sampleName_new		### Sample name


SEED1=$(awk "NR==$SLURM_ARRAY_TASK_ID" $SEEDFILE1)
SEED2=$(awk "NR==$SLURM_ARRAY_TASK_ID" $SEEDFILE2)
SEED3=$(awk "NR==$SLURM_ARRAY_TASK_ID" $SEEDFILE3)
SEED4=$(awk "NR==$SLURM_ARRAY_TASK_ID" $SEEDFILE4)

#File1=`cat seed4_sampleName | sed 's/_S.*_R1_001.fastq.gz/.test_111.sam/'`
# P23261_106.bam
#File2=`cat seed4_sampleName | sed 's/_S.*_R1_001.fastq.gz/.sorted.test_111.bam/'`
# P23261_106.sorted.bam

File1=${SEED4/.fastq.gz/.bam}	     		 ### bam file
File2=${File1/.bam/_sort.bam}			     ### sorted bam file

# application run with 8 threads

bwa mem -t 8 -R $SEED3 $REF $SEED1 $SEED2 | samtools view -b -@ 8 -o $File1 

samtools sort -@ 8 -m 5G -o $File2 $File1

samtools index $File2

for sample in ${File2}; do
	echo $sample
	echo "Running bamtools stats for $sample" >> bam_stat_test_27-209.txt
bamtools stats -in $sample >> bam_stat_test_27-209.txt
done

