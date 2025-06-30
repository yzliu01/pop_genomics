#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 4
#SBATCH --mem 200g
##SBATCH --array=1-1%1
#SBATCH --time=06:15:00
##SBATCH --time=16:30:00
#SBATCH --error=4-6_new_mapping_gatk_sort_BomPas_REF_BomMus.%A_%a.e
#SBATCH --output=4-6_new_mapping_gatk_sort_BomPas_REF_BomMus.%A_%a.o
#SBATCH --job-name=4-6_new_mapping_gatk_sort_BomPas_REF_BomMus
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com


## Step II: reorder the chromosome order
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate gatk_4.3.0.0
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
## New_REF New_mapping
#for vcf in `ls concated*.100kb_g1500x_regions.vcf.gz`
#for vcf in `ls -t concated*.100kb_g1500x_regions.vcf.gz | head -4`
for vcf in "concated.BomPas_New_alt_REF_BomMus.100kb_g1500x_regions.vcf.gz" # more mem
    do 
    vcf_sorted_chr=${vcf/.vcf.gz/}
    java -Xmx200G -jar /home/yzliu/bin/gatk_4.3.0.0/gatk-4.3.0.0/gatk-package-4.3.0.0-local.jar SortVcf --INPUT $vcf --OUTPUT $vcf_sorted_chr.all_chr.sorted.new.vcf.gz
done

conda activate variant_calling_mapping
bcftools index $vcf_sorted_chr.all_chr.sorted.new.vcf.gz


exit 0

# above not working, but below working
original_script_with_issue=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/4_6_concate_vcf_filtering_genome_fraction_depth_pgzip_gzip_decompress/6_get_vcf_related_species_DP_3x_5x_7x_filtering_fun_careful_bcftools_norm_a_d_flags.sh
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF

## run this separately due to isssues for this vcf (working)
vcf_list=BomPas_New_alt_REF_BomMus.individual_100kb_1500x_region_vcf_file.list
conc_name="${vcf_list/.individual_100kb_1500x_region_vcf_file.list/}"
time vcf-concat --files $vcf_list | sed 's/ID=GQ,Number=1,Type=Integer/ID=GQ,Number=1,Type=Float/' | bgzip -c > ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.new_1.vcf.gz

cp concated.BomPas_New_alt_REF_BomMus.100kb_g1500x_regions.new_1.vcf concated.BomPas_New_alt_REF_BomMus.100kb_g1500x_regions.cp_new_1.vcf
bgzip -d ./concated_vcf_each_species_REF/concated.$conc_name.100kb_g1500x_regions.new_1.vcf.gz
bgzip concated.BomPas_New_alt_REF_BomMus.100kb_g1500x_regions.cp_new_1.vcf -k -i
# -i, --index                compress and create BGZF index
# bgzip --reindex (re)index compressed file
bgzip -r concated.BomPas_New_alt_REF_BomMus.100kb_g1500x_regions.cp_new_1.vcf.gz
#concated.BomPas_New_alt_REF_BomMus.100kb_g1500x_regions.cp_new_1.vcf.gz.gzi

Bompas_New_alt_REF_BomMus_VCF_filter=${Bompas_New_alt_REF_BomMus_VCF/.vcf.gz/}

#zcat concated.BomPas_New_alt_REF_BomMus.100kb_g1500x_regions.vcf.gz | grep -v '^$' | bgzip > concated.BomPas_New_alt_REF_BomMus.100kb_g1500x_regions.cleaned.vcf.gz
## alternative
# | awk 'NF' \
