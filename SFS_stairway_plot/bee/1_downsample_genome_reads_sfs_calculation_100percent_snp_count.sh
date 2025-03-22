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

## 2025
## downsample reads
# 01 02 03 04 05 06 07 07 09
for vcf in `ls Andhae.New_REF_AndHae_0_*P_downsample_reads.*x.vcf.gz | sort -V`
# Andhae.New_REF_AndHae_0_9P_downsample_reads.10x.equal_self.sfs

for vcf in `ls Andmar.New_REF_AndMar_0_*P_downsample_reads.*x.vcf.gz | sort -V`

# 100% reads
for vcf in `ls concated.AndHae*noMS.P_10.vcf.gz | sort -V`
# from: concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_1x_1500x_noMS.P_10.equal_self.sfs
# to: Andhae.New_REF_AndHae_0_10P_downsample_reads.1x.equal_self.sfs
for vcf in `ls concated.AndMar*noMS.P_10.vcf.gz | sort -V`
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

## downsample genomes
# linear region selection
for vcf in `ls -t *P_[0-1][0-9].vcf.gz | sort -V`
# issue Mar
for vcf in `ls *Mar*DP_*P_10.issue.vcf.gz | sort -V`

# rerun shuf (random region selection) after deleting them...:)
for vcf in `ls -t *shuf.P_[0-1][0-9].vcf.gz | sort -V`

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

