



## concat vcf I
## save vcf file per region into a file
species_dir=(
            "fb_per_contig_AndMar_REF_AndHatt"
            "fb_per_contig_AndHae_REF_AndHatt" "fb_per_contig_AndMar_REF_BomPas" "fb_per_contig_BomVet_REF_ApisMel"
            "fb_per_contig_AndHae_REF_BomPas" "fb_per_contig_BomPas_REF_ApisMel" "fb_per_contig_BomVet_REF_BomHyp"
            "fb_per_contig_AndMar_REF_AndHae" "fb_per_contig_BomPas_REF_BomHyp"

)

fun_concat_vcf_I(){
for vcf in ${species_dir[*]}
    do
    ## rename concat files
    concat_vcf1=${vcf/fb_per_contig_/}
    concat_vcf2=${concat_vcf1/_REF/_New_REF}
    ls ./$vcf/*100kb_1500x_regions*vcf | sort -V > ./$concat_vcf2.individual_100kb_1500x_region_vcf_file.list
done
}

## execute function
#fun_concat_vcf_I

## concat vcf II
## for all
conda activate variant_calling_mapping
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf
#ls *individual_100kb_1500x*.list
vcf_list=(
   #"AndHae_New_REF_AndHae.individual_100kb_1500x_region_vcf_file.list"
   "AndHae_New_REF_AndHat.individual_100kb_1500x_region_vcf_file.list"
   "AndHae_New_REF_BomPas.individual_100kb_1500x_region_vcf_file.list"
   "AndMar_New_REF_AndHae.individual_100kb_1500x_region_vcf_file.list"
   "AndMar_New_REF_AndHat.individual_100kb_1500x_region_vcf_file.list"
   #"AndMar_New_REF_AndMar.individual_100kb_1500x_region_vcf_file.list"
   "AndMar_New_REF_BomPas.individual_100kb_1500x_region_vcf_file.list"
   "BomPas_New_REF_ApisMel.individual_100kb_1500x_region_vcf_file.list"
   
   ***"BomPas_New_REF_BomHyp.individual_100kb_1500x_region_vcf_file.list"

   #"BomPas_New_REF_BomPas.individual_100kb_1500x_region_vcf_file.list"
   "BomVet_New_REF_ApisMel.individual_100kb_1500x_region_vcf_file.list"
   "BomVet_New_REF_BomHyp.individual_100kb_1500x_region_vcf_file.list"
   #"BomVet_New_REF_BomPas.individual_100kb_1500x_region_vcf_file.list"
)

fun_concat_vcf_II(){
for species_vcf in  ${vcf_list[*]}
    do
    concat_vcf=${species_vcf/.individual_100kb_1500x_region_vcf_file.list/.100kb_1500x_regions}
    vcf-concat --files $species_vcf | bgzip -c > ./concated_vcf_each_species_REF/concated.$concat_vcf.vcf.gz
done
}
## execute function
#fun_concat_vcf_II


## rename concatenated vcf file
rename_vcf(){
    rename .100kb 100kb *100kb_1500x_region.list.vcf.gz
    rename region.list regions *100kb_1500x_region.list.vcf.gz
    rename 1500x g1500x *100kb_1500x_regions.vcf.gz

}
rename_vcf

## issued vcf
## reorder the chromosome order
#conda activate gatk_4.3.0.0
## already in the PATH
export PATH="/home/yzliu/bin/gatk_4.3.0.0/gatk-4.3.0.0/:$PATH"

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
## New_REF
gatk_sort_vcf(){
for vcf in `ls -t concated*.100kb_g1500x_regions.vcf.gz | head -9`
    do 
    vcf_sorted_chr=${vcf/.vcf.gz/}
    gatk SortVcf --INPUT $vcf --OUTPUT $vcf_sorted_chr.all_chr.sorted.vcf.gz
done
}

## execute function
gatk_sort_vcf

## issue
## https://github.com/samtools/bcftools/issues/420
## [E::vcf_parse_format_fill5] Invalid character '.' in 'GQ' FORMAT field at 1:4484
## example of one sample
#sed -i 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' \
#    concated.Andhae.New_REF_AndHae.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf

## replace "Integer" with "Float" using for loop
for vcf in `ls *all_chr.sorted.vcf.gz`
for vcf in `ls *AndMar_New_REF_AndMar*all_chr.sorted.vcf.gz`

modify_vcf_GQ_issue(){
for vcf in `ls -t *all_chr.sorted.vcf.gz | head -8`
    do
    output_vcf=${vcf/sorted.vcf.gz/sorted.GQ_issue_solved.vcf}
    ## pigz is faster than gzip
    ## https://www.baeldung.com/linux/gzip-and-gunzip
    pigz -d -k -c $vcf > $output_vcf
    sed -i 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' $output_vcf
    ## -f: Force overwrite, compress .gz, links, and to terminal
    pigz -f $output_vcf > $output_vcf.gz
done
}

## execute function
modify_vcf_GQ_issue

