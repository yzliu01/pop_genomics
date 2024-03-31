
dro_mel_pop_list_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/easy_SFS_stairway_plot/dro_mel_pop
cd $dro_mel_pop_list_dir

awk 'BEGIN{OFS=FS="\t"}{$1=$1; $2="BP_CS"}1' BP_CS.list
awk 'BEGIN{OFS=FS="\t"}{print $1=$1, $2="BP_CS"}' BP_CS.list
ls *pop.list
# BP_CS.pop.list  SB_RP.pop.list  SB_SE.pop.list  SPD.pop.list

## activate bioproject env to use python for easrSFS
dro_mel_pop_list_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/easy_SFS_stairway_plot/dro_mel_pop
cd $dro_mel_pop_list_dir

conda activate bioproject
easySFS=/home/yzliu/bin/easySFS/easySFS.py
dro_mel_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_gatk_vcf/DB_VCF
dro_mel_vcf=$dro_mel_vcf_dir/concated_dro_mel_all_chr.sorted_chr.SNP_hard_filtered_bi_MQ20_FMT_DP3_MSG03.vcf.gz
## New REF
dro_mel_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_gatk_vcf/conc_vcf
dro_mel_vcf=concated_dro_mel_all_chr.sorted_chr.SNP_hard_filter.MQ40_masked_bi_AC1_FMT_DP3_noMS.vcf.gz

output_sfs_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_gatk_vcf/easy_SFS
pop_assignments=$output_sfs_dir/all_4_dro_mel.pop.list

for rep in {1..5};do
    #for vcf in `find -print | grep "10000Ne" | grep "20hapS" | grep "15Mb" | grep "high_mu" | grep "$rep.gen.vcf.final_ld05.pruned.vcf$"`;do
    ## figure out error of converting genotype
    for vcf in `find -print | grep "10000Ne" | grep "20hapS" | grep "15Mb" | grep "$rep.gen.modification.new.vcf.final_ld05.pruned.vcf$"`;do
        #vcf_dir=`ls $vcf`
        echo $vcf
        ## replace file name to get output directory name
        out_dir=`echo $vcf | cut -d "/" -f 1,2`
        echo $out_dir
        $easySFS -i $vcf -p $pop20 -a -f --proj 20 -o $out_dir --prefix $out_dir"_1_"$rep
    done
done


## run this command in terminal
$easySFS -i $dro_mel_vcf -p $pop_assignments -a -f --proj 17,17,17,17 -o $output_sfs_dir --prefix dro_mel_4_pop_SFS
## Processing 4 populations - ['BP_CS', 'SB_RP', 'SB_SE', 'SPD']
## subset vcf for each group
for vcf_group in `ls $dro_mel_vcf_dir/concated*list.vcf.gz`;do
    $easySFS -i $vcf_group -p $pop_assignments -a -f --proj 17 -o $out_put_sfs_dir --prefix dro_mel_4_pop_SFS;
done

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_gatk_vcf/conc_vcf
sample_pop=("BP_CS.pop.list" "SB_RP.pop.list" "SB_SE.pop.list" "SPD.pop.list")
## run a preview to identify the values for projecting down each population
for vcf_group in `ls $dro_mel_vcf_dir/concated*list.vcf.gz`
do
    sample_pop=("BP_CS.pop.list" "SB_RP.pop.list" "SB_SE.pop.list" "SPD.pop.list")
    #echo $sample_pop
    $easySFS -i $vcf_group -p $dro_mel_pop_list_dir/$sample_pop --preview
done
## do the conversion specifying the projection values
## Samples in pops file not present in VCF: 
for vcf_group in `ls $dro_mel_vcf_dir/concated*list.vcf.gz`
do
    sample_pop=("BP_CS.pop.list" "SB_RP.pop.list" "SB_SE.pop.list" "SPD.pop.list")
    $easySFS -i $vcf_group -p ${sample_pop[*]} -a -f --proj 17 -o $output_sfs_dir --prefix dro_mel_subset.$sample_pop
done

$easySFS -i $dro_mel_vcf_dir/concated_dro_mel_all_chr.sorted_chr.SNP_hard_filter.MQ40_masked_bi_AC1_FMT_DP3_noMS.BP_CS.list.vcf.gz -p $dro_mel_pop_list_dir/BP_CS.pop.list --preview -a
$easySFS -i $dro_mel_vcf_dir/concated_dro_mel_all_chr.sorted_chr.SNP_hard_filter.MQ40_masked_bi_AC1_FMT_DP3_noMS.SB_RP.list.vcf.gz -p $dro_mel_pop_list_dir/SB_RP.pop.list --preview -a
$easySFS -i $dro_mel_vcf_dir/concated_dro_mel_all_chr.sorted_chr.SNP_hard_filter.MQ40_masked_bi_AC1_FMT_DP3_noMS.SB_SE.list.vcf.gz -p $dro_mel_pop_list_dir/SB_SE.pop.list --preview -a
$easySFS -i $dro_mel_vcf_dir/concated_dro_mel_all_chr.sorted_chr.SNP_hard_filter.MQ40_masked_bi_AC1_FMT_DP3_noMS.SPD.list.vcf.gz -p $dro_mel_pop_list_dir/SPD.pop.list --preview -a

