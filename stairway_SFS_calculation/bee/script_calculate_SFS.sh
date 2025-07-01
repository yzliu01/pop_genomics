
                                                ## vcf to sfs

# count column No
awk 'NR>1' filename
sed '1d' file.txt > newfile.txt

cd /home/yzliu/DK_proj/scripts/msprime
tail -n+7 pop_sim_output_file_xx_hap.vcf | head -1 | awk '{print NF; exit}'
tail -n+7 pop_sim_output_file_xx_hap.vcf | head
1       481     0       0       1       .       PASS    .       GT      0       1       0       0       1       1       1       0       1  1
1       996     1       0       1       .       PASS    .       GT      1       0       1       0       0       0       0       1       0  0
1       2088    2       0       1       .       PASS    .       GT      0       0       0       0       1       0       0       0       1  1

# vcf 2 sfs
# remove header lines in the first six lines
awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | awk '$1=$1' | cut -d ' ' -f 2 | tr '\n' '\t'

tail -n+7 pop_sim_output_file_xx_hap.vcf | cut -f 10- | \
    awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c | head -20

tail -n+7 pop_sim_output_file_xx_hap.vcf | cut -f 10- | head
0       1       0       0       1       1       1       0       1       1
1       0       1       0       0       0       0       1       0       0
0       0       0       0       1       0       0       0       1       1
0       0       0       0       1       0       0       0       1       1
1       0       1       0       0       0       0       1       0       0
...
## $NF the last column
tail -n+7 pop_sim_output_file_xx_hap.vcf | cut -f 10- |     awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | head -6
tail -n+7 pop_sim_output_file_xx_hap.vcf | cut -f 10- |     awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=0} 1' | awk '{print $NF}' | head -6

6
3
3
3
3
1

   1920 1
    994 2
    650 3
    489 4
    369 5
    310 6
    251 7
    266 8
    221 9

awk '$1=$1' | cut -d ' ' -f 1 | tr '\n' ' '

