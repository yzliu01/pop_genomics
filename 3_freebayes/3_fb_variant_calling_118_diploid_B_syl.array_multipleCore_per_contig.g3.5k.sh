#!/bin/bash -l

#SBATCH -A snic2022-22-258
##SBATCH -p node
#SBATCH -n 18
#SBATCH --array=1-592%300
##SBATCH -C mem256GB
#SBATCH -t 48:00:00
#SBATCH -J fb_g3.5k_diploid_variant_calling_Bsyl.array_multipleCPU_g1k
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=fb_diploid_variant_calling_Bsyl.array_multipleCPU_g3.5k.%A.e
#SBATCH --output=fb_diploid_variant_calling_Bsyl.array_multipleCPU_g3.5k.%A.o

##the location of bam-files
SEQDIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL
OUTDIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/freebayes_variant_calling

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

#for i in {001..592}; do grep contig_$i syl.ref.fa.100kbp.regions.freebayes > \
#./freebayes_syl_contig_region/syl.ref.fa.100kbp.contig_$i.regions.freebayes; done

contig_region=$(ls $REF_DIR/freebayes_syl_contig_region | sed -n ${SLURM_ARRAY_TASK_ID}p)
contig=$(cut -f 1 $REF_DIR/Bombus_sylvicola_v1.fna.fai | sed -n ${SLURM_ARRAY_TASK_ID}p)

##load module
module load bioinfo-tools
module load freebayes/1.3.2
module load bamtools/2.5.1

#cd $OUTDIR; mkdir freebayes_contig_gt

freebayes-parallel $REF_DIR/freebayes_syl_contig_region/$contig_region 17 \
--fasta-reference $REF --bam-list $SAMPLE -r $contig -g 3500 \
--ploidy 2 --strict-vcf --gvcf > $OUTDIR/freebayes_contig_g1k/fb_female_52mon_66lap.$contig.g.vcf

