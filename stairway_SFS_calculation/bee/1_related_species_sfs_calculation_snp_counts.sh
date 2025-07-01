
## Step I: "sfs for softmasked+gene_regions"   ********

## ($3 <= $4/2)
## 2024
conda activate variant_calling_mapping
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
output_SFS_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data

## related species
for species in {AndHae,AndMar,BomPas,BomVet}
do echo $species
#done

## not enough vcf for 10x AndMar
for vcf in `ls -t concated."$species"_{New,New_alt}_REF_*SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz | sort -V`

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

done

## step II: check the number of space to know if sfs nseq is correct

## search for the string count= in all files within the specified directory
output_SFS_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data
#find /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/ -type f -exec grep 'count=' {} +
cd $output_SFS_dir
#for species in {AndHae,AndMar,BomPas,BomVet}
for species in {BomPas,}
do echo $species
#done
    for sfs_file in $(ls ./concated."$species"_{New,New_alt}_REF_*SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.equal_self.sfs)
        do
        #echo $sfs_file
        #done
        count=$(grep ' ' -o $sfs_file | wc -l); echo -e "$count\t$sfs_file"
    done
done

## Step III: cat sfs for each dataset in one file
#cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
output_SFS_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data
cd $output_SFS_dir
out_cat_sfs_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/bee_pools_blueprint/templates

## delete existing files
#ls $out_cat_sfs_dir/concated*.related_species.3_5_7x.sfs
#rm $out_cat_sfs_dir/concated*.related_species.3_5_7x.sfs

for species in {AndHae,AndMar,BomPas,BomVet}
#for species in {AndMar,}
do echo "$species"
#done

sfs_list=$(ls -t ./concated."$species"_{New,New_alt}_REF_*SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.equal_self.sfs | sort -V)

    for sfs in ${sfs_list[@]}
    do
    echo "concatenating: $sfs"
    #head $sfs
    cat $sfs >> $out_cat_sfs_dir/concated."$species"_New_REF_"$species".related_species.3_5_7x.sfs
    echo >> $out_cat_sfs_dir/concated."$species"_New_REF_"$species".related_species.3_5_7x.sfs
    done
done


*********************** count numbre of SNPs from VCF files *********************
conda activate bcftools
concated_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
cd $concated_vcf_dir
out_snp_no_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/bee_pools_blueprint/templates

for species in {AndHae,AndMar,BomPas,BomVet}

#for species in {AndHae,}
#concatenating: ./concated.BomVet_New_REF_BomCon.100kb_g1500x_regions.all_chr.sorted.SNP_softmask_genic_bi_FMT_DP174_1500x_noMS.equal_self.sfs
#concatenating: ./concated.BomVet_New_REF_BomCon.100kb_g1500x_regions.all_chr.sorted.SNP_softmask_genic_bi_FMT_DP290_1500x_noMS.equal_self.sfs
#concatenating: ./concated.BomVet_New_REF_BomCon.100kb_g1500x_regions.all_chr.sorted.SNP_softmask_genic_bi_FMT_DP416_1500x_noMS.equal_self.sfs
#concatenating: ./concated.BomVet_New_REF_BomHor.100kb_g1500x_regions.all_chr.sorted.SNP_softmask_genic_bi_FMT_DP174_1500x_noMS.equal_self.sfs
#concatenating: ./concated.BomVet_New_REF_BomHor.100kb_g1500x_regions.all_chr.sorted.SNP_softmask_genic_bi_FMT_DP290_1500x_noMS.equal_self.sfs
#concatenating: ./concated.BomVet_New_REF_BomHor.100kb_g1500x_regions.all_chr.sorted.SNP_softmask_genic_bi_FMT_DP416_1500x_noMS.equal_self.sfs

do
    #for vcf in `ls And*P_downsample_reads*10x.vcf.gz | sort -V` # test with 10x
    #for vcf in `ls Andhae*P_downsample_reads*x.vcf.gz | sort -V | perl -pe 'm/_(\d+)P_downsample_reads\.(\d+)x/; ($p, $xn) = ($1, $2); $_ = sprintf("%05d_%05d_%s", $xn, $p, $_);' | sort -t '_' -k1,1n -k2,2n | cut -d'_' -f3-`
    for vcf in `ls concated."$species"_{New,New_alt}_REF_*SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz | sort -V | perl -pe 'm/_(\d+)P_downsample_reads\.(\d+)x/; ($p, $xn) = ($1, $2); $_ = sprintf("%05d_%05d_%s", $xn, $p, $_);' | sort -t '_' -k1,1n -k2,2n | cut -d'_' -f3-`
    
    do
    snp_count=$(bcftools query -f "%POS\t" $vcf | wc -l)
    echo -e "calculating snp number\t$snp_count\t$vcf"
    echo -e "$snp_count" >> $out_snp_no_dir/"$species"_snp_number.related_species.3_5_7x.txt
    done
done

## add comma in excel


*************************** number of called sites **********************
#here: 
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/4_6_concate_vcf_filtering_genome_fraction_depth_pgzip_gzip_decompress/
4-6_vcftools_concat_fb_vcf_related_species.filtering.genome_fraction_depth.pgzip_gzip_decompress.sh