#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 8
#SBATCH --mem 80g
#SBATCH --array=1-60%30
#SBATCH --time=03-03:14:00
#SBATCH --error=ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb_5rep.%A.e.txt
#SBATCH --output=ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb_5rep.%A.o.txt
#SBATCH --job-name=ft_3_rep5
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## run parallel jobs
#cd /home/yzliu/DK_proj/steps/
#mkdir systematic_ftsm_test
## check No. of par file of 1 chromosome test
#ls $par_folder/*5Chr*.par | wc -l
#24
cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep
fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne
## test par
#par=$par_folder/ft_sim_1000Ne_20dipS_1E_50G_1d_20Chr_15Mb.par
par=$(ls $par_folder/ft_sim_100000Ne*1E_*20Chr_15Mb.par | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
$fsc -i $par -n 5 -q -s 0 -m --foldedSFS -c 8 -g -G -k 300000000

exit

## alternative way of parallel job
## This function is to run the job in parallel, submitting each contig to a core for up to $1q contigs at a time
function pwait() {
    while [ $(jobs -p | wc -l) -ge $1 ]; do
    sleep $2
    done
}

par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test1
fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
## create a function for running fastsimcoal in for loop
run_fastsimcoal(){
    for par in `ls $par_folder/*1Chr*.par | sort -V`; do
        pwait 10 10s # set the number of cores and the wait time here
        $fsc -i $par -n1 -q -s0 -d --foldedSFS -c 6 -G -k 20000000;
    done
    wait
}
#run_fastsimcoal


exit


## create par file
for i in {20,80,200};do
## sample size 20 haploid genomes -> 10 diploid workers
    for j in {01,05,09};do
    ## magnitute of declines 10%, 50%, 90%
        for k in {50,100,500,1000};do
        ## x generations ago
        cp ft_sim_10000Ne_"$i"hapS_1E_50G_01d_20Chr_15Mb.par ft_sim_10000Ne_"$i"hapS_1E_"$k"G_"$j"d_20Chr_15Mb.par
        done
    done
done



## [Replacing string in text file based on line number](https://unix.stackexchange.com/questions/70878/replacing-string-based-on-line-number)
## generations(50,100,500,1000)
for sample in {20,80,200};do
    sed -i '13s/50 0 0 0 1.10 0 0/100 0 0 0 1.10 0 0/g' ft_sim_100000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par;
done

for sample in {20,80,200};do
    sed -i '13s/50 0 0 0 1.10 0 0/500 0 0 0 1.10 0 0/g' ft_sim_10000Ne_"$sample"hapS_1E_500G_01d_20Chr_15Mb.par;
done

for sample in {20,80,200};do
    sed -i '13s/50 0 0 0 1.10 0 0/1000 0 0 0 1.10 0 0/g' ft_sim_10000Ne_"$sample"hapS_1E_1000G_01d_20Chr_15Mb.par;
done

## declines(01,05,09), using double qute
for generation in {50,100,500,1000};do
    sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.50 0 0/g" ft_sim_100000Ne_20hapS_1E_"$generation"G_05d_20Chr_15Mb.par;
done
for generation in {50,100,500,1000};do
    sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.90 0 0/g" ft_sim_100000Ne_20hapS_1E_"$generation"G_09d_20Chr_15Mb.par;
done

for generation in {50,100,500,1000};do
    sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.50 0 0/g" ft_sim_100000Ne_80hapS_1E_"$generation"G_05d_20Chr_15Mb.par;
done
for generation in {50,100,500,1000};do
    sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.90 0 0/g" ft_sim_100000Ne_80hapS_1E_"$generation"G_09d_20Chr_15Mb.par;
done

for generation in {50,100,500,1000};do
    sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.50 0 0/g" ft_sim_100000Ne_200hapS_1E_"$generation"G_05d_20Chr_15Mb.par;
done
for generation in {50,100,500,1000};do
    sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.90 0 0/g" ft_sim_100000Ne_200hapS_1E_"$generation"G_09d_20Chr_15Mb.par;
done

## 100000Ne
## change file names
cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3
cp -r 10000Ne 100000Ne
cd ..
cp -r 100000Ne 1000000Ne
for Ne in `ls ft_sim_100000Ne*1E*20Chr_15Mb.par`;do
    sed -i "4s/100000/1000000/" $Ne;
    rename "100000Ne" "1000000Ne" $Ne;
done

## manually prepare 
ft_sim_100000Ne_80hapS_1E_50G_00d_20Chr_15Mb.par
ft_sim_100000Ne_80hapS_1E_100G_00d_20Chr_15Mb.par
ft_sim_100000Ne_80hapS_1E_500G_00d_20Chr_15Mb.par
ft_sim_100000Ne_80hapS_1E_1000G_00d_20Chr_15Mb.par

for g in {50,100,500,1000};do
    cp ft_sim_100000Ne_20hapS_1E_"$g"G_00d_20Chr_15Mb.par ft_sim_100000Ne_20hapS_1E_"$g"G_05i_20Chr_15Mb.par;
done

for g in {50,100,500,1000};do
    cp ft_sim_100000Ne_80hapS_1E_"$g"G_00d_20Chr_15Mb.par ft_sim_100000Ne_80hapS_1E_"$g"G_05i_20Chr_15Mb.par;
done

for g in {50,100,500,1000};do
    cp ft_sim_100000Ne_200hapS_1E_"$g"G_00d_20Chr_15Mb.par ft_sim_100000Ne_200hapS_1E_"$g"G_05i_20Chr_15Mb.par;
done
## change history event in increasing pop
for generation in {50,100,500,1000};do
    sed -i "13s/$generation 0 0 0 1.0 0 0/$generation 0 0 0 -1.50 0 0/g" ft_sim_100000Ne_200hapS_1E_"$generation"G_05i_20Chr_15Mb.par;
done

for generation in {50,100,500,1000};do
    sed -i "13s/$generation 0 0 0 1.0 0 0/$generation 0 0 0 -1.50 0 0/g" ft_sim_100000Ne_80hapS_1E_"$generation"G_05i_20Chr_15Mb.par;
done

for generation in {50,100,500,1000};do
    sed -i "13s/$generation 0 0 0 1.0 0 0/$generation 0 0 0 -1.50 0 0/g" ft_sim_100000Ne_20hapS_1E_"$generation"G_05i_20Chr_15Mb.par;
done

## copy 00d from one to another
cp /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne/*00d_*Mb.par \
/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/1000000Ne
## rename files
for par_i in `ls *00d_*Mb.par`;do     rename 100000Ne 10000Ne $par_i; done
## modify Ne in line 4
for par_i in `ls *00d_*Mb.par`;do     sed -i -e '4s/100000/10000/' $par_i; done


## [How do I rename files with spaces using the Linux shell?](https://superuser.com/questions/295994/how-do-i-rename-files-with-spaces-using-the-linux-shell)
## deal with space
for f in *\ *; do mv "$f" "${f// /_}";done
for i in `ls *_copy.par`;do rename 500G 5000G $i;done
for i in `ls *_50D_*`;do cp $i $i-;done

## make par file for 10 percent declines, rename files and replace event parameters by following codes
for i in `ls *10D*.par`; do sed -i -e '13s/100 0 0 0 50 0 0/100 0 0 0 10 0 0/' -e '14s/500 0 0 0 50 0 0/500 0 0 0 10 0 0/' -e '15s/15000 0 0 0 50 0 0/15000 0 0 0 10 0 0/' $i;done

## navigate to specific folders
## diploid genotype table to vcf
cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne
cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/1000000Ne_5rep
cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep
cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep

############################### run of 5 replicates ######################################
## 10 diploid samples
for rep in {1..5};do
    for gen_table in `find -print | grep "15Mb-" | grep "$rep.gen$"`;do
        ## ft_sim_dir=ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb-
        ## gen_table=ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb_1_1.gen
        gen_table_new=$gen_table.new
        gen_table_new_vcf=$gen_table_new.vcf

        awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' $gen_table > $gen_table_new

        sed '1d' $gen_table_new | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | \
        sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' | \
        sed '$d' > $gen_table_new_vcf
    done
done
## files generated
ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_5.gen.new.vcf
ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_4.gen.new.vcf
...
ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1.gen.new.vcf
############################### a single run ######################################
## 10 diploid samples
for gen_table in `find -print | grep "15Mb-" | grep '.gen$'`;do
    ## ft_sim_dir=ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb-
    ## gen_table=ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb_1_1.gen
    gen_table_new=$gen_table.new
    gen_table_new_vcf=$gen_table_new.vcf

    awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' $gen_table > $gen_table_new

    sed '1d' $gen_table_new | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | \
    sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' | \
    sed '$d' > $gen_table_new_vcf
done

############################### run of 5 replicates ######################################
## 40 diploid samples
for rep in {1..5};do
    for gen_table in `find -print | grep "15Mb-" | grep "$rep.gen$"`;do
        ## ft_sim_dir=ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb-
        ## gen_table=ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb_1_1.gen
        gen_table_new=$gen_table.new
        gen_table_new_vcf=$gen_table_new.vcf

        awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' $gen_table > $gen_table_new

        sed '1d' $gen_table_new | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | \
        sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10\tG_1_11\tG_1_12\tG_1_13\tG_1_14\tG_1_15\tG_1_16\tG_1_17\tG_1_18\tG_1_19\tG_1_20\tG_1_21\tG_1_22\tG_1_23\tG_1_24\tG_1_25\tG_1_26\tG_1_27\tG_1_28\tG_1_29\tG_1_30\tG_1_31\tG_1_32\tG_1_33\tG_1_34\tG_1_35\tG_1_36\tG_1_37\tG_1_38\tG_1_39\tG_1_40' | \
        sed '$d' > $gen_table_new_vcf
    done
done

## 100 diploid samples
genotype_fie_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
cd $genotype_fie_dir
genotype_fie=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_200hapS_1E_1000G_2e_i_cons_20Chr_15Mb/ft_sim_10000Ne_200hapS_1E_1000G_2e_i_cons_20Chr_15Mb_1_1.gen
for rep in {1..5};do
    for gen_table in `find -print | grep "200hapS_1E_1000G_2e_i_cons" | grep "$rep.gen$"`;do
        ## ft_sim_dir=ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb-
        ## gen_table=ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb_1_1.gen
        gen_table_new=$gen_table.new
        gen_table_new_vcf=$gen_table_new.vcf

        awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 2) { $i = "1/1"; } else {$i="0/1";}} } 1' $gen_table > $gen_table_new

        sed '1d' $gen_table_new | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | \
        sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10\tG_1_11\tG_1_12\tG_1_13\tG_1_14\tG_1_15\tG_1_16\tG_1_17\tG_1_18\tG_1_19\tG_1_20\tG_1_21\tG_1_22\tG_1_23\tG_1_24\tG_1_25\tG_1_26\tG_1_27\tG_1_28\tG_1_29\tG_1_30\tG_1_31\tG_1_32\tG_1_33\tG_1_34\tG_1_35\tG_1_36\tG_1_37\tG_1_38\tG_1_39\tG_1_40\tG_1_41\tG_1_42\tG_1_43\tG_1_44\tG_1_45\tG_1_46\tG_1_47\tG_1_48\tG_1_49\tG_1_50\tG_1_51\tG_1_52\tG_1_53\tG_1_54\tG_1_55\tG_1_56\tG_1_57\tG_1_58\tG_1_59\tG_1_60\tG_1_61\tG_1_62\tG_1_63\tG_1_64\tG_1_65\tG_1_66\tG_1_67\tG_1_68\tG_1_69\tG_1_70\tG_1_71\tG_1_72\tG_1_73\tG_1_74\tG_1_75\tG_1_76\tG_1_77\tG_1_78\tG_1_79\tG_1_80\tG_1_81\tG_1_82\tG_1_83\tG_1_84\tG_1_85\tG_1_86\tG_1_87\tG_1_88\tG_1_89\tG_1_90\tG_1_91\tG_1_92\tG_1_93\tG_1_94\tG_1_95\tG_1_96\tG_1_97\tG_1_98\tG_1_99\tG_1_100' | \
        sed '$d' > $gen_table_new_vcf
    done
done

awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 2) { $i = "1/1"; } else {$i="0/1";}} } 1' $genotype_fie | sed '1d' | sed 's/\//\\t/g' | less -S
 awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1'

## final
awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 2) { $i = "1/1"; } else {$i="0/1";}} } 1' $genotype_fie | sed '1d' | sed 's/\// /g' | awk 'OFS="\t"{c=0; skip=0; for(i=5;i<=NF;++i) { if ($i > 1) { skip=1; break } c+=$i } if (!skip) print $1,$2,$3,$4,c,"200" }' | awk '{if ($5 <= $6/2) print $5; if ($5 > $6/2) print $6-$5 }' | sort -V | uniq -c 

############################################################################
## set a variable for vcf file to plink
conda activate plink
cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne
## perform linkage pruning
## vcf: ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_5.gen.new.vcf
## https://onlinelibrary.wiley.com/doi/10.1111/mec.13838
## We used plink (‘-indep-pairwise 50 5 0.5’, Purcell et al. 2007) to calculate LD (r2) between each pair of SNPs in a window of 50 SNPs. 
## If a pair of SNPs had r2 greater than 0.5, one of the two SNPs was removed at random. 
## The window was then shifted by five SNPs and the procedure was repeated until the last SNP was reached.

for rep in {1..5};do
    for gen_vcf in `find -print | grep "15Mb-" | grep "$rep.gen.new.vcf$"`;do
        plink --vcf $gen_vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 5 0.5 --out $gen_vcf.plink_ld05
    done
done

## prune and extract
## for gen_vcf in `find -print | grep "15Mb-" | grep '.vcf$'`;do
#    plink --vcf $gen_vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --extract $gen_vcf.plink_ld01.prune.in --out $gen_vcf.plink_ld01.pruned --make-bed
#    done
## extract, recode bed/ped to vcf
https://www.biostars.org/p/155272/
for rep in {1..5};do
    for gen_vcf in `find -print | grep "15Mb-" | grep "$rep.gen.new.vcf$"`;do
        plink --vcf $gen_vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --extract $gen_vcf.plink_ld05.prune.in --out $gen_vcf.plink_ld05.pruned --keep-allele-order --recode vcf
    done
done

## easySFS
dir=/home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne/ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb-
vcf=ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb_1_1.gen.new.vcf.plink_ld01.pruned.vc

## prepare pop file using bcftools in each major folder
cd 1000000Ne_5rep
cd 100000Ne_5rep
cd 10000Ne_5rep
## activate bcftools env 
conda activate bcftools
## 10 - 40 -100 diploid samples (workers) -> (20,80,200) genomes
for folder in {10000Ne_5rep,100000Ne_5rep,1000000Ne_5rep};do
## test (use variable in awk)
for folder in {10000Ne_5rep,};do
    for size in {20,80,200};do
        bcftools query -l `find ./$folder -print | grep "$size"hapS | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"` | \
        grep 'G_1' | awk -v var=$size '{split($0,a,"_G");print $1,"pop"var}' > ./$folder/pop"$size"_file
    done
done

## activate bioproject env to use python for easrSFS
conda activate bioproject
## in major folder with pop_file
cd 1000000Ne_5rep
cd 100000Ne_5rep
cd 10000Ne_5rep

easySFS=/home/yzliu/bin/easySFS/easySFS.py
## pop file (pop10_file,pop40_file,pop100_file) 
## pop10_file
for rep in {1..5};do
    for vcf in `find -print | grep "15Mb-" | grep "$rep.gen.new.vcf.plink_ld05.pruned.vcf$"`;do 
        echo -e "\n------> VCF_$rep <------"
        $easySFS -i $vcf -p pop_file -a -f --preview
    done
done
## choose number of samples with high SNPs
#pop
#(2, 35800)      (3, 53701)      (4, 62222)   ...   (18, 68631)     (19, 68631)     (20, 68631)

## correct way ##
## dir=ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-
## need to be in these directory for 'cut -d "/" -f 1,2'
## https://stackoverflow.com/questions/23690698/remove-everything-after-2nd-occurrence-in-a-string-in-unix
cd 1000000Ne_5rep
cd 100000Ne_5rep
cd 10000Ne_5rep
for rep in {1..5};do
    for vcf in `find -print | grep "10000Ne" | grep "15Mb-" | grep "$rep.gen.new.vcf.plink_ld05.pruned.vcf$"`;do 
        vcf_dir=`ls $vcf`
        ## replace file name to get output directory name
        out_dir=`echo $vcf_dir | cut -d "/" -f 1,2`
        $easySFS -i $vcf -p pop_file -a -f --proj 20 -o $out_dir
    done
done

#dir /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne/ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb-/output/fastsimcoal2/
#file pop_MAFpop0.obs

#1 observation
#d0_0	d0_1	d0_2	d0_3	d0_4	d0_5	d0_6	d0_7	d0_8	d0_9	d0_10	d0_11	d0_12	d0_13	d0_14	d0_15	d0_16	d0_17	d0_18	d0_19	d0_20
#0 0 1 2 15 36 673 1087 6273 13763 46781 0 0 0 0 0 0 0 0 0 0

## wrong way of using proj ##
#/home/yzliu/bin/easySFS/easySFS.py -i $vcf -p ../pop_file -a -f --proj 20,68631

#  Processing 1 populations - ['pop']
#You must pass in the same number of values for projection as you have populations specified

#N pops = 1
#N projections = 2
#Projections = [20, 68631]

## output sfs from MAS.obs files
cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
sfs=`find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep _MSFS.obs$ | sort -V`
for i in $sfs;do
#    sfs=`find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep _MSFS.obs$`
#    echo -e "\n"
#   tr -d # delete newline characters 
    awk 'NR==3' $i | cut -d " " -f 2-11 | tr -d $'\n' >> sfs_file_bp.txt
    ## old method: sfs_file.txt
    echo -e "\t$i\t$i" >> sfs_file_bp.txt
done

## awk 'NR==3{print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs | \
## cut -f 2-41 | tr -d '\s+' > /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb.sfs

## remove extra text & edit the first line
## sfs_file.txt
71 6522 507 3915 1597 4282 2948 6719 5746 4172	./ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/fastsimcoal2/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_4_MSFS.obs
58 6593 518 3965 1690 4213 2940 6527 5697 4144	./ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/fastsimcoal2/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_5_MSFS.obs
cat sfs_file.txt | cut -d "/" -f 1,4 | sed -e 's/\.\///' -e 's/\.obs//' > sfs_file.new.txt
## sfs_file.blueprint.txt
cat sfs_file.txt | cut -d "/" -f 1,4 | sed -e 's/\.\///g' -e 's/obs/blueprint/' > /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/sfs_file.blueprint.txt
## sfs_file_bp.txt
## 57 6546 492 3844 1685 4234 2959 6586 5810 4187	./ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/fastsimcoal2/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1_MSFS.obs	./ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/fastsimcoal2/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1_MSFS.obs
## sfs_file_bp.blueprint.txt
cat sfs_file_bp.txt | cut -d "/" -f 1,4,7 | sed -e 's/\.\///g' -e 's/.obs//' -e 's/obs/blueprint/1' > /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/sfs_file_bp.blueprint.txt


57 6546 492 3844 1685 4234 2959 6586 5810 4187  ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1_MSFS.blueprint

## new data: sfs_file.new.txt
57 6546 492 3844 1685 4234 2959 6586 5810 4187	ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1_MSFS.obs
63 6658 525 3955 1637 4356 3039 6562 5878 4086	ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_2_MSFS.obs
65 6523 495 3978 1663 4310 2960 6515 5708 4235	ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_3_MSFS.obs
71 6522 507 3915 1597 4282 2948 6719 5746 4172	ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_4_MSFS.obs
58 6593 518 3965 1690 4213 2940 6527 5697 4144	ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_5_MSFS.obs

## declining
ls /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne | sort -V | grep -v i_ > ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.list
## increasing
ls /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne | sort -V | grep i_ >> ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.list
ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb.par
ft_sim_100000Ne_20hapS_1E_50G_01d_20Chr_15Mb.par

##
cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
par_list=ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.list
# ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb.par
par_list_new=ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.list
sed 's/\.par//g' $par_list > $par_list_new
# ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb
blueprint_list_5rep=ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.5rep_blueprint.list

## make blueprint replicate (5) filea
cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-
cd /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint

for par in `cat ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.list`;do
    # ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb
    for rep in {1..5};do
        echo "$par"_1_"$rep"_MSFS.blueprint >> $blueprint_list_5rep
        ## https://stackoverflow.com/questions/76920576/vscode-adds-control-and-script-code-to-first-line-of-output
        ## instead of piping via "for loop" after done to avoid that VSCode adds control and script code to first line of output
    done
done

## copy $ft_dir_5rep_blueprint_list rom ./10000Ne_5rep to $stairway_dir
ft_dir_5rep_blueprint_list=/home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.5rep_blueprint.list
stairway_dir=/home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint
cp $ft_dir_5rep_blueprint_list $stairway_dir

## put blueprint content into blueprint file
cd /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint
## example 5 replicates
# bp_file_names=ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.5rep_blueprint_5.list
## attention to unfinished runs
bp_file_names=ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.5rep_blueprint.list
bp_template=ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_0_MSFS.blueprint
for bp_file in `cat $bp_file_names`;do
    cat $bp_template > $bp_file
done

##awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' $gen_table > $gen_table_new
cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep
cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/1000000Ne_5rep
for i in {4..5};do
    ## modify pop AA with filename in col2
    ## sfs_file_bp.new.txt
    sfs1=`awk -F "\t" -v var=$i 'FNR==var {print $2}' sfs_file.new.txt`
    ## /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/sfs_file.new.txt
    ## 57 6546 492 3844 1685 4234 2959 6586 5810 4187	ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1_MSFS
    
    ## /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/sfs_file.blueprint.txt
    ## 57 6546 492 3844 1685 4234 2959 6586 5810 4187	ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1_MSFS.blueprint
    ## attention to input file
    sed -i -e "3s/AA/$sfs1/" -e "12s/CC/$sfs1/" -e "20s/DD/$sfs1/" ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_"$i"_MSFS.blueprint
    ## modify pop AA with filename in col1
    ## attention to input file
    sfs2=`awk -F "\t" -v var=$i 'FNR==var {print $1}' sfs_file.new.txt`
    sed -i "7s/BB/$sfs2/" ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_"$i"_MSFS.blueprint
done


for i in {4..5};do
    while $3 == 
    ## modify pop AA with filename in col2
    ## sfs_file_bp.new.txt
    sfs1=`awk -F "\t" -v var=$i 'FNR==var {print $2}' sfs_file.new.txt`
    ## /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/sfs_file.new.txt
    ## 57 6546 492 3844 1685 4234 2959 6586 5810 4187	ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1_MSFS
    
    ## /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/sfs_file.blueprint.txt
    ## 57 6546 492 3844 1685 4234 2959 6586 5810 4187	ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1_MSFS.blueprint
    ## attention to input file
    sed -i -e "3s/AA/$sfs1/" -e "12s/CC/$sfs1/" -e "20s/DD/$sfs1/" ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_"$i"_MSFS.blueprint
    ## modify pop AA with filename in col1
    ## attention to input file
    sfs2=`awk -F "\t" -v var=$i 'FNR==var {print $1}' sfs_file.new.txt`
    sed -i "7s/BB/$sfs2/" ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_"$i"_MSFS.blueprint
done

## https://www.cyberciti.biz/faq/unix-howto-read-line-by-line-from-file/
#!/bin/bash
input="sfs_file.new.txt"
while IFS= read -r line
do
  cut -f 1 $line
done < $input

cut -d "\t" -f 1 sfs_file.new.txt
## worked
cut -f 1 sfs_file.new.txt
awk -F "\t" 'NR = 3 { print $1}' sfs_file.new.txt
awk 'BEGIN{FS="\t"} {print $1}' sfs_file.new.txt

## correct growth rate
cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne
par_i=`ls *i_*Mb.par`

## modify par file in 10000Ne
for par_i in `ls *i_*Mb.par`;do
    sed -i -e '8s/0/-0.0007/' -e '13s/1000 0 0 0 -1.50 0 0/1000 0 0 0 1.50 0 0/' $par_i
done


## copy increasing par from Ne 100000 to 10000 
cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/10000Ne
cp /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne/*i_*Mb.par .
## replace Ne in line 8
par_i=`ls *i_*Mb.par`
for par_i in `ls *i_*Mb.par`;do
    sed -i '4s/100000/10000/' $par_i
done
## rename those files
for par_i in `ls *i_*Mb.par`;do
    rename 100000Ne 10000Ne $par_i;
done
## modify par file in 1000000Ne
[yzliu@fe-open-01 10000Ne]$ cd ../1000000Ne/
[yzliu@fe-open-01 1000000Ne]$ cp /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne/*i_*Mb.par .
[yzliu@fe-open-01 1000000Ne]$ for par_i in `ls *i_*Mb.par`;do     sed -i '4s/100000/1000000/' $par_i; done
[yzliu@fe-open-01 1000000Ne]$ for par_i in `ls *i_*Mb.par`;do     rename 100000Ne 1000000Ne $par_i; done
for par_i in `ls *i_*Mb.par`;do
    sed -i -e '8s/0/-0.0007/' -e '13s/1000 0 0 0 -1.50 0 0/1000 0 0 0 1.50 0 0/' $par_i
done