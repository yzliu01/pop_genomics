#!/bin/sh
##SBATCH --cpus-per-task 20
#SBATCH --mem 20g
##SBATCH --array=1-10%10
#SBATCH --array=10%1
##SBATCH --time=00:10:00
#SBATCH --time=06:00:00
#SBATCH --error=concate_vcf_10_species.%A_%a.e
#SBATCH --output=concate_vcf_10_species.%A_%a.o
#SBATCH --job-name=concate_vcf_10_species
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## https://cyverse.atlassian.net/wiki/spaces/DEapps/pages/259063974/vcftools-merge+0.1.16
## https://vcftools.sourceforge.net/perl_module.html
## concat vcf files: "bcftools concate" or "vcf-concat" -h
## using sed: the first item in the array starts with 1 instead of 0

## concatenate (having duplicates due to smaller number of genome pieces?)
vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/
cd $vcf_dir

## 2025 poolseq
## search for a first vcf file
#find . -maxdepth 2 -type f -name '*100kb_1500x_region_1.g.vcf' -exec ls -th {} + | head | sort

## rename vcf files from early run
#rename Cerryb.REF_CerRyb CerRyb_REF_CerRyb *Cerryb.REF_CerRyb*g.vcf
#rename Meglea.REF_MegLea MegLea_REF_MegLea *Meglea.REF_MegLea*g.vcf
#rename Rutmac.REF_RutMac RutMac_REF_RutMac *Rutmac.REF_RutMac*g.vcf

## new vcf file names
#./fb_per_region_SteMel_REF_SteMel/SteMel_REF_SteMel.100kb_1500x_region_13923.g.vcf

## save vcf file names for 10 species in a file, separately, in terminal
#ls ./fb_per_region_AphSti_REF_AphSti/AphSti_REF_AphSti.100kb_1500x_region_*.g.vcf | sort -V > AphSti_REF_AphSti.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_BomMaj_REF_BomMaj/BomMaj_REF_BomMaj.100kb_1500x_region_*.g.vcf | sort -V > BomMaj_REF_BomMaj.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_CerRyb_REF_CerRyb/CerRyb_REF_CerRyb.100kb_1500x_region_*.g.vcf | sort -V > CerRyb_REF_CerRyb.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_EphDan_REF_EphDan/EphDan_REF_EphDan.100kb_1500x_region_*.g.vcf | sort -V > EphDan_REF_EphDan.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_MegLea_REF_MegLea/MegLea_REF_MegLea.100kb_1500x_region_*.g.vcf | sort -V > MegLea_REF_MegLea.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_NotGla_REF_NotGla/NotGla_REF_NotGla.100kb_1500x_region_*.g.vcf | sort -V > NotGla_REF_NotGla.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_OchPle_REF_OchPle/OchPle_REF_OchPle.100kb_1500x_region_*.g.vcf | sort -V > OchPle_REF_OchPle.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_PhrFul_REF_PhrFul/PhrFul_REF_PhrFul.100kb_1500x_region_*.g.vcf | sort -V > PhrFul_REF_PhrFul.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_RutMac_REF_RutMac/RutMac_REF_RutMac.100kb_1500x_region_*.g.vcf | sort -V > RutMac_REF_RutMac.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_SteMel_REF_SteMel/SteMel_REF_SteMel.100kb_1500x_region_*.g.vcf | sort -V > SteMel_REF_SteMel.100kb_1500x_region_vcf_file.list

