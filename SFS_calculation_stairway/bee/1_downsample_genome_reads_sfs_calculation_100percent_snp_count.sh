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

## 2025
## downsample reads
# 01 02 03 04 05 06 07 07 09
for vcf in `ls Andhae.New_REF_AndHae_0_*P_downsample_reads.*x.vcf.gz | sort -V`
# Andhae.New_REF_AndHae_0_9P_downsample_reads.10x.equal_self.sfs

for vcf in `ls Andmar.New_REF_AndMar_0_*P_downsample_reads.*x.vcf.gz | sort -V`

# 100% reads
for vcf in `ls concated.AndHae*noMS.P_10.vcf.gz | sort -V`
# from: concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_1x_1500x_noMS.P_10.equal_self.sfs
# to: Andhae.New_REF_AndHae_0_10P_downsample_reads.1x.equal_self.sfs
for vcf in `ls concated.AndMar*noMS.P_10.vcf.gz | sort -V`
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

## downsample genomes
# linear region selection
for vcf in `ls -t *P_[0-1][0-9].vcf.gz | sort -V`
# issue Mar
for vcf in `ls *Mar*DP_*P_10.issue.vcf.gz | sort -V`

# rerun shuf (random region selection) after deleting them...:)
for vcf in `ls -t *shuf.P_[0-1][0-9].vcf.gz | sort -V`

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
do
count=$(grep ' ' -o $sfs_file | wc -l)
echo -e "$count\t$sfs_file"
done

## check number of snps
dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/data_2025_downsample/Scripts/stairway_plot_steps/downsample_genome_reads_prepare_plots/
1_downsample_genome_reads_sfs_calculation.sh