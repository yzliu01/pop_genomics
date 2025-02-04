
conda activate variant_calling_mapping
vcf-concat -h

## concatenate (having duplicates?)
vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/
cd $vcf_dir

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
ls ./fb_per_region_AndMar_New_REF_AndBic/Andmar.New_REF_AndBic.100kb_1500x_region_*.g.vcf | sort -V > AndMar_New_REF_AndBic.individual_100kb_1500x_region_vcf_file.list
ls ./fb_per_region_BomPas_New_alt_REF_BomMus/Bompas.New_alt_REF_BomMus.100kb_1500x_region_*.g.vcf | sort -V > BomPas_New_alt_REF_BomMus.individual_100kb_1500x_region_vcf_file.list
ls ./fb_per_region_BomPas_New_REF_BomSyl/Bompas.New_REF_BomSyl.100kb_1500x_region_*.g.vcf | sort -V > BomPas_New_REF_BomSyl.individual_100kb_1500x_region_vcf_file.list
ls ./fb_per_region_BomVet_New_REF_BomSyl/Bomvet.New_REF_BomSyl.100kb_1500x_region_*.g.vcf | sort -V > BomVet_New_REF_BomSyl.individual_100kb_1500x_region_vcf_file.list


# concatenate individual vcf file from freebayes
conda activate variant_calling_mapping
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf

for vcf_list in $(ls -t *.list | head -1)
    do
    conc_name="${vcf_list/.individual_100kb_1500x_region_vcf_file.list/}"
    # select all related folders storing region_vcf files
    for dir in `ls -t -d fb_per_region* | sort`
        do
#        echo $dir
#    done
#done
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
# new assembly        
        elif [[ $vcf_list == *BomVet*New_REF_BomVet* && $dir == fb_per_region*BomVet*New_REF_BomVet* ]]
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
## add four new mappings        
        elif [[ $vcf_list == *AndMar*New_REF_AndBic* && $dir == fb_per_region*AndMar*New_REF_AndBic* ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz

        elif [[ $vcf_list == *BomPas*New_alt_REF_BomMus* && $dir == fb_per_region*BomPas*New_alt_REF_BomMus* ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz

        elif [[ $vcf_list == *BomPas*New_REF_BomSyl* && $dir == fb_per_region*BomPas*New_REF_BomSyl* ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz

        elif [[ $vcf_list == *BomVet*New_REF_BomSyl* && $dir == fb_per_region*BomVet*New_REF_BomSyl* ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz

        else
            echo "no_concat"
        fi
    done
done

# reorder the chromosome order
conda activate gatk_4.3.0.0
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
for vcf in `ls concated*.100kb_g1500x_regions.vcf.gz`
    do
    echo $vcf
    vcf_sorted_chr=${vcf/.vcf.gz/}
    gatk SortVcf --INPUT $vcf --OUTPUT $vcf_sorted_chr.all_chr.sorted.new.vcf.gz
done
