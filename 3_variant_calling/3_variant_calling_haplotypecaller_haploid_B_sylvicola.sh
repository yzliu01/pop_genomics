#!/bin/bash -l

#SBATCH -A snic2021-22-195
#SBATCH -p core
#SBATCH -n 1
#SBATCH --array=1-89%40
##SBATCH -C mem128GB
#SBATCH -t 3-00:20:00
#SBATCH -J haploid_Bsyl_haplotypecaller
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=variant_calling_haplotypecaller_haploid_Bsyl.%A.e
#SBATCH --output=variant_calling_haplotypecaller_haploid_Bsyl.%A.o


# Main directories as variables

# Update the location of your bam-files
SEQDIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL
OUTDIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy
#cd $SEQDIR
#mkdir gVCF

# Update with the path to your ref genome
REFDIR=/crex/proj/snic2020-6-58/private/yzliu/reference_genome
# Update this with the name of the ref fasta file
REF=$REFDIR/Bombus_sylvicola_v1.fna

# Haploid or diploid genotyping
# PLOIDY=2
# -ploidy $PLOIDY

cd $SEQDIR

SAMPLE=$(cat male.27monticola_62lapponicus.bam.list | sed -n ${SLURM_ARRAY_TASK_ID}p)
# example: WO_865.sorted_marked_dups.bam

NEW_NAME=${SAMPLE/.bam/.bam.haploid.g.vcf.gz}

echo "Running HaplotypeCaller for $SAMPLE"

module load bioinfo-tools
module load GATK

gatk HaplotypeCaller -R $REF -I $SAMPLE -ploidy 1 \
-O $OUTDIR/$NEW_NAME -ERC GVCF
