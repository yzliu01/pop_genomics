######## problem solving: delete lines contain a pattern except for the first line #########
## https://stackoverflow.com/questions/16126479/how-to-conditionally-remove-first-line-only-with-sed-when-it-matches
"AB"
"CD"
"E"
"AB"
"F"
"AB"
## 
sed '1!{/AB/d}' /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/test_delete.txt

vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/fb_per_contig_BomPas_REF_BomPas
vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/fb_per_contig_BomVet_REF_BomPas
issued_vcf=$vcf_dir/Bompas.REF_BomPas.g600_10kb_fb.10kbp.regions.48.fb.qual_20.g.copy.vcf------------
ok_vcf=Bompas.REF_BomPas.g600_10kb_fb.10kbp.regions.48.fb.qual_20.g.OK.vcf
## check files that have multiple "##fileformat=VCFv4.2"
grep fileformat /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/fb_per_contig_BomPas_REF_BomHyp/*g600_10kb_fb.10kbp.regions*
grep fileformat /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/fb_per_contig_BomVet_REF_BomHyp/*g600_10kb_fb.10kbp.regions*
## 1500
grep fileformat /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/fb_per_contig_BomVet_REF_BomHyp/*g1500x_10kb_fb.10kbp.regions*

sed '1!{/##fileformat=VCFv4.2/d}' $issued_vcf > $vcf_dir/$ok_vcf

sed -i '1!{/##fileformat=VCFv4.2/d}' $issued_vcf

## fb_per_contig_BomPas_REF_BomHyp
vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/fb_per_contig_BomPas_REF_BomHyp
issued_vcf=$vcf_dir/*g600_10kb_fb.10kbp.regions*.vcf
for vcf in ${issued_vcf[*]}
    do
    sed -i '1!{/##fileformat=VCFv4.2/d}' $vcf
done

issued_vcf=./*g1500x_10kb_fb.10kbp.regions*.g.vcf

## Another issue
grep -E '^#|GT:GQ:DP:AD:RO:QR:AO:QA' Bompas.REF_BomHypn.g600_10kb_fb.10kbp.regions.084.fb.qual_20.g.vcf| less -S
grep -E '^#|GT:GQ:DP:AD:RO:QR:AO:QA' Bompas.REF_BomHypn.g600_10kb_fb.10kbp.regions.084.fb.qual_20.g.vcf > \
    Bompas.REF_BomHypn.g600_10kb_fb.10kbp.regions.084.fb.qual_20.md.g.vcf| bgzip -c >
## check lines without these
grep -E -v '^#|GT:GQ:DP:AD:RO:QR:AO:QA' Bomvet.REF_BomPas.g600_10kb_fb.10kbp.regions.*.fb.qual_20.g.vcf

less concated.fb_per_contig_BomPas_REF_BomHyp.g600_regions.vcf.list.vcf.gz | grep -E '^#|GT:GQ:DP:AD:RO:QR:AO:QA' | bgzip -c > \
    concated.fb_per_contig_BomPas_REF_BomHyp.g600_regions.vcf.list.md.vcf.gz
## GQ issue
grep -E -v '^#|GT:GQ:DP:AD:RO:QR:AO:QA' Bompas.REF_BomPas.g1500x_10kb_fb.10kbp.regions.*.fb.qual_20.g.vcf
grep -E -v '^#|GT:GQ:DP:AD:RO:QR:AO:QA' Bomvet.REF_BomPas.g1500x_10kb_fb.10kbp.regions.*.fb.qual_20.g.vcf
****************************************************************************************


## https://cyverse.atlassian.net/wiki/spaces/DEapps/pages/259063974/vcftools-merge+0.1.16
## https://vcftools.sourceforge.net/perl_module.html

conda activate variant_calling_mapping
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/fb_per_region_AndHae_New_REF_AndHae
vcf-concat -h

## suggestion from Jeppe
## concatenate (having duplicates?)
vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/
cd $vcf_dir
#ls ./fb_per_region_BomPas_New_REF_BomPas/Bompas.New_REF_BomPas.100kb_1500x_region_*[0-9].g.vcf | sort -V > BomPas_New_REF_BomPas.individual_100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_BomVet_New_REF_BomPas/Bomvet.New_REF_BomPas.100kb_1500x_region_*.g.vcf | sort -V > BomVet_New_REF_BomPas.individual_100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_AndHae_New_REF_AndHae/Andhae.New_REF_AndHae.100kb_1500x_region_*.g.vcf | sort -V > AndHae_New_REF_AndHae.individual_100kb_1500x_region_vcf_file.list
ls ./fb_per_region_AndMar_New_REF_AndHae/Andmar.New_REF_AndHae.100kb_1500x_region_*.g.vcf | sort -V > AndMar_New_REF_AndHae.individual_100kb_1500x_region_vcf_file.list
ls ./fb_per_region_BomPas_New_REF_BomHyp/Bompas.New_REF_BomHyp.100kb_1500x_region_*[0-9].g.vcf | sort -V > BomPas_New_REF_BomHyp.individual_100kb_1500x_region_vcf_file.list
ls ./fb_per_region_BomVet_New_REF_BomHyp/Bomvet.New_REF_BomHyp.100kb_1500x_region_*.g.vcf | sort -V > BomVet_New_REF_BomHyp.individual_100kb_1500x_region_vcf_file.list
ls ./fb_per_region_AndHae_New_REF_AndHat/Andhae.New_REF_AndHat.100kb_1500x_region_*.g.vcf | sort -V > AndHae_New_REF_AndHat.individual_100kb_1500x_region_vcf_file.list
ls ./fb_per_region_AndMar_New_REF_AndHat/Andmar.New_REF_AndHat.100kb_1500x_region_*.g.vcf | sort -V > AndMar_New_REF_AndHat.individual_100kb_1500x_region_vcf_file.list
ls ./fb_per_region_BomPas_New_REF_ApisMel/Bompas.New_REF_ApisMel.100kb_1500x_region_*[0-9].g.vcf | sort -V > BomPas_New_REF_ApisMel.individual_100kb_1500x_region_vcf_file.list
ls ./fb_per_region_BomVet_New_REF_ApisMel/Bomvet.New_REF_ApisMel.100kb_1500x_region_*.g.vcf | sort -V > BomVet_New_REF_ApisMel.individual_100kb_1500x_region_vcf_file.list
ls ./fb_per_region_AndHae_New_REF_BomPas/Andhae.New_REF_BomPas.100kb_1500x_region_*.g.vcf | sort -V > AndHae_New_REF_BomPas.individual_100kb_1500x_region_vcf_file.list
ls ./fb_per_region_AndMar_New_REF_BomPas/Andmar.New_REF_BomPas.100kb_1500x_region_*.g.vcf | sort -V > AndMar_New_REF_BomPas.individual_100kb_1500x_region_vcf_file.list

ls ./fb_per_region_AndMar_New_REF_AndTri/Andmar.New_REF_AndTri.100kb_1500x_region_*.g.vcf | sort -V > AndMar_New_REF_AndTri.individual_100kb_1500x_region_vcf_file.list
ls ./fb_per_region_AndHae_New_REF_AndFul/Andhae.New_REF_AndFul.100kb_1500x_region_*.g.vcf | sort -V > AndHae_New_REF_AndFul.individual_100kb_1500x_region_vcf_file.list
ls ./fb_per_region_BomPas_New_REF_BomCon/Bompas.New_REF_BomCon.100kb_1500x_region_*.g.vcf | sort -V > BomPas_New_REF_BomCon.individual_100kb_1500x_region_vcf_file.list
ls ./fb_per_region_BomVet_New_REF_BomCon/Bomvet.New_REF_BomCon.100kb_1500x_region_*.g.vcf | sort -V > BomVet_New_REF_BomCon.individual_100kb_1500x_region_vcf_file.list
ls ./fb_per_region_BomPas_New_REF_BomHor/Bompas.New_REF_BomHor.100kb_1500x_region_*.g.vcf | sort -V > BomPas_New_REF_BomHor.individual_100kb_1500x_region_vcf_file.list
ls ./fb_per_region_BomVet_New_REF_BomHor/Bomvet.New_REF_BomHor.100kb_1500x_region_*.g.vcf | sort -V > BomVet_New_REF_BomHor.individual_100kb_1500x_region_vcf_file.list

#ls ./fb_per_region_AndMar_New_REF_AndMar/Andmar.New_REF_AndMar.100kb_1500x_region_*.g.vcf | sort -V > AndMar_New_REF_AndMar.individual_100kb_1500x_region_vcf_file.list

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf
mv Andmar*g.vcf ./fb_per_region_AndMar_New_REF_AndMar

vcf_list1=BomPas_New_REF_BomPas.individual_100kb_1500x_region_vcf_file.list
vcf_list2=BomVet_New_REF_BomPas.individual_100kb_1500x_region_vcf_file.list
vcf_list3=AndHae_New_REF_AndHae.individual_100kb_1500x_region_vcf_file.list
vcf_list4=AndMar_New_REF_AndHae.individual_100kb_1500x_region_vcf_file.list
vcf_list5=AndMar_New_REF_AndMar.individual_100kb_1500x_region_vcf_file.list
vcf_list6=AndMar_New_REF_AndTri.individual_100kb_1500x_region_vcf_file.list
AndHae_New_REF_AndFul.individual_100kb_1500x_region_vcf_file.list
BomPas_New_REF_BomCon.individual_100kb_1500x_region_vcf_file.list
vcf-concat --files $vcf_list1 | bgzip -c > ./concated_vcf_each_species_REF/concated.BomPas_New_REF_BomPas.100kb_g1500x_regions.vcf.gz
vcf-concat --files $vcf_list2 | bgzip -c > ./concated_vcf_each_species_REF/concated.BomVet_New_REF_BomPas.100kb_g1500x_regions.vcf.gz
vcf-concat --files $vcf_list3 | bgzip -c > ./concated_vcf_each_species_REF/concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.vcf.gz
vcf-concat --files $vcf_list4 | bgzip -c > ./concated_vcf_each_species_REF/concated.AndMar_New_REF_AndHae.100kb_g1500x_regions.vcf.gz
vcf-concat --files $vcf_list5 | bgzip -c > ./concated_vcf_each_species_REF/concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.vcf.gz

## sort chr according to ref
cd ./concated_vcf_each_species_REF
conda activate gatk_4.3.0.0
gatk SortVcf --INPUT concated.BomPas_New_REF_BomPas.100kb_g1500x_regions.vcf.gz --OUTPUT concated.BomPas_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.vcf.gz
gatk SortVcf --INPUT concated.BomVet_New_REF_BomPas.100kb_g1500x_regions.vcf.gz --OUTPUT concated.BomVet_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.vcf.gz
gatk SortVcf --INPUT concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.vcf.gz --OUTPUT concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.all_chr.sorted.vcf.gz
#gatk SortVcf --INPUT concated.AndMar_New_REF_AndHae.100kb_g1500x_regions.vcf.gz --OUTPUT concated.AndMar_New_REF_AndHae.100kb_g1500x_regions.all_chr.sorted.vcf.gz
gatk SortVcf --INPUT concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.vcf.gz --OUTPUT concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.all_chr.sorted.vcf.gz

## issue
## https://github.com/samtools/bcftools/issues/420
## [E::vcf_parse_format_fill5] Invalid character '.' in 'GQ' FORMAT field at 1:4484
## example of one sample
sed -i 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' \
    concated.Andhae.New_REF_AndHae.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf

## replace "Integer" with "Float" using for loop
for vcf in `ls *all_chr.sorted.vcf.gz`
for vcf in `ls *AndMar_New_REF_AndMar*all_chr.sorted.vcf.gz`
for vcf in `ls -t *all_chr.sorted.vcf.gz | head -9`
    do
    output_vcf=${vcf/sorted.vcf.gz/sorted.GQ_issue_solved.vcf}
    ## pigz is faster than gzip
    ## https://www.baeldung.com/linux/gzip-and-gunzip
    pigz -d -k -c $vcf > $output_vcf
    sed -i 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' $output_vcf
    ## -f: Force overwrite, compress .gz, links, and to terminal
    pigz -f $output_vcf > $output_vcf.gz
done

## New_REF
file_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf
head `ls *.list` | while read line
    do
    [[ $line == *Bompas_REF_BomPas* ]] && echo $line
    #echo $line
done
# ==> Bompas_REF_BomPas.individual_100kb_1500x_region_vcf_file.list <==

while IFS= read -rd '' file
    do
    [[ $line == *Bompas_New_REF_BomPas* ]] && echo $file
    #echo $line
done < $list
list=( "fb_per_region_BomPas_New_REF_BomPas"
    "fb_per_region_BomVet_New_REF_BomPas"
    "fb_per_region_BomVet_New_REF_ApisMel"
    "fb_per_region_BomPas_New_REF_ApisMel"
    "fb_per_region_AndHae_New_REF_BomPas"
    "fb_per_region_AndHae_New_REF_AndHae"
    )

****************** New mapping *******************

## step I: concat in for loop
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf

for vcf_list in $(ls -t *.list | head -6)
    do
    conc_name="${vcf_list/.individual_100kb_1500x_region_vcf_file.list/}"
    for dir in `ls -t -d fb_per_region* | head -7`
        do
        ## when meet multiple condition
        if [[ $vcf_list == *BomPas*New_REF_BomPas* && $dir == fb_per_region*BomPas*New_REF_BomPas* ]]
        then
            echo $vcf_list $dir
            ## attention to the directory
            #cd $dir
            ## https://github.com/samtools/bcftools/issues/420
            ## [E::vcf_parse_format_fill5] Invalid character '.' in 'GQ' FORMAT field at 1:4484
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz
            ##cd ..


        elif [[ $vcf_list == *AndMar*New_REF_AndTri* && $dir == fb_per_region*AndMar*New_REF_AndTri* ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz


        elif [[ $vcf_list == *AndHae*New_REF_AndFul* && $dir == fb_per_region*AndHae*New_REF_AndFul* ]]
        then
            echo $vcf_list $dir
            ## cd $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz
            ## attention to if the vcf list contains path and output to sed; below is older version
            ## time vcf-concat --files ../$vcf_list | sed -i 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ../concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz
            ## cd ..
        elif [[ $vcf_list == *BomPas*New_REF_BomCon* && $dir == fb_per_region*BomPas*New_REF_BomCon* ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz
        elif [[ $vcf_list == *BomVet*New_REF_BomCon* && $dir == fb_per_region*BomVet*New_REF_BomCon* ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz
        elif [[ $vcf_list == *BomPas*New_REF_BomHor* && $dir == fb_per_region*BomPas*New_REF_BomHor* ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz
        elif [[ $vcf_list == *BomVet*New_REF_BomHor* && $dir == fb_per_region*BomVet*New_REF_BomHor* ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz

        elif [[ $vcf_list == *BomVet*New_REF_BomPas* && $dir == fb_per_region*BomVet*New_REF_BomPas* ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz
        elif [[ $vcf_list == *BomPas*New_REF_ApisMel* && $dir == fb_per_region*BomPas*New_REF_ApisMel* ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz
        elif [[ $vcf_list == *BomVet*New_REF_ApisMel* && $dir == fb_per_region*BomVet*New_REF_ApisMel* ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz
        elif [[ $vcf_list == *AndHae*New_REF_BomPas* && $dir == fb_per_region*AndHae*New_REF_BomPas* ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz
        elif [[ $vcf_list == *AndHae*New_REF_AndHae* && $dir == fb_per_region*AndHae*New_REF_AndHae* ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz
        else
            echo "no_concat"
        fi
    done
done

## sort chromosome order with SortVcf (indexed automatically)
conda activate gatk_4.3.0.0
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
gatk --list
gatk SortVcf --INPUT concated_fb_all_chr.vcf.gz --OUTPUT concated_fb_all_chr.sorted_chr.vcf.gz
less -S concated_fb_all_chr.sorted_chr.vcf.gz


cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf
## list only directory in a folder
species_dir=("fb_per_contig_AndHae_REF_AndHae" "fb_per_contig_AndMar_REF_AndHatt" "fb_per_contig_BomPas_REF_BomPas"
            "fb_per_contig_AndHae_REF_AndHatt" "fb_per_contig_AndMar_REF_BomPas" "fb_per_contig_BomVet_REF_ApisMel"
            "fb_per_contig_AndHae_REF_BomPas" "fb_per_contig_BomPas_REF_ApisMel" "fb_per_contig_BomVet_REF_BomHyp"
            "fb_per_contig_AndMar_REF_AndHae" "fb_per_contig_BomPas_REF_BomHyp" "fb_per_contig_BomVet_REF_BomPas"
)
species_dir=("fb_per_contig_BomPas_REF_BomPas" "fb_per_contig_AndHae_REF_AndHae")
species_dir=(
            "fb_per_contig_AndMar_REF_AndHatt"
            "fb_per_contig_AndHae_REF_AndHatt" "fb_per_contig_AndMar_REF_BomPas" "fb_per_contig_BomVet_REF_ApisMel"
            "fb_per_contig_AndHae_REF_BomPas" "fb_per_contig_BomPas_REF_ApisMel" "fb_per_contig_BomVet_REF_BomHyp"
            "fb_per_contig_AndMar_REF_AndHae" "fb_per_contig_BomPas_REF_BomHyp"

)
## save vcf file per region into a file
for vcf in ${species_dir[*]};
    do ls ./$vcf/*100kb_1500x_regions*vcf | sort -V > ./$vcf.individual_100kb_1500x_region_vcf_file.list
    #sort -V > AndHae_New_REF_AndHae.individual_100kb_1500x_region_vcf_file.list
done

## for all
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

## issued vcf files
vcf_list=("fb_per_contig_BomVet_REF_BomPas.g600_regions.vcf.list"
    #"fb_per_contig_BomPas_REF_BomHyp.g600_regions.vcf.list" "fb_per_contig_BomPas_REF_BomPas.g600_regions.vcf.list"
)
## not available yet:  "fb_per_contig_BomVet_REF_BomPas.g600_regions.vcf.list"

conda activate variant_calling_mapping
for species_vcf in  ${vcf_list[*]}
    do
    concat_vcf=${species_vcf/.individual_100kb_1500x_region_vcf_file.list/.100kb_1500x_regions}
    vcf-concat --files $species_vcf | bgzip -c > ./concated_vcf_each_species_REF/concated.$concat_vcf.vcf.gz
done

********************** reorder the chromosome order ***********************
## issued vcf
## Step II: reorder the chromosome order
conda activate gatk_4.3.0.0
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
## New_REF New_mapping
#for vcf in `ls concated*.100kb_g1500x_regions.vcf.gz`
for vcf in `ls -t concated*.100kb_g1500x_regions.vcf.gz | head -6`
    do 
    vcf_sorted_chr=${vcf/.vcf.gz/}
    gatk SortVcf --INPUT $vcf --OUTPUT $vcf_sorted_chr.all_chr.sorted.vcf.gz
done

****************************************************************************************

## concated.fb_per_contig_BomPas_REF_BomHyp.g600_regions.vcf.list.md.sorted_chr.vcf.gz
## example from freebayes
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  Andmar_pool1
chr1    3332    .       T       A       221.12  .       AB=0;ABP=0;AC=58;AF=1;AN=58;AO=1>
chr1    19245   .       G       T       31.41   .       AB=0;ABP=0;AC=58;AF=1;AN=58;AO=2>
chr1    19255   .       G       A       94.6    .       AB=0;ABP=0;AC=58;AF=1;AN=58;AO=5>
chr1    19298   .       G       C       38.6    .       AB=0.417582;ABP=8.37933;AC=24;AF>
chr1    19451   .       G       A       2225.52 .       AB=0;ABP=0;AC=58;AF=1;AN=58;AO=1>
chr1    19460   .       AAGGCCGG        AAGACCGA        2413.2  .       AB=0;ABP=0;AC=58>
chr1    19482   .       G       C       2071    .       AB=0.881481;ABP=173.656;AC=51;AF>
chr1    19500   .       A       T       1564.41 .       AB=0.729927;ABP=65.9196;AC=42;AF>
chr1    19515   .       GCAGA   ATAGG   1300.26 .       AB=0;ABP=0;AC=58;AF=1;AN=58;AO=6>
chr1    19532   .       GAC     AAT     1189.91 .       AB=0;ABP=0;AC=58;AF=1;AN=58;AO=5>

## keep biallelic snp, remove duplicates and normalize snp with long base, also remove monomorphic snps
bcftools view -v snps -A -m 2 -M 2 concated_fb_all_chr.g600_100_regions.vcf.gz | \
    bcftools norm -D -f $REF | bcftools filter -e 'AC==0 || AC == AN' | bcftools view -i 'INFO/DP > 200 && INFO/MQM > 15 && FMT/GQ > 10' | less -S

number of sites covered by reads 200X

## variant filtering after hard_filtering
bcftools view -v snps -A -m 2 -M 2 -f PASS concated_deo_mel_all_chr.sorted_chr.SNP_hard_filtered.vcf.gz | \
    bcftools norm -D -f $REF | bcftools filter -e 'AC==0 || AC == AN' | bcftools view -i 'INFO/DP > 200 && INFO/MQM > 15 && FMT/GQ > 10' | \
    bcftools query -f '%CHROM\t%POS\t%DP\t%DPB\t%MQM[\t%SAMPLE\tGQ=%GQ\tDP=%DP\tTYPE=%TYPE]\n'| less -S

REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/iyBomHypn_7925v1_2.md_chr.fa


**********************************************************************************
## variant filtering and subset samples in vcf
conda activate variant_calling_mapping
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
## concated_vcf_REF_all
concated_vcf_species=(
    "concated.fb_per_contig_AndHae_REF_AndHae.g600_regions.vcf.list.vcf.gz"
    "concated.fb_per_contig_AndHae_REF_AndHatt.g600_regions.vcf.list.vcf.gz"
    "concated.fb_per_contig_AndHae_REF_BomPas.g600_regions.vcf.list.vcf.gz"
    "concated.fb_per_contig_AndMar_REF_AndHae.g600_regions.vcf.list.vcf.gz"
    "concated.fb_per_contig_AndMar_REF_AndHatt.g600_regions.vcf.list.vcf.gz"
    "concated.fb_per_contig_AndMar_REF_BomPas.g600_regions.vcf.list.vcf.gz"
    "concated.fb_per_contig_BomPas_REF_ApisMel.g600_regions.vcf.list.vcf.gz"
    "concated.fb_per_contig_BomPas_REF_BomHyp.g600_regions.vcf.list.vcf.gz"
    "concated.fb_per_contig_BomPas_REF_BomPas.g600_regions.vcf.list.vcf.gz"
    "concated.fb_per_contig_BomVet_REF_ApisMel.g600_regions.vcf.list.vcf.gz"
    "concated.fb_per_contig_BomVet_REF_BomHyp.g600_regions.vcf.list.vcf.gz"
)
## concated_vcf_REF_pas
concated_vcf_REF_pas=(
    "concated.fb_per_contig_BomVet_REF_BomPas.g1500x_regions.all_chr.sorted_chr.vcf.gz"
    #"concated.fb_per_contig_BomPas_REF_BomPas.g1500x_regions.all_chr.sorted_chr.vcf.gz"
    #"concated.fb_per_contig_BomVet_REF_BomPas.g600_regions.vcf.list.vcf.gz"
    #"concated.fb_per_contig_AndHae_REF_BomPas.g600_regions.vcf.list.vcf.gz"
    #"concated.fb_per_contig_AndMar_REF_BomPas.g600_regions.vcf.list.vcf.gz"
    #"concated.fb_per_contig_BomPas_REF_BomPas.g600_regions.vcf.list.vcf.gz"
)

## concated_vcf_REF_hyp
concated_vcf_REF_hyp=(
    "concated.fb_per_contig_BomPas_REF_BomHyp.g600_regions.vcf.list.md.sorted_chr.vcf.gz" ## some issue with variants for BomPas_REF_BomHyp
    #"concated.fb_per_contig_BomVet_REF_BomHyp.g600_regions.vcf.list.vcf.gz"
)

## concated_vcf_REF_hae
concated_vcf_REF_hae=(
    "concated.fb_per_contig_AndHae_REF_AndHae.g600_regions.vcf.list.vcf.gz"
    "concated.fb_per_contig_AndMar_REF_AndHae.g600_regions.vcf.list.vcf.gz"
)

## concated_vcf_REF_hat
concated_vcf_REF_hat=(
    "concated.fb_per_contig_AndHae_REF_AndHatt.g600_regions.vcf.list.vcf.gz"
    "concated.fb_per_contig_AndMar_REF_AndHatt.g600_regions.vcf.list.vcf.gz"
)

## concated_vcf_REF_ApisMel
concated_vcf_REF_ApisMel=(
    "concated.fb_per_contig_BomPas_REF_ApisMel.g600_regions.vcf.list.vcf.gz"
    "concated.fb_per_contig_BomVet_REF_ApisMel.g600_regions.vcf.list.vcf.gz"
)

## Reference dir
REF_BomPas=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/iyBomPasc1_1.md_chr.fa
REF_BomHyp=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/iyBomHypn_7925v1_2.md_chr.fa
REF_ApisMel=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Amel_HAv3_1.md_chr.fa
REF_AndHae=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/iyAndHaem1_1.md_chr.fa
REF_AndHat=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/iyAndHatt_8785v1_2.md_chr.fa


bcftools view -v snps -A -m 2 -M 2 -f PASS $vcf_dro_mel | bcftools norm -d none -f $REF_DRO_MEL | \
    bcftools filter -e 'AC==0 || AC == AN' | bcftools +setGT -- -t q -n . -i 'FMT/DP=0' | \
    bcftools view -S SB_RP.list -i 'MIN(FMT/DP) > 3 | F_MISSING < 0.3' | bcftools filter -e 'AC==0 || AC == AN' \
    -Oz -o ./concated_dro_mel_all_chr.sorted_chr.SNP_hard_filtered_bi_MQ20_FMT_DP3_MSG03.SB_RP.list.vcf.gz

for sample_list in ${sample_listS[*]};
    do echo $sample_list;
done

## concated_vcf_REF_pas
for vcf in ${concated_vcf_REF_pas[*]}
    do  out_vcf_prefix=${vcf/.vcf.list.vcf.gz/}
        bcftools view -v snps -A -m 2 -M 2 $vcf | bcftools norm -d none -f $REF_BomPas \
        | bcftools filter -e 'AC==0 || AC == AN' | bcftools +setGT -- -t q -n . -i 'FMT/DP=0' | \
        bcftools view -i 'INFO/DP > 270' | bcftools filter -e 'AC==0 || AC == AN' \
    -Oz -o ./$out_vcf_prefix.bi_MQ20_DP270.vcf.gz
done

## 1500x
conda activate variant_calling_mapping
for vcf in ${concated_vcf_REF_pas[*]}
    do  out_vcf_prefix=${vcf/.vcf.list.vcf.gz/}
        bcftools view -v snps -A -m 2 -M 2 $vcf | bcftools norm -d none -f $REF_BomPas \
        | bcftools filter -e 'AC==0 || AC == AN' | bcftools +setGT -- -t q -n . -i 'FMT/DP=0' | \
        bcftools view -i 'INFO/DP > 160' | bcftools filter -e 'AC==0 || AC == AN' \
    -Oz -o ./$out_vcf_prefix.bi_MQ20_DP160_1500.vcf.gz
done

## problem solved after remove issued variants
Lines   total/split/joined/realigned/skipped:   1207855/0/0/4113/0
Filled 0 alleles
Lines   total/split/joined/realigned/skipped:   1214385/0/0/3388/0
Filled 0 alleles
[W::vcf_parse_info] INFO 'technology.B##fileformat' is not defined in the header, assuming Type=String
[W::bcf_hrec_check] Invalid tag name: "technology.B##fileformat"
[E::bcf_write] Broken VCF record, the number of columns at chr7:10424222 does not match the number of samples (0 vs 1)
[main_vcfview] Error: cannot write to (null)
Lines   total/split/joined/realigned/skipped:   1241798/0/0/9072/0
Filled 0 alleles

## DP <= 1500x for New_REF
conda activate variant_calling_mapping
## 600x < DP
## 400x < DP
## 200x < DP
## example
concated_vcf_REF_pas=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/fb_per_contig_BomPas_REF_BomPas/Bompas.REF_BomPas.mono_1500x_region_1.g.vcf
bcftools filter -g 40:indel $concated_vcf_REF_pas | less -S
## 17363 ins
## 17393 snp (removed)

for vcf in ${concated_vcf_REF_pas[*]}
    do  out_vcf_prefix=${vcf/.vcf.list.vcf.gz/}
        bcftools view -i 'INFO/DP >= 600' $vcf > xx.vcf

        bcftools filter --SnpGap 5:indel | \
        bcftools view --types snps --min-alleles 2 --max-alleles 2 -i 'INFO/AO > 2' xx.$vcf | \
#        bcftools norm -d none -f $REF_BomPas | \
        bcftools +setGT -- -t q -n . -i 'FMT/DP=0' | \
        bcftools filter -e 'AC==0 || AC == AN' | \
        bcftools filter -e --mask-file file.bed | \
        bcftools view -e 'F_MISSING > 0' | \
        -Oz -o ./$out_vcf_prefix.bi_MQ20_DP160_1500.vcf.gz
done




>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  step I: "Concatenate and Sort VCF "  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

                                        ## New REF
                                        ## dro_mel
conda activate variant_calling_mapping
REF_MASKED_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed

## deal with missing data for Dro_Mel
New_REF_mask_region=$REF_MASKED_DIR/Drosophila_melanoganster-GCF_000001215.4_Release_6_plus_ISO1_MT_genomic-softmasked_ref_gene.conca_sorted.bed
bcftools filter --soft-filter mask --mask-file $New_REF_mask_region concated_dro_mel_all_chr.sorted_chr.SNP_hard_filter.vcf.gz | \
bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | bcftools filter --SnpGap 5:indel | \
bcftools norm -d none -f $New_REF_DRO_MEL | bcftools filter -e 'AC==0 || AC == AN' | \
bcftools +setGT -- -t q -n . -i 'FMT/DP=0' | bcftools view -e 'MIN(FMT/DP) < 3 | F_MISSING > 0' | \
bcftools view -i 'AC > 1' -Oz -o ./concated_dro_mel_all_chr.sorted_chr.SNP_hard_filter.MQ40_masked_bi_AC1_FMT_DP3_noMS.vcf.gz


                                        ## pooled bees
conda activate variant_calling_mapping
REF_MASKED_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed

## complement (softmasked_regions + gene_regions) bed file - preferred
New_REF_AndHae_mask_region=$REF_MASKED_DIR/Andrena_haemorrhoa-GCA_910592295.1-softmasked_ref_gene.conca_sorted.bed
New_REF_AndHat_mask_region=$REF_MASKED_DIR/Andrena_hattorfiana-GCA_944738655.1-softmasked_ref_gene.conca_sorted.bed
New_REF_BomPas_mask_region=$REF_MASKED_DIR/Bombus_pascuorum-GCA_905332965.1-softmasked_ref_gene.conca_sorted.bed
New_REF_BomHyp_mask_region=$REF_MASKED_DIR/Bombus_hypnorum-GCA_911387925.1-softmasked_ref_gene.conca_sorted.bed
New_REF_ApisMel_mask_region=$REF_MASKED_DIR/Amel_HAv-GCF_003254395.2-softmasked_ref_gene.conca_sorted.bed
New_REF_AndMar_mask_region=$REF_MASKED_DIR/Andrena_marginata_GCA_963932335.1-softmasked_ref_gene.conca_sorted.bed

New_REF_AndMar_mask_region=$REF_MASKED_DIR/Andrena_marginata_GCA_963932335.1-softmasked.bed

## only softmasked_regions bed file
#New_REF_AndHae_mask_region=$REF_MASKED_DIR/Andrena_haemorrhoa-GCA_910592295.1-softmasked.bed
#New_REF_AndHat_mask_region=$REF_MASKED_DIR/Andrena_hattorfiana-GCA_944738655.1-softmasked.bed
#New_REF_BomPas_mask_region=$REF_MASKED_DIR/Bombus_pascuorum-GCA_905332965.1-softmasked.bed
#New_REF_BomHyp_mask_region=$REF_MASKED_DIR/Bombus_hypnorum-GCA_911387925.1-softmasked.bed
#New_REF_ApisMel_mask_region=$REF_MASKED_DIR/Amel_HAv-GCF_003254395.2-softmasked.bed

## ref
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
REF_AndHae=$REF_DIR/Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa
REF_AndHat=$REF_DIR/Andrena_hattorfiana-GCA_944738655.1-softmasked.fa
REF_BomPas=$REF_DIR/Bombus_pascuorum-GCA_905332965.1-softmasked.fa
REF_BomHyp=$REF_DIR/Bombus_hypnorum-GCA_911387925.1-softmasked.fa
REF_ApisMel=$REF_DIR/Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa
REF_AndMar=$REF_DIR/Andrena_marginata_GCA_963932335.1-softmasked.fa

## vcf
concated_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
cd $concated_vcf_dir

## earlier (GQ_issue? and attention to VCF file names)
Andhae_New_REF_AndHae_VCF=concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andhae_New_REF_AndHae_VCF_filter=${Andhae_New_REF_AndHae_VCF/.vcf.gz/}
##Andhae_New_REF_AndHae_VCF_filter=${Andhae_New_REF_AndHae_VCF/concated.*.vcf.gz/}
#echo ${Andhae_New_REF_AndHae_VCF_filter/concated./}
Andhae_New_REF_BomPas_VCF=concated.AndHae_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andhae_New_REF_BomPas_VCF_filter=${Andhae_New_REF_BomPas_VCF/.vcf.gz/}
Bompas_New_REF_BomPas_VCF=concated.BomPas_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Bompas_New_REF_BomPas_VCF_filter=${Bompas_New_REF_BomPas_VCF/.vcf.gz/}
Bomvet_New_REF_BomPas_VCF=concated.BomVet_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Bomvet_New_REF_BomPas_VCF_filter=${Bomvet_New_REF_BomPas_VCF/.vcf.gz/}
Bompas_New_REF_ApisMel_VCF=concated.BomPas_New_REF_ApisMel.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Bompas_New_REF_ApisMel_VCF_filter=${Bompas_New_REF_ApisMel_VCF/.vcf.gz/}
Bomvet_New_REF_ApisMel_VCF=concated.BomVet_New_REF_ApisMel.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Bomvet_New_REF_ApisMel_VCF_filter=${Bomvet_New_REF_ApisMel_VCF/.vcf.gz/}

## later (GQ_issue?)
Andmar_New_REF_AndHae_VCF=concated.AndMar_New_REF_AndHae.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andmar_New_REF_AndHae_VCF_filter=${Andmar_New_REF_AndHae_VCF/.vcf.gz/}

Andmar_New_REF_AndMar_VCF=concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andmar_New_REF_AndMar_VCF_filter=${Andmar_New_REF_AndMar_VCF/.vcf.gz/}

Andmar_New_REF_BomPas_VCF=concated.AndMar_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andmar_New_REF_BomPas_VCF_filter=${Andmar_New_REF_BomPas_VCF/.vcf.gz/}
Andmar_New_REF_AndHat_VCF=concated.AndMar_New_REF_AndHat.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andmar_New_REF_AndHat_VCF_filter=${Andmar_New_REF_AndHat_VCF/.vcf.gz/}
Andhae_New_REF_AndHat_VCF=concated.AndHae_New_REF_AndHat.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andhae_New_REF_AndHat_VCF_filter=${Andhae_New_REF_AndHat_VCF/.vcf.gz/}
Bompas_New_REF_BomHyp_VCF=concated.BomPas_New_REF_BomHyp.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Bompas_New_REF_BomHyp_VCF_filter=${Bompas_New_REF_BomHyp_VCF/.vcf.gz/}
Bomvet_New_REF_BomHyp_VCF=concated.BomVet_New_REF_BomHyp.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Bomvet_New_REF_BomHyp_VCF_filter=${Bomvet_New_REF_BomHyp_VCF/.vcf.gz/}

## keep biallelic snp, remove duplicates and normalize snp with long base (bcftools norm -d none/-m-snps), also remove monomorphic snps
## new final
for depth in {200,400,600}
do
bcftools filter --soft-filter mask --mask-file $New_REF_AndHae_mask_region $Andhae_New_REF_AndHae_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHae | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MIN(FMT/DP) < $depth" \
-Oz -o ./"$Andhae_New_REF_AndHae_VCF_filter".SNP_softmasked_bi_FMT_DP"$depth"_noMS.vcf.gz
done

# 200x - hae -hae
bcftools filter --soft-filter mask --mask-file $New_REF_AndHae_mask_region concated.fb_per_contig_AndHae_REF_AndHae.100kb_g1500x_regions.all_chr.sorted_chr.vcf.gz | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHae | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MIN(FMT/DP) < 200" \
-Oz -o AndHae_New_REF_AndHae.SNP_softmasked_bi_FMT_DP200x_noMS.vcf.gz

# 200x - hae -hae (softmasked+gene)
bcftools filter --soft-filter mask --mask-file $New_REF_AndHae_mask_region $Andhae_New_REF_AndHae_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHae | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MIN(FMT/DP) < 200" \
-Oz -o AndHae_New_REF_AndHae.SNP_softmask_genic_bi_FMT_DP200x_noMS.vcf.gz

## data check
bcftools query -f '%CHROM\t%POS\t%DP\t%DPB\t%AC\n' AndHae_New_REF_AndHae.SNP_softmask_genic_bi_FMT_DP200x_noMS.vcf.gz | less -S | awk '{if($5 < 5) print $0}' | less
## sfs
bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' AndHae_New_REF_AndHae.SNP_softmask_genic_bi_FMT_DP200x_noMS.vcf.gz | \
    awk '{if ($3 <= $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   Old Version  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
1. ## Andhae_New_REF_AndHae_VCF 
for depth in {200,400,600}
do
depth_upper=`echo $(($depth+50))`
bcftools filter --soft-filter mask --mask-file $New_REF_AndHae_mask_region $Andhae_New_REF_AndHae_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHae | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC == 0 || AC == AN' | \
bcftools +setGT -- -t q -n . -i 'FMT/DP = 0' | bcftools view -e "MIN(FMT/DP) < $depth | F_MISSING > 0" | \
bcftools view -i 'FMT/AO > 2' -Oz -o ./"$Andhae_New_REF_AndHae_VCF_filter".SNP_masked_bi_FMT_DP"$depth"_noMS_AO3.vcf.gz
done

## rename final files
#echo ${Andhae_New_REF_AndHae_VCF_filter/concated.fb_per_contig_/}

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Test of New Version  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
1. ## Andhae_New_REF_AndHae_VCF
for depth in {200,300,400,600}
do
    if [ $depth == 300 ];then
        ## depth_upper=`echo $(($depth+50))`
        bcftools filter --soft-filter mask --mask-file $New_REF_AndHae_mask_region $Andhae_New_REF_AndHae_VCF | \
        bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHae | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
        bcftools filter -e 'AC==0 || AC == AN' | \
        bcftools view -e "MIN(FMT/DP) < $depth || MAX(FMT/DP) > 600" \
        -Oz -o ./"$Andhae_New_REF_AndHae_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"x_600x_noMS.vcf.gz

    else
        ## depth_upper=`echo $(($depth+50))`
        bcftools filter --soft-filter mask --mask-file $New_REF_AndHae_mask_region $Andhae_New_REF_AndHae_VCF | \
        bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHae | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
        bcftools filter -e 'AC==0 || AC == AN' | \
        bcftools view -e "MIN(FMT/DP) < $depth || MAX(FMT/DP) > 1200" \
        ## bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > $depth+50" \
        -Oz -o ./"$Andhae_New_REF_AndHae_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"x_1200x_noMS.vcf.gz
    fi
done

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  NEW  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
1. ## Andhae_New_REF_AndHae_VCF *************   New Version afterwards
for depth in {234,400,600}
do
    ## depth_upper=`echo $(($depth+50))`
    bcftools filter --soft-filter mask --mask-file $New_REF_AndHae_mask_region $Andhae_New_REF_AndHae_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHae | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Andhae_New_REF_AndHae_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done

2. ## Andhae_New_REF_BomPas_VCF ****************
for depth in {234,400,600}
do
    bcftools filter --soft-filter mask --mask-file $New_REF_BomPas_mask_region $Andhae_New_REF_BomPas_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomPas | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Andhae_New_REF_BomPas_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done

3. ## Bompas_New_REF_BomPas_VCF ****************
for depth in {204,400,600}
do
    bcftools filter --soft-filter mask --mask-file $New_REF_BomPas_mask_region $Bompas_New_REF_BomPas_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomPas | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Bompas_New_REF_BomPas_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done

4. ## Bomvet_New_REF_BomPas_VCF ****************
for depth in {174,400,600}
do
    bcftools filter --soft-filter mask --mask-file $New_REF_BomPas_mask_region $Bomvet_New_REF_BomPas_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomPas | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Bomvet_New_REF_BomPas_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done

5. ## Bompas_New_REF_ApisMel_VCF ****************
for depth in {204,400,600}
do
    bcftools filter --soft-filter mask --mask-file $New_REF_ApisMel_mask_region $Bompas_New_REF_ApisMel_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_ApisMel | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Bompas_New_REF_ApisMel_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done

6. ## Bomvet_New_REF_ApisMel_VCF ****************
for depth in {174,400,600}
do
    bcftools filter --soft-filter mask --mask-file $New_REF_ApisMel_mask_region $Bomvet_New_REF_ApisMel_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_ApisMel | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Bomvet_New_REF_ApisMel_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done

## later
7-1. ## Andmar_New_REF_AndMar_VCF
for depth in {240,400,600}
do
bcftools filter --soft-filter mask --mask-file $New_REF_AndMar_mask_region $Andmar_New_REF_AndMar_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndMar | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andmar_New_REF_AndMar_VCF_filter".SNP_softmask_bi_FMT_DP"$depth"x_1500x_noMS.vcf.gz
done

7. ## Andmar_New_REF_AndHae_VCF
for depth in {240,400,600}
do
bcftools filter --soft-filter mask --mask-file $New_REF_AndHae_mask_region $Andmar_New_REF_AndHae_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHae | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andmar_New_REF_AndHae_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"x_1500x_noMS.vcf.gz
done

8. ## Andmar_New_REF_AndHat_VCF
for depth in {240,400,600}
do
bcftools filter --soft-filter mask --mask-file $New_REF_AndHat_mask_region $Andmar_New_REF_AndHat_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHat | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andmar_New_REF_AndHat_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"x_1500x_noMS.vcf.gz
done

9. ## Andmar_New_REF_BomPas_VCF
for depth in {240,400,600}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomPas_mask_region $Andmar_New_REF_BomPas_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomPas | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andmar_New_REF_BomPas_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"x_1500x_noMS.vcf.gz
done

10. ## Andhae_New_REF_AndHat_VCF
for depth in {234,400,600}
do
bcftools filter --soft-filter mask --mask-file $New_REF_AndHat_mask_region $Andhae_New_REF_AndHat_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHat | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andhae_New_REF_AndHat_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"x_1500x_noMS.vcf.gz
done
11. ## Bompas_New_REF_BomHyp_VCF
for depth in {204,400,600}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomHyp_mask_region $Bompas_New_REF_BomHyp_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomHyp | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Bompas_New_REF_BomHyp_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"x_1500x_noMS.vcf.gz
done
12. ## Bomvet_New_REF_BomHyp_VCF
for depth in {174,400,600}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomHyp_mask_region $Bomvet_New_REF_BomHyp_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomHyp | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Bomvet_New_REF_BomHyp_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"x_1500x_noMS.vcf.gz
done


>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>        step II           <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
## count SNP number
less /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF/concated.fb_per_contig_BomVet_REF_BomPas.g1500x_regions.all_chr.sorted_chr.vcf.gz.bi_MQ20_DP160_1500.vcf.gz | \
    grep -v '^#' | wc -l

for vcf in `ls *GQ_issue.SNP_softmasked_bi_FMT_DP*_noMS_AO3*vcf.gz`
    do
    less $vcf | grep -v '^#' | wc -l | tr -d '\n'
    echo -e "\t$vcf"
done
## concated_vcf_REF_hyp
for vcf in ${concated_vcf_REF_hyp[*]}
    do  out_vcf_prefix=${vcf/.vcf.list.vcf.gz/}
        bcftools view -v snps -A -m 2 -M 2 $vcf | bcftools norm -d none -f $REF_BomHyp \
        | bcftools filter -e 'AC==0 || AC == AN' | bcftools +setGT -- -t q -n . -i 'FMT/DP=0' | \
        bcftools view -i 'INFO/DP > 270' | bcftools filter -e 'AC==0 || AC == AN' \
    -Oz -o ./$out_vcf_prefix.bi_MQ20_DP270.vcf.gz
done
## solved
[E::vcf_parse_format_fill5] Invalid character '#' in 'GT' FORMAT field at chr1:24722469
[W::vcf_parse_info] INFO '##fileformat' is not defined in the header, assuming Type=String
[W::bcf_hrec_check] Invalid tag name: "##fileformat"
[E::bcf_write] Broken VCF record, the number of columns at chr10:6674058 does not match the number of samples (0 vs 1)
[main_vcfview] Error: cannot write to (null)
[E::bcf_write] Broken VCF record, the number of columns at chr10:6673809 does not match the number of samples (0 vs 1)
[flush_buffer] Error: cannot write to -
[E::vcf_parse_format_empty1] FORMAT column with no sample columns starting at chr10:6673445
Filled 0 alleles
Lines   total/split/joined/realigned/skipped:   4066817/0/0/40295/0
Filled 0 alleles

## concated_vcf_REF_hae
for vcf in ${concated_vcf_REF_hae[*]}
    do  out_vcf_prefix=${vcf/.vcf.list.vcf.gz/}
        bcftools view -v snps -A -m 2 -M 2 $vcf | bcftools norm -d none -f $REF_AndHae \
        | bcftools filter -e 'AC==0 || AC == AN' | bcftools +setGT -- -t q -n . -i 'FMT/DP=0' | \
        bcftools view -i 'INFO/DP > 270' | bcftools filter -e 'AC==0 || AC == AN' \
    -Oz -o ./$out_vcf_prefix.bi_MQ20_DP270.vcf.gz
done
## concated_vcf_REF_hat
for vcf in ${concated_vcf_REF_hat[*]}
    do  out_vcf_prefix=${vcf/.vcf.list.vcf.gz/}
        bcftools view -v snps -A -m 2 -M 2 $vcf | bcftools norm -d none -f $REF_AndHat \
        | bcftools filter -e 'AC==0 || AC == AN' | bcftools +setGT -- -t q -n . -i 'FMT/DP=0' | \
        bcftools view -i 'INFO/DP > 270' | bcftools filter -e 'AC==0 || AC == AN' \
    -Oz -o ./$out_vcf_prefix.bi_MQ20_DP270.vcf.gz
done
## concated_vcf_REF_ApisMel
for vcf in ${concated_vcf_REF_ApisMel[*]}
    do  out_vcf_prefix=${vcf/.vcf.list.vcf.gz/}
        bcftools view -v snps -A -m 2 -M 2 $vcf | bcftools norm -d none -f $REF_ApisMel \
        | bcftools filter -e 'AC==0 || AC == AN' | bcftools +setGT -- -t q -n . -i 'FMT/DP=0' | \
        bcftools view -i 'INFO/DP > 270' | bcftools filter -e 'AC==0 || AC == AN' \
    -Oz -o ./$out_vcf_prefix.bi_MQ20_DP270.vcf.gz
done


## -S $sample_list
vcf_pas=concated.fb_per_contig_BomPas_REF_BomPas.g600_regions.vcf.list.vcf.gz
out_vcf_prefix=${vcf_pas/.vcf.list.vcf.gz/}
echo $out_vcf_prefix
bcftools view -v snps -A -m 2 -M 2 $vcf_pas | bcftools norm -d none -f $REF_BomPas \
    | bcftools filter -e 'AC==0 || AC == AN' | bcftools +setGT -- -t q -n . -i 'FMT/DP=0' | \
    bcftools view -i 'INFO/DP > 160' | bcftools filter -e 'AC==0 || AC == AN' \
    -Oz -o ./$vcf_pas.bi_MQ20_DP160_MSG03.vcf.gz

## qualimap ref length

## snpeff neutral variants

## https://unix.stackexchange.com/questions/66255/awk-how-to-add-all-columns-beginning-with-specific-row
## https://askubuntu.com/questions/785038/how-can-i-sum-numbers-on-lines-in-a-file
## https://stackoverflow.com/questions/33006845/how-to-sum-a-row-of-numbers-from-text-file-bash-shell-scripting
awk -F " " '{sum=0;for(i=200;i<=NR;i++){sum+=$i};print sum}'
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate/stats/samtools_stats
less -S SRR24680792.sort.marked_rm_dups.bam.stats.txt | grep ^COV | cut -f 2- > ./samtools_stat_cov/SRR24680792.sort.marked_rm_dups.bam.stats_COV.txt
for sample_samtools_stat in `ls *sort*stats.txt`;do
    grep ^COV $sample_samtools_stat| cut -f 2- > ./samtools_stat_cov/$sample_samtools_stat.COV;
done

*********************  calculate genome fraction covered by reads   **********************
## total number of bases with depth > 9
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/samtools_stats
BomVet_BomPas_COV=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/qualimap/New_REF/Bomvet.New_REF_BomPas.sort.marked_dups.bam/raw_data_qualimapReport/coverage_histogram.txt
BomPas_BomPas_COV=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/qualimap/New_REF/Bompas.New_REF_BomPas.sort.marked_dups.bam/raw_data_qualimapReport/coverage_histogram.txt

awk -F " " 'NR > 7 && NR < 10 {sum+=$2}END{print sum}' $BomVet_BomPas_COV
2124160

## right expression
for COV in `find -maxdepth 3 -print | grep 'coverage_histogram.txt'`
    do
    sed '1d' $COV | awk -F " " 'NR > 280 && NR < 600 {sum+=$2}END{print sum}'
    printf "$COV \n"
done

## dro_mel
## NR > 2 && NR < 1500
for COV in `find -maxdepth 3 -print | grep 'coverage_histogram.txt'`
    do
    sed '1d' $COV | awk -F " " 'NR > 2 && NR < 1500 {sum+=$2}END{print sum}'  | tr -d '\n'
    printf "\t$COV \n"
done

Andhae.New_REF_AndHae.sort.marked_dups.bam
Andhae.New_REF_AndHat.sort.marked_dups.bam
Andhae.New_REF_BomPas.sort.marked_dups.bam
Andmar.New_REF_AndHae.sort.marked_dups.bam
Andmar.New_REF_AndHat.sort.marked_dups.bam
Andmar.New_REF_BomPas.sort.marked_dups.bam
Bompas.New_REF_ApisMel.sort.marked_dups.bam
Bompas.New_REF_BomHyp.sort.marked_dups.bam
Bompas.New_REF_BomPas.sort.marked_dups.bam
Bomvet.New_REF_ApisMel.sort.marked_dups.bam
Bomvet.New_REF_BomHyp.sort.marked_dups.bam
Bomvet.New_REF_BomPas.sort.marked_dups.bam

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/samtools_stats
ls -t *dups.bam | head -6

Bompas.New_REF_BomCon.sort.marked_dups.bam
Bompas.New_REF_BomHor-.sort.marked_dups.bam
Bomvet.New_REF_BomCon.sort.marked_dups.bam
Bomvet.New_REF_BomHor-.sort.marked_dups.bam
Andhae.New_REF_AndFul.sort.marked_dups.bam
Andmar.New_REF_AndTri.sort.marked_dups.bam



## New REF for pooled bees
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/qualimap/New_REF
## 3x per sample: NR > 200 (&& NR < 1500: fb variant calling)
## grep 'Bompas.New_REF'
for COV in `find -maxdepth 3 -print | grep 'Bompas.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 204 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP204_1500x\t$COV \n"
done

## ls -td *dups.bam | head -6
## grep 'Bompas.New_REF - BomHor- BomCon'
for COV in `find -maxdepth 3 -print | grep 'Bompas.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 204 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP204_1500x\t$COV \n"
done

## grep 'Bomvet.New_REF'
for COV in `find -maxdepth 3 -print | grep 'Bomvet.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 174 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP174_1500x\t$COV \n"
done
## grep 'Bomvet.New_REF - BomHor- BomCon'
for COV in `find -maxdepth 3 -print | grep 'Bomvet.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 174 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP174_1500x\t$COV \n"
done
## grep 'Andhae.New_REF'
for COV in `find -maxdepth 3 -print | grep 'Andhae.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 234 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP234_1500x\t$COV \n"
done

## grep 'Andhae.New_REF - AndFul'
for COV in `find -maxdepth 3 -print | grep 'Andhae.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 234 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP234_1500x\t$COV \n"
done

## grep 'Andmar.New_REF'
for COV in `find -maxdepth 3 -print | grep 'Andmar.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 240 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP240_1500x\t$COV \n"
done

## grep 'Andmar.New_REF - AndTri'
for COV in `find -maxdepth 3 -print | grep 'Andmar.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 240 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP240_1500x\t$COV \n"
done



## 5x per sample:  NR > 400 (&& NR < 1500: fb variant calling)
## grep 'Bompas.New_REF'
for COV in `find -maxdepth 3 -print | grep 'Bompas.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 340 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP340_1500x\t$COV \n"
done

## ls -td *dups.bam | head -6
## grep 'Bompas.New_REF - BomHor- BomCon'
for COV in `find -maxdepth 3 -print | grep 'Bompas.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 340 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP340_1500x\t$COV \n"
done

## grep 'Bomvet.New_REF'
for COV in `find -maxdepth 3 -print | grep 'Bomvet.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 290 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP290_1500x\t$COV \n"
done

## grep 'Bomvet.New_REF - BomHor- BomCon'
for COV in `find -maxdepth 3 -print | grep 'Bomvet.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 290 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP290_1500x\t$COV \n"
done

## grep 'Andhae.New_REF'
for COV in `find -maxdepth 3 -print | grep 'Andhae.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 390 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP390_1500x\t$COV \n"
done

## grep 'Andhae.New_REF - AndFul'
for COV in `find -maxdepth 3 -print | grep 'Andhae.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 390 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP390_1500x\t$COV \n"
done


## grep 'Andmar.New_REF'
for COV in `find -maxdepth 3 -print | grep 'Andmar.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 400 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP400_1500x\t$COV \n"
done

## grep 'Andmar.New_REF - AndTri'
for COV in `find -maxdepth 3 -print | grep 'Andmar.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 400 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP400_1500x\t$COV \n"
done

## 7x per sample: NR > 600 (&& NR < 1500: fb variant calling)
## grep 'Bompas.New_REF'
for COV in `find -maxdepth 3 -print | grep 'Bompas.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 476 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP476_1500x\t$COV \n"
done

## ls -td *dups.bam | head -6
## grep 'Bompas.New_REF - BomHor- BomCon'
for COV in `find -maxdepth 3 -print | grep 'Bompas.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 476 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP476_1500x\t$COV \n"
done

## grep 'Bomvet.New_REF'
for COV in `find -maxdepth 3 -print | grep 'Bomvet.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 416 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP416_1500x\t$COV \n"
done

## grep 'Bomvet.New_REF - BomHor- BomCon'
for COV in `find -maxdepth 3 -print | grep 'Bomvet.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 416 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP416_1500x\t$COV \n"
done

## grep 'Andhae.New_REF'
for COV in `find -maxdepth 3 -print | grep 'Andhae.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 546 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP546_1500x\t$COV \n"
done

## grep 'Andhae.New_REF - AndFul'
for COV in `find -maxdepth 3 -print | grep 'Andhae.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 546 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP546_1500x\t$COV \n"
done

## grep 'Andmar.New_REF'
for COV in `find -maxdepth 3 -print | grep 'Andmar.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 560 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP560_1500x\t$COV \n"
done

## grep 'Andmar.New_REF - AndTri'
for COV in `find -maxdepth 3 -print | grep 'Andmar.New_REF' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 560 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP560_1500x\t$COV \n"
done


*****************************************************************************************************
## individually seq Swedish data: getting SFS
cd /crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/PAS/QC_qualimap/pas_samtools
cp -r DA_04*Qualimap GT_03*Qualimap GT_05*Qualimap GT_08*Qualimap NS_07*Qualimap NS_08*Qualimap SL_04*Qualimap ./subset_qualimap/
cd ./subset_qualimap/
for COV in `find -maxdepth 3 -print | grep 'coverage_histogram.txt'`
    do
    sed '1d' $COV | awk -F " " 'NR > 3 && NR < 1000 {sum+=$2}END{print sum}'
    printf "$COV \n"
done
## subset 7 samples with DP > 14x 
vcf_SE_BomPas=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/PAS/new_variant_calling_ploidy/combined_vcf_genotyping/pas.DP3_GQ20_biSNP_maf005_f_missing05.infoDP3_1000Excesshet_25.rm_non_var.pas_41F.vcf.gz
#bcftools query -l pas_7dip_1hap_depth_X15.headerlines.vcf.gz
sample_list=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/PAS/new_variant_calling_ploidy/combined_vcf_genotyping/pop_list/pas_7_depth_X15.list
bcftools view -S $sample_list $vcf_SE_BomPas | bcftools filter -e 'AC==0 || AC == AN' | bcftools view -e 'F_MISSING > 0' | less -S
bcftools view -S $sample_list $vcf_SE_BomPas | bcftools filter -e 'AC==0 || AC == AN' | bcftools view -e 'INFO/DP < 220 | F_MISSING > 0' | less -S
bcftools view -S $sample_list $vcf_SE_BomPas | bcftools filter -e 'AC==0 || AC == AN' | bcftools view -e 'INFO/DP < 220 | F_MISSING > 0' -Oz -o Se_subset_7_BomPas_inds_DP220_1000.vcf.gz
less Se_subset_7_BomPas_inds_DP220_1000.vcf.gz | grep -v '#' | wc -l

## get SFS
bcftools view -S $sample_list $vcf_SE_BomPas | bcftools filter -e 'AC==0 || AC == AN' | bcftools view -e 'F_MISSING > 0' | bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' | head -500 | awk '{if ($3 < $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c |awk '$1=$1'| cut -d ' ' -f 1 | tr '\n' ' '
bcftools view -S $sample_list $vcf_SE_BomPas | bcftools filter -e 'AC==0 || AC == AN' | bcftools view -e 'INFO/DP < 220 | F_MISSING > 0' | bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' | awk '{if ($3 < $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c |awk '$1=$1'| cut -d ' ' -f 1 | tr '\n' ' '

## save subset vcf file
bcftools view -S $sample_list $vcf_SE_BomPas | bcftools filter -e 'AC==0 || AC == AN' | bcftools view -e 'F_MISSING > 0' -Oz -o Se_subset_7_BomPas_inds.vcf.gz
## count the number of SNPs
less Se_subset_7_BomPas_inds.vcf.gz | grep -v '#' | wc -l
2102389

## count SNP number
less /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF/concated.fb_per_contig_BomVet_REF_BomPas.g1500x_regions.all_chr.sorted_chr.vcf.gz.bi_MQ20_DP160_1500.vcf.gz | \
    grep -v '^#' | wc -l

for vcf in `ls *GQ*AO3.vcf.gz`
    do
    less $vcf | grep -v '^#' | wc -l | tr -d '\n'
    echo -e "\t$vcf"
done


## balteatus
sample_bal_list=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/BAL/new_variant_calling_ploidy/combined_vcf_genotyping/subpop_list/bal_12_DP_13X_SMC.txt
vcf_bal=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/BAL/new_variant_calling_ploidy/combined_vcf_genotyping/gatk_17haploid_54diploid_B_bal.SNP_hard_filtered.DP3_GQ20_biSNP.missing05_DP3_1000_Excesshet25.vcf.gz

bcftools view -S $sample_list $vcf_bal | bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e 'F_MISSING > 0'| bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' | \
    awk '{if ($3 < $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c
## SE - pas
sample_pas_list=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/PAS/new_variant_calling_ploidy/combined_vcf_genotyping/pop_list/pas_7_depth_X15.list
vcf_pas=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/PAS/new_variant_calling_ploidy/combined_vcf_genotyping/genotyping_output_14haploid_41diploid_B_pas.SNP_hard_filtered.DP3_GQ20_biSNP_05missing_DP3_1000_Excesshet25.vcf.gz

# qualimap pas
cd /crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/PAS/QC_qualimap/pas_samtools/subset_qualimap
# qualimap bal
cd /crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/BAL/QC_qualimap/bal/subset_qualimap

# qualimap data mon
cp -r AC-002* AC-022* AC-152* M_L024* M_L032* M_L033* M_L049* M_L137* M_L149* M_L190* M_L195* M_L198* ./subset_qualimap/
sample_mon_list=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy/combined_vcf_genotyping/Fst_pop_list/mon_10F_X15.list
vcf_mon=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy/combined_vcf_genotyping/gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP.minorAC2_maleHet_missing05_DP3_3134_Excesshet25.mon_76_27M_49F.vcf.gz

# qualimap data lap
cp -r M_L018* M_L021* M_L138* M_L180* M_L194* AC-006* AC-138* WO_003* WO_006* WO_383* WO_448* WO_449* WO_703* BH_11* subset_qualimap_lap
sample_lap_list=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy/combined_vcf_genotyping/Fst_pop_list/lap_11F_X15.list
vcf_lap=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy/combined_vcf_genotyping/gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP.minorAC2_maleHet_missing05_DP3_3134_Excesshet25.lap_128_62M_66F.vcf.gz

## qualimap lap
cd /crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/QC_qualimap/mon_lap/subset_qualimap_lap
cd ../subset_qualimap_mon/
## lap & mon: DP 2 - 3134
for COV in `find -maxdepth 3 -print | grep 'coverage_histogram.txt'`
    do
    sed '1d' $COV | awk -F " " 'NR > 2 && NR < 3134 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\t$COV \n"
done
## pas & bal: DP 2 - 1000
for COV in `find -maxdepth 3 -print | grep 'coverage_histogram.txt'`
    do
    sed '1d' $COV | awk -F " " 'NR > 2 && NR < 1000 {sum+=$2}END{print sum}'
    printf "$COV \n"
done

# qualimap data mon
cp -r M_L119* AC-020* AC-021* AC-034* M_L210* M_L213* BH_07* BH_08* BH_09* BH_16* ./subset_qualimap_mon
sample_mon_list=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy/combined_vcf_genotyping/Fst_pop_list/mon_10F_X15.list

## get SFS from vcf file
#conda activate variant_calling_mapping
##via uppmax
module load bioinfo-tools python bcftools
## lap
bcftools view -S $sample_lap_list $vcf_lap | bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e 'F_MISSING > 0'| bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' | \
    awk '{if ($3 <= $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c
## mon
bcftools view -S $sample_mon_list $vcf_mon | bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e 'F_MISSING > 0'| bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' | \
    awk '{if ($3 <= $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c





***************************
awk -F " " 'NR > 9 {sum+=$3}END{print sum}' ./samtools_stat_cov/SRR24680792.sort.marked_rm_dups.bam.stats_COV.txt
125571763
## genome fraction coverage 
awk -F " " 'NR > 9 {len=133880608;sum+=$3}END{print sum/len}' ./samtools_stat_cov/SRR24680792.sort.marked_rm_dups.bam.stats_COV.txt
0.937938

## total length of dro_mel genome
awk -F " " 'NR > 0 {sum+=$2}END{print sum}' /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/D_melanogaster.7509v1.md_chr.fa.fai
133880608
 95%*133880608

 0.95*133880608
127186577.60
