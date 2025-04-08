
********    "sfs for softmasked+gene_regions"   ********
## 2025 new pools
conda activate bcftools
concated_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
cd $concated_vcf_dir

## 3 species
for vcf in `ls -t concated*vcf.gz | head -15 | sort -V`
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


## check the number of space to know if sfs nseq is correct
## search for the string count= in all files within the specified directory
output_SFS_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data
find /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/ -type f -exec grep 'count=' {} +
cd $output_SFS_dir

ls $output_SFS_dir/*.sfs
grep ' ' -o /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data/concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_1x_1500x_noMS.shuf.P_01.equal_self.sfs | wc -l
39

cd $output_SFS_dir

## Rut Cer Meg
for sfs_file in $(ls -t ./*.sfs | head -15 | sort -V)
do
count=$(grep ' ' -o $sfs_file | wc -l)
echo -e "$count\t$sfs_file"
done

## check number of snps
dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/data_2025_downsample/Scripts/stairway_plot/downsample_genome_reads_prepare_plots/
1_downsample_genome_reads_sfs_calculation.sh


# cat sfs for each dataset in one file
#cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
output_SFS_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data
cd $output_SFS_dir
out_cat_sfs_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/2025_pools/templates


## target files
for species in {Cerryb,Meglea,Rutmac}
do
sfs_list=$(ls -t ./*$species*.sfs | head -15 | sort -V)

for sfs in ${sfs_list[@]}
do
echo "concatenating: $sfs"
#head $sfs
cat $sfs >> $out_cat_sfs_dir/$species.1_3_5_7_10x.sfs
done

done


*********************** count numbre of SNPs from VCF files *********************
conda activate bcftools
concated_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
cd $concated_vcf_dir
out_snp_no_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/2025_pools/templates

#for species in {Cerryb,Meglea,Rutmac}
## delete old files
rm $out_snp_no_dir/*_snp_number.DP_1_3_5_7_10x.txt
for depth in {1x,3x,5x,7x,10x}
do
#concated.Cerryb.REF_CerRyb.DP_1x.vcf.gz
#concated.Meglea.REF_MegLea.DP_1x.vcf.gz
#concated.Rutmac.REF_RutMac.DP_1x.vcf.gz
for vcf in `ls -t concated.*$depth*vcf.gz | head -3 | sort -V`
## sort out in specific order
#for vcf in `ls Andmar*P_downsample_reads*x.vcf.gz | sort -V | perl -pe 'm/_(\d+)P_downsample_reads\.(\d+)x/; ($p, $xn) = ($1, $2); $_ = sprintf("%05d_%05d_%s", $xn, $p, $_);' | sort -t '_' -k1,1n -k2,2n | cut -d'_' -f3-`
do
snp_count=$(bcftools query -f "%POS\t" $vcf | wc -l)
echo -e "calculating snp number\t$snp_count\t$vcf"
#echo -e "$snp_count \t snp_no: $vcf" >> $out_snp_no_dir/AndHae_snp_number.P_reads_01_02_03_04_05_06_07_08_09_10.DP_1_3_5_7_10x.txt
echo -e "$snp_count" >> $out_snp_no_dir/Cer_Meg_Rut.snp_number.DP_1_3_5_7_10x.txt
done
done
