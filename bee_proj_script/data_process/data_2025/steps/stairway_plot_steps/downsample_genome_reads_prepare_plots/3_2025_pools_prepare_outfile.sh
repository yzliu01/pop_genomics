
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/2025_pools/templates

# sfs.final.txt
803 762 626 459 357 256 181 145 88 68 56 36 29 26 17 25 11 18 5 6 7 9 7 3 6 1 6 1 5 6 4 4 3 2 7 2 4 5 5 2 4 5 2 4 2 1 5 4 3 1 ./concated.Rutmac.REF_RutMac.DP_10x.equal_self.sfs ./concated.Rutmac.REF_RutMac.DP_10x.equal_self.sfs

# from: ./concated.Rutmac.REF_RutMac.DP_10x.equal_self.sfs
# to: RutMac_REF_RutMac.DP_10x

for species in {Cerryb_50,Meglea_50,Rutmac_50};do
#for species in {Hae_39,Mar_40};do
    if [ "$species" = "Cerryb_50" ];then
        cat "$species"_dipS.DP_1_3_5_7_10x.sfs |\
        # cut: the delimiter must be a single character
        #cut -d "/" -f 1,3,5 | \
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/concated.Cerryb.REF_CerRyb/CerRyb_REF_CerRyb/g' -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_3_5_7_10x.sfs.blueprint.txt
        # add order numbers to the duplicate runs
        #awk -F "\t" -v OFS="\t" '{$42=++a[$41]}1' | \
        # i is th enumber of columns including numbers and two file names (this became optional for downsampling)
        #awk '{ for (i = 1; i <= 40; ++i) printf $i"\t"; print "" $41$42}' > $out_sub_dir/"$species"_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.txt
        ## https://www.baeldung.com/linux/display-columns-from-file
        ## add a number of the same strings in a column
        ## https://stackoverflow.com/questions/18516301/add-a-number-to-each-line-of-a-file-in-bash
        ## https://unix.stackexchange.com/questions/517985/how-can-i-merge-multiple-column-in-one-column-and-separated-by
    elif [ "$species" = "Meglea_50" ];then
        cat "$species"_dipS.DP_1_3_5_7_10x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/concated.Meglea.REF_MegLea/MegLea_REF_MegLea/g' -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_3_5_7_10x.sfs.blueprint.txt
        #awk -F "\t" -v OFS="\t" '{$43=++a[$41]}1' | \
        #awk '{ for (i = 1; i <= 41; ++i) printf $i"\t"; print "" $42$43}' >> $out_sub_dir/sfs_Ne1000000_hapS_20_80_200_400_5rep_00d_01d_05d_09d_final.blueprint.txt
    
    elif [ "$species" = "Rutmac_50" ];then
        cat "$species"_dipS.DP_1_3_5_7_10x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/concated.Rutmac.REF_RutMac/RutMac_REF_RutMac/g' -e 's/.equal_self.sfs//g' > ./"$species"_dipS.DP_1_3_5_7_10x.sfs.blueprint.txt
        #awk -F "\t" -v OFS="\t" '{$103=++a[$101]}1' | \
        #awk '{ for (i = 1; i <= 101; ++i) printf $i"\t"; print "" $102$103}' >> $out_sub_dir/sfs_Ne1000000_hapS_20_80_200_400_5rep_00d_01d_05d_09d_final.blueprint.txt
    else
        cat "$species"_dipS.DP_1_3_5_7_10x.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/concated\.//g' -e 's/_New//g' -e 's/100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_//g' -e 's/_noMS//g' -e 's/.equal_self.sfs//g' -e 's/_1500x//g' > ./"$species"_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.txt
        #awk -F "\t" -v OFS="\t" '{$203=++a[$201]}1' | \
        #awk '{ for (i = 1; i <= 201; ++i) printf $i"\t"; print "" $202$203}' >> $out_sub_dir/sfs_Ne1000000_hapS_20_80_200_400_5rep_00d_01d_05d_09d_final.blueprint.txt

    fi
done

