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

grep -E -v '^#|GT:GQ:DP:AD:RO:QR:AO:QA' Bompas.REF_BomPas.g1500x_10kb_fb.10kbp.regions.*.fb.qual_20.g.vcf
grep -E -v '^#|GT:GQ:DP:AD:RO:QR:AO:QA' Bomvet.REF_BomPas.g1500x_10kb_fb.10kbp.regions.*.fb.qual_20.g.vcf
****************************************************************************************


## https://cyverse.atlassian.net/wiki/spaces/DEapps/pages/259063974/vcftools-merge+0.1.16
## https://vcftools.sourceforge.net/perl_module.html

conda activate variant_calling_mapping
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/fb_per_contig_BomVet_REF_BomHyp
vcf-concat -h
## g600_chunks (having duplicates)
ls *g600_10kb_fb_*vcf > BomVet_REF_BomHyp.individual_fb_vcf_file.list

vcf-concat Bomvet.REF_BomHypn.g600_10kb_fb_chr1.qual_20.g.vcf Bomvet.REF_BomHypn.g600_10kb_fb_chr2.qual_20.g.vcf | bgzip -c > concated_fb_chr_1_2.vcf.gz

vcf_list=BomVet_REF_BomHyp.individual_fb_vcf_file.list
vcf-concat --files $vcf_list | bgzip -c > concated_fb_all_chr.vcf.gz

ls *g1500x_10kb_fb*g.vcf > Bompas_REF_BomPas.individual_fb_g1500x_vcf_file.list
ls *g1500x_10kb_fb*g.vcf > Bomvet_REF_BomPas.individual_fb_g1500x_vcf_file.list
vcf_list=Bompas_REF_BomPas.individual_fb_g1500x_vcf_file.list
vcf_list=Bomvet_REF_BomPas.individual_fb_g1500x_vcf_file.list
vcf-concat --files $vcf_list | bgzip -c > ../concated_vcf_each_species_REF/concated.fb_per_contig_BomPas_REF_BomPas.g1500x_regions.vcf.list.vcf.gz
vcf-concat --files $vcf_list | bgzip -c > ../concated_vcf_each_species_REF/concated.fb_per_contig_BomVet_REF_BomPas.g1500x_regions.vcf.list.vcf.gz

## sort chromosome order with SortVcf (indexed automatically)
conda activate gatk_4.3.0.0
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
gatk --list
gatk SortVcf --INPUT concated_fb_all_chr.vcf.gz --OUTPUT concated_fb_all_chr.sorted_chr.vcf.gz
less -S concated_fb_all_chr.sorted_chr.vcf.gz

## 1500x
gatk SortVcf --INPUT concated.fb_per_contig_BomPas_REF_BomPas.g1500x_regions.vcf.list.vcf.gz --OUTPUT concated.fb_per_contig_BomPas_REF_BomPas.g1500x_regions.all_chr.sorted_chr.vcf.gz
gatk SortVcf --INPUT concated.fb_per_contig_BomVet_REF_BomPas.g1500x_regions.vcf.list.vcf.gz --OUTPUT concated.fb_per_contig_BomVet_REF_BomPas.g1500x_regions.all_chr.sorted_chr.vcf.gz


