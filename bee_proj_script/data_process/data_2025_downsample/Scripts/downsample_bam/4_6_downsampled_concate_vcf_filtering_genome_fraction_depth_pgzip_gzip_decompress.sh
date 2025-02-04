## https://cyverse.atlassian.net/wiki/spaces/DEapps/pages/259063974/vcftools-merge+0.1.16
## https://vcftools.sourceforge.net/perl_module.html

conda activate variant_calling_mapping
#vcf-concat -h

## suggestion from Jeppe
## concatenate (having duplicates?)
vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/
cd $vcf_dir

## downsample
ls ./fb_per_region_AndHae_New_REF_AndHae_0_2_bam/Andhae.New_REF_AndHae.100kb_1500x_region_*.g.vcf | sort -V > Andhae.New_REF_AndHae_0_2.100kb_1500x_region_vcf_file.list
ls ./fb_per_region_AndHae_New_REF_AndHae_0_3_bam/Andhae.New_REF_AndHae.100kb_1500x_region_*.g.vcf | sort -V > Andhae.New_REF_AndHae_0_3.100kb_1500x_region_vcf_file.list
ls ./fb_per_region_AndHae_New_REF_AndHae_0_4_bam/Andhae.New_REF_AndHae.100kb_1500x_region_*.g.vcf | sort -V > Andhae.New_REF_AndHae_0_4.100kb_1500x_region_vcf_file.list

ls ./fb_per_region_AndMar_New_REF_AndMar_0_2_bam/Andmar.New_REF_AndMar.100kb_1500x_region_*.g.vcf | sort -V > Andmar.New_REF_AndMar_0_2.100kb_1500x_region_vcf_file.list
ls ./fb_per_region_AndMar_New_REF_AndMar_0_3_bam/Andmar.New_REF_AndMar.100kb_1500x_region_*.g.vcf | sort -V > Andmar.New_REF_AndMar_0_3.100kb_1500x_region_vcf_file.list
ls ./fb_per_region_AndMar_New_REF_AndMar_0_4_bam/Andmar.New_REF_AndMar.100kb_1500x_region_*.g.vcf | sort -V > Andmar.New_REF_AndMar_0_4.100kb_1500x_region_vcf_file.list

## downsample
for vcf_list in $(ls -t *.list | head -6 | sort)
    do
    #conc_name="${vcf_list/.individual_100kb_1500x_region_vcf_file.list/}"
    conc_name="${vcf_list/.100kb_1500x_region_vcf_file.list/}"
    #for dir in `ls -t -d fb_per_region* | head -4 | sort`
    #for dir in `ls -t -d fb_per_region* | head -1 | sort`
    ## downsample
    for dir in `ls -t -d fb_per_region* | head -6 | sort`
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

        ## downsample AndHae AndMar ~500x (0.2, 0.4, 0.6)
        elif [[ $vcf_list == Andhae.New_REF_AndHae_0_2.100kb_1500x_region_vcf_file.list && $dir == fb_per_region_AndHae_New_REF_AndHae_0_2_bam ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz

        elif [[ $vcf_list == Andhae.New_REF_AndHae_0_3.100kb_1500x_region_vcf_file.list && $dir == fb_per_region_AndHae_New_REF_AndHae_0_3_bam ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz

        elif [[ $vcf_list == Andhae.New_REF_AndHae_0_4.100kb_1500x_region_vcf_file.list && $dir == fb_per_region_AndHae_New_REF_AndHae_0_4_bam ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz

        elif [[ $vcf_list == Andmar.New_REF_AndMar_0_2.100kb_1500x_region_vcf_file.list && $dir == fb_per_region_AndMar_New_REF_AndMar_0_2_bam ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz
        elif [[ $vcf_list == Andmar.New_REF_AndMar_0_3.100kb_1500x_region_vcf_file.list && $dir == fb_per_region_AndMar_New_REF_AndMar_0_3_bam ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz
        elif [[ $vcf_list == Andmar.New_REF_AndMar_0_4.100kb_1500x_region_vcf_file.list && $dir == fb_per_region_AndMar_New_REF_AndMar_0_4_bam ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz

        
        else
            echo "no_concat"
        fi
    done
done


## genome fraction of called sites

## downsample
## New REF for pooled bees
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/qualimap/New_REF

## 1x per sample
## grep 'Andhae.New_REF'
for COV in `find -maxdepth 3 -print | grep 'Andhae.New_REF' | grep '\.0_[2-4]' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 78 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP78_1500x\t$COV \n"
done

## 1.5x per sample
## grep 'Andhae.New_REF'
for COV in `find -maxdepth 3 -print | grep 'Andhae.New_REF' | grep '\.0_[2-4]' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 117 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP117_1500x\t$COV \n"
done

## 2x per sample
## grep 'Andhae.New_REF'
for COV in `find -maxdepth 3 -print | grep 'Andhae.New_REF' | grep '\.0_[2-4]' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 156 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP156_1500x\t$COV \n"
done

## 1x per sample
## grep 'Andmar.New_REF'
for COV in `find -maxdepth 3 -print | grep 'Andmar.New_REF' | grep '\.0_[2-4]' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 80 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP80_1500x\t$COV \n"
done

## 1.5x per sample
## grep 'Andmar.New_REF'
for COV in `find -maxdepth 3 -print | grep 'Andmar.New_REF' | grep '\.0_[2-4]' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 120 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP120_1500x\t$COV \n"
done

## 2x per sample
## grep 'Andmar.New_REF'
for COV in `find -maxdepth 3 -print | grep 'Andmar.New_REF' | grep '\.0_[2-4]' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 160 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP160_1500x\t$COV \n"
done
