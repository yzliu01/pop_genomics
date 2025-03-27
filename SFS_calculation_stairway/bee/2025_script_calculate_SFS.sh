
********    "sfs for softmasked+gene_regions"   ********
## New REF ($3 <= $4/2)
## 2025
conda activate variant_calling_mapping
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
output_SFS_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data

#cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/snpEff_annotation

for vcf in `ls -t *AndMar_New_REF_AndMar*all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT*vcf.gz`
for vcf in `ls -t *BomPas_New_REF_BomHyp*all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT*vcf.gz`
for vcf in `ls -t *noMS.vcf.gz | head -12 | sort`
for vcf in `ls -t *BomVet_New_REF_BomVet*SNP_softmask_genic_bi_FMT*vcf.gz | sort`

## downsample
for vcf in `ls -t *vcf.gz | head -24 | sort`

## 2025 new pools
for vcf in `ls -t *vcf.gz | head -12 | sort`
for vcf in `ls -t concated.Rutmac*_1500x_noMS.vcf.gz | sort`

## 3 species
for vcf in `ls -t *concated*vcf.gz | head -15`

## downsample genomes
#for vcf in `ls -t *P_[0-1][0-9].vcf.gz | sort -V`

    do
    output_sfs_name=${vcf/vcf.gz/equal_self}
    bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' $vcf | \
        awk '{if ($3 <= $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c | \
        awk '$1=$1'| cut -d ' ' -f 1 | tr '\n' ' ' > $output_SFS_dir/$output_sfs_name.sfs
        ## $1=$1 is an assignment operation in awk. 
        ## It reassigns the first field ($1) to itself, which forces awk to rebuild the current line using the default output field separator (a single space).

        ## print the sfs in terminal
        echo -e $output_sfs_name.sfs"\n"
        cat $output_SFS_dir/$output_sfs_name.sfs
        echo -e "\n"
done


## check the number of nseq by counting space
ls $output_SFS_dir/*shuf*.sfs

less /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data/concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_1x_1500x_noMS.shuf.P_01.equal_self.sfs | grep -o " " | wc -l
39
grep ' ' -o /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data/concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_1x_1500x_noMS.shuf.P_01.equal_self.sfs | wc -l
39

cd $output_SFS_dir
for sfs_file in $(ls ./*shuf*.sfs)
## Rut Cer Meg
for sfs_file in $(ls -t ./*.sfs | head -15 | sort -V)
do
count=$(grep ' ' -o $sfs_file | wc -l)
echo -e "$count\t$sfs_file"
done

## check number of snps
dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/data_2025_downsample/Scripts/stairway_plot/downsample_genome_reads_prepare_plots/
1_downsample_genome_reads_sfs_calculation.sh



## simulated reads
## add AC and AN tags
sim_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/simulated_reference_genomes
bcftools +fill-tags hap_100_chr_1_10.vcf.gz -t AC,AN -Oz -o hap_100_chr_1_10.AC_AN_tags.vcf.gz
bcftools view hap_100_chr_1_10.vcf.gz -S sim_sample.list -Oz -o hap_100_chr_1_10.AC_AN_tags.vcf.gz
## get biallelic SNPs
bcftools view -m2 -M2 hap_100_chr_1_10.vcf.gz -S sim_sample.list | bcftools filter -e 'AC==0 || AC == AN' | bcftools view -Oz -o hap_100_chr_1_10.bi_SNPs.AC_AN_tags.vcf.gz

less hap_100_chr_1_10.bi_SNPs.AC_AN_tags.vcf.gz | wc -l
2084577

sample=$(cat sim_sample.list | tr "\n" ",")
bcftools view hap_100_chr_1_10.vcf.gz -s tsk_0,tsk_1,tsk_2,tsk_3,tsk_4,tsk_5,tsk_6,tsk_7,tsk_8,tsk_9,tsk_10,tsk_11,tsk_12,tsk_13,tsk_14,tsk_15,tsk_16,tsk_17,tsk_18,tsk_19,tsk_20,tsk_21,tsk_22,tsk_23,tsk_24,tsk_25,tsk_26,tsk_27,tsk_28,tsk_29,tsk_30,tsk_31,tsk_32,tsk_33,tsk_34,tsk_35,tsk_36,tsk_37,tsk_38,tsk_39,tsk_40,tsk_41,tsk_42,tsk_43,tsk_44,tsk_45,tsk_46,tsk_47,tsk_48,tsk_49,tsk_50,tsk_51,tsk_52,tsk_53,tsk_54,tsk_55,tsk_56,tsk_57,tsk_58,tsk_59,tsk_60,tsk_61,tsk_62,tsk_63,tsk_64,tsk_65,tsk_66,tsk_67,tsk_68,tsk_69,tsk_70,tsk_71,tsk_72,tsk_73,tsk_74,tsk_75,tsk_76,tsk_77,tsk_78,tsk_79,tsk_80,tsk_81,tsk_82,tsk_83,tsk_84,tsk_85,tsk_86,tsk_87,tsk_88,tsk_89,tsk_90,tsk_91,tsk_92,tsk_93,tsk_94,tsk_95,tsk_96,tsk_97,tsk_98,tsk_99 \
| less -S
bcftools view hap_100_chr_1_10.vcf.gz -s tsk_0,tsk_1 -Oz -o hap_100_chr_1_10.AC_AN_tags.vcf.gz

bcftools query -f '%CHROM\t%POS\t%AC\t%AN' hap_100_chr_1_10.AC_AN_tags.vcf.gz | less -S

# 1       7328791 14147   G       C,A     .       PASS    AC=0,1;AN=100   GT 

for vcf in `ls hap_100_chr_1_10.bi_SNPs.AC_AN_tags.vcf.gz`

    do
    output_sfs_name=${vcf/vcf.gz/equal_self}
    bcftools query -f '%CHROM\t%POS\t%AC\t%AN' $vcf | \
        awk '{if ($3 <= $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c | \
        awk '$1=$1'| cut -d ' ' -f 1 | tr '\n' ' ' > ./sfs/$output_sfs_name.sfs
        ## $1=$1 is an assignment operation in awk. 
        ## It reassigns the first field ($1) to itself, which forces awk to rebuild the current line using the default output field separator (a single space).
        
        ## print the sfs in terminal
        echo -e $output_sfs_name.sfs"\n"
        cat ./sfs/$output_sfs_name.sfs
        echo -e "\n"
done