## 21 rest pools
#ls ./fb_per_region_AelAcu_REF_AelAcu/AelAcu_REF_AelAcu.100kb_1500x_region_*.g.vcf | sort -V > AelAcu_REF_AelAcu.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_AgeAln_REF_AgeAln/AgeAln_REF_AgeAln.100kb_1500x_region_*.g.vcf | sort -V > AgeAln_REF_AgeAln.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_AmpSol_REF_AmpSol/AmpSol_REF_AmpSol.100kb_1500x_region_*.g.vcf | sort -V > AmpSol_REF_AmpSol.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_BibMar_REF_BibMar/BibMar_REF_BibMar.100kb_1500x_region_*.g.vcf | sort -V > BibMar_REF_BibMar.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_DorPar_REF_DorPar/DorPar_REF_DorPar.100kb_1500x_region_*.g.vcf | sort -V > DorPar_REF_DorPar.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_EriInt_REF_EriInt/EriInt_REF_EriInt.100kb_1500x_region_*.g.vcf | sort -V > EriInt_REF_EriInt.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_EriPer_REF_EriPer/EriPer_REF_EriPer.100kb_1500x_region_*.g.vcf | sort -V > EriPer_REF_EriPer.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_GerLac_REF_GerLac/GerLac_REF_GerLac.100kb_1500x_region_*.g.vcf | sort -V > GerLac_REF_GerLac.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_LasMor_REF_LasMor/LasMor_REF_LasMor.100kb_1500x_region_*.g.vcf | sort -V > LasMor_REF_LasMor.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_LepDol_REF_LepDol/LepDol_REF_LepDol.100kb_1500x_region_*.g.vcf | sort -V > LepDol_REF_LepDol.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_MalBip_REF_MalBip/MalBip_REF_MalBip.100kb_1500x_region_*.g.vcf | sort -V > MalBip_REF_MalBip.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_MysLon_REF_MysLon/MysLon_REF_MysLon.100kb_1500x_region_*.g.vcf | sort -V > MysLon_REF_MysLon.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_NocPro_REF_NocPro/NocPro_REF_NocPro.100kb_1500x_region_*.g.vcf | sort -V > NocPro_REF_NocPro.100kb_1500x_region_vcf_file.list
## no grasshoppers
#ls ./fb_per_region_PanBan_REF_PanBan/PanBan_REF_PanBan.100kb_1500x_region_*.g.vcf | sort -V > PanBan_REF_PanBan.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_PhoAtr_REF_PhoAtr/PhoAtr_REF_PhoAtr.100kb_1500x_region_*.g.vcf | sort -V > PhoAtr_REF_PhoAtr.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_PorSca_REF_PorSca/PorSca_REF_PorSca.100kb_1500x_region_*.g.vcf | sort -V > PorSca_REF_PorSca.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_PteNig_REF_PtgNig/PteNig_REF_PtgNig.100kb_1500x_region_*.g.vcf | sort -V > PteNig_REF_PtgNig.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_RhaFul_REF_RhaFul/RhaFul_REF_RhaFul.100kb_1500x_region_*.g.vcf | sort -V > RhaFul_REF_RhaFul.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_TacFer_REF_TacFer/TacFer_REF_TacFer.100kb_1500x_region_*.g.vcf | sort -V > TacFer_REF_TacFer.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_ThoDec_REF_ThoDec/ThoDec_REF_ThoDec.100kb_1500x_region_*.g.vcf | sort -V > ThoDec_REF_ThoDec.100kb_1500x_region_vcf_file.list
#ls ./fb_per_region_XesNig_REF_XesNig/XesNig_REF_XesNig.100kb_1500x_region_*.g.vcf | sort -V > XesNig_REF_XesNig.100kb_1500x_region_vcf_file.list

