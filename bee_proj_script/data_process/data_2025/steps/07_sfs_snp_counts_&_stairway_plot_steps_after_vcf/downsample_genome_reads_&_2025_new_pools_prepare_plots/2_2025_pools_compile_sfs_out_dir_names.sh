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

# attention to the order of files (new final depth: 1x 1.5x 2x)
./concated.CerRyb.REF_CerRyb.DP_1x.equal_self.sfs
./concated.CerRyb.REF_CerRyb.DP_1.5x.equal_self.sfs
./concated.CerRyb.REF_CerRyb.DP_2x.equal_self.sfs

# early test
#./concated.Cerryb.REF_CerRyb.DP_1x.equal_self.sfs
#./concated.Cerryb.REF_CerRyb.DP_3x.equal_self.sfs
#./concated.Cerryb.REF_CerRyb.DP_5x.equal_self.sfs
#./concated.Cerryb.REF_CerRyb.DP_7x.equal_self.sfs
#./concated.Cerryb.REF_CerRyb.DP_10x.equal_self.sfs

## all: checked methods
input_sfs_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data
cd $input_sfs_dir
#out_sfs_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/pool_downsample_reads/templates
out_sfs_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/2025_pools/templates

# delete old sfs files
#rm $out_sfs_dir/*.sfs

for species in {AphSti,BomMaj,CerRyb,EphDan,MegLea,NotGla,OchPle,PhrFul,RutMac,SteMel};do
## next batch
#for species in {AphSti,BomMaj,CerRyb,EphDan,MegLea,NotGla,OchPle,PhrFul,RutMac,SteMel};do
## early test with 3 species
#for species in {Cerryb,Meglea,Rutmac};do
    ## different sort orders
    sfs1=`find -maxdepth 1 -print | grep "$species" | egrep -v "concated" | egrep "DP_[0-9]" | grep "equal_self.sfs$" | sort -V`
    ## ./concated.CerRyb.REF_CerRyb.DP_1x.equal_self.sfs

    ## downsample linear genome
    #sfs1=`find -maxdepth 1 -print | grep "$species" | egrep "P_[0-1][0-9]" | grep "equal_self.sfs$" | sort -V`
    ## downsample reads
    #sfs1=`find -maxdepth 1 -print | grep "$species" | egrep '_[0-9]P|_[0-1][0-9]P' | grep "equal_self.sfs$" | perl -pe 'm/_(\d+)P_downsample_reads\.(\d+)x/; ($p, $xn) = ($1, $2); $_ = sprintf("%05d_%05d_%s", $xn, $p, $_);' | sort -t '_' -k1,1n -k2,2n | cut -d'_' -f3-`
    sfs2=`find -maxdepth 1 -print | grep "xxxxx_old_script" | sort -V`

# species: AphSti - 50 ind
    if [ "$species" = "AphSti" ];then
        for file_name in $sfs1;do
            #    echo -e "\n"
            #new_file_name=${file_name//}
            
            ## 1x, 1.5x, 2x
            #awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2x.sfs;
            
            ## 1x, 1.5x, 2x, 2.5x, 3x
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
            ## https://unix.stackexchange.com/questions/638196/how-to-print-in-only-one-column-if-condition-with-awk
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_5rep_final.txt
            
            ## delete old files
            # ls $out_sfs_dir/*hapS_5rep_*00d*_final* | grep -v '200_300G' | xargs rm
        done
        
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done

# species: BomMaj - 50 ind
    elif [ "$species" = "BomMaj" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done

# species: CerRyb - 50 ind
    elif [ "$species" = "CerRyb" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done

# species: EphDan - 50 ind
    elif [ "$species" = "EphDan" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done

# species: Meglea - 50 ind
    elif [ "$species" = "MegLea" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done

# species: NotGla - 50 ind
    elif [ "$species" = "NotGla" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done

# species: OchPle - 50 ind
    elif [ "$species" = "OchPle" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done

# species: PhrFul - 50 ind
    elif [ "$species" = "PhrFul" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done

# species: Rutmac - 50 ind
    elif [ "$species" = "RutMac" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done

# species: SteMel - 50 ind
    elif [ "$species" = "SteMel" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done

### rest species

# species: AelAcu - 50 ind
    elif [ "$species" = "AelAcu" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done

# species: AgeAln - 50 ind
    elif [ "$species" = "AgeAln" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
# species: AmpSol - 50 ind
    elif [ "$species" = "AmpSol" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
# species: BibMar - 50 ind
    elif [ "$species" = "BibMar" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
# species: DorPar - 50 ind
    elif [ "$species" = "DorPar" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
# species: EriInt - 50 ind
    elif [ "$species" = "EriInt" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
# species: EriPer - 50 ind
    elif [ "$species" = "EriPer" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
# species: GerLac - 50 ind
    elif [ "$species" = "GerLac" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
# species: LasMor - 50 ind
    elif [ "$species" = "LasMor" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
# species: LepDol - 50 ind
    elif [ "$species" = "LepDol" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
# species: MalBip - 50 ind
    elif [ "$species" = "MalBip" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
# species: MysLon - 50 ind
    elif [ "$species" = "MysLon" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
# species: NocPro - 50 ind
    elif [ "$species" = "NocPro" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
# species: PanBan - 50 ind
    elif [ "$species" = "PanBan" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
# species: PhoAtr - 50 ind
    elif [ "$species" = "PhoAtr" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
# species: PorSca - 50 ind
    elif [ "$species" = "PorSca" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
# species: PteNig - 50 ind
    elif [ "$species" = "PteNig" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
# species: RhaFul - 50 ind
    elif [ "$species" = "RhaFul" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
# species: TacFer - 50 ind
    elif [ "$species" = "TacFer" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
# species: ThoDec - 50 ind
    elif [ "$species" = "ThoDec" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done
# species: XesNig - 50 ind
    elif [ "$species" = "XesNig" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done

    else
# species: Vet
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-31 >> $out_sfs_dir/"$species"_29_dipS.DP_1_1.5_2_2.5_3x.sfs;
            #awk 'NR>=3,NR<=5' $i | cut -d " " -f 2-101 >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt;
            #echo -e "\t$i\t$i" >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
            ## result file: sfs_1000000Ne_200hapS_5rep_for_bp_non_pruned.txt
        done
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-31 >> $out_sfs_dir/"$species"_29_dipS.DP_1_1.5_2_2.5_3x.sfs;
        done

    fi
done
