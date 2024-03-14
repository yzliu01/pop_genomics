
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
1
1
1
2
1
v
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
chr1    25291   27      58      303
chr1    25294   22      58      292
chr1    30041   42      58      274
chr1    32262   40      58      375
chr1    34030   3       58      487
chr1    34045   55      58      494
chr1    34135   5       58      470
chr1    34714   8       58      339
chr1    35971   6       58      459
chr1    36052   3       58      529
chr1    36534   57      58      386
chr1    36614   38      58      515
chr1    37848   11      58      272
chr1    37922   10      58      482
chr1    38085   8       58      558
chr1    42014   8       58      526
chr1    42130   9       58      543
chr1    43438   6       58      524

## https://unix.stackexchange.com/questions/396785/selecting-two-sets-of-conditions-in-awk
bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' $vcf_BomVet_REF_BomPas | head | awk '{if ($3 < $4/2) print $3; if ($3 > $4/2) print $4-$3 }' |  
bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' $vcf_BomVet_REF_BomPas | head -500 | awk '{if ($3 < $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c |awk '$1=$1'| cut -d ' ' -f 1 | tr '\n' ' '
23 6 25 53 36 49 23 22 27 19 13 16 15 12 15 13 12 11 9 13 11 13 11 13 10 6 12 8 
## do all with for loop
conda activate variant_calling_mapping
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
output_SFS_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data
for vcf_rename in `ls concated*rename.vcf.gz`
    do
    output_sfs_name=${vcf_rename/bi_MQ20_DP270_rename.vcf.gz/bi_MQ20_DP270_rename}
    bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' $vcf_rename | \
        awk '{if ($3 < $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c | \
        awk '$1=$1'| cut -d ' ' -f 1 | tr '\n' ' ' > $output_SFS_dir/$output_sfs_name.sfs
done

for vcf_rename in `ls concated*rename.vcf.gz`
    do
    output_sfs_name=${vcf_rename/bi_MQ20_DP270_rename.vcf.gz/bi_MQ20_DP270_rename}
    bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' $vcf_rename | \
        awk '{if ($3 < $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c
        echo $vcf_rename
done

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
