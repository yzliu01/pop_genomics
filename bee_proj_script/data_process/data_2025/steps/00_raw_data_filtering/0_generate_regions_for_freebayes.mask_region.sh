
# script from freebayes: https://github.com/freebayes/freebayes/tree/master/scripts
# fasta_generate_regions.py

conda activate variant_calling_mapping
cd /data/ref_genome
Regions_New=/data/ref_genome/fasta_generate_regions/chr_regions
REF_list=(
            "Andrena_fulva-GCA_946251845.1-softmasked.fa"
            "Andrena_trimmerana-GCA_951215215.1-softmasked.fa"
            "Bombus_hortorum-GCA_905332935.1-softmasked.fa"
            "Bombus_hortorum-GCA_905332935.1-softmasked.fa"
            "Bombus_confusus-GCA_014737475.1_ASM1473747v1-softmasked.fa"
            "Bombus_confusus-GCA_014737475.1_ASM1473747v1-softmasked.fa"
            "Bombus_muscorum-GCA_963971185.1.fa"
            "Andrena_bicolor-GCA_960531205.1.fa"
            "Bombus_sylvestris-GCA_911622165.2-softmasked.fa"
            "Bombus_veteranus.hifi_asm_pl2.fa"
            )


for Ref_New in ${REF_list[@]}
    do
    #echo $Ref_New
#done
    Out_Region_Name=${Ref_New/.fa/.fb_100kb.regions}
    fasta_generate_regions.py $Ref_New 100000 > $Regions_New/$Out_Region_Name
done
