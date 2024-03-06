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

sed '1!{/##fileformat=VCFv4.2/d}' $issued_vcf > $vcf_dir/$ok_vcf

sed -i '1!{/##fileformat=VCFv4.2/d}' $issued_vcf

## fb_per_contig_BomPas_REF_BomHyp
vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/fb_per_contig_BomPas_REF_BomHyp
issued_vcf=$vcf_dir/*g600_10kb_fb.10kbp.regions*.vcf
for vcf in ${issued_vcf[*]}
    do
    sed -i '1!{/##fileformat=VCFv4.2/d}' $vcf
done

## Another issue
grep -E '^#|GT:GQ:DP:AD:RO:QR:AO:QA' Bompas.REF_BomHypn.g600_10kb_fb.10kbp.regions.084.fb.qual_20.g.vcf| less -S
grep -E '^#|GT:GQ:DP:AD:RO:QR:AO:QA' Bompas.REF_BomHypn.g600_10kb_fb.10kbp.regions.084.fb.qual_20.g.vcf > \
    Bompas.REF_BomHypn.g600_10kb_fb.10kbp.regions.084.fb.qual_20.md.g.vcf| bgzip -c >
## check lines without these
grep -E -v '^#|GT:GQ:DP:AD:RO:QR:AO:QA' Bomvet.REF_BomPas.g600_10kb_fb.10kbp.regions.*.fb.qual_20.g.vcf

less concated.fb_per_contig_BomPas_REF_BomHyp.g600_regions.vcf.list.vcf.gz | grep -E '^#|GT:GQ:DP:AD:RO:QR:AO:QA' | bgzip -c > \
    concated.fb_per_contig_BomPas_REF_BomHyp.g600_regions.vcf.list.md.vcf.gz

****************************************************************************************


## https://cyverse.atlassian.net/wiki/spaces/DEapps/pages/259063974/vcftools-merge+0.1.16
## https://vcftools.sourceforge.net/perl_module.html

conda activate variant_calling_mapping
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/fb_per_contig_BomVet_REF_BomHyp
vcf-concat -h
## g600_chunks (having duplicates)
ls *g600_10kb_fb_*vcf > BomVet_REF_BomHyp.individual_fb_vcf_file.list

vcf-concat Bomvet.REF_BomHypn.g600_10kb_fb_chr1.qual_20.g.vcf Bomvet.REF_BomHypn.g600_10kb_f
b_chr2.qual_20.g.vcf | bgzip -c > concated_fb_chr_1_2.vcf.gz
vcf_list=BomVet_REF_BomHyp.individual_fb_vcf_file.list
vcf-concat --files $vcf_list | bgzip -c > concated_fb_all_chr.vcf.gz

## sort chromosome order with SortVcf (indexed automatically)
conda activate gatk_4.3.0.0
gatk --list
gatk SortVcf --INPUT concated_fb_all_chr.vcf.gz --OUTPUT concated_fb_all_chr.sorted_chr.vcf.gz
less -S concated_fb_all_chr.sorted_chr.vcf.gz

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
    "concated.fb_per_contig_BomVet_REF_BomPas.g600_regions.vcf.list.vcf.gz"
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

## total number of bases with depth > 9
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
