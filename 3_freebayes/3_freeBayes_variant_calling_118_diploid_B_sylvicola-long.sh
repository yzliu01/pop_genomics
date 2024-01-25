#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 6
##SBATCH --array=1-2
##SBATCH --array=1-118%60
##SBATCH -C mem128GB
##SBATCH -t 00:20:00
#SBATCH -t 10-00:00:00
#SBATCH -J freeBayes_variant_calling_diploid_Bsyl
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=freeBayes_variant_calling_diploid_Bsyl.long.%A.e
#SBATCH --output=freeBayes_variant_calling_diploid_Bsyl.long.%A.o

##load module
module load bioinfo-tools
module load freebayes/1.3.2

##the location of bam-files
SEQDIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL
OUTDIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/freebayes_variant_calling

cd $SEQDIR
#; mkdir $OUTDIR/gVCF

##path to your ref genome
REF=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/Bombus_sylvicola_v1.fna

cd $SEQDIR
#SAMPLE=$(cat male.27monticola_62lapponicus.bam.list | sed -n ${SLURM_ARRAY_TASK_ID}p)
##example: WO_865.sorted_marked_dups.bam
SAMPLE=female.52monticola_66lapponicus.bam.list
#NEW_NAME=${SAMPLE/.bam/.bam.haploid.g.vcf.gz}
NEW_NAME=freeBayes_female_52monticola_66lapponicus.bam.g.long.vcf

freebayes --fasta-reference $REF --bam-list $SAMPLE --ploidy 2 --strict-vcf --gvcf > $OUTDIR/gVCF/$NEW_NAME
