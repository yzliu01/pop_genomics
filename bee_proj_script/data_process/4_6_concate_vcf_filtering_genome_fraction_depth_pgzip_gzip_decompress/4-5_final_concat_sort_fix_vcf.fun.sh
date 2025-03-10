#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 4
#SBATCH --mem 50g
##SBATCH --array=1-1%1
#SBATCH --time=08:15:00
#SBATCH --error=6_concat_index_vcf.%A_%a.e
#SBATCH --output=6_concat_index_vcf.%A_%a.o
#SBATCH --job-name=6_concat_index_vcf
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## concat vcf II
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf
#ls *individual_100kb_1500x*.list
vcf_list=(
   "AndHae_New_REF_AndHae.individual_100kb_1500x_region_vcf_file.list"
   ##"AndHae_New_REF_AndHat.individual_100kb_1500x_region_vcf_file.list"
   ##"AndHae_New_REF_BomPas.individual_100kb_1500x_region_vcf_file.list"
   ##"AndMar_New_REF_AndHae.individual_100kb_1500x_region_vcf_file.list"
   ##"AndMar_New_REF_AndHat.individual_100kb_1500x_region_vcf_file.list"
   #"AndMar_New_REF_AndMar.individual_100kb_1500x_region_vcf_file.list"
   ##"AndMar_New_REF_BomPas.individual_100kb_1500x_region_vcf_file.list"
   ##"BomPas_New_REF_ApisMel.individual_100kb_1500x_region_vcf_file.list"
   #"BomPas_New_REF_BomHyp.individual_100kb_1500x_region_vcf_file.list"
   #"BomPas_New_REF_BomPas.individual_100kb_1500x_region_vcf_file.list"
   ##"BomVet_New_REF_ApisMel.individual_100kb_1500x_region_vcf_file.list"
   ##"BomVet_New_REF_BomHyp.individual_100kb_1500x_region_vcf_file.list"
   #"BomVet_New_REF_BomPas.individual_100kb_1500x_region_vcf_file.list"
)

fun_concat_vcf_II(){
for species_vcf in  ${vcf_list[@]}
    do
    echo "concat vcf: $species_vcf"
    concat_vcf=${species_vcf/.individual_100kb_1500x_region_vcf_file.list/.100kb_g1500x_regions}
    vcf-concat --files $species_vcf | bgzip -c > ./concated_vcf_each_species_REF/concated.$concat_vcf.vcf.gz
done
}

# GQ_issue_solved
fun_concat_vcf_II(){
for species_vcf in  ${vcf_list[@]}
    do
    echo "concat vcf: $species_vcf"
    concat_vcf=${species_vcf/.individual_100kb_1500x_region_vcf_file.list/.100kb_g1500x_regions}
    vcf-concat --files $species_vcf | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$concat_vcf.GQ_issue_solved.vcf.gz
    # index vcf
    bcftools index ./concated_vcf_each_species_REF/concated.$concat_vcf.GQ_issue_solved.vcf.gz
done
}

## execute function
fun_concat_vcf_II

exit 0

vcf-concat --files AndHae_New_REF_AndHae.individual_100kb_1500x_region_vcf_file.list | \
bgzip -c > ./concated_vcf_each_species_REF/concated.AndHae_New_REF_AndHae.xxx.vcf.gz

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

#ls ./fb_per_region_AndMar_New_REF_AndMar/Andmar.New_REF_AndMar.100kb_1500x_region_*.g.vcf | sort -V > AndMar_New_REF_AndMar.individual_100kb_1500x_region_vcf_file.list

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf
mv Andmar*g.vcf ./fb_per_region_AndMar_New_REF_AndMar

vcf_list1=BomPas_New_REF_BomPas.individual_100kb_1500x_region_vcf_file.list
vcf_list2=BomVet_New_REF_BomPas.individual_100kb_1500x_region_vcf_file.list
vcf_list3=AndHae_New_REF_AndHae.individual_100kb_1500x_region_vcf_file.list
vcf_list4=AndMar_New_REF_AndHae.individual_100kb_1500x_region_vcf_file.list
vcf_list5=AndMar_New_REF_AndMar.individual_100kb_1500x_region_vcf_file.list
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

***************************************************************************************
## concat vcf I
## save vcf file per region into a file
species_dir=(
            "fb_per_contig_AndMar_REF_AndHatt"
            "fb_per_contig_AndHae_REF_AndHatt"
            "fb_per_contig_AndMar_REF_BomPas"
            "fb_per_contig_BomVet_REF_ApisMel"
            "fb_per_contig_AndHae_REF_BomPas" 
            "fb_per_contig_BomPas_REF_ApisMel"
            "fb_per_contig_BomVet_REF_BomHyp"
            "fb_per_contig_AndMar_REF_AndHae" 
            "fb_per_contig_BomPas_REF_BomHyp"

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

## rename concatenated vcf file
rename_vcf(){
    rename .100kb 100kb *100kb_1500x_region.list.vcf.gz
    rename region.list regions *100kb_1500x_region.list.vcf.gz
    rename 1500x g1500x *100kb_1500x_regions.vcf.gz

}
rename_vcf

## issued vcf
## reorder the chromosome order
conda activate gatk_4.3.0.0
## already in the PATH
export PATH="/home/yzliu/bin/gatk_4.3.0.0/gatk-4.3.0.0/:$PATH"

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
## New_REF
/concated.BomPas_New_REF_BomHyp.100kb_1500x_regions.vcf.gz
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

vcf_list=(
            #"concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.all_chr.sorted_chr.vcf.gz"
            "concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.all_chr.sorted.vcf.gz"
            "concated.BomPas_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.vcf.gz"
)
## replace "Integer" with "Float" using for loop
for vcf in `ls *all_chr.sorted.vcf.gz`
for vcf in `ls *AndMar_New_REF_AndMar*all_chr.sorted.vcf.gz`

modify_vcf_GQ_issue(){
#for vcf in `ls -t concated.BomPas_New_REF_BomHyp*all_chr.sorted.vcf.gz | head -8`
#for vcf in `ls -t *all_chr.sorted.vcf.gz | head -8`
for vcf in ${vcf_list[@]}

do
echo $vcf
#done

    #output_vcf=${vcf/sorted.vcf.gz/sorted.GQ_issue_solved.vcf}
    output_vcf=${vcf/sorted.vcf.gz/sorted.GQ_issue_solved.vcf.gz}
    ## pigz is faster than gzip
    ## https://www.baeldung.com/linux/gzip-and-gunzip
    #pigz -d -k -c $vcf > $output_vcf
    #sed -i 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' $output_vcf
    #sed -i 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' $output_vcf | bgzip -f

    ## -f: Force overwrite, compress .gz, links, and to terminal
    #pigz -f $output_vcf > $output_vcf.gz
    #bgzip -f $output_vcf

    # one step
    pigz -d -c -k -f $vcf | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -f -c > $output_vcf


done
}

## execute function
modify_vcf_GQ_issue


for vcf in "concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz" \
             "concated.BomPas_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz"
do
#echo $vcf
#done
out_vcf=${vcf/.gz/}
pigz -d -f $vcf
# required for bcftools
bgzip -f $out_vcf
done
