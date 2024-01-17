#!/bin/bash -l

#SBATCH -A snic2022-22-258
##SBATCH -p node
#SBATCH -n 10
#SBATCH --array=1-10%10
##SBATCH --array=1-592%300
##SBATCH -C mem256GB
#SBATCH -t 5:00:00
##SBATCH -t 24:00:00
#SBATCH -J fb_diploid_variant_calling_Bsyl.array_multipleCPU_cov2reg_calling
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=fb_diploid_variant_calling_Bsyl.array_multipleCPU_cov2reg_calling.%A.e
#SBATCH --output=fb_diploid_variant_calling_Bsyl.array_multipleCPU_cov2reg_calling.%A.o

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
coverage2region=`ls $REF_DIR/syl_coverage2region_array0`
#contig=$(cut -f 1 $REF_DIR/Bombus_sylvicola_v1.fna.fai | sed -n ${SLURM_ARRAY_TASK_ID}p)

##load module
module load bioinfo-tools
module load freebayes/1.3.2
module load bamtools/2.5.1
module load bcftools

mkdir $OUTDIR/freebayes_contig_cov2reg

#bamtools coverage -in $SAMPLE_BAM | coverage_to_regions.py $REF_DIR/Bombus_sylvicola_v1.fna.fai 500 > \
#$REF_DIR/syl_coverage2region_array0/$NEW_NAME

#bamtools coverage -in aln.bam | coverage_to_regions.py ref.fa 500 >ref.fa.500.regions
#freebayes-parallel ref.fasta.500.regions 36 -f ref.fa aln.bam >out.vcf

freebayes-parallel $REF_DIR/syl_coverage2region_array0/$coverage2region 10 \
--fasta-reference $REF --bam-list $SAMPLE \
--ploidy 2 --strict-vcf --gvcf > $OUTDIR/freebayes_contig_cov2reg/fb_female_52mon_66lap.$SAMPLE.g.vcf
#--strict-vcf --gvcf | bgzip -c > $OUTDIR/freebayes_contig_cov2reg/fb_female_52mon_66lap.$SAMPLE.g.vcf.gz
