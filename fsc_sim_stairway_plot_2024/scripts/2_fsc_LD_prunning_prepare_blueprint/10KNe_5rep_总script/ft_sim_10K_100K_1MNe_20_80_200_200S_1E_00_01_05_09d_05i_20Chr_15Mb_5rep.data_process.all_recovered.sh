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
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
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

## check number of column
awk -F '\t' '{print NF; exit}' file
## check number of row
awk 'END{print NR}' file

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

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
############################### run of 5 replicates ######################################
## 10 diploid samples
for rep in {1..5};do
    for gen_table in `find -print | grep "15Mb-" | grep "$rep.gen$"`;do
        ## ft_sim_dir=ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb-
        ## gen_table=ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb_1_1.gen
        gen_table_new=$gen_table.new
        gen_table_new_vcf=$gen_table_new.vcf
   
        ## A MISTAKE CONVERTING GENOTYPES
        ## G stands for “Genotype”, and where genotype entries are coded as 0 (homozygote ancestral), 1 (heterozygote), and 2 (homozygote derived)
        #awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' $gen_table > $gen_table_new
        awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "0/1"; } else {$i="1/1";}} } 1' $gen_table > $gen_table_new

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
    gen_table_new=$gen_table.modification.new
    gen_table_new_vcf=$gen_table_new.vcf

    ## A MISTAKE CONVERTING GENOTYPES
    ## G stands for “Genotype”, and where genotype entries are coded as 0 (homozygote ancestral), 1 (heterozygote), and 2 (homozygote derived)
    #awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' $gen_table > $gen_table_new
    awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "0/1"; } else {$i="1/1";}} } 1' $gen_table > $gen_table_new

    sed '1d' $gen_table_new | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | \
    sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' | \
    sed '$d' > $gen_table_new_vcf
done

############################### run of 5 replicates ######################################
## 40 diploid samples
for rep in {1..5};do
    for gen_table in `find -print | grep "80hapS" | grep "15Mb-" | grep "$rep.gen$"`;do
        ## ft_sim_dir=ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb-
        ## gen_table=ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb_1_1.gen
        #gen_table_new=$gen_table.new
        gen_table_new=$gen_table.modification.new
        gen_table_new_vcf=$gen_table_new.vcf


        ## A MISTAKE CONVERTING GENOTYPES
        ## G stands for “Genotype”, and where genotype entries are coded as 0 (homozygote ancestral), 1 (heterozygote), and 2 (homozygote derived)
        awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "0/1"; } else {$i="1/1";}} } 1' $gen_table > $gen_table_new

        sed '1d' $gen_table_new | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | \
        sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10\tG_1_11\tG_1_12\tG_1_13\tG_1_14\tG_1_15\tG_1_16\tG_1_17\tG_1_18\tG_1_19\tG_1_20\tG_1_21\tG_1_22\tG_1_23\tG_1_24\tG_1_25\tG_1_26\tG_1_27\tG_1_28\tG_1_29\tG_1_30\tG_1_31\tG_1_32\tG_1_33\tG_1_34\tG_1_35\tG_1_36\tG_1_37\tG_1_38\tG_1_39\tG_1_40' | \
        sed '$d' > $gen_table_new_vcf
    done
done

## 100 diploid samples
for rep in {1..5};do
    for gen_table in `find -print | grep "15Mb-" | grep "$rep.gen$"`;do
        ## ft_sim_dir=ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb-
        ## gen_table=ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb_1_1.gen
        gen_table_new=$gen_table.new
        gen_table_new_vcf=$gen_table_new.vcf

        ## A MISTAKE CONVERTING GENOTYPES
        ## G stands for “Genotype”, and where genotype entries are coded as 0 (homozygote ancestral), 1 (heterozygote), and 2 (homozygote derived)
        awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "0/1"; } else {$i="1/1";}} } 1' $gen_table > $gen_table_new

        sed '1d' $gen_table_new | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | \
        sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10\tG_1_11\tG_1_12\tG_1_13\tG_1_14\tG_1_15\tG_1_16\tG_1_17\tG_1_18\tG_1_19\tG_1_20\tG_1_21\tG_1_22\tG_1_23\tG_1_24\tG_1_25\tG_1_26\tG_1_27\tG_1_28\tG_1_29\tG_1_30\tG_1_31\tG_1_32\tG_1_33\tG_1_34\tG_1_35\tG_1_36\tG_1_37\tG_1_38\tG_1_39\tG_1_40\tG_1_41\tG_1_42\tG_1_43\tG_1_44\tG_1_45\tG_1_46\tG_1_47\tG_1_48\tG_1_49\tG_1_50\tG_1_51\tG_1_52\tG_1_53\tG_1_54\tG_1_55\tG_1_56\tG_1_57\tG_1_58\tG_1_59\tG_1_60\tG_1_61\tG_1_62\tG_1_63\tG_1_64\tG_1_65\tG_1_66\tG_1_67\tG_1_68\tG_1_69\tG_1_70\tG_1_71\tG_1_72\tG_1_73\tG_1_74\tG_1_75\tG_1_76\tG_1_77\tG_1_78\tG_1_79\tG_1_80\tG_1_81\tG_1_82\tG_1_83\tG_1_84\tG_1_85\tG_1_86\tG_1_87\tG_1_88\tG_1_89\tG_1_90\tG_1_91\tG_1_92\tG_1_93\tG_1_94\tG_1_95\tG_1_96\tG_1_97\tG_1_98\tG_1_99\tG_1_100' | \
        sed '$d' > $gen_table_new_vcf
    done
