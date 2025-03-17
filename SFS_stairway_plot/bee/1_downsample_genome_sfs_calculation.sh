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

## 2025
for vcf in `ls -t *vcf.gz | head -12 | sort`
for vcf in `ls -t concated.Rutmac*_1500x_noMS.vcf.gz | sort`

## downsample genomes
for vcf in `ls -t *P_[0-1][0-9].vcf.gz | sort -V`
# issue Mar
for vcf in `ls *Mar*DP_*P_10.issue.vcf.gz | sort -V`

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