## g600_regions
ls *g600*regions*vcf > BomVet_REF_BomHyp.individual_fb.g600_100_regions.vcf_file.list
vcf_list=BomVet_REF_BomHyp.individual_fb.g600_100_regions.vcf_file.list
conda activate variant_calling_mapping
vcf-concat --files $vcf_list | bgzip -c > concated_fb_all_chr.g600_100_regions.vcf.gz
conda activate gatk_4.3.0.0
gatk SortVcf --INPUT concated_fb_all_chr.g600_100_regions.vcf.gz --OUTPUT concated_fb_all_chr.g600_100_regions.sorted_chr.vcf.gz

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf
## list only directory in a folder
species_dir=("fb_per_contig_AndHae_REF_AndHae" "fb_per_contig_AndMar_REF_AndHatt" "fb_per_contig_BomPas_REF_BomPas"
            "fb_per_contig_AndHae_REF_AndHatt" "fb_per_contig_AndMar_REF_BomPas" "fb_per_contig_BomVet_REF_ApisMel"
            "fb_per_contig_AndHae_REF_BomPas" "fb_per_contig_BomPas_REF_ApisMel" "fb_per_contig_BomVet_REF_BomHyp"
            "fb_per_contig_AndMar_REF_AndHae" "fb_per_contig_BomPas_REF_BomHyp" "fb_per_contig_BomVet_REF_BomPas"
)
species_dir=("fb_per_contig_BomPas_REF_BomPas" "fb_per_contig_AndHae_REF_AndHae")
species_dir=("fb_per_contig_BomVet_REF_BomPas")
## save vcf file per region into a file
for vcf in ${species_dir[*]};
    do ls ./$vcf/*g600*regions*vcf > ./$vcf.g600_regions.vcf.list
done
## concate each vcf file
vcf_list=fb_per_contig_BomVet_REF_BomPas.g600_regions.vcf.list
conda activate variant_calling_mapping
vcf-concat --files $vcf_list | bgzip -c > concated_fb_all_chr.g600_100_regions.vcf.gz

conda activate gatk_4.3.0.0
gatk SortVcf --INPUT concated_fb_all_chr.g600_100_regions.vcf.gz --OUTPUT concated_fb_all_chr.g600_100_regions.sorted_chr.vcf.gz

## for all
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf
ls *g600*.list
vcf_list=("fb_per_contig_AndHae_REF_AndHae.g600_regions.vcf.list" "fb_per_contig_BomPas_REF_ApisMel.g600_regions.vcf.list"
        "fb_per_contig_AndHae_REF_AndHatt.g600_regions.vcf.list" "fb_per_contig_BomPas_REF_BomHyp.g600_regions.vcf.list"
        "fb_per_contig_AndHae_REF_BomPas.g600_regions.vcf.list" "fb_per_contig_BomPas_REF_BomPas.g600_regions.vcf.list"
        "fb_per_contig_AndMar_REF_AndHae.g600_regions.vcf.list" "fb_per_contig_BomVet_REF_ApisMel.g600_regions.vcf.list"
        "fb_per_contig_AndMar_REF_AndHatt.g600_regions.vcf.list" "fb_per_contig_BomVet_REF_BomHyp.g600_regions.vcf.list"
        "fb_per_contig_AndMar_REF_BomPas.g600_regions.vcf.list"
)
## issued vcf files
vcf_list=("fb_per_contig_BomVet_REF_BomPas.g600_regions.vcf.list"
    #"fb_per_contig_BomPas_REF_BomHyp.g600_regions.vcf.list" "fb_per_contig_BomPas_REF_BomPas.g600_regions.vcf.list"
)
## not available yet:  "fb_per_contig_BomVet_REF_BomPas.g600_regions.vcf.list"
for species_vcf in  ${vcf_list[*]}
    do vcf-concat --files $species_vcf | bgzip -c > ./concated_vcf_each_species_REF/concated.$species_vcf.vcf.gz
done

## reorder the chromosome order
conda activate gatk_4.3.0.0
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
for vcf in `ls concated*.g600_regions.vcf.list.vcf.gz`
    do 
    vcf_sorted_chr=${vcf/.vcf.list.vcf.gz/}
    gatk SortVcf --INPUT $vcf --OUTPUT $vcf_sorted_chr.sorted_chr.vcf.gz
done

## issued vcf
## concated.fb_per_contig_BomPas_REF_BomHyp.g600_regions.vcf.list.md.vcf.gz
for vcf in `ls *BomVet_REF_BomPas*g600_regions.vcf.list.vcf.gz`
    do 
    vcf_sorted_chr=${vcf/.vcf.list.vcf.gz/}
    gatk SortVcf --INPUT $vcf --OUTPUT $vcf_sorted_chr.sorted_chr.vcf.gz
done

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
        bcftools view -i 'INFO/DP > 600' $vcf > xx.vcf

        bcftools filter --SnpGap 10:indel | \
        bcftools view --types snps --min-alleles 2 --max-alleles 2 -i 'INFO/AO > 2' xx.$vcf | \
#        bcftools norm -d none -f $REF_BomPas | \
        bcftools +setGT -- -t q -n . -i 'FMT/DP=0' | \
        bcftools filter -e 'AC==0 || AC == AN' | \
        bcftools filter -e --mask-file file.bed | \
        bcftools view -e 'F_MISSING > 0' | \
        -Oz -o ./$out_vcf_prefix.bi_MQ20_DP160_1500.vcf.gz
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
    
## example of output query data
chr1    66849   502     502     60      Andmar_pool1    GQ=11   DP=502  TYPE=SNP
chr1    68097   469     469     59.9393 Andmar_pool1    GQ=21   DP=469  TYPE=SNP
chr1    99914   548     548     58.9736 Andmar_pool1    GQ=19   DP=548  TYPE=SNP
chr1    116296  570     573     60      Andmar_pool1    GQ=12   DP=570  TYPE=SNP
chr1    117038  525     525     60      Andmar_pool1    GQ=11   DP=525  TYPE=SNP
chr1    123741  515     515     60      Andmar_pool1    GQ=11   DP=515  TYPE=SNP
chr1    197577  561     561     60      Andmar_pool1    GQ=12   DP=561  TYPE=SNP
chr1    247579  584     584     59.9229 Andmar_pool1    GQ=13   DP=584  TYPE=SNP
chr1    327127  572     572     59.9891 Andmar_pool1    GQ=17   DP=572  TYPE=SNP
chr1    337434  527     527     60      Andmar_pool1    GQ=11   DP=527  TYPE=SNP

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

## calculate genome fraction covered by reads
## total number of bases with depth > 9
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/samtools_stats
BomVet_BomPas_COV=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/qualimap/Bomvet.REF_BomPas.sort.marked_dups.new.bam/raw_data_qualimapReport/coverage_histogram.txt
BomPas_BomPas_COV=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/qualimap/Bompas.REF_BomPas.sort.marked_dups.new.bam/raw_data_qualimapReport/coverage_histogram.txt

awk -F " " 'NR > 7 && NR < 10 {sum+=$2}END{print sum}' $BomVet_BomPas_COV

## right expression
for COV in `find -maxdepth 3 -print | grep 'coverage_histogram.txt'`
    do
    sed '1d' $COV | awk -F " " 'NR > 280 && NR < 600 {sum+=$2}END{print sum}'
    printf "$COV \n"
done

## NR > 160 && NR < 1500
for COV in `find -maxdepth 2 -print | grep 'coverage_histogram.txt'`
    do
    sed '1d' $COV | awk -F " " 'NR > 160 && NR < 1500 {sum+=$2}END{print sum}'
    printf "$COV \n"
done
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/qualimap/Bomvet.REF_BomPas.sort.marked_dups.new.bam

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
less /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF/concated.fb_per_contig_BomVet_REF_BomPas.g1500x_regions.all_chr.sorted_chr.vcf.gz.bi_MQ20_DP160_1500.vcf.gz | grep -v '^#' | wc -l
## balteatus
vcf_SE_BomBal=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/BAL/new_variant_calling_ploidy/combined_vcf_genotyping/gatk_17haploid_54diploid_B_bal.SNP_hard_filtered.DP3_GQ20_biSNP.missing05_DP3_1000_Excesshet25.vcf.gz
sample_list=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/BAL/new_variant_calling_ploidy/combined_vcf_genotyping/subpop_list/bal_12_DP_13X_SMC.txt
bcftools view -S $sample_list $vcf_SE_BomBal | bcftools filter -e 'AC==0 || AC == AN' | bcftools view -e 'F_MISSING > 0'| bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' | awk '{if ($3 < $4/2) print $3; 
if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c

# qualimap data bal
cp -r AC-002* AC-022* AC-152* M_L024* M_L032* M_L033* M_L049* M_L137* M_L149* M_L190* M_L195* M_L198* ./subset_qualimap/
sample_mon_list=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy/combined_vcf_genotyping/Fst_pop_list/mon_10F_X15.list
vcf_mon=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy/combined_vcf_genotyping/gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP.minorAC2_maleHet_missing05_DP3_3134_Excesshet25.mon_76_27M_49F.vcf.gz

# qualimap data lap
cp -r M_L018* M_L021* M_L138* M_L180* M_L194* AC-006* AC-138* WO_003* WO_006* WO_383* WO_448* WO_449* WO_703* BH_11* subset_qualimap_lap
vcf_lap=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy/combined_vcf_genotyping/gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP.minorAC2_maleHet_missing05_DP3_3134_Excesshet25.lap_128_62M_66F.vcf.gz
sample_lap_list=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy/combined_vcf_genotyping/Fst_pop_list/lap_11F_X15.list

cd ./subset_qualimap/
for COV in `find -maxdepth 3 -print | grep 'coverage_histogram.txt'`
    do
    sed '1d' $COV | awk -F " " 'NR > 3 && NR < 3134 {sum+=$2}END{print sum}'
    printf "$COV \n"
done
## DP 220 - 1000
for COV in `find -maxdepth 3 -print | grep 'coverage_histogram.txt'`
    do
    sed '1d' $COV | awk -F " " 'NR > 16 && NR < 1000 {sum+=$2}END{print sum}'
    printf "$COV \n"
done
bcftools view -S $sample_lap_list $vcf_lap | bcftools filter -e 'AC==0 || AC == AN' | bcftools view -e 'F_MISSING > 0'| bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' | awk '{if ($3 < $4/2) print $3; 
if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c

# qualimap data mon
cp -r M_L119* AC-020* AC-021* AC-034* M_L210* M_L213* BH_07* BH_08* BH_09* BH_16* ./subset_qualimap_mon
sample_mon_list=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy/combined_vcf_genotyping/Fst_pop_list/mon_10F_X15.list

cd ./subset_qualimap/
for COV in `find -maxdepth 3 -print | grep 'coverage_histogram.txt'`
    do
    sed '1d' $COV | awk -F " " 'NR > 3 && NR < 3134 {sum+=$2}END{print sum}'
    printf "$COV \n"
done

bcftools view -S $sample_mon_list $vcf_mon | bcftools filter -e 'AC==0 || AC == AN' | bcftools view -e 'F_MISSING > 0'| bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' | awk '{if ($3 < $4/2) print $3; 
if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c

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