done

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



## correct growth rate
cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/fastsimcoal/para_test3/100000Ne
par_i=`ls *i_*Mb.par`

## modify par file in 10000Ne
for par_i in `ls *i_*Mb.par`;do
    sed -i -e '8s/0/-0.0007/' -e '13s/1000 0 0 0 -1.50 0 0/1000 0 0 0 1.50 0 0/' $par_i
done

for par_i in `ls *i_*Mb.par`;do
    sed -i -e '13s/-1.50 0 0/1.50 0 0/' $par_i
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



## batch work
## plink pruning
## convert genotype file to vcf
## [Convert genotypes to 0/1](https://unix.stackexchange.com/questions/228532/convert-genotypes-to-0-1)
## [https://unix.stackexchange.com/questions/228532/convert-genotypes-to-0-1](https://unix.stackexchange.com/questions/228532/convert-genotypes-to-0-1)

cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
10000Ne_5rep=/home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
ls ft_sim*15Mb/*.gen | sort -V | grep -v _05i > ft_sim_10000Ne_20Chr_15Mb.gen.txt
ls ft_sim*15Mb/*.gen | sort -V | grep _05i >> ft_sim_10000Ne_20Chr_15Mb.gen.txt

ls ft_sim*20hapS*15Mb/*.gen | sort -V | grep -v _05i > ft_sim_10000Ne_20hapS_20Chr_15Mb.gen.txt
ls ft_sim*80hapS*15Mb/*.gen | sort -V | grep -v _05i > ft_sim_10000Ne_20hapS_80Chr_15Mb.gen.txt
ls ft_sim*200hapS*15Mb/*.gen | sort -V | grep -v _05i > ft_sim_10000Ne_200hapS_20Chr_15Mb.gen.txt

## comparison test
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_50G_05i_20Chr_15Mb.high_mu
ls *high_mu*.gen | sort -V | grep _05i >> ft_sim_10000Ne_05i_20Chr_15Mb.high_mu.gen.txt

##example: for 10,40,100 samples
## for gen in {1..3};do
for gen in {1..300};do
    ## ft_sim_10000Ne_200hapS_1E_500G_01d_20Chr_15Mb_1_5.gen
    gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`;
    ## sample name row
    sample_id=`awk 'NR==1 {print $0}' $gen_file | cut --complement -f 1-4`;
    ## modify genotype table and input file for 10 diploid samples
    ## Add a new column to the file
    ## (https://stackoverflow.com/questions/7551991/add-a-new-column-to-the-file)
    awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` |
    sed '1d' | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | sed "1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t$sample_id" | sed '$d' > ./$gen_file.vcf
    ## above sed -> use double quote to use variable in sed command
    ## `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.## gen.txt` > ./$gen_file.new
    ## remove the last line | sed '$d'
done
******************************************************************
## additiona test for high mu
for gen in {1..5};do
    ## ft_sim_10000Ne_200hapS_1E_500G_01d_20Chr_15Mb_1_5.gen
    ## use the *gen.txt file name twice
    gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_05i_20Chr_15Mb.high_mu.gen.txt`;
    ## sample name row
    sample_id=`awk 'NR==1 {print $0}' $gen_file | cut --complement -f 1-4`;
    ## modify genotype table and input file for 10 diploid samples
    ## Add a new column to the file
    ## (https://stackoverflow.com/questions/7551991/add-a-new-column-to-the-file)
    awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_05i_20Chr_15Mb.high_mu.gen.txt` |
    sed '1d' | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | sed "1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t$sample_id" | sed '$d' > ./$gen_file.vcf
    ## above sed -> use double quote to use variable in sed command
    ## `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.## gen.txt` > ./$gen_file.new
    ## remove the last line | sed '$d'
done
******************************************************************
## set a variable for vcf file to plink
## perform linkage pruning
## old folder
cd /home/yzliu/DK_proj/steps/systematic_fsc_test3
## new folder
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3
for folder in {10000Ne_5rep,100000Ne_5rep,1000000Ne_5rep};do

for folder in {10000Ne_5rep,};do
    plink=/home/yzliu/miniforge3/envs/plink/bin/plink
    #for vcf in `find ./$folder -print | grep ft_sim_ | grep 20Chr_15Mb_1 | grep gen.vcf$`;do
    for vcf in `find ./$folder -print | grep ft_sim_ | grep "80hapS" |grep 15Mb- | grep modification.new.vcf$`;do
        ## vcf file: /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_200hapS_1E_500G_05i_20Chr_15Mb/ft_sim_10000Ne_200hapS_1E_500G_05i_20Chr_15Mb_1_5.gen.vcf
        
        $plink --vcf $vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 10 0.5 --out $vcf.final_ld05;
        
        ## prune recode bed/ped to vcf
        ## https://www.biostars.org/p/155272/
        $plink --vcf $vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --extract $vcf.final_ld05.prune.in --out $vcf.final_ld05.pruned --keep-allele-order --recode vcf;
    done
done
*****************************
Error: Invalid --indep-pairwise r^2 threshold '1.0'.
--indep-pairwise 50 10 0.8
--indep-pairwise 50 10 0.9
## additiona test for high mu
for folder in {10000Ne_5rep,};do
    plink=/home/yzliu/miniforge3/envs/plink/bin/plink
    for vcf in `find ./$folder -print | grep ft_sim_ | grep '20Chr_15Mb.high_mu_1' | grep gen.vcf$`;do
        ## vcf file: /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_200hapS_1E_500G_05i_20Chr_15Mb/ft_sim_10000Ne_200hapS_1E_500G_05i_20Chr_15Mb_1_5.gen.vcf
        
        $plink --vcf $vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 10 0.95 --out $vcf.final_ld095;
        
        ## prune recode bed/ped to vcf
        ## https://www.biostars.org/p/155272/
        $plink --vcf $vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --extract $vcf.final_ld095.prune.in --out $vcf.final_ld095.pruned --keep-allele-order --recode vcf;
    done
done
********************************
## easySFS
## example test "15Mb-"
dir=/home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne/ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb-
vcf=ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb_1_1.gen.new.vcf.plink_ld01.pruned.vc

## prepare pop file using bcftools in each major folder
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3
## activate bcftools env 
conda activate bcftools
## 10 - 40 -100 diploid samples (workers) -> (20,80,200) genomes
#for folder in {10000Ne_5rep,100000Ne_5rep,1000000Ne_5rep};do
    ## example prined vcf:./10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1.gen.vcf.final_ld05.pruned.vcf
    ## test (use variable in awk)
for folder in {10000Ne_5rep,};do
    for size in {20,80,200};do
        bcftools query -l `find ./$folder -print | grep "$size"hapS | grep "15Mb" | grep "1_1.gen.vcf.final_ld05.pruned.vcf$"` | \
        grep 'G_1' | awk -v var=$size '{split($0,a,"_G");print $1,"pop"var}' > ./$folder/pop"$size"_file
        ## G_1_2_G_1_2
        ## split a column: '{split($0,a,"_G");print a[1],"pop"var}' -> e.g. G_1_2
        ## https://stackoverflow.com/questions/8009664/how-to-split-a-delimited-string-into-an-array-in-awk
    done
done

## activate bioproject env to use python for easrSFS
conda activate bioproject
easySFS=/home/yzliu/bin/easySFS/easySFS.py
cd 10000Ne_5rep
## in major folder with pop_file
cd 100000Ne_5rep
cd 1000000Ne_5rep

## check max no. of site per pop (can be ignored for sim data)
## pop file (pop10_file,pop40_file,pop100_file) 
## pop10_file
for pop_file in {pop20_file,pop80_file,pop200_file};do
    for rep in {1..5};do
        for vcf in `find -print | grep "15Mb" | grep "$rep.gen.vcf.final_ld05.pruned.vcf$"`;do
        #for vcf in `find -print | grep "15Mb" | grep "$rep.gen.modification.new.vcf.final_ld05.pruned.vcf$"`;do
            echo -e "\n------> VCF_$rep <------"
            $easySFS -i $vcf -p $pop_file -a -f --preview
        done
    done
done

## choose number of samples with high SNPs
#pop
#(2, 35800)      (3, 53701)      (4, 62222)   ...   (18, 68631)     (19, 68631)     (20, 68631)

## correct way ##
## dir=ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-
## need to be in these directory for 'cut -d "/" -f 1,2'
## https://stackoverflow.com/questions/23690698/remove-everything-after-2nd-occurrence-in-a-string-in-unix
cd 10000Ne_5rep
cd 100000Ne_5rep
cd 1000000Ne_5rep

pop20=pop20_file
pop80=pop80_file
pop200=pop200_file

pop20_file
G_1_1_G_1_1 pop20
G_1_2_G_1_2 pop20
G_1_3_G_1_3 pop20
G_1_4_G_1_4 pop20
G_1_5_G_1_5 pop20
G_1_6_G_1_6 pop20
G_1_7_G_1_7 pop20
G_1_8_G_1_8 pop20
G_1_9_G_1_9 pop20
G_1_10_G_1_10 pop20

## output files depend on the file name and dots in its name
for sample_size in {20,80,200};do
    if [ $sample_size == 20 ];then
        for rep in {1..5};do
            for vcf in `find -print | grep "10000Ne" | grep "$sample_size"hapS| grep "high_mu" | grep "15Mb" | grep "$rep.gen.vcf.final_ld09.pruned.vcf$"`;do 
                vcf_dir=`ls $vcf`
                ## replace file name to get output directory name
                out_dir=`echo $vcf_dir | cut -d "/" -f 1,2`
                echo $vcf
                $easySFS -i $vcf -p $pop20 -a -f --proj $sample_size -o $out_dir --prefix $out_dir"_LD09_1_"$rep
            done
        done
    elif [ $sample_size == 80 ];then
        for rep in {1..5};do
            for vcf in `find -print | grep "10000Ne" | grep "$sample_size"hapS| grep "high_mu" | grep "15Mb" | grep "$rep.gen.vcf.final_ld05.pruned.vcf$"`;do 
                vcf_dir=`ls $vcf`
                ## replace file name to get output directory name
                out_dir=`echo $vcf_dir | cut -d "/" -f 1,2`
                $easySFS -i $vcf -p $pop80 -a -f --proj $sample_size -o $out_dir
            done
        done
    else
        for rep in {1..5};do
            for vcf in `find -print | grep "10000Ne" | grep "$sample_size"hapS| grep "high_mu" | grep "15Mb" | grep "$rep.gen.vcf.final_ld05.pruned.vcf$"`;do 
                vcf_dir=`ls $vcf`
                ## replace file name to get output directory name
                out_dir=`echo $vcf_dir | cut -d "/" -f 1,2`
                $easySFS -i $vcf -p $pop200 -a -f --proj $sample_size -o $out_dir
            done
        done
    fi
done


for rep in {1..5};do
    #for vcf in `find -print | grep "10000Ne" | grep "20hapS" | grep "15Mb" | grep "high_mu" | grep "$rep.gen.vcf.final_ld05.pruned.vcf$"`;do
    ## figure out error of converting genotype
    for vcf in `find -print | grep "10000Ne" | grep "20hapS" | grep "15Mb" | grep "$rep.gen.modification.new.vcf.final_ld05.pruned.vcf$"`;do
        #vcf_dir=`ls $vcf`
        echo $vcf
        ## replace file name to get output directory name
        out_dir=`echo $vcf | cut -d "/" -f 1,2`
        echo $out_dir
        $easySFS -i $vcf -p $pop20 -a -f --proj 20 -o $out_dir --prefix $out_dir"_1_"$rep
    done
done
*************************************************
for run in `ls -t ./stairway_plot_blueprint/*noLDprun.blueprint | head -4`;do
    java -cp stairway_plot_es Stairbuilder ./$run;
done
*******************
for run in `ls -t ./stairway_plot_blueprint/*noLDprun.blueprint.sh | head -4 | sort -V`;do
    bash ./$run;
done

*************************************************
## create folders for high mu
cd eDNA/faststorage/yzliu/DK_proj/backup/scripts/fastsimcoal/para_test3
for i in {10000Ne,100000Ne,1000000Ne};do
    cp -r $i ./$i"_high_mu";
done
find -print 


*************************************************
## simplified test
## https://www.thegeekstuff.com/2010/06/bash-if-statement-examples/
## https://unix.stackexchange.com/questions/255652/linux-bash-if-statement-inside-for-loop
## https://stackoverflow.com/questions/42960710/bash-script-for-loop-with-if-else-statement
for sample_size in {20,80,200}; do
    if [ $sample_size == 20 ]; then
        echo "sample_size=20"
    elif [ $sample_size == 80 ]; then
        echo "sample_size=80"
    else
        echo "sample_size=200"
    fi
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


-----------Step III
*************************************************************************************
## output SFS from MAS.obs files
cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
sfs=`find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep _MSFS.obs$ | sort -V`
## exclude test folder: "15Mb-"

sfs_folder=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep

rm *hapS_5rep_for_bp.txt
for sample_size in {20,80,200};do
    sfs=`find -print | grep "10000Ne" | grep "$sample_size"hapS | grep "15Mb/fastsimcoal2" | grep "_MSFS.obs$" | sort -V`
    if [ $sample_size == 20 ];then
        for i in $sfs;do
        #    sfs=`find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep _MSFS.obs$`
        #    echo -e "\n"
        #   tr -d # delete newline characters 
            awk 'NR==3' $i | cut -d " " -f 2-11 | tr -d $'\n' >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp.txt;
            ## old method: sfs_file.txt;sfs_file_bp.txt
            echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp.txt
        done
    elif [ $sample_size == 80 ];then
        for i in $sfs;do
            awk 'NR==3' $i | cut -d " " -f 2-41 | tr -d $'\n' >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp.txt;
            echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp.txt
        done
    else
        for i in $sfs;do
            awk 'NR==3' $i | cut -d " " -f 2-101 | tr -d $'\n' >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp.txt;
            echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp.txt
            ## result file: sfs_10000Ne_200hapS_5rep_for_bp.txt
        done
    fi
done

***************** Non-pruned SFS data ********************
## single 20
rm *20hapS_5rep_for_bp_non_pruned.txt
for sample_size in {20,};do
    sfs=`find -maxdepth 2 -print | grep "10000Ne" | grep "1E" | grep "15Mb/" | grep "$sample_size"hapS | grep "15Mb_MAFpop0.obs$" | sort -V`;
    #printf "$sfs\n";
    sfs1=`find -maxdepth 2 -print | grep "10000Ne" | grep "1E" | grep -v "05i" | grep "15Mb/" | grep "$sample_size"hapS | grep "15Mb_MAFpop0.obs$" | sort -V`
    sfs2=`find -maxdepth 2 -print | grep "10000Ne" | grep "1E" | grep "05i" |  grep "15Mb/" | grep "$sample_size"hapS | grep "15Mb_MAFpop0.obs$" | sort -V`
    for stable_decrease in $sfs1;do
        #    echo -e "\n"
        #   tr -d # delete newline characters
        echo "$stable_decrease\n"
        #awk -v var=$stable_decrease 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $stable_decrease | cut -f 2-11,22-24 >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt;
        #BEGIN{FS=OFS="\t"}
        #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
    done
    for increase in $sfs2;do
        #    echo -e "\n"
        #   tr -d # delete newline characters
        echo "$increase\n"
        #awk -v var=$increase 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $increase | cut -f 2-11,22-24 >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt;
        #BEGIN{FS=OFS="\t"}
        #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
    done
done

## all
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
awk 'NR>2{print NF;exit}' file
rm *hapS_5rep_for_bp_non_pruned.txt
for sample_size in {20,80,200};do
    sfs1=`find -maxdepth 2 -print | grep "10000Ne" | grep "1E" | grep -v "05i" | grep "15Mb/" | grep "$sample_size"hapS | grep "15Mb_MAFpop0.obs$" | sort -V`
    sfs2=`find -maxdepth 2 -print | grep "10000Ne" | grep "1E" | grep "05i" |  grep "15Mb/" | grep "$sample_size"hapS | grep "15Mb_MAFpop0.obs$" | sort -V`
    if [ $sample_size == 20 ];then
        for stable_decrease in $sfs1;do
            #    echo -e "\n"
            #   tr -d # delete newline characters 
            awk -v var=$stable_decrease 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $stable_decrease | cut -f 2-11,22-24 >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt;
            ## https://unix.stackexchange.com/questions/638196/how-to-print-in-only-one-column-if-condition-with-awk
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
        done
        for increase in $sfs2;do
            #    echo -e "\n"
            #   tr -d # delete newline characters 
            awk -v var=$increase 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $increase | cut -f 2-11,22-24 >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt;
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
        done
    elif [ $sample_size == 80 ];then
        for stable_decrease in $sfs1;do
            #printf $sfs"\n"
            awk -v var=$stable_decrease 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $stable_decrease | cut -f 2-41,82-84 >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt;
            #awk 'NR>=3,NR<=5' $i | cut -d " " -f 2-41 >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt;
            #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
        done
        for increase in $sfs2;do
            #    echo -e "\n"
            #   tr -d # delete newline characters 
            awk -v var=$increase 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $increase | cut -f 2-41,82-84 >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt;
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
        done
    else
        for stable_decrease in $sfs1;do
            awk -v var=$stable_decrease 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $stable_decrease | cut -f 2-101,202-204 >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt;
            #awk 'NR>=3,NR<=5' $i | cut -d " " -f 2-101 >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt;
            #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
            ## result file: sfs_10000Ne_200hapS_5rep_for_bp_non_pruned.txt
        done
        for increase in $sfs2;do
            #    echo -e "\n"
            #   tr -d # delete newline characters 
            awk -v var=$increase 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $increase | cut -f 2-101,202-204 >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt;
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
        done
    fi
done

## delete old blueprint files: pass ls output to rm
cd /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint
ls *_1_* | grep -v 'prun' | grep -v '_1_0' | xargs rm
##
cd bin/stairway_plot_v2.1.2/systematic_ft_test3
ls -t -d *15Mb_[0-5]$* | sort -V | xargs rm -r

******************************** easySFS (space separated) **********************************
## SFS: remove extra text & edit the first line
## sfs_file_bp.blueprint.txt
cat sfs_file_bp.txt | cut -d "/" -f 1,4,7 | sed -e 's/\.\///g' -e 's/.obs//' -e 's/obs/blueprint/1' > /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/sfs_file_bp.blueprint.txt
## e.g.
57 6546 492 3844 1685 4234 2959 6586 5810 4187	ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1_MSFS	ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1_MSFS.blueprint
cd $sfs_folder
sfs200=sfs_10000Ne_200hapS_5rep_for_bp.txt
cat $sfs200 | cut -d "/" -f 1,4,7 | sed -e 's/\.\///g' -e 's/.obs//' -e 's/obs/blueprint/1' > /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/sfs_file_200hapS.blueprint.txt
## for all groups
out_sub_dir=/home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint
for sample_size in {20,80,200};do
    if [ $sample_size == 20 ];then
        cat sfs_10000Ne_"$sample_size"hapS_5rep_for_bp.txt |\
        cut -d "/" -f 1,4,7 | sed -e 's/\.\///g' -e 's/.obs//' -e 's/obs/blueprint/1' > $out_sub_dir/sfs_file_20_80_200hapS.blueprint.txt
    elif [ $sample_size == 80 ];then
        cat sfs_10000Ne_"$sample_size"hapS_5rep_for_bp.txt |\
        cut -d "/" -f 1,4,7 | sed -e 's/\.\///g' -e 's/.obs//' -e 's/obs/blueprint/1' >> $out_sub_dir/sfs_file_20_80_200hapS.blueprint.txt
    else
        cat sfs_10000Ne_"$sample_size"hapS_5rep_for_bp.txt |\
        cut -d "/" -f 1,4,7 | sed -e 's/\.\///g' -e 's/.obs//' -e 's/obs/blueprint/1' >> $out_sub_dir/sfs_file_20_80_200hapS.blueprint.txt
    fi
done


************ non-pruned ( tab separated) *******************************************
cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep

cut -d "/" -f 1,3,5 sfs_10000Ne_20hapS_5rep_for_bp_non_pruned.txt | \
sed -e 's/\.\///g' -e 's/_MAFpop0\.obs//' -e 's/MAFpop0\.obs//1' | \
awk -F "\t" -v OFS="\t" '{$13=++a[$11]".blueprint"}1' | \
awk '{ for (i = 1; i <= 11; ++i) printf $i"\t"; print "" $12$13}'

out_sub_dir=/home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint

for sample_size in {20,80,200};do
    if [ $sample_size == 20 ];then
        cat sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt |\
        cut -d "/" -f 1,3,5 | \
        sed -e 's/\.\///g' -e 's/_MAFpop0\.obs//' -e 's/MAFpop0\.obs//1' | \
        awk -F "\t" -v OFS="\t" '{$13=++a[$11]}1' | \
        awk '{ for (i = 1; i <= 11; ++i) printf $i"\t"; print "" $12$13}' > $out_sub_dir/sfs_file_20_80_200hapS_non_pruned.blueprint.txt
        ## https://www.baeldung.com/linux/display-columns-from-file
        ## https://stackoverflow.com/questions/18516301/add-a-number-to-each-line-of-a-file-in-bash
        ## https://unix.stackexchange.com/questions/517985/how-can-i-merge-multiple-column-in-one-column-and-separated-by
    elif [ $sample_size == 80 ];then
        cat sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt |\
        cut -d "/" -f 1,3,5 | \
        sed -e 's/\.\///g' -e 's/_MAFpop0\.obs//' -e 's/MAFpop0\.obs//1' | \
        awk -F "\t" -v OFS="\t" '{$43=++a[$41]}1' | \
        awk '{ for (i = 1; i <= 41; ++i) printf $i"\t"; print "" $42$43}' >> $out_sub_dir/sfs_file_20_80_200hapS_non_pruned.blueprint.txt
    else
        cat sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt |\
        cut -d "/" -f 1,3,5 | \
        sed -e 's/\.\///g' -e 's/_MAFpop0\.obs//' -e 's/MAFpop0\.obs//1' | \
        awk -F "\t" -v OFS="\t" '{$103=++a[$101]}1' | \
        awk '{ for (i = 1; i <= 101; ++i) printf $i"\t"; print "" $102$103}' >> $out_sub_dir/sfs_file_20_80_200hapS_non_pruned.blueprint.txt
    fi
done
## example
## 22608	11900	8644	6733	5772	5060	4867	4442	4276	2175	ft_sim_10000Ne_20hapS_1E_50G_00d_20Chr_15Mb	ft_sim_10000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1
**************************** create folder list **********************************************
##################################################################################
## test
par_folder_10K=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/fastsimcoal/para_test3/10000Ne
sfs_folder_10K=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
## declining
ls $par_folder_10K | sort -V | grep -v i_ > $sfs_folder_10K/ft_sim_10KNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.par.list
## increasing
ls $par_folder_10K | sort -V | grep i_ >> $sfs_folder_10K/ft_sim_10KNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.par.list
## e.g.
ft_sim_10000Ne_20hapS_1E_50G_00d_20Chr_15Mb.par
ft_sim_10000Ne_20hapS_1E_50G_01d_20Chr_15Mb.par
#################
## final for loop
par_folder=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/fastsimcoal/para_test3
sfs_folder=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3

for size in {10000,100000,1000000};do
    ls $par_folder/"$size"Ne | sort -V | grep -v i_ > "$sfs_folder"/"$size"Ne_5rep/ft_sim_"$size"Ne_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.par.list
    ls $par_folder/"$size"Ne | sort -V | grep i_ >> "$sfs_folder"/"$size"Ne_5rep/ft_sim_"$size"Ne_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.par.list
done
##################################################################################
## to par_list folder
## ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb.par
dir_10000Ne_5rep=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
cd $dir_10000Ne_5rep
par_list=ft_sim_10000Ne_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.par.list
par_list_new=ft_sim_10000Ne_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.par.folder_name.list
## create folder list
sed 's/\.par//g' $par_list > $par_list_new
## ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb


*********** create list of each blueprint file (non-pruned SNP) ************
cd /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint
sfs_20_80_200=sfs_file_20_80_200hapS_non_pruned.blueprint.txt

#blueprint_output_folder_list_5rep=ft_sim_10000Ne_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.5rep_blueprint.output_dir_name.list

blueprint_file_list_5rep=ft_sim_10000Ne_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.5rep_blueprint.file_name.list
## example lines
22608   11900   8644    6733    5772    5060    4867    4442    4276    2175    ft_sim_10000Ne_20hapS_1E_50G_00d_20Chr_15Mb     ft_sim_10000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1
22879   12021   8459    6698    5719    5023    4665    4579    4471    2157    ft_sim_10000Ne_20hapS_1E_50G_00d_20Chr_15Mb     ft_sim_10000Ne_20hapS_1E_50G_00d_20Chr_15Mb_2
## take the 3rd column
sed 's/\.blueprint//g' $sfs_20_80_200 | awk '{print $NF}' > $blueprint_output_folder_list_5rep
awk '{print $NF".blueprint"}' $sfs_20_80_200 > $blueprint_file_list_5rep

************************** create blueprint file names list (pruned 300 items) ***************************
blueprint_list_5rep=ft_sim_10000Ne_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.folder_name.5rep_blueprint.list
## make blueprint replicate (5) files
cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-
cd /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint

for par in `cat $dir_10000Ne_5rep/$par_list_new`;do
    # ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb
    for rep in {1..5};do
        echo "$par"_1_"$rep"_MSFS.blueprint >> $blueprint_list_5rep
        ## (300 items.blueprint)
        ## https://stackoverflow.com/questions/76920576/vscode-adds-control-and-script-code-to-first-line-of-output
        ## instead of piping via "for loop" after done to avoid that VSCode adds control and script code to first line of output
    done
done

************************** put content into blueprint files ***************************
## copy $ft_dir_5rep_blueprint_list rom ./10000Ne_5rep to $stairway_dir
ft_dir_5rep_blueprint_list=/home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.5rep_blueprint.list
stairway_dir=/home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint
cp $ft_dir_5rep_blueprint_list $stairway_dir

## put blueprint content into blueprint file according to sample size (10000Ne,100000Ne,1000000Ne)
cd /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint-
cd /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint
## example 5 replicates
# bp_file_names=ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.5rep_blueprint_5.list
## attention to unfinished runs
bp_file_names=ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.5rep_blueprint.list

## final
blueprint_list_5rep=ft_sim_10000Ne_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.folder_name.5rep_blueprint.list
for size in {20,80,200};do
    for bp_file in `grep "$size"hapS $blueprint_list_5rep`;do
        ## 10000Ne,100000Ne,1000000Ne
        #echo $bp_file
        cat ft_sim_10000Ne_"$size"hapS_1E_50G_00d_20Chr_15Mb_1_0_MSFS.blueprint > $bp_file
    done
done

cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep
cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/1000000Ne_5rep

***************** non-pruned (new) *********************
## make blueprint replicate (5) files
cd /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint
blueprint_file_list_5rep=ft_sim_10000Ne_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.5rep_blueprint.file_name.list
## blueprint file name
## ft_sim_10000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1.blueprint
stairway_dir=/home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/10000Ne_5rep

# rm ./10000Ne_5rep/*20hapS*.blueprint
for size in {20,80,200};do
    for bp_file in `grep "$size"hapS $blueprint_file_list_5rep`;do
        ## 10000Ne,100000Ne,1000000Ne
        #echo $bp_file
        cat ft_sim_10000Ne_"$size"hapS_1E_50G_00d_20Chr_15Mb_1_0_MSFS.blueprint > $stairway_dir/$bp_file
    done
done

****************************** replace pattern in blueprint files ***********************
## better way
cd /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint
for i in {1..300};do
    ## modify name and title with AA,CC,DD filename in col2
    ## /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/sfs_file_bp.blueprint.txt
    ## 57 6546 492 3844 1685 4234 2959 6586 5810 4187	ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1_MSFS	ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1_MSFS.blueprint
    sfs1=`awk -F "\t" -v var=$i 'FNR==var {print $2}' sfs_file_20_80_200hapS.blueprint.txt`
    ## attention to input file
    ## blueprint file names in 3rd column
    sfs2=`awk -F "\t" -v var=$i 'FNR==var {print $3}' sfs_file_20_80_200hapS.blueprint.txt`
    sed -i -e "3s/AA/$sfs1/" -e "12s/CC/$sfs1/" -e "20s/DD/$sfs1/" $sfs2
    ## modify pop BB with filename in col1
    ## attention to input file
    sfs3=`awk -F "\t" -v var=$i 'FNR==var {print $1}' sfs_file_20_80_200hapS.blueprint.txt`
    sed -i "7s/BB/$sfs3/" $sfs2
done

******************* non-pruned **********
## dir of blueprint files
blueprint_output_folder_list_5rep
## ft_sim_10000Ne_20hapS_1E_50G_00d_20Chr_15Mb
blueprint_file_list_5rep=ft_sim_10000Ne_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.5rep_blueprint.file_name.list
## ft_sim_10000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1.blueprint

cd /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint
sfs_FilePlotName_20_80_200=sfs_file_20_80_200hapS_non_pruned.blueprint.txt

for i in {1..100};do
    for sample_size in {20hapS,80hapS,200hapS};do
        ## sfs file
        ## modify AA and CC with pop_name and proj_dir_name in column (NF-1)
        #sfs1=`grep "$sample_size" $sfs_FilePlotName_20_80_200 | awk -F "\t" -v var=$i 'FNR==var {print $(NF-1)}'`
        
        ## attention to input file
        
        ## blueprint file names in last column; dir of blueprint files
        sfs2=`grep "$sample_size" $sfs_FilePlotName_20_80_200 | awk -F "\t" -v var=$i 'FNR==var {print $NF}'`
        ## add ".blueprint" file extension
        sfs3=`grep "$sample_size" $sfs_FilePlotName_20_80_200 | awk -F "\t" -v var=$i 'FNR==var {print $NF".blueprint"}'`
        sed -i -e "3s/AA/$sfs2/" -e "12s/CC/$sfs2/" ./10000Ne_5rep/$sfs3
        ## modify pop BB (sfs) and DD with sfs data and plot_title in col1 and column (NF)
        ## attention to input file
        sfs4=`grep "$sample_size" $sfs_FilePlotName_20_80_200 | awk -F "\t" -v var=$i 'FNR==var {$NF=$(NF-1)="";print}' | sed 's/[[:blank:]]*$//'`
        ## issue: sfs4=`grep "$sample_size" $sfs_20_80_200 | awk -F "\t" -v var=$i 'FNR==var {$NF=$(NF-1)=""}1' | sed 's/[[:blank:]]*$//'`
        ## remove excess space
        ## https://unix.stackexchange.com/questions/102008/how-do-i-trim-leading-and-trailing-whitespace-from-each-line-of-some-output
        sed -i -e "7s/BB/$sfs4/" -e "20s/DD/$sfs2/" ./10000Ne_5rep/$sfs3
    done
done


#### run blueprint files ####



## R plot of SFS distribution
sfs_LD05 <- c(117,22997,272,12288,489,8547,651,6181,818,5007,884,3971,1085,3165,1168,2838,1291,2388,1403,2390,1739,2420,2068,2760,2764,3066,3132,3474,3269,3557,3555,3530,3197,3152,3030,2939,2845,28
    48,2763,1213)

sfs_non_prun <- c(30803,16476,11311,8673,6948,5955,4945,4601,4058,3817,3337,3150,2897,2848,2782,2526,2400,2294,2242,2201,2125,2117,2018,1895,1875,1842,1794,1790,1805,1738,1648,1667,1692,1596,1640,1
    626,1648,1629,1659,817)

hap80_sfs_raw <- c(22152,11433,7838,6065,4941,4120,3670,3282,2926,2646,2507,2345,2202,2055,1976,1861,1811,1671,1681,1646,1510,1565,1401,1499,1398,1363,1315,1342,1253,1337,1235,1247,1243,1219,1230,1211,1222,1184,1241,604
)
hap80_sfs_raw_ld05 <- c(16564,8875,6248,4834,4155,3400,3069,2745,2482,2266,2127,1985,1860,1726,1688,1558,1529,1436,1420,1379,1273,1333,1176,1237,1151,1166,1100,1154,1066,1136,1059,1048,1080,1057,1062,1078,1113,1081,1161,582
)
hap80_sfs_raw_ld08 <- c(16910,10155,7198,5679,4556,3850,3411,3077,2751,2507,2350,2194,2071,1930,1857,1725,1707,1573,1560,1531,1421,1467,1295,1366,1304,1282,1223,1261,1186,1243,1161,1160,1185,1147,1137,1140,1160,1103,1171,584
)


plot(1,1,type = "n",xlim=c(0,50), ylim=c(0,30000),col="red",xlab="minor allele frequency",ylab="number of sites")
par(mar=c(5,4,2,2)+0.1,new=TRUE)
#plot(hap80_sfs_raw,type = "l",col="red",xlab="minor allele frequency",ylab="number of sites")
lines(hap80_sfs_raw,type = "l",col="red")
lines(hap80_sfs_raw_ld05,type = "l",col="blue")
lines(hap80_sfs_raw_ld08,type = "l",col="darkorange")
mtext(side=3,text="SFS distribution")
legend("topright",legend = c("hap80_sfs_raw","hap80_sfs_raw_ld05","hap80_sfs_raw_ld08"),col = c("red","blue","darkorange"),lty=1,lwd=2,bty="n")

dev.off()



##
awk -v var=$stable_decrease 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $stable_decrease | cut -f 2-41,82-84
awk '{ for (i = 1; i <= 41; ++i) printf $i"\t"; print "" $42$43}'


## https://www.cyberciti.biz/faq/unix-howto-read-line-by-line-from-file/
#!/bin/bash
input="sfs_file.new.txt"
while IFS= read -r line
do
  cut -f 1 $line
done < $input

input="sfs_file.new.txt"
unfinished_5_list=`sort finished_100000Ne_{1,5}_list | uniq -u`
while IFS= read -r line
do
  cut -f 1 $line
done < $unfinished_5_list