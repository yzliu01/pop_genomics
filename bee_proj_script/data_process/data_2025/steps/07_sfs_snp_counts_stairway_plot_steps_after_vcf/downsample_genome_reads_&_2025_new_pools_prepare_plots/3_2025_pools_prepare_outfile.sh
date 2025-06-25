
# sfs.final.txt
803 762 626 459 357 256 181 145 88 68 56 36 29 26 17 25 11 18 5 6 7 9 7 3 6 1 6 1 5 6 4 4 3 2 7 2 4 5 5 2 4 5 2 4 2 1 5 4 3 1 ./concated.Rutmac.REF_RutMac.DP_10x.equal_self.sfs ./concated.Rutmac.REF_RutMac.DP_10x.equal_self.sfs

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/2025_pools/templates

# from: ./concated.Rutmac.REF_RutMac.DP_10x.equal_self.sfs
# to: RutMac_REF_RutMac.DP_10x
## early test with 3 species
#for species in {Cerryb_50,Meglea_50,Rutmac_50};do
#for species in {Hae_39,Mar_40};do

## 10 new pools
#for species in {AphSti_50,BomMaj_50,CerRyb_50,EphDan_50,MegLea_50,NotGla_50,OchPle_50,PhrFul_50,RutMac_50,SteMel_50};do
## 16 new pools
#PorSca_50
for species in {AelAcu_50,AgeAln_50,AmpSol_50,EriInt_50,EriPer_50,GerLac_50,LasMor_50,LepDol_50,MalBip_50,MysLon_50,PhoAtr_50,RhaFul_50,TacFer_50,ThoDec_50,XesC-n_50};do

    if [ "$species" = "AphSti_50" ];then
        ## few depth
        #cat "$species"_dipS.DP_1_1.5_2x.sfs |\
        ## more depth
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        # cut: the delimiter must be a single character
        #cut -d "/" -f 1,3,5 | \
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt
        ## few depth
        #sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5_2x.sfs.blueprint.txt
        ## new 10 pools
        ## SteMel_REF_SteMel.DP_1x.equal_self.sfs

        ## no need below as new output vcf file names are simple
        ## early 3 pools
        ## -e 's/concated.AphSti_REF_AphSti/AphSti_REF_AphSti/g'

        # add order numbers to the duplicate runs
        #awk -F "\t" -v OFS="\t" '{$42=++a[$41]}1' | \
        # i is th enumber of columns including numbers and two file names (this became optional for downsampling)
        #awk '{ for (i = 1; i <= 40; ++i) printf $i"\t"; print "" $41$42}' > $out_sub_dir/"$species"_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.txt
        ## https://www.baeldung.com/linux/display-columns-from-file
        ## add a number of the same strings in a column
        ## https://stackoverflow.com/questions/18516301/add-a-number-to-each-line-of-a-file-in-bash
        ## https://unix.stackexchange.com/questions/517985/how-can-i-merge-multiple-column-in-one-column-and-separated-by

    elif [ "$species" = "BomMaj_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt
        #awk -F "\t" -v OFS="\t" '{$43=++a[$41]}1' | \
        #awk '{ for (i = 1; i <= 41; ++i) printf $i"\t"; print "" $42$43}' >> $out_sub_dir/sfs_Ne1000000_hapS_20_80_200_400_5rep_00d_01d_05d_09d_final.blueprint.txt

    elif [ "$species" = "CerRyb_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt

    elif [ "$species" = "EphDan_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt

    elif [ "$species" = "MegLea_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt

    elif [ "$species" = "NotGla_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt

    elif [ "$species" = "OchPle_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt

    elif [ "$species" = "PhrFul_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt
  
    elif [ "$species" = "RutMac_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt

    elif [ "$species" = "SteMel_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt
# 16 new pools
    elif [ "$species" = "AelAcu_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt

    elif [ "$species" = "AgeAln_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt

    elif [ "$species" = "AmpSol_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt

    elif [ "$species" = "EriInt_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt

    elif [ "$species" = "EriPer_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt

    elif [ "$species" = "GerLac_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt

    elif [ "$species" = "LasMor_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt

    elif [ "$species" = "LepDol_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt

    elif [ "$species" = "MalBip_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt

    elif [ "$species" = "MysLon_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt

    elif [ "$species" = "PhoAtr_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt
#PorSca_50
    elif [ "$species" = "PorSca_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt

    elif [ "$species" = "RhaFul_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt

    elif [ "$species" = "TacFer_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt

    elif [ "$species" = "ThoDec_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt

    elif [ "$species" = "XesC-n_50" ];then
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt

## ignore this one
    else
        cat "$species"_dipS.DP_1_1.5x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/concated\.//g' -e 's/_New//g' -e 's/.equal_self.sfs//g' -e 's/_1500x//g' > ./"$species"_dipS.DP_1_1.5x.sfs.blueprint.txt
        #awk -F "\t" -v OFS="\t" '{$203=++a[$201]}1' | \
        #awk '{ for (i = 1; i <= 201; ++i) printf $i"\t"; print "" $202$203}' >> $out_sub_dir/sfs_Ne1000000_hapS_20_80_200_400_5rep_00d_01d_05d_09d_final.blueprint.txt

    fi
done

