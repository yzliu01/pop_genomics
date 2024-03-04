
dro_mel_pop_list_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/easy_SFS/dro_mel_pop
cd $dro_mel_pop_list_dir

awk 'BEGIN{OFS=FS="\t"}{$1=$1; $2="BP_CS"}1' BP_CS.list
awk 'BEGIN{OFS=FS="\t"}{print $1=$1, $2="BP_CS"}' BP_CS.list
ls *pop.list
# BP_CS.pop.list  SB_RP.pop.list  SB_SE.pop.list  SPD.pop.list

## activate bioproject env to use python for easrSFS
conda activate bioproject
easySFS=/home/yzliu/bin/easySFS/easySFS.py
dro_mel_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_gatk_vcf/DB_VCF
dro_mel_vcf=$dro_mel_vcf_dir/concated_dro_mel_all_chr.sorted_chr.SNP_hard_filtered_bi_MQ20_FMT_DP3_MSG03.vcf.gz
pop_assignments=all_4_dro_mel.pop.list
out_put_sfs_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_gatk_vcf/easy_SFS

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
$easySFS -i $dro_mel_vcf -p $pop_assignments -a -f --proj 17,16,17,17 -o $out_put_sfs_dir --prefix dro_mel_4_pop_SFS
## Processing 4 populations - ['BP_CS', 'SB_RP', 'SB_SE', 'SPD']


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
