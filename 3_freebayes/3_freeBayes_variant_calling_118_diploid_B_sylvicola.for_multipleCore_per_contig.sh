,#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p node
##SBATCH -n 18
##SBATCH --array=1-2
##SBATCH --array=1-118%60
#SBATCH -C mem256GB
#SBATCH -t 01-05:00:00
#SBATCH -J freeBayes_diploid_variant_calling_Bsyl.multipleCPU
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=freeBayes_diploid_variant_calling_Bsyl.multipleCPU.%A.e
#SBATCH --output=freeBayes_diploid_variant_calling_Bsyl.multipleCPU.%A.o

##the location of bam-files
SEQDIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL
OUTDIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/freebayes_variant_calling

cd $SEQDIR; mkdir $OUTDIR/new_per_contig_gt

##path to your ref genome
REF_DIR=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/
REF=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/Bombus_sylvicola_v1.fna
REF_REGION=$REF_DIR/syl.ref.fa.100kbp.regions.freebayes

#SAMPLE=$(cat male.27monticola_62lapponicus.bam.list | sed -n ${SLURM_ARRAY_TASK_ID}p)
##example: WO_865.sorted_marked_dups.bam
SAMPLE=female.52monticola_66lapponicus.bam.list
#NEW_NAME=${SAMPLE/.bam/.bam.haploid.g.vcf.gz}
#NEW_NAME=freeBayes_female_52monticola_66lapponicus.bam.contig_x.g.vcf

#fasta_generate_regions.py $REF_DIR/Bombus_sylvicola_v1.fna.fai 100000 > $REF_DIR/syl.ref.fa.100kbp.regions.freebayes
## https://github.com/freebayes/freebayes/issues/73

## This function is to run the jobs in parallel
	function pwait() {
	while [ $(jobs -p | wc -l) -ge $1 ]; do
	sleep $2
	done
	}

function freebayes_genotyping() {
##load module
module load bioinfo-tools
module load freebayes/1.3.2

	for i in `cut -f 1 $REF_DIR/Bombus_sylvicola_v1.fna.fai`; do
			# The jobs are submitted in the background (with the "&" option below)
			# The pwait function prevents jobs from being submitted if the maximum number of jobs (40) are already running
			# Then it waits for 10 s and then checks again
			pwait 40 10s
			
			Ref_Region=`grep $i $REF_REGION`
			freebayes-parallel $Ref_Region --fasta-reference $REF -r $i --bam-list $SAMPLE \
			--ploidy 2 --strict-vcf --gvcf > $OUTDIR/new_per_contig_gt/freeBayes_female_52monticola_66lapponicus.bam.$i.g.vcf &
	done
	wait # wait until all jobs have finished
	}

freebayes_genotyping

