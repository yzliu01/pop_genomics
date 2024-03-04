## https://www.biostars.org/p/330140/

htsfile Amel_HAv3_1.zip

conda create -c conda-forge --name snpEff snpeff
conda activate snpEff
snpEff -Xmx8g databases -h
snpEff -Xmx8g build -h
## create databases
java -Xmx8g -jar /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/snpEff.jar build -dataDir /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data -gtf22 -v AndHae_GCA_910592295.1
snpEff -Xmx8g build -dataDir /home/yzliu/miniforge3/envs/snpEff/share/snpeff-5.2-0/data \
    -gtf22 -v AndHae_GCA_910592295.1

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