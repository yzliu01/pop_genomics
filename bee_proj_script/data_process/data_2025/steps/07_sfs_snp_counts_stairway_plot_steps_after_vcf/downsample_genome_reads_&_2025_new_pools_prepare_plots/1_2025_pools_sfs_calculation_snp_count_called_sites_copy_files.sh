AelAcu_REF_AelAcu.100kb_1500x_region_vcf_file.list
AgeAln_REF_AgeAln.100kb_1500x_region_vcf_file.list
AmpSol_REF_AmpSol.100kb_1500x_region_vcf_file.list
##AphSti_REF_AphSti.100kb_1500x_region_vcf_file.list
BibMar_REF_BibMar.100kb_1500x_region_vcf_file.list
##BomMaj_REF_BomMaj.100kb_1500x_region_vcf_file.list
##CerRyb_REF_CerRyb.100kb_1500x_region_vcf_file.list
DorPar_REF_DorPar.100kb_1500x_region_vcf_file.list
##EphDan_REF_EphDan.100kb_1500x_region_vcf_file.list
EriInt_REF_EriInt.100kb_1500x_region_vcf_file.list
EriPer_REF_EriPer.100kb_1500x_region_vcf_file.list
GerLac_REF_GerLac.100kb_1500x_region_vcf_file.list
LasMor_REF_LasMor.100kb_1500x_region_vcf_file.list
LepDol_REF_LepDol.100kb_1500x_region_vcf_file.list
MalBip_REF_MalBip.100kb_1500x_region_vcf_file.list
##MegLea_REF_MegLea.100kb_1500x_region_vcf_file.list
MysLon_REF_MysLon.100kb_1500x_region_vcf_file.list
NocPro_REF_NocPro.100kb_1500x_region_vcf_file.list
##NotGla_REF_NotGla.100kb_1500x_region_vcf_file.list
##OchPle_REF_OchPle.100kb_1500x_region_vcf_file.list
## no grasshoppers
PanBan_REF_PanBan.100kb_1500x_region_vcf_file.list
PhoAtr_REF_PhoAtr.100kb_1500x_region_vcf_file.list
##PhrFul_REF_PhrFul.100kb_1500x_region_vcf_file.list
PorSca_REF_PorSca.100kb_1500x_region_vcf_file.list
PteNig_REF_PtgNig.100kb_1500x_region_vcf_file.list
RhaFul_REF_RhaFul.100kb_1500x_region_vcf_file.list
##RutMac_REF_RutMac.100kb_1500x_region_vcf_file.list
##SteMel_REF_SteMel.100kb_1500x_region_vcf_file.list
TacFer_REF_TacFer.100kb_1500x_region_vcf_file.list
ThoDec_REF_ThoDec.100kb_1500x_region_vcf_file.list
XesNig_REF_XesNig.100kb_1500x_region_vcf_file.list


********    "sfs for softmasked+gene_regions"   ********
## 2025 new pools
conda activate bcftools
output_SFS_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data
concated_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
cd $concated_vcf_dir

## 3 species
#for vcf in `ls -t concated*vcf.gz | head -15 | sort -V`

