
********    "sfs for softmasked+gene_regions"   ********
## New REF ($3 <= $4/2)
## 2025
conda activate variant_calling_mapping
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
output_SFS_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data

## downsample genomes
for vcf in `ls -t *P_[0-1][0-9].vcf.gz | sort -V`

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

# cat sfs for each dataset in one file
#cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
output_SFS_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data
cd $output_SFS_dir
out_cat_sfs_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/pool_downsample_genome/templates
#ls -t concated.AndHae*P_[0-1][0-9].vcf.gz | sort -V | head
sfs_list=$(ls -t concated.AndHae*P_[0-1][0-9].equal_self.sfs | sort -V)

rm $out_sfs_dir/concated.AndHae_New_REF_AndHae.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs
for sfs in ${sfs_list[@]}
do
echo "concatenating: $sfs"
#head $sfs
cat $sfs >> $out_sfs_dir/concated.AndHae_New_REF_AndHae.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs
done