$easySFS -i $dro_mel_vcf_dir/concated_dro_mel_all_chr.sorted_chr.SNP_hard_filter.MQ40_masked_bi_AC1_FMT_DP3_noMS.BP_CS.list.vcf.gz -p $dro_mel_pop_list_dir/BP_CS.pop.list -a -f --proj 34,264202 -o $output_sfs_dir --prefix dro_mel_subset_BP_CS
$easySFS -i $dro_mel_vcf_dir/concated_dro_mel_all_chr.sorted_chr.SNP_hard_filter.MQ40_masked_bi_AC1_FMT_DP3_noMS.SB_RP.list.vcf.gz -p $dro_mel_pop_list_dir/SB_RP.pop.list -a -f --proj 34,227922 -o $output_sfs_dir --prefix dro_mel_subset_SB_RP
$easySFS -i $dro_mel_vcf_dir/concated_dro_mel_all_chr.sorted_chr.SNP_hard_filter.MQ40_masked_bi_AC1_FMT_DP3_noMS.SB_SE.list.vcf.gz -p $dro_mel_pop_list_dir/SB_SE.pop.list -a -f --proj 34,231337 -o $output_sfs_dir --prefix dro_mel_subset_SB_SE
$easySFS -i $dro_mel_vcf_dir/concated_dro_mel_all_chr.sorted_chr.SNP_hard_filter.MQ40_masked_bi_AC1_FMT_DP3_noMS.SPD.list.vcf.gz -p $dro_mel_pop_list_dir/SPD.pop.list -a -f --proj 34,228151 -o $output_sfs_dir --prefix dro_mel_subset_SPD

## comparison
## self script
cat /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data/concated_dro_mel_all_chr.sorted_chr.SNP_hard_filter.MQ40_masked_bi_AC1_FMT_DP3_noMS.BP_CS.equal_self.sfs
12403 19389 37146 23540 22513 18487 15998 14751 13835 12670 12233 11633 11843 11284 11022 11685 10414 5759 

## easySFS.py
cat /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_gatk_vcf/easy_SFS/fastsimcoal2/dro_mel_subset_BP_CS_MSFS.obs
1 observations. No. of demes and sample sizes are on next line.
1	34
12403 19389 37146 23540 22513 18487 15998 14751 13835 12670 12233 11633 11843 11284 11022 11685 10414 5759 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0



cd ./easy_SFS_stairway_plot/dro_mel_pop/test_SFS
$easySFS -i $dro_mel_vcf_dir/concated_dro_mel_all_chr.sorted_chr.SNP_hard_filtered_bi_MQ20_FMT_DP3_MSG0.BP_CS.list.vcf.gz -p ../BP_CS.pop.list --proj 17 -o .

## New REF
$easySFS -i $dro_mel_vcf_dir/$dro_mel_vcf -p SPD.pop.list -a -f --proj 17 -o $output_sfs_dir --prefix dro_mel_New_REF_SPD_pop_SFS

sample_pop=("BP_CS.pop.list" "SB_RP.pop.list" "SB_SE.pop.list" "SPD.pop.list")
concated_dro_mel_all_chr.sorted_chr.SNP_hard_filter.MQ40_masked_bi_AC1_FMT_DP3_noMS.vcf.gz
sample_pop=("BP_CS.pop.list" "SB_RP.pop.list" "SB_SE.pop.list" "SPD.pop.list")
for sample in `echo ${sample_pop[*]}`
do
#    echo $sample
#done
    $easySFS -i $dro_mel_vcf_dir/$dro_mel_vcf -p $sample -a -f --proj 17 -o $output_sfs_dir --prefix dro_mel_New_REF_$sample
done


## bees
conda activate bioproject
easySFS=/home/yzliu/bin/easySFS/easySFS.py
bee_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
BomPas_REF_BomPas_vcf=concated.fb_per_contig_BomPas_REF_BomPas.g600_regions.bi_MQ20_DP270.vcf.gz
output_sfs_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/easy_SFS
$easySFS -i $bee_vcf_dir/$BomPas_REF_BomPas_vcf -a -f --proj 68 -o $output_sfs_dir --prefix BomPas_REF_BomPas_SFS

## thin vcf variants using vcftools
conda activate variant_calling_mapping

vcftools 
rename deo_mel dro_mel /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_gatk_vcf/DB_VCF/*d
eo_mel*
# compress with bgzip not gzip, GATK cannot recognize correctly otherwise
time vcftools --gzvcf $dro_mel_vcf --exclude-positions heterozygous_site_male.cut.list --recode --recode-INFO-all --stdout | bgzip -c > gatk_female_52mon_66lap_B_syl.remove_het_sites_found_in_male_for_female_mon_lap_207_B_syl.vcf.gz
time vcftools --gzvcf $dro_mel_vcf --thin 10 --recode --recode-INFO-all --stdout | bgzip -c > $dro_mel_vcf_dir/concated_dro_mel_all_chr.sorted_chr.SNP_hard_filtered_bi_MQ20_FMT_DP3_MSG03.thin_10.vcf.gz

After filtering, kept 68 out of 68 Individuals
Outputting VCF file...
After filtering, kept 1439474 out of a possible 1919861 Sites
Run Time = 306.00 seconds
