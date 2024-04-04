
## https://pcingola.github.io/SnpEff/snpeff/build_db/
## Step 1: Configure a new genome

# Andrena haemorrhoa genome, version AndHae_GCA_910592295.1
AndHae_GCA_910592295.1.genome : AndHae

# Andrena hattorfiana genome, version AndHat_GCA_944738655.1
AndHat_GCA_944738655.1.genome : AndHat

# Bombus hypnorum genome, version BomHyp_GCA_911387925.1
BomHyp_GCA_911387925.1.genome : BomHyp
 
# Bombus pascuorum genome, version BomPas_GCA_905332965.1
BomPas_GCA_905332965.1.genome : BomPas

# Apis mellifera genome, version Amel_HAv3_1
Amel_HAv3_1.genome : ApisMel

# Drosophila melanogaster genome, version DroMel_GCF_000001215.4_Release_6_plus_ISO1_MT
DroMel_GCF_000001215.4_Release_6_plus_ISO1_MT.genome : DroMel



## https://www.biostars.org/p/330140/

htsfile Amel_HAv3_1.zip

conda create -c conda-forge --name snpEff snpeff
conda activate snpEff
snpEff -Xmx8g databases -h
snpEff -Xmx8g build -h
## Step 2, Option 1: Building a database from GTF files
## create databases
java -Xmx8g -jar /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/snpEff.jar build -dataDir /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data -gtf22 -v AndHae_GCA_910592295.1
snpEff -Xmx8g build -dataDir /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data \
    -gtf22 -noCheckProtein -v AndHae_GCA_910592295.1

snpEff -Xmx8g build -dataDir /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data \
    -gtf22 -noCheckProtein -v AndHat_GCA_944738655.1

snpEff -Xmx8g build -dataDir /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data \
    -gtf22 -noCheckProtein -v BomHyp_GCA_911387925.1

snpEff -Xmx8g build -dataDir /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data \
    -gtf22 -noCheckProtein -v BomPas_GCA_905332965.1

snpEff -Xmx8g build -dataDir /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data \
    -gtf22 -noCheckCds -noCheckProtein -v Amel_HAv3_1

snpEff -Xmx8g build -dataDir /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data \
    -gtf22 -noCheckCds -noCheckProtein -v DroMel_GCF_000001215.4_Release_6_plus_ISO1_MT

****************************************
        Protein check:  AndHae_GCA_910592295.1  OK: 0   Not found: 19301        Errors: 0       Error percentage: NaN%
00:00:12        Protein sequences comparison failed!
ERROR: Database check failed.
00:00:12 Logging
00:00:13 Checking for updates...
00:00:14 Done.

## skip checking cds and protein
for ref in "Amel_HAv3_1" "AndHat_GCA_944738655.1" "BomHyp_GCA_911387925.1" "BomPas_GCA_905332965.1" "DeoMel_7509v1";
    do echo $ref;
done
##  working
## echo ${REF1_list[*]}
ref_list=("Amel_HAv3_1" "AndHat_GCA_944738655.1" "BomHyp_GCA_911387925.1" "BomPas_GCA_905332965.1" "DeoMel_7509v1")
for ref in ${ref_list[*]};
    do echo $ref;
done
snpEff -Xmx8g build -dataDir /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data \
    -noCheckCds -noCheckProtein -gtf22 -v BomPas_GCA_905332965.1

for ref in "Amel_HAv3_1" "AndHat_GCA_944738655.1" "BomHyp_GCA_911387925.1" "BomPas_GCA_905332965.1" "DroMel_7509v1";
    do snpEff -Xmx8g build -dataDir /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data \
    -noCheckCds -noCheckProtein -gtf22 -v $ref;
done

conda activate snpEff
vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
Bompas_New_REF_BomPas=concated.Bompas.New_REF_BomPas.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_softmasked_bi_FMT_DP200_noMS_AO3.vcf.gz
Bompas_New_REF_BomPas_ann=${Bompas_New_REF_BomPas/vcf.gz/ann_no_mis.vcf.gz}

Bomvet_New_REF_BomPas=concated.Bomvet.New_REF_BomPas.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_softmasked_bi_FMT_DP200_noMS_AO3.vcf.gz
Bomvet_New_REF_BomPas_ann=${Bomvet_New_REF_BomPas/vcf.gz/ann_no_mis.vcf.gz}