1920 994 650 489 369 310 251 266 221
```
## jseper's
## from .gen to sfs
## gen file data
gen_file=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb_1_1.gen
Chrom	Pos	Anc_all	Der_all	G_1_1	G_1_2	G_1_3	G_1_4	G_1_5	G_1_6	G_1_7	G_1_8	G_1_9	G_1_10
1	7428	G	T	1	0	0	0	0	0	0	0	0	0	
2	2886	C	A	0	0	0	0	0	0	1	0	0	0	
4	3734	C	A	1	0	0	1	0	1	0	0	0	1	
9	4517	C	G	0	0	0	0	0	1	1	0	0	0	
15	967	G	C	0	1	1	0	0	0	0	0	0	0	
15	2471	C	G	0	0	0	0	0	0	0	1	1	1	
19	7241	A	T	0	0	0	1	0	0	0	0	0	0	
19	8126	C	G	0	1	1	0	2	1	1	1	1	1	
23	2667	G	C	0	0	0	0	0	0	0	0	0	1	
26	9405	G	C	2	1	2	1	0	1	0	1	2	1	
32	149	G	T	0	0	0	0	0	0	0	1	1	0	
36	1787	G	C	0	0	1	0	0	0	0	0	0	0	
55	9414	G	C	0	0	0	0	0	0	0	0	0	1	
57	7730	C	T	0	1	0	0	0	0	0	0	0	0	
67	3752	G	A	0	2	1	2	1	2	1	2	1	1	
69	9643	C	G	2	2	2	1	1	2	2	1	2	2	
74	2418	G	C	1	0	0	0	0	0	0	0	0	0	
77	4899	G	A	2	1	0	2	1	2	2	2	2	2	
80	1505	G	C	0	0	1	0	1	0	0	1	0	1	
92	3702	T	C	0	1	0	0	0	0	1	1	0	0
## codes
## get genotype data columns
awk '{$1=$2=$3=$4=""; print $0}' *.gen > out
## remove header line
sed '1d' out > out1
rm out
## sum up each row
awk '{for(i=t=0;i<NF;) t+=$++i; $0=t}1' out1 > out2
rm out1
tr -s ' ' '\n' < out2 | sort | uniq -c -d > out3
rm out2
sort -n -k2 out3 > out4
rm out3
awk '{$2=""; print $0}' out4 > out5
rm out4
tr '\n' ' ' < out5 > sfs
rm out5
## try
awk '{$1=$2=$3=$4=""; print $0}' $gen_file | sed '1d' | awk '{for(i=t=0;i<NF;) t+=$++i; $0=t}1' | tr -s ' ' '\n' | \
    sort | uniq -c -d

    759 1
     61 10
     79 11
     61 12
     58 13
     56 14
     46 15
     31 16
     63 17
     38 18
     36 19
    331 2
    256 3
    174 4
    144 5
    117 6
     91 7
     90 8
     85 9
## new codes
 tail -n+7 pop_sim_output_file_xx_hap.vcf | cut -f 10- | awk '{sum=0; for(i=1; i<=NF; i++) sum += $i; print s
um}' | head
6
3
3
3
3

vcf_BomVet_REF_BomPas=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF/concated.fb_per_contig_BomVet_REF_BomPas.g600_regions.bi_MQ20_DP270_rename.vcf.gz
vcf_BomPas_REF_BomPas=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF/concated.fb_per_contig_BomPas_REF_BomPas.g600_regions.bi_MQ20_DP270_rename.vcf.gz
bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' $vcf_BomVet_REF_BomPas | less

#CHROM   POS AC  AN  DP
chr1    25042   22      58      300 # 0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1/1
chr1    25043   19      58      300
chr1    25131   23      58      495
chr1    25165   25      58      560
chr1    25218   23      58      515
chr1    25225   31      58      485
chr1    25233   36      58      457
chr1    25243   22      58      422
chr1    25255   24      58      368
chr1    25267   37      58      352

## https://unix.stackexchange.com/questions/396785/selecting-two-sets-of-conditions-in-awk
bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' $vcf_BomVet_REF_BomPas | head | awk '{if ($3 <= $4/2) print $3; if ($3 > $4/2) print $4-$3 }' |  
bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' $vcf_BomVet_REF_BomPas | head -500 | awk '{if ($3 <= $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c |awk '$1=$1'| cut -d ' ' -f 1 | tr '\n' ' '
23 6 25 53 36 49 23 22 27 19 13 16 15 12 15 13 12 11 9 13 11 13 11 13 10 6 12 8 
## do all with for loop
conda activate variant_calling_mapping
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
output_SFS_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data
for vcf_rename in `ls concated*rename.vcf.gz`
    do
    output_sfs_name=${vcf_rename/bi_MQ20_DP270_rename.vcf.gz/bi_MQ20_DP270_rename}
    bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' $vcf_rename | \
        awk '{if ($3 <= $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c | \
        awk '$1=$1'| cut -d ' ' -f 1 | tr '\n' ' ' > $output_SFS_dir/$output_sfs_name.sfs
done

for vcf_rename in `ls concated*rename.vcf.gz`
    do
    output_sfs_name=${vcf_rename/bi_MQ20_DP270_rename.vcf.gz/bi_MQ20_DP270_rename}
    bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' $vcf_rename | \
        awk '{if ($3 <= $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c
        echo $vcf_rename
done

********    "sfs for softmasked+gene_regions"   ********
## New REF ($3 <= $4/2)
## 2025
conda activate variant_calling_mapping
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
output_SFS_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data

#cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/snpEff_annotation

for vcf in `ls -t *AndMar_New_REF_AndMar*all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT*vcf.gz`
for vcf in `ls -t *BomPas_New_REF_BomHyp*all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT*vcf.gz`
for vcf in `ls -t *noMS.vcf.gz | head -12 | sort`
for vcf in `ls -t *BomVet_New_REF_BomVet*SNP_softmask_genic_bi_FMT*vcf.gz | sort`

## downsample
for vcf in `ls -t *vcf.gz | head -24 | sort`

## 2025 new pools
for vcf in `ls -t *vcf.gz | head -12 | sort`
for vcf in `ls -t concated.Rutmac*_1500x_noMS.vcf.gz | sort`

## 3 species
for vcf in `ls -t *concated*vcf.gz | head -15`

## downsample genomes
#for vcf in `ls -t *P_[0-1][0-9].vcf.gz | sort -V`

    do
    output_sfs_name=${vcf/vcf.gz/equal_self}
    bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' $vcf | \
        awk '{if ($3 <= $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c | \
        awk '$1=$1'| cut -d ' ' -f 1 | tr '\n' ' ' > $output_SFS_dir/$output_sfs_name.sfs
        ## $1=$1 is an assignment operation in awk. 
        ## It reassigns the first field ($1) to itself, which forces awk to rebuild the current line using the default output field separator (a single space).

        ## print the sfs in terminal
        echo -e $output_sfs_name.sfs"\n"
        cat $output_SFS_dir/$output_sfs_name.sfs
        echo -e "\n"
done

## simulated reads
## add AC and AN tags
sim_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/simulated_reference_genomes
bcftools +fill-tags hap_100_chr_1_10.vcf.gz -t AC,AN -Oz -o hap_100_chr_1_10.AC_AN_tags.vcf.gz
bcftools view hap_100_chr_1_10.vcf.gz -S sim_sample.list -Oz -o hap_100_chr_1_10.AC_AN_tags.vcf.gz
## get biallelic SNPs
bcftools view -m2 -M2 hap_100_chr_1_10.vcf.gz -S sim_sample.list | bcftools filter -e 'AC==0 || AC == AN' | bcftools view -Oz -o hap_100_chr_1_10.bi_SNPs.AC_AN_tags.vcf.gz

less hap_100_chr_1_10.bi_SNPs.AC_AN_tags.vcf.gz | wc -l
2084577

sample=$(cat sim_sample.list | tr "\n" ",")
bcftools view hap_100_chr_1_10.vcf.gz -s tsk_0,tsk_1,tsk_2,tsk_3,tsk_4,tsk_5,tsk_6,tsk_7,tsk_8,tsk_9,tsk_10,tsk_11,tsk_12,tsk_13,tsk_14,tsk_15,tsk_16,tsk_17,tsk_18,tsk_19,tsk_20,tsk_21,tsk_22,tsk_23,tsk_24,tsk_25,tsk_26,tsk_27,tsk_28,tsk_29,tsk_30,tsk_31,tsk_32,tsk_33,tsk_34,tsk_35,tsk_36,tsk_37,tsk_38,tsk_39,tsk_40,tsk_41,tsk_42,tsk_43,tsk_44,tsk_45,tsk_46,tsk_47,tsk_48,tsk_49,tsk_50,tsk_51,tsk_52,tsk_53,tsk_54,tsk_55,tsk_56,tsk_57,tsk_58,tsk_59,tsk_60,tsk_61,tsk_62,tsk_63,tsk_64,tsk_65,tsk_66,tsk_67,tsk_68,tsk_69,tsk_70,tsk_71,tsk_72,tsk_73,tsk_74,tsk_75,tsk_76,tsk_77,tsk_78,tsk_79,tsk_80,tsk_81,tsk_82,tsk_83,tsk_84,tsk_85,tsk_86,tsk_87,tsk_88,tsk_89,tsk_90,tsk_91,tsk_92,tsk_93,tsk_94,tsk_95,tsk_96,tsk_97,tsk_98,tsk_99 \
| less -S
bcftools view hap_100_chr_1_10.vcf.gz -s tsk_0,tsk_1 -Oz -o hap_100_chr_1_10.AC_AN_tags.vcf.gz

bcftools query -f '%CHROM\t%POS\t%AC\t%AN' hap_100_chr_1_10.AC_AN_tags.vcf.gz | less -S

# 1       7328791 14147   G       C,A     .       PASS    AC=0,1;AN=100   GT 

for vcf in `ls hap_100_chr_1_10.bi_SNPs.AC_AN_tags.vcf.gz`

    do
    output_sfs_name=${vcf/vcf.gz/equal_self}
    bcftools query -f '%CHROM\t%POS\t%AC\t%AN' $vcf | \
        awk '{if ($3 <= $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c | \
        awk '$1=$1'| cut -d ' ' -f 1 | tr '\n' ' ' > ./sfs/$output_sfs_name.sfs
        ## $1=$1 is an assignment operation in awk. 
        ## It reassigns the first field ($1) to itself, which forces awk to rebuild the current line using the default output field separator (a single space).
        
        ## print the sfs in terminal
        echo -e $output_sfs_name.sfs"\n"
        cat ./sfs/$output_sfs_name.sfs
        echo -e "\n"
done


********** output SFS in terminal ***********

## https://unix.stackexchange.com/questions/513131/how-to-get-the-files-name-and-content-in-the-terminal-for-all-files-in-a-direc
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data
ls -t *softmask_genic_bi_FMT*_1500x_noMS.equal_self.sfs | head -36 | sort -V | xargs head


## softmask - AndMar
for vcf in `ls *AndMar_New_REF_AndMar*all_chr.sorted.GQ_issue_solved.SNP_softmask_bi_FMT*vcf.gz`
    do
    output_sfs_name=${vcf/vcf.gz/equal_self}
    bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' $vcf | \
        awk '{if ($3 <= $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c | \
        awk '$1=$1'| cut -d ' ' -f 1 | tr '\n' ' ' > $output_SFS_dir/$output_sfs_name.sfs
done


## pas-pas-200x
vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF

vcf_ann=concated.Bompas.New_REF_BomPas.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_softmasked_bi_FMT_DP200_noMS_AO3.ann_no_mis.vcf.gz
vcf_ann=concated.Andhae.New_REF_BomPas.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_softmasked_bi_FMT_DP200_noMS_AO3.ann_no_mis.vcf.gz
vcf_ann=concated.Andhae.New_REF_AndHae.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_softmasked_bi_FMT_DP200_noMS_AO3.ann_no_mis.vcf.gz

bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' $vcf_ann | \
        awk '{if ($3 <= $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c

********** each group sfs count **********
for vcf in `ls *all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT*vcf.gz`
## low depth
for vcf in `ls -t *all_chr.sorted.*vcf.gz | head -24`
    do
    output_sfs_name=${vcf/vcf.gz/equal_self}
    bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' $vcf | \
    #echo -e "$vcf_softmask_ann\n"
        awk '{if ($3 <= $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c \
        > $output_SFS_dir/$output_sfs_name.sfs.count
done

******************************************

## New_REF_DroMel
vcf=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_gatk_vcf/conc_vcf/concated_dro_mel_all_chr.sorted_chr.SNP_hard_filter.MQ40_masked_bi_AC1_FMT_DP3_noMS.BP_CS.list.vcf.gz
bcftools index $vcf
bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' $vcf | awk '{if ($3 <= $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | less -S
bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' $vcf | awk '{if ($3 <= $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V > BP_CS.list_equal.sfs

output_SFS_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_gatk_vcf/SFS_data
for vcf in `ls *softmasked*list.vcf.gz`
    do
    output_sfs_name=${vcf/vcf.gz/equal_self}
    bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' $vcf | \
        awk '{if ($3 <= $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c | \
        awk '$1=$1'| cut -d ' ' -f 1 | tr '\n' ' ' > $output_SFS_dir/$output_sfs_name.sfs
done

## calculate sum of sites
## https://stackoverflow.com/questions/33006845/how-to-sum-a-row-of-numbers-from-text-file-bash-shell-scripting
awk 'NR == 3{c=0;for(i=1;i<=NF;++i){c+=$i};print $0, "Sum:", c}' \
/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_gatk_vcf/easy_SFS/fastsimcoal2/dro_mel_New_REF_SB_RP.pop.list_MSFS.obs
## New REF
awk 'NR == 1{c=0;for(i=1;i<=NF;++i){c+=$i};print $0, "Sum:", c}' concated.Andhae.New_REF_AndHae.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_masked_bi_FMT_DP200_noMS_AO3.equal_self.sfs
## 2666 3050 3529 70067 98376 79382 65285 55824 48856 43201 39099 35214 32157 29398 27450 25431 24830 23321 22039 21667 20605 19647 18932 18410 17801 17102 17021 16561 16296 16077 15939 15770 15800 15568 15448 15329 15366 15357 7538  Sum: 1061409
awk 'NR == 1{c=0;for(i=1;i<=NF;++i){c+=$i};print $0, "Sum:", c}' concated.Andhae.New_REF_AndHae.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_softmasked_bi_FMT_DP200_noMS_AO3.equal_self.sfs
## count SNP number
less /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF/concated.fb_per_contig_BomVet_REF_BomPas.g1500x_regions.all_chr.sorted_chr.vcf.gz.bi_MQ20_DP160_1500.vcf.gz |\
 grep -v '^#' | wc -l

## NR > 160 && NR < 1500
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
vcf_pas=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF/concated.fb_per_contig_BomPas_REF_BomPas.g1500x_regions.all_chr.sorted_chr.vcf.gz.bi_MQ20_DP160_1500.vcf.gz
vcf_vet=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF/concated.fb_per_contig_BomVet_REF_BomPas.g1500x_regions.all_chr.sorted_chr.vcf.gz.bi_MQ20_DP160_1500.vcf.gz

for vcf_rename in `ls concated.fb_per_contig_BomVet_REF_BomPas*g1500x_regions*bi_MQ20_DP160_1500.vcf.gz`
    do
    output_sfs_name=${vcf_rename/bi_MQ20_DP270_rename.vcf.gz/bi_MQ20_DP270_rename}
    bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' $vcf_rename | \
        awk '{if ($3 < $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c
        echo $vcf_rename
done
