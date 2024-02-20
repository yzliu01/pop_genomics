

for i in `ls /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/*REF_And*`;
    do sbatch $i;
done

Submitted batch job 32731046
Submitted batch job 32731047
Submitted batch job 32731048
Submitted batch job 32731049

## count the number of row
awk 'END{print NR}' /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_freebayes_vcf/empiri
cal_dro_mel_68samples.fb_qual20_dp1000.g.vcf

## gatk haplotypecaller
A USER ERROR has occurred: Fasta dict file file:///home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/D_melanogaster.7509v1.md_chr.dict for reference file:///home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/D_melanogaster.7509v1.md_chr.fa does not exist. Please see http://gatkforums.broadinstitute.org/discussion/1601/how-can-i-prepare-a-fasta-file-to-use-as-reference for help creating it.A USER ERROR has occurred: Fasta dict file file:///home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/D_melanogaster.7509v1.md_chr.dict for reference file:///home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/D_melanogaster.7509v1.md_chr.fa does not exist. Please see http://gatkforums.broadinstitute.org/discussion/1601/how-can-i-prepare-a-fasta-file-to-use-as-reference for help creating it.

## change order of columns
REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/2_mapping_genome
sed '1d' $REF/dro_mel_readGroup.list | awk -F "\t"  '{print $4,$1}' OFS="\t" | head

SB_SE_01        SRR24680725
SB_SE_02        SRR24680726

