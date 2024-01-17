#!/bin/bash -l

#SBATCH -A snic2021-22-195
#SBATCH -p core
#SBATCH --array=14-209
##SBATCH -C mem128GB
#SBATCH -t 2-20:00:00
#SBATCH -J 14-209_array_Bsyl_haplotypecaller
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=variant_calling_haplotypecaller_array_14-209_Bsyl.%A.e
#SBATCH --output=variant_calling_haplotypecaller_array_14-209_Bsyl.%A.o


# Main directories as variables

# Update the location of your bam-files
SEQDIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL
OUTDIR=$SEQDIR"/gVCF"
#cd $SEQDIR
#mkdir gVCF

# Update with the path to your ref genome
REFDIR=/crex/proj/snic2020-6-58/private/yzliu/reference_genome
# Update this with the name of the ref fasta file
REF=$REFDIR/Bombus_sylvicola_v1.fna

# Haploid or diploid genotyping=
# PLOIDY=2
# -ploidy $PLOIDY


cd $SEQDIR

SAMPLE=$(ls *sorted_marked_dups.bam | sed -n ${SLURM_ARRAY_TASK_ID}p)
# example: M_L010.sorted.marked_dups.bam

echo "Running HaplotypeCaller for $SAMPLE"

module load bioinfo-tools
module load GATK

gatk HaplotypeCaller -R $REF \
-I $SAMPLE \
-O $OUTDIR/$SAMPLE.g.vcf.gz \
-ERC GVCF
