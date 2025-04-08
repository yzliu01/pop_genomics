## https://cyverse.atlassian.net/wiki/spaces/DEapps/pages/259063974/vcftools-merge+0.1.16
## https://vcftools.sourceforge.net/perl_module.html

conda activate variant_calling_mapping
#vcf-concat -h

## suggestion from Jeppe
## concatenate (having duplicates?)
vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/
cd $vcf_dir

## 2025 poolseq

ls ./fb_per_region_RutMac_REF_RutMac/Rutmac.REF_RutMac.100kb_1500x_region_*.g.vcf | sort -V > Rutmac.REF_RutMac.individual_100kb_1500x_region_vcf_file.list
ls ./fb_per_region_MegLea_REF_MegLea/Meglea.REF_MegLea.100kb_1500x_region_*.g.vcf | sort -V > Meglea.REF_MegLea.individual_100kb_1500x_region_vcf_file.list
ls ./fb_per_region_CerRyb_REF_CerRyb/Cerryb.REF_CerRyb.100kb_1500x_region_*.g.vcf | sort -V > Cerryb.REF_CerRyb.individual_100kb_1500x_region_vcf_file.list

for vcf_list in $(ls -t *.list | head -3 | sort)
    do
    conc_name="${vcf_list/.individual_100kb_1500x_region_vcf_file.list/}" # better
    conc_name="${vcf_list/.100kb_1500x_region_vcf_file.list/}"
    #for dir in `ls -t -d fb_per_region* | head -4 | sort`
    for dir in `ls -t -d fb_per_region* | head -3 | sort`
        do
#        echo $dir
#    done
#done
        ## when meet multiple condition
        ## false one
        if [[ $vcf_list == *BomPas*New_REF_BomPas* && $dir == fb_per_region*BomPas*New_REF_BomPas* ]]
        then
            echo $vcf_list $dir
            ## attention to the directory
            #cd $dir
            ## https://github.com/samtools/bcftools/issues/420
            ## [E::vcf_parse_format_fill5] Invalid character '.' in 'GQ' FORMAT field at 1:4484
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz
            ##cd ..

        ## 2025 test mean depth ~200x (30-40% sampling reads - 2x depth)
        elif [[ $vcf_list == Rutmac.REF_RutMac.individual_100kb_1500x_region_vcf_file.list && $dir == fb_per_region_RutMac_REF_RutMac ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz

        elif [[ $vcf_list == Meglea.REF_MegLea.individual_100kb_1500x_region_vcf_file.list && $dir == fb_per_region_MegLea_REF_MegLea ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz

        elif [[ $vcf_list == Cerryb.REF_CerRyb.individual_100kb_1500x_region_vcf_file.list && $dir == fb_per_region_CerRyb_REF_CerRyb ]]
        then
            echo $vcf_list $dir
            time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.vcf.gz

        # others (downsample)
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


******************** genome fraction of called sites ********************
## downsample
## New REF for pooled bees
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/qualimap/New_REF
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/qualimap/data_2025

## new pools 2025
# 1.5x
# 50*2*1.5=150
for COV in `find -maxdepth 3 -print | grep '.REF_' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 150 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP_1.5x_1500x\t$COV \n"
done

# 2x
# 50*2*2=200
for COV in `find -maxdepth 3 -print | grep '.REF_' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 200 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP_2x_1500x\t$COV \n"
done

# 2.5x
# 50*2*2.5=250
for COV in `find -maxdepth 3 -print | grep '.REF_' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 250 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP_2.5x_1500x\t$COV \n"
done

*************** systematic analyses **************
# 1x
# 50*2*1=100
for COV in `find -maxdepth 3 -print | grep '.REF_' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 100 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP_1x\t$COV \n"
done

# 3x
# 50*2*3=300
for COV in `find -maxdepth 3 -print | grep '.REF_' | grep 'coverage_histogram.txt' | sort -V`
    do
    #awk -F " " 'NR >= 300 && NR < 1500 {total_DP+=$1*$2;sum_loc+=$2;last_col1=$1; last_col2=$2} END {if (sum_loc > 0) print last_col1 "\t" last_col2 "\t" total_DP "\t" sum_loc "\tmean: "total_DP/sum_loc}' $COV | tr -d '\n'
    #sed '1d' $COV | awk -F " " 'NR > 300 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    awk -F " " 'NR >= 300 && NR < 1503 {total_DP+=$1*$2;sum_loc+=$2;last_col1=$1; last_col2=$2} END {if (sum_loc > 0) print "mean: "total_DP/sum_loc}' $COV | tr -d '\n'    
    printf "\tDP_3x\t$COV \n"
done


# 5x
# 50*2*5=500
for COV in `find -maxdepth 3 -print | grep '.REF_' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 500 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP_5x\t$COV \n"
done


# 7x
# 50*2*7=700
for COV in `find -maxdepth 3 -print | grep '.REF_' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 700 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP_7x\t$COV \n"
done

# 10x
# 50*2*10=1000
for COV in `find -maxdepth 3 -print | grep '.REF_' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 1000 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP_10x\t$COV \n"
done







COV_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/samtools_stats
COV_01=Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_100b.shuf_subset_01.sort.depth
COV_02=Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_100b.shuf_subset_02.sort.depth
COV_03=Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_100b.shuf_subset_03.sort.depth

sed '1d' $COV | awk -F "[ \t]+" 'NR > 1 && NR < 6 {total_DP+=$1*$2;sum_loc+=$2;last_col1=$1; last_col2=$2} END {if (sum_loc > 0) print last_col1 "\t" last_col2 "\t" total_DP "\t" sum_loc "\tmean: "total_DP/sum_loc}'
awk -F "[ \t]+" '$3 >= 234 && $3 < 1500 {sum+=$3;i++} END {if (i>0) print "mean: " sum/i; else print "no data"}' $COV_01
566.922
awk -F "[ \t]+" '$3 >= 234 && $3 < 1500 {sum+=$3;i++} END {if (i>0) print "mean: " sum/i; else print "no data"}' $COV_02
566.398
awk -F "[ \t]+" '$3 >= 234 && $3 < 1500 {sum+=$3;i++} END {if (i>0) print "mean: " sum/i; else print "no data"}' $COV_03
566.381

for cov in ${ls Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.*.shuf_subset_*.depth}
do
awk -F "[ \t]+" '$3 >= 234 && $3 < 1500 {sum+=$3;i++} END {if (i>0) print "mean: " sum/i; else print "no data"}' $cov
done

COV=./Bombus_veteranus.hifi_asm_pl2.fa.fai.win_100b.shuf_subset_09/raw_data_qualimapReport/coverage_histogram.txt
sed '1d' $COV | awk -F " " 'NR > 1 && NR < 6 {total_DP+=$1*$2;sum_loc+=$2;last_col1=$1; last_col2=$2} END {if (sum_loc > 0) print last_col1 "\t" last_col2 "\t" total_DP "\t" sum_loc "\tmean: "total_DP/sum_loc}'

sed '1d' $COV | awk -F " " 'NR == 1 {print}'
0.0     166742.0
sed '1d' $COV | awk -F " " 'NR < 5 {print}'
0.0     166742.0
1.0     108595.0
2.0     85024.0
3.0     75365.0

sed '1d' $COV | awk -F " " 'NR < 6 {print}'
0.0     166742.0
1.0     108595.0
2.0     85024.0
3.0     75365.0
4.0     69284.0

