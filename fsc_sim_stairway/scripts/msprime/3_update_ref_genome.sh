#!/bin/bash
#SBATCH --account eDNA
##SBATCH --cpus-per-task 12
#SBATCH --mem 20g
#SBATCH --array=1-10%10
##SBATCH --array=1-1%1
#SBATCH --time=1-04:14:00
#SBATCH --error=updata_ref_genome_ref_alleles.%A_%a.e
#SBATCH --output=updata_ref_genome_ref_alleles.%A_%a.o
#SBATCH --job-name=updata_ref_genome_ref_alleles
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## call env
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
conda activate bioproject
## execute python script
sim_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/simulated_reference_genomes
cd $sim_dir

## vcf files need to be compressed bgzip for bcftools later
#conda activate bcftools
#for vcf in $(ls chr_*.vcf | sort -V)
#do
#echo $vcf
#bgzip -kf $vcf
#bcftools index $vcf.gz
#done

original_ref=reference_genome.fasta
#concat_vcf=concat_sim_100hap_N_0_1000_Nt_1200_200000.new.vcf.gz
vcf=$(ls chr_{1..10}.vcf.gz | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
# ls chromosome_{1..10}.vcf.gz
# ls chromosome_*.vcf.gz | grep -E 'chromosome_[1-9]|chromosome_10\.vcf.gz'
# ls chromosome_@([1-9]|10).vcf.gz

#output_md_ref=reference_genome_md_chr_${SLURM_ARRAY_TASK_ID}.fasta
output_md_ref=ref_genome_md_chr_${SLURM_ARRAY_TASK_ID}.fasta
convert_script=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/fsc_sim_stairway/scripts/msprime/3_replace_ref_alleles_ref_genome_by_ref_alleles_vcf.new.py
python $convert_script --ref $original_ref --vcf $vcf --output $output_md_ref
# this script output fasta for all chr, need to subset each chr later in step II

exit 0


*************************** step I test only: test to convert REF alleles in REF as above *************

conda activate bcftools
## 100 lines
sim_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/simulated_reference_genomes
## create bgzip compressed vcf file for bcftools
less -S chromosome_1_tsk_99.vcf.gz | head -100 | bgzip > chromosome_1_tsk_99_100lines.vcf.gz

## index the vcf
bcftools index chromosome_1_tsk_99_100lines.vcf.gz

tsk_99_vcf_100lines=chromosome_1_tsk_99_100lines.vcf.gz
chr1_md_ref=reference_genome_chr1_100Mb.mapped_ref.fasta
convert_script=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/fsc_sim_stairway/scripts/msprime/replace_ref_alleles_ref_genome_by_ref_alleles_vcf.new.py

conda activate bioproject
python $convert_script --ref $original_ref --vcf $tsk_99_vcf_100lines --output $chr1_md_ref


## make consensus ref genome
#bcftools consensus -H A -f reference_genome.fasta chromosome_1_tsk_99.vcf.gz -o chromosome_1_tsk_99_genome.fa 2>&1 | tee chromosome_1_tsk_99.debug.log
conda activate bcftools
bcftools consensus -H A -f $chr1_md_ref $tsk_99_vcf_100lines -o chr_1_tsk_99_100lines_genome.fa 2>&1 | tee chr_1_tsk_99_100lines.debug.log

**************************************
conda activate bcftools
## 300 lines
sim_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/simulated_reference_genomes
## create bgzip compressed vcf file for bcftools
less -S chromosome_1_tsk_99.vcf.gz | head -300 | bgzip > chromosome_1_tsk_99_300lines.vcf.gz

## index the vcf
bcftools index chromosome_1_tsk_99_300lines.vcf.gz

tsk_99_vcf_300lines=chromosome_1_tsk_99_300lines.vcf.gz
chr1_md_ref=reference_genome_chr1_100Mb_300lines.mapped_ref.fasta
convert_script=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/fsc_sim_stairway/scripts/msprime/replace_ref_alleles_ref_genome_by_ref_alleles_vcf.new.py

conda activate bioproject
python $convert_script --ref $original_ref --vcf $tsk_99_vcf_300lines --output $chr1_md_ref


*************************** step II: subset reference genome fasta sequences based on chr names *************

conda activate variant_calling_mapping

ref_chr_md=($(ls ref_genome_md_chr_*.fasta | sort -V | awk '{print $0}'))

for i in ${!ref_chr_md[*]}
do
echo ${ref_chr_md[i]}
#bgzip -k ${ref_chr_md[i]}
#samtools faidx ${ref_chr_md[i]}
#done
#echo $i
# remove prefix text using #
chr_n=${ref_chr_md[i]#ref_genome_md_chr_}
# remove suffix text using %
chr_n=${chr_n%.fasta}
echo $chr_n
#done
# use 'samtools faidx' to subset sequences based on header names
samtools faidx ${ref_chr_md[i]} $chr_n -o ref_genome_md_chr_$chr_n.final.fasta
done



exit 0

## test samtools faidx
## https://www.biostars.org/p/469520/#9534676
samtools faidx reference.fasta chr1
samtools faidx reference_genome_md_chr_1.new.fasta -o reference_genome_md_chr_1.final.fasta
## not working
#seqkit subseq -r 1: reference_genome_md_chr_1.new.fasta.gz -o reference_genome_md_chr_1.final.fasta.gz
# seqkit -h