## new pools no PorSca
for vcf in `ls -t *x.vcf.gz | head -30 | sort -V`
    do
    output_sfs_name=${vcf/vcf.gz/equal_self}
    ## concated.Meglea.REF_MegLea.DP_10x.equal_self
    bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' $vcf | \
        awk '{if ($3 <= $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c | \
        awk '$1=$1'| cut -d ' ' -f 1 | tr '\n' ' ' > $output_SFS_dir/$output_sfs_name.sfs
        ## $1=$1 is an assignment operation in awk. 
        ## It reassigns the first field ($1) to itself, which forces awk to rebuild the current line using the default output field separator (a single space).

        ## print the sfs in terminal
        echo -e $output_sfs_name.sfs"\n"
        cat $output_SFS_dir/$output_sfs_name.sfs
        ## new 10 pools
        ## SteMel_REF_SteMel.DP_1x.equal_self.sfs
        
        ## early 3 pools
        ## concated.Meglea.REF_MegLea.DP_10x.equal_self.sfs

        echo -e "\n"
done


## check the number of space to know if sfs nseq is correct
## search for the string count= in all files within the specified directory
output_SFS_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data
## below in snp count
#find /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/ -type f -exec grep 'count=' {} +

cd $output_SFS_dir

## Rut Cer Meg
#for sfs_file in $(ls -t ./*.sfs | head -15 | sort -V)
## for all 10 species
for sfs_file in $(ls -t ./*.sfs | head -50 | sort -V)

for sfs_file in $(ls -t ./*.sfs | head -30 | sort -V)
do
count=$(grep ' ' -o $sfs_file | wc -l)
echo -e "$count\t$sfs_file"
done

## to be deleted, similar work in 2_2025...
''''''''''''
## check number of snps
dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/data_2025_downsample/Scripts/stairway_plot/downsample_genome_reads_prepare_plots/1_downsample_genome_reads_sfs_calculation.sh


# cat sfs for each dataset in one file
#cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
output_SFS_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data
cd $output_SFS_dir
out_cat_sfs_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/2025_pools/templates


## target files
for species in {AphSti,BomMaj,CerRyb,EphDan,MegLea,NotGla,OchPle,PhrFul,RutMac,SteMel}
## early test
#for species in {Cerryb,Meglea,Rutmac}
do
sfs_list=$(ls -t ./*$species*.sfs | head -15 | sort -V)

for sfs in ${sfs_list[@]}
do
echo "concatenating: $sfs"
#head $sfs
## 3 test pools
#cat $sfs >> $out_cat_sfs_dir/$species.1_3_5_7_10x.sfs

## new pools
cat $sfs >> $out_cat_sfs_dir/$species.1_1.5_2x.sfs
done

done
''''''''''''
*********************** get number of called site from excel file ********************
## go here
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/data_2025/steps/456_concate_vcf_genome_fraction_bam_stats/
4_5_2025_10_pools_concate_vcf_filtering_genome_fraction_depth_bgzip_decompress.sh

*********************** count numbre of SNPs from VCF files *********************
conda activate bcftools
concated_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
cd $concated_vcf_dir
out_snp_no_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/2025_pools/templates

#for species in {Cerryb,Meglea,Rutmac}
## delete old files
#rm $out_snp_no_dir/*_snp_number.DP_1_3_5_7_10x.txt

#rm $out_snp_no_dir/10_pools.snp_number.DP_1_1.5_2x.txt

## retrive snp count for each species at different DP levels
for species in {AelAcu,AgeAln,AmpSol,EriInt,EriPer,GerLac,LasMor,LepDol,MalBip,MysLon,PhoAtr,PorSca,RhaFul,TacFer,ThoDec,XesC-n}
do
#for depth in {1x,3x,5x,7x,10x}
## new 
#for depth in {1x,1.5x,2x}
#for depth in {1x,1.5x,2x,2.5x,3x}
#do
#echo $depth
#done

#concated.Cerryb.REF_CerRyb.DP_1x.vcf.gz
#concated.Meglea.REF_MegLea.DP_1x.vcf.gz
#concated.Rutmac.REF_RutMac.DP_1x.vcf.gz
## the number depends on number of depth
#for vcf in `ls -t concated.*$depth*vcf.gz | head -3 | sort -V`
#for vcf in `ls -t *$depth*vcf.gz | head -10 | sort -V`
for vcf in `ls -t $species*vcf.gz | head -2 | sort -V`
## new vcf 
## ## SteMel_REF_SteMel.1x.vcf.gz
## in the order: 1x,1.5x,2x,2.5x,3x

## sort out in specific order
#for vcf in `ls Andmar*P_downsample_reads*x.vcf.gz | sort -V | perl -pe 'm/_(\d+)P_downsample_reads\.(\d+)x/; ($p, $xn) = ($1, $2); $_ = sprintf("%05d_%05d_%s", $xn, $p, $_);' | sort -t '_' -k1,1n -k2,2n | cut -d'_' -f3-`
do
snp_count=$(bcftools query -f "%POS\t" $vcf | wc -l)
echo -e "calculating snp number\t$snp_count\t$vcf"
#echo -e "$snp_count \t snp_no: $vcf" >> $out_snp_no_dir/AndHae_snp_number.P_reads_01_02_03_04_05_06_07_08_09_10.DP_1_3_5_7_10x.txt
#echo -e "$snp_count" >> $out_snp_no_dir/Cer_Meg_Rut.snp_number.DP_1_3_5_7_10x.txt
#echo -e "$snp_count" >> $out_snp_no_dir/10_pools.snp_number.DP_1_1.5_2x.txt
#echo -e "$snp_count" >> $out_snp_no_dir/10_pools.snp_number.DP_1_1.5_2_2.5_3x.new.txt
echo -e "$snp_count" >> $out_snp_no_dir/16_pools.snp_number.DP_1_1.5x.txt
done
done

## then add comma for the numbers

## create new files
for i in $(ls -t *_50*genome.txt | head);do echo $i;cp $i $i.new;done
## remove ","
for i in $(ls -t *_50*genome.txt.new | head);do echo $i;sed -i 's/,//g' $i;done


******************* make copies of called sites and SNP files using AelAcu as a template *******************
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/2025_pools/templates/
for species in {AgeAln,AmpSol,EriInt,EriPer,GerLac,LasMor,LepDol,MalBip,MysLon,PhoAtr,PorSca,RhaFul,TacFer,ThoDec,XesC-n}
do
## create snp files (copy from excel to text files)
cp AelAcu_snp_number.DP_1_1.5x.txt "$species"_snp_number.DP_1_1.5x.txt
## create called site files (copy from excel to text files)
cp AelAcu_50_number_called_sites_across_genome.txt "$species"_50_number_called_sites_across_genome.txt
done
## AelAcu_50_number_called_sites_across_genome.txt

## optional
## called sites revised from snp number files (due to errors)
for snp_list in $(ls *snp_number.DP_1_1.5x.txt)
do
new_name=${snp_list/snp_number.DP_1_1.5x.txt/50_number_called_sites_across_genome.txt}
cp $snp_list $new_name
## remove comma
sed 's/,//g' $new_name > $new_name.new
done
