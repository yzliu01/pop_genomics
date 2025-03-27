#!/bin/bash
#SBATCH --account eDNA
##SBATCH --cpus-per-task 12
#SBATCH --mem 20g
##SBATCH --array=1-10%10
##SBATCH --array=1-1%1
#SBATCH --time=05:14:00
#SBATCH --error=subset_vcf_each_ind_and_consensus_ref.%A_%a.e
#SBATCH --output=subset_vcf_each_ind_and_consensus_ref.%A_%a.o
#SBATCH --job-name=subset_vcf_each_ind_and_consensus_ref
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## call env
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
conda activate bcftools
#conda activate bioproject

#*************************** step III: subset each individual for a vcf file *************
sim_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/simulated_reference_genomes
cd $sim_dir

#concat_vcf_gz=concat_sim_100hap_N_0_1000_Nt_1200_200000.vcf.gz
#sim_ref=sim_reference_genome_1.1Gb.fasta
#vcf_gz=chromosome_1.vcf.gz
#sim_ref=reference_genome.fasta
# get sample list
#bcftools query -l $vcf_gz > sim_sample.list

# subset vcf files for each individual, e.g., tsk_99
#bcftools view $concat_vcf_gz -s tsk_99 -O z -o tsk_99.vcf.gz
#bcftools view chromosome_1.vcf- -s tsk_99 -O z -o chromosome_1_tsk_99.vcf.gz

## formal
#vcf=$(ls chromosome_{1..10}.vcf.gz | sort -V | awk '{print $0}')
#chr_vcf=$(ls chromosome_{1..10}.vcf.gz | sort -V)
#ind=$(read -a ind < sim_sample.list)
ind_list=$(awk '{print $0}' sim_sample.list)
# tsk_1 tsk_2
## print index
#echo ${!ind[*]}

for ind in $ind_list
do
echo -e "\n$ind"
# tsk_1 tsk_2
#done
    for chr_n in {1..10}
    do
    echo "chr_$chr_n"
    #chr_vcf="chromosome_$chr_n.vcf.gz"
    # chromosome_6.vcf.gz
    chr_vcf="chr_$chr_n.vcf.gz"
    # chr_6.vcf.gz
    ## new vcf file names for wach individual
    echo "$ind.chr_$chr_n.vcf.gz"
    #done
    bcftools view $chr_vcf -s $ind -O z -o ./sim_ind_vcf/"$ind.chr_$chr_n.vcf.gz"
    done
done

exit 0

*************************** step IV: concate vcf file for each individual *************
 
## concatenate VCF/BCF files from the same set of samples
## merge VCF/BCF files files from non-overlapping sample sets
ind_list=$(awk '{print $0}' sim_sample.list)
# tsk_1 tsk_2
## print index
#echo ${!ind[*]}

for ind in $ind_list
do
echo -e "\n$ind\n"
# tsk_1 tsk_2
ls ./sim_ind_vcf/$ind.chr*vcf.gz | sort -V
vcf_list=$(ls ./sim_ind_vcf/$ind.chr*vcf.gz | sort -V | tr "\n" " ")
bcftools concat $vcf_list -O z -o ./concat_ind_vcf/"$ind"_chr_1_10.vcf.gz
#bgzip ./concat_ind_vcf/"$ind"_chr_1_10.vcf.gz
bcftools index ./concat_ind_vcf/"$ind"_chr_1_10.vcf.gz
done

## concate vcf and index it
vcf_list=$(ls ./concat_ind_vcf/tsk_*_chr_1_10.vcf.gz | sort -V | tr "\n" " ")
## merge non-overlapping samples
bcftools merge $vcf_list -O z -o ./concat_ind_vcf/hap_100_chr_1_10.vcf.gz
bcftools index ./concat_ind_vcf/hap_100_chr_1_10.vcf.gz

*************************** step V: make consensus ref genomes for each individual *************
 
#bcftools consensus -H A -f reference_genome.fasta chromosome_1_tsk_99.vcf.gz -o chromosome_1_tsk_99_genome.fa 2>&1 | tee chromosome_1_tsk_99.debug.log
conda activate bcftools
#tsk_99_vcf_300lines=chromosome_1_tsk_99_300lines.vcf.gz
#chr1_md_ref=reference_genome_chr1_100Mb_300lines.mapped_ref.fasta
#bcftools consensus -H A -f $chr1_md_ref $tsk_99_vcf_300lines -o chr_1_tsk_99_300lines_consensus_genome.fa 2>&1 | tee chr_1_tsk_99_300lines_consensus_genome.debug.log

## combined each chr as a whole ref genome
ls ref_genome_md_chr_*.final.fasta | sort -V | xargs cat > ref_genome_md.chr_1_10.fa

cd ./concat_ind_vcf
tsk_vcf_list=($(ls tsk_*chr_1_10.vcf.gz | sort -V))
REF_allele_mapped_REF=../ref_genome_md.chr_1_10.fa
#for tsk in $(ls tsk_*chr_1_10.vcf.gz | sort -V)
for i in ${!tsk_vcf_list[*]}
do
#echo -e "\n$tsk"
echo ${tsk_vcf_list[i]}
#done
bcftools consensus -H A -f $REF_allele_mapped_REF $tsk -o tsk_"$i"_consensus_genome.fa 2>&1 | tee tsk_"$i"_consensus_genome.debug.log
done

## total SNP number
 less -S /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/simulated_reference_genomes/concat_ind_vcf/tsk_99_chr_1_10.vcf.gz | wc -l
429913

 wc -l /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/simulated_reference_genomes/chr_10.vcf
39349
