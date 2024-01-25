#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p node
##SBATCH -n 1
##SBATCH --array=1-592%200
#SBATCH -C mem256GB
#SBATCH -t 21:00:00
#SBATCH -J freeBayes_syl_coverage2region
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=freeBayes_syl_coverage2region.%A.e
#SBATCH --output=freeBayes_syl_coverage2region.%A.o

##the location of bam-files
SEQDIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL
OUTDIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/freebayes_variant_calling

#cd $OUTDIR #; mkdir freebayes_contig_gt
cd $SEQDIR
##path to your ref genome
REF_DIR=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/
REF=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/Bombus_sylvicola_v1.fna
#REF_REGION=$REF_DIR/syl.ref.fa.100kbp.regions.freebayes

#SAMPLE_BAM=$(cat female.52monticola_66lapponicus.bam.list | sed -n ${SLURM_ARRAY_TASK_ID}p)
##example: WO_865.sorted_marked_dups.bam
SAMPLE=female.52monticola_66lapponicus.bam.list
#NEW_NAME=${SAMPLE/.bam/.bam.fna.500.coverage2regions}
#NEW_NAME=freeBayes_female_52monticola_66lapponicus.bam.contig_x.g.vcf

#fasta_generate_regions.py $REF_DIR/Bombus_sylvicola_v1.fna.fai 100000 > $REF_DIR/syl.ref.fa.100kbp.regions.freebayes
## https://github.com/freebayes/freebayes/issues/73

contig_region=$(ls $REF_DIR/freebayes_syl_contig_region | sed -n ${SLURM_ARRAY_TASK_ID}p)
contig=$(cut -f 1 $REF_DIR/Bombus_sylvicola_v1.fna.fai | sed -n ${SLURM_ARRAY_TASK_ID}p)

## This function is to run the jobs in parallel
	function pwait() {
	while [ $(jobs -p | wc -l) -ge $1 ]; do
	sleep $2
	done
	}

function coverage2region() {

##load module
module load bioinfo-tools
module load freebayes/1.3.2
module load bamtools/2.5.1

for i in `cat $SAMPLE`; do
			# Then it waits for 10 s and then checks again
			pwait 200 10s
bamtools coverage -in $i | coverage_to_regions.py $REF_DIR/Bombus_sylvicola_v1.fna.fai 500 > \
$REF_DIR/syl_coverage2region/$i.fa.500.regions
done
wait
}
coverage2region
#freebayes-parallel ref.fasta.500.regions 36 -f ref.fasta aln.bam >out.vcf

#freebayes-parallel $REF_DIR/freebayes_syl_contig_region/$contig_region 17 \
#--fasta-reference $REF --bam-list $SAMPLE -r $contig -g 100 \
#--ploidy 2 --strict-vcf --gvcf > $OUTDIR/freebayes_contig_gt/freeBayes_female_52monticola_66lapponicus.bam.$contig.g.vcf

