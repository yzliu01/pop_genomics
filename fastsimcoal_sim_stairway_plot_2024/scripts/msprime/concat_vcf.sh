## https://cyverse.atlassian.net/wiki/spaces/DEapps/pages/259063974/vcftools-merge+0.1.16
## https://vcftools.sourceforge.net/perl_module.html

conda activate variant_calling_mapping
#vcf-concat -h

sim_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/simulated_reference_genomes
cd $sim_vcf_dir

vcf_list=$(ls -t chromosome*.vcf | sort -V | tr "\n" " ")
# not update the header lines
#vcf-concat $vcf_list > concated_sim_100hap_N_0_1000_Nt_1200_200000.vcf

conda activate bcftools
# concat       concatenate VCF/BCF files from the same set of samples
# merge        merge VCF/BCF files files from non-overlapping sample sets
# updata header lines in vcf files
#bcftools concat $vcf_list > concat_sim_100hap_N_0_1000_Nt_1200_200000.vcf
#bgzip concat_sim_100hap_N_0_1000_Nt_1200_200000.vcf
#bcftools index concat_sim_100hap_N_0_1000_Nt_1200_200000.vcf.gz
bcftools concat $vcf_list > concat_sim_100hap_N_0_1000_Nt_1200_200000.new.vcf
bgzip concat_sim_100hap_N_0_1000_Nt_1200_200000.new.vcf
bcftools index concat_sim_100hap_N_0_1000_Nt_1200_200000.new.vcf.gz

# subset each individual for a vcf file
#concat_vcf_gz=concat_sim_100hap_N_0_1000_Nt_1200_200000.vcf.gz
#sim_ref=sim_reference_genome_1.1Gb.fasta
concat_vcf_gz=concat_sim_100hap_N_0_1000_Nt_1200_200000.new.vcf.gz
sim_ref=reference_genome.fasta
# get sample list
bcftools query -l $concat_vcf_gz > sim_sample.list

# subset vcf files for each individual, e.g., tsk_99
bcftools view $concat_vcf_gz -s tsk_99 -O z -o tsk_99.vcf.gz
bcftools view chromosome_1.vcf- -s tsk_99 -O z -o chromosome_1_tsk_99.vcf.gz

vcf_list=$(ls chromosome_{1..10}.vcf | sort -V)
for vcf in $vcf_list
do
echo $vcf
bgzip -k $vcf
#bgzip -d $vcf
bcftools index $vcf.gz
done


chr_vcf=(ls chromosome_{1..10}.vcf.gz | sort -V)
#ind=$(read -a ind < sim_sample.list)
ind_list=($(awk '{print $0}' sim_sample.list))
## print index
echo ${!ind[*]}

for ind in $ind_list
do
echo $ind
#done
new_chr_vcf=${chr_vcf/vcf.gz/}
bcftools view $chr_vcf -s $ind -O z -o $new_chr_vcf.$ind.vcf.gz
done


bcftools index tsk_99.vcf.gz
tabix tsk_99.vcf.gz
tabix chromosome_1_tsk_99.vcf.gz

bcftools consensus -f $sim_ref tsk_99.vcf.gz | less -S 

bcftools consensus -H A -f reference_genome.fasta tsk_99.vcf.gz -o tsk_99_genome.fa 2>&1 | tee debug.log

bcftools consensus -H A -f reference_genome.fasta chromosome_1_tsk_99.vcf.gz -o chromosome_1_tsk_99_genome.fa 2>&1 | tee chromosome_1_tsk_99.debug.log

The fasta sequence does not match the REF allele at 1:64:
   REF .vcf: [G]
   ALT .vcf: [G]
   REF .fa : [T]
TCGTCCGCAATTTGCAATTACGGACATATTTCGAACCATATATGTTAACGGGTTATGTCAGTGCCGTACATGGAAAAT

>1
TGCTGTACCTACAGACCTTCTGAGAATTCCATAACTGGGTTAGCAGTCAAGTAGAACTCGCGT T TCGTCCGCAATTTGCAATTACGGACATATTTCGAACCATATA

for ind in $(head sim_sample.list)
do
#echo $ind
#done
bcftools consensus -i -s $ind -f $sim_ref $concat_vcf_gz | less -S 


exit 0

3. Reduce the Number of Threads Used by OpenBLAS

    If increasing the RLIMIT_NPROC limit is not an option, you can reduce the number of threads that OpenBLAS uses. OpenBLAS uses the number of CPU cores by default, but you can control this by setting the OMP_NUM_THREADS or OPENBLAS_NUM_THREADS environment variable:
    bash
    Copy

    export OPENBLAS_NUM_THREADS=4

    This command limits OpenBLAS to using 4 threads. Adjust the number based on your system's capabilities.


