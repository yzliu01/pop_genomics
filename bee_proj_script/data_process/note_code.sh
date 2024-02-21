conda activate variant_calling_mapping
for bam in `ls -t *.bam | head -4`;do time samtools index $bam;done
for bam in `ls -t *.bam | awk 'FNR > 2 && FNR < 6 {print $0}'`;do time samtools index $bam;done


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

## create map file
MAP_FILE_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics
sed '1d' $MAP_FILE_DIR/2_mapping_genome/dro_mel_readGroup.list | awk -F "\t"  '{print $4,""$1".sort.marked_dups.g.vcf.gz"}' OFS="\t" > $VCF_DIR/sample_name_map_dro_mel.txt


## vcf index
A USER ERROR has occurred: Failed to create reader from file:///faststorage/project/eDNA/yzliu/DK_proj/data/dro_mel_gatk_vcf/gVCF/SRR24680727.sort.marked_dups.g.vcf.gz because of the following error:
	An index is required, but none found with file ending .idx, for input source: file:///faststorage/project/eDNA/yzliu/DK_proj/data/dro_mel_gatk_vcf/gVCF/SRR24680727.sort.marked_dups.g.vcf.gz


## submit jobs
for bom_sh in `ls /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/
bee_proj_script/data_process/*REF_Bom*.sh`;do sbatch $bom_sh;done

Submitted batch job 32815643
Submitted batch job 32815644
Submitted batch job 32815645
Submitted batch job 32815646
Submitted batch job 32815647
Submitted batch job 32815648

for i in `seq 32815375 32815380`;do scancel $i;done

❯ sbatch /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/3_fb_variant_calling_4_bee_pools.AndHae_REF_AndHatt.array_per_contig.10kb_g600.sh
Submitted batch job 32816268

yzliu in 🌐 fe-open-02 in DK_proj/data/job_submission on  main [?] 
❯ sbatch /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/3_fb_variant_calling_4_bee_pools.AndMar_REF_AndHatt.array_per_contig.10kb_g600.sh
Submitted batch job 32816287

samtools view -h Bompas.REF_BomHypn.sort.bam | less -S


freebayes-parallel $contig_region 12 --fasta-reference $REF \
    --ploidy 68 --pooled-discrete --genotype-qualities --use-best-n-alleles 4 \
    --bam $BAM_DIR/$SAMPLE -g 600 --strict-vcf --gvcf | \
    vcffilter -f "QUAL > 20" > $VCF_OUT_DIR/fb_per_contig_BomPas_REF_BomHyp/"$BAM2VCF_NAME"_"$contig_name".qual_20.g.vcf


## for number of threads, it must be specified, otherwise you get error as below
Bareword found where operator expected at (eval 14) line 1, near "--fasta"
	(Missing operator before fasta?)
Please specify a fasta reference file.