## check the number of nseq by counting space
ls $output_SFS_dir/*shuf*.sfs

less /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data/concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_1x_1500x_noMS.shuf.P_01.equal_self.sfs | grep -o " " | wc -l
39
grep ' ' -o /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data/concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_1x_1500x_noMS.shuf.P_01.equal_self.sfs | wc -l
39

cd $output_SFS_dir
for sfs_file in $(ls ./*shuf*.sfs)
do
count=$(grep ' ' -o $sfs | wc -l)
echo -e "$count\t$sfs_file"
done

*********************** count numbre of SNPs from VCF files *********************
conda activate bcftools
concated_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
cd $concated_vcf_dir
out_snp_no_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/pool_downsample_reads/templates

**********************************************************

## downsampling reads: 10% 20% ... 90% reads
for species in {Andhae,Andmar}
#Andmar.New_REF_AndMar_0_9P_downsample_reads.1x.vcf.gz
#Andmar.New_REF_AndMar_0_9P_downsample_reads.3x.vcf.gz
#Andmar.New_REF_AndMar_0_9P_downsample_reads.5x.vcf.gz
#Andmar.New_REF_AndMar_0_9P_downsample_reads.7x.vcf.gz
#Andmar.New_REF_AndMar_0_9P_downsample_reads.10x.vcf.gz
do
#for vcf in `ls And*P_downsample_reads*10x.vcf.gz | sort -V` # test with 10x
#for vcf in `ls Andhae*P_downsample_reads*x.vcf.gz | sort -V | perl -pe 'm/_(\d+)P_downsample_reads\.(\d+)x/; ($p, $xn) = ($1, $2); $_ = sprintf("%05d_%05d_%s", $xn, $p, $_);' | sort -t '_' -k1,1n -k2,2n | cut -d'_' -f3-`
for vcf in `ls Andmar*P_downsample_reads*x.vcf.gz | sort -V | perl -pe 'm/_(\d+)P_downsample_reads\.(\d+)x/; ($p, $xn) = ($1, $2); $_ = sprintf("%05d_%05d_%s", $xn, $p, $_);' | sort -t '_' -k1,1n -k2,2n | cut -d'_' -f3-`
do
snp_count=$(bcftools query -f "%POS\t" $vcf | wc -l)
echo -e "calculating snp number...$snp_count\t$vcf"
#echo -e "$snp_count \t snp_no: $vcf" >> $out_snp_no_dir/AndHae_snp_number.P_reads_01_02_03_04_05_06_07_08_09_10.DP_1_3_5_7_10x.txt
echo -e "$snp_count" >> $out_snp_no_dir/"$species"_snp_number.P_reads_01_02_03_04_05_06_07_08_09_10.DP_1_3_5_7_10x.txt
done
done

## 100% full genome and full reads

## /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/data_2025_downsample/Scripts/downsample_bam/
## see these vcf file used: 6_systematic_sample_genome.1x_3x_5x_7x_10x.Vet.sh
## four original vcf files
ls -t concated.*AndHae*REF_AndHae*.vcf.gz
concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.GQ_issue_solved.vcf.gz
concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
concated.BomPas_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
concated.BomVet_New_REF_BomVet.100kb_g1500x_regions.vcf.gz

## 100% read group vcf files: from genome 100% genome sampling
## /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/data_2025_downsample/Scripts/downsample_bam/
## 6_systematic_sample_genome.1x_3x_5x_7x_10x.Mar.sh

ls concated.AndMar*noMS.P_10.vcf.gz | sort -V
concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_1x_1500x_noMS.P_10.vcf.gz
concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_3x_1500x_noMS.P_10.vcf.gz
concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_5x_1500x_noMS.P_10.vcf.gz
concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_7x_1500x_noMS.P_10.vcf.gz
concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_10x_1500x_noMS.P_10.vcf.gz
ls concated.AndHae*noMS.P_10.vcf.gz | sort -V
concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_1x_1500x_noMS.P_10.vcf.gz
concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_3x_1500x_noMS.P_10.vcf.gz
concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_5x_1500x_noMS.P_10.vcf.gz
concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_7x_1500x_noMS.P_10.vcf.gz
concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_10x_1500x_noMS.P_10.vcf.gz

## downsampling reads: 100% reads
for species in {AndHae,AndMar}
do
#for vcf in `ls And*P_downsample_reads*10x.vcf.gz | sort -V` # test with 10x
#for vcf in `ls Andhae*P_downsample_reads*x.vcf.gz | sort -V | perl -pe 'm/_(\d+)P_downsample_reads\.(\d+)x/; ($p, $xn) = ($1, $2); $_ = sprintf("%05d_%05d_%s", $xn, $p, $_);' | sort -t '_' -k1,1n -k2,2n | cut -d'_' -f3-`
for vcf in `ls concated."$species"*noMS.P_10.vcf.gz | sort -V`
do
snp_count=$(bcftools query -f "%POS\t" $vcf | wc -l)
echo -e "calculating snp number\t$snp_count\t$vcf"
#echo -e "$snp_count \t snp_no: $vcf" >> $out_snp_no_dir/AndHae_snp_number.P_reads_01_02_03_04_05_06_07_08_09_10.DP_1_3_5_7_10x.txt
#echo -e "$snp_count" >> $out_snp_no_dir/"$species"_snp_number.P_reads_01_02_03_04_05_06_07_08_09_10.DP_1_3_5_7_10x.txt
done
done

# calculating snp number  1815453 concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_1x_1500x_noMS.P_10.vcf.gz
# calculating snp number  1797771 concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_3x_1500x_noMS.P_10.vcf.gz

************************************************

## downsampling genomes
out_snp_no_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/pool_downsample_genome/templates
rm $out_snp_no_dir/*_snp_number.P_genome_01_02_03_04_05_06_07_08_09_10.DP_1_3_5_7_10x.txt
for species in {AndHae,AndMar,BomPas,BomVet}
do
for vcf in `ls concated.*"$species"*DP_*x*noMS.P_*[0-9].vcf.gz | sort -V` # test with 10x
#concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_1x_1500x_noMS.P_01.vcf.gz
#concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_1x_1500x_noMS.P_02.vcf.gz
#concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_1x_1500x_noMS.P_03.vcf.gz
do
snp_count=$(bcftools query -f "%POS\t" $vcf | wc -l)
echo -e "calculating snp number...$snp_count\t$vcf"
#echo -e "$snp_count \t snp_no: $vcf" >> $out_snp_no_dir/AndHae_snp_number.P_reads_01_02_03_04_05_06_07_08_09_10.DP_1_3_5_7_10x.txt
echo -e "$snp_count" >> $out_snp_no_dir/"$species"_snp_number.P_genome_01_02_03_04_05_06_07_08_09_10.DP_1_3_5_7_10x.txt
done

done