Andhae_New_REF_AndHae=concated.Andhae.New_REF_AndHae.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_softmasked_bi_FMT_DP200_noMS_AO3.vcf.gz
Andhae_New_REF_AndHae_ann=${Andhae_New_REF_AndHae/vcf.gz/ann_no_mis.vcf.gz}

Andhae_New_REF_BomPas=concated.Andhae.New_REF_BomPas.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_softmasked_bi_FMT_DP200_noMS_AO3.vcf.gz
Andhae_New_REF_BomPas_ann=${Andhae_New_REF_BomPas/vcf.gz/ann_no_mis.vcf.gz}

Bompas_New_REF_ApisMel=concated.Bompas.New_REF_ApisMel.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_softmasked_bi_FMT_DP200_noMS_AO3.vcf.gz
Bompas_New_REF_ApisMel_ann=${Bompas_New_REF_ApisMel/vcf.gz/ann_no_mis.vcf.gz}

Bomvet_New_REF_ApisMel=concated.Bomvet.New_REF_ApisMel.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_softmasked_bi_FMT_DP200_noMS_AO3.vcf.gz
Bomvet_New_REF_ApisMel_ann=${Bomvet_New_REF_ApisMel/vcf.gz/ann_no_mis.vcf.gz}

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/snpEff_annotation
time snpEff -Xmx8g ann -v BomPas_GCA_905332965.1 $vcf_dir/$Bompas_New_REF_BomPas -s Bompas_New_REF_BomPas_ann_summary.html| \
    grep -v 'missense' | gzip > ./$Bompas_New_REF_BomPas_ann

time snpEff -Xmx8g ann -v BomPas_GCA_905332965.1 $vcf_dir/$Bomvet_New_REF_BomPas -s Bomvet_New_REF_BomPas_ann_summary.html| \
    grep -v 'missense' | gzip > ./$Bomvet_New_REF_BomPas_ann

time snpEff -Xmx8g ann -v BomPas_GCA_905332965.1 $vcf_dir/$Andhae_New_REF_BomPas -s Andhae_New_REF_AndHae_ann_summary.html| \
    grep -v 'missense' | gzip > ./$Andhae_New_REF_BomPas_ann 2> ./Andhae_New_REF_BomPas_ann_err

time snpEff -Xmx8g ann -v AndHae_GCA_910592295.1 $vcf_dir/$Andhae_New_REF_AndHae -s Andhae_New_REF_AndHae_ann_summary.html| \
    grep -v 'missense' | gzip > ./$Andhae_New_REF_AndHae_ann 2> Andhae_New_REF_AndHae_ann_err

time snpEff -Xmx8g ann -v Amel_HAv3_1 $vcf_dir/$Bompas_New_REF_ApisMel -s Bompas_New_REF_ApisMel_ann_summary.html| \
    grep -v 'missense' | gzip > ./$Bompas_New_REF_ApisMel_ann

time snpEff -Xmx8g ann -v Amel_HAv3_1 $vcf_dir/$Bomvet_New_REF_ApisMel -s Bomvet_New_REF_ApisMel_ann_summary.html| \
    grep -v 'missense' | gzip > ./$Bomvet_New_REF_ApisMel_ann

snpEff_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/snpEff_annotation
## without missense variants
less -S $snpEff_dir/concated.Bompas.New_REF_BomPas.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_softmasked_bi_FMT_DP200_noMS_AO3.snpEff.ann.vcf.gz | grep -v '#' | wc -l
2025836
## missense variants
less -S $snpEff_dir/concated.Bompas.New_REF_BomPas.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_softmasked_bi_FMT_DP200_noMS_AO3.snpEff.ann | grep 'missense' | wc -l
15080
## all No. of annitation of variant
less -S $snpEff_dir/concated.Bompas.New_REF_BomPas.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_softmasked_bi_FMT_DP200_noMS_AO3.snpEff.ann | grep -v '#' | wc -l
2040916
## all variants
vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
less concated.Bompas.New_REF_BomPas.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_softmasked_bi_FMT_DP200_noMS_AO3.vcf.gz | grep -v '#' | wc -l
2040916
        