vcf_list_file=(
# early 10 pools
AphSti_REF_AphSti.100kb_1500x_region_vcf_file.list
BomMaj_REF_BomMaj.100kb_1500x_region_vcf_file.list
CerRyb_REF_CerRyb.100kb_1500x_region_vcf_file.list
EphDan_REF_EphDan.100kb_1500x_region_vcf_file.list
MegLea_REF_MegLea.100kb_1500x_region_vcf_file.list
NotGla_REF_NotGla.100kb_1500x_region_vcf_file.list
OchPle_REF_OchPle.100kb_1500x_region_vcf_file.list
PhrFul_REF_PhrFul.100kb_1500x_region_vcf_file.list
RutMac_REF_RutMac.100kb_1500x_region_vcf_file.list
SteMel_REF_SteMel.100kb_1500x_region_vcf_file.list

# 21 rest pools {add # in front of the uppercase letters: enter (^[A-Z]) in Find, enter #$1 or #${1} in Replace}

#AelAcu_REF_AelAcu.100kb_1500x_region_vcf_file.list
#AgeAln_REF_AgeAln.100kb_1500x_region_vcf_file.list
#AmpSol_REF_AmpSol.100kb_1500x_region_vcf_file.list
##AphSti_REF_AphSti.100kb_1500x_region_vcf_file.list
#BibMar_REF_BibMar.100kb_1500x_region_vcf_file.list
##BomMaj_REF_BomMaj.100kb_1500x_region_vcf_file.list
##CerRyb_REF_CerRyb.100kb_1500x_region_vcf_file.list
#DorPar_REF_DorPar.100kb_1500x_region_vcf_file.list
##EphDan_REF_EphDan.100kb_1500x_region_vcf_file.list
#EriInt_REF_EriInt.100kb_1500x_region_vcf_file.list
#EriPer_REF_EriPer.100kb_1500x_region_vcf_file.list
#GerLac_REF_GerLac.100kb_1500x_region_vcf_file.list
#LasMor_REF_LasMor.100kb_1500x_region_vcf_file.list
#LepDol_REF_LepDol.100kb_1500x_region_vcf_file.list
#MalBip_REF_MalBip.100kb_1500x_region_vcf_file.list
##MegLea_REF_MegLea.100kb_1500x_region_vcf_file.list
#MysLon_REF_MysLon.100kb_1500x_region_vcf_file.list
#NocPro_REF_NocPro.100kb_1500x_region_vcf_file.list
##NotGla_REF_NotGla.100kb_1500x_region_vcf_file.list
##OchPle_REF_OchPle.100kb_1500x_region_vcf_file.list
## no grasshoppers
#PanBan_REF_PanBan.100kb_1500x_region_vcf_file.list
#PhoAtr_REF_PhoAtr.100kb_1500x_region_vcf_file.list
##PhrFul_REF_PhrFul.100kb_1500x_region_vcf_file.list
#PorSca_REF_PorSca.100kb_1500x_region_vcf_file.list
#PteNig_REF_PtgNig.100kb_1500x_region_vcf_file.list
#RhaFul_REF_RhaFul.100kb_1500x_region_vcf_file.list
##RutMac_REF_RutMac.100kb_1500x_region_vcf_file.list
##SteMel_REF_SteMel.100kb_1500x_region_vcf_file.list
#TacFer_REF_TacFer.100kb_1500x_region_vcf_file.list
#ThoDec_REF_ThoDec.100kb_1500x_region_vcf_file.list
#XesNig_REF_XesNig.100kb_1500x_region_vcf_file.list
)

## new way (100kb_g1500x_region)
vcf_list=$(echo ${vcf_list_file[@]} | tr " " "\n" | sed -n ${SLURM_ARRAY_TASK_ID}p)
## echo ${vcf_list[10]}
## outfile names
output_vcf=${vcf_list/_vcf_file.list/.vcf.gz}
## SteMel_REF_SteMel.100kb_1500x_region.vcf.gz
echo "concating: $vcf_list"
## use --file-list not --files
## similarly here: /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/data_2025/downsample_bam/4_5_2024_bam_and_genome_read_downsample_concate_vcf_filtering_genome_fraction_depth_pgzip_gzip_decompress.sh
time bcftools concat --file-list $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/$output_vcf
time bcftools index ./concated_vcf_each_species_REF/$output_vcf

## run subset vcf afterward
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/job_submission
sbatch /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/data_2025/steps/456_concate_vcf_genome_fraction_bam_stats/6_2025_10_pools_get_vcf_ind.DP_1x_1.5x_2x_old_3x_5x_7x_10x.filtering_fun_sort_files_by_names_sizes.sh

exit 0





## check file size and sort files by their names
ls -lht ./concated_vcf_each_species_REF | head -31 | sort -k9 | less -N

#    sort -t ' ' is unnecessary because ls -l already uses spaces as delimiters by default.
#    If filenames contain spaces, use ls -lh | sort -k9 -b to ignore leading blanks.
#    For recursive listing (subdirectories), add -R to ls.


## old way (100kb_g1500x_regions)
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
# 1x
# 50*2*1=100
for COV in `find -maxdepth 3 -print | grep '.REF_' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 100 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP_1x_1500x\t$COV \n"
done

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


## much earlier test

# 2.5x
# 50*2*2.5=250
for COV in `find -maxdepth 3 -print | grep '.REF_' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 250 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP_2.5x_1500x\t$COV \n"
done

# 3x
# 50*2*3=300
for COV in `find -maxdepth 3 -print | grep '.REF_' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 300 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP_3x_1500x\t$COV \n"
done

# 4x
# 50*2*4=400
for COV in `find -maxdepth 3 -print | grep '.REF_' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 400 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP_4x_1500x\t$COV \n"
done

# 5x
# 50*2*5=500
for COV in `find -maxdepth 3 -print | grep '.REF_' | grep 'coverage_histogram.txt' | sort -V`
    do
    sed '1d' $COV | awk -F " " 'NR > 500 && NR < 1500 {sum+=$2}END{print sum}' | tr -d '\n'
    printf "\tDP_5x_1500x\t$COV \n"
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

