*********** step I: create a file name list for each blueprint file ************
# to the sfs.blueprint.txt file directory
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/2025_pools/templates

#for compiled_sfs in `ls -t *_dipS.DP_1_1.5_2x.sfs.blueprint.txt`
for compiled_sfs in `ls -t *_dipS.DP_1_1.5_2_2.5_3x.sfs.blueprint.txt`
do
echo $compiled_sfs
#head -1 $compiled_sfs
blueprint_file_name=${compiled_sfs/txt/folder_name.list}
# create a file of name list of blueprint files
awk '{print $NF".blueprint"}' $compiled_sfs > $blueprint_file_name
done

# Rutmac_50_dipS.DP_1_3_5_7_10x.sfs.blueprint.folder_name.list
RutMac_REF_RutMac.DP_1x.blueprint
RutMac_REF_RutMac.DP_3x.blueprint
RutMac_REF_RutMac.DP_5x.blueprint
RutMac_REF_RutMac.DP_7x.blueprint
RutMac_REF_RutMac.DP_10x.blueprint


******************* step II: create blueprint files using blueprint file name list *********************
## make blueprint replicate (5) files
#cd /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint
#blueprint_file_list_5rep=sfs_file_20_80_200hapS_10_2_e_id_cons_non_pruned.5rep_blueprint.file_name.list

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/2025_pools/templates
## blueprint.folder_name.list
## Rutmac_50_dipS.DP_1_3_5_7_10x.sfs.blueprint.folder_name.list

## create blueprint files using blueprint file name list
## example lines
#AndHae_REF_AndHae.DP_1x.P_01.blueprint
#AndHae_REF_AndHae.DP_1x.P_02.blueprint
#blueprint_file_name_list=`ls *_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.folder_name.list | sort -V`
## early test
#for species in {Cerryb_50,Meglea_50,Rutmac_50};do

## new 
## template.RutMac_50.no_singleton_sfs_nx_1500x.sm_genic.blueprint
for species in {AphSti_50,BomMaj_50,CerRyb_50,EphDan_50,MegLea_50,NotGla_50,OchPle_50,PhrFul_50,RutMac_50,SteMel_50};do

    for bp_file in `cat ./"$species"_dipS.DP_1_1.5_2_2.5_3x.sfs.blueprint.folder_name.list`;do
    #for bp_file in `cat ./"$species"_dipS.DP_1_1.5_2x.sfs.blueprint.folder_name.list`;do
        #echo $bp_file by using templates

        ## save blueprint files in folder: 2025_pools
        cat ./template."$species".no_singleton_sfs_nx_1500x.sm_genic.blueprint > $bp_file
        ## test data
        #cat ../test/template."$species".no_singleton_sfs_nx_1500x.sm_genic.blueprint > $bp_file

        ## use RutMac_50 as the example
        #cat ./template."RutMac_50".no_singleton_sfs_nx_1500x.sm_genic.blueprint > $bp_file
        ## template.Cerryb_50.no_singleton_sfs_nx_1500x.sm_genic.blueprint
    done
done


****************** step III: replace data and pattern in blueprint files ***********************
## blueprint files
#"$species"_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.folder_name.list`

CerRyb_REF_CerRyb.DP_1x.blueprint
CerRyb_REF_CerRyb.DP_3x.blueprint
CerRyb_REF_CerRyb.DP_5x.blueprint
CerRyb_REF_CerRyb.DP_7x.blueprint
CerRyb_REF_CerRyb.DP_10x.blueprint

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/2025_pools

## early five depth: DP_1_3_5_7_10x
#for i in {1..5};do
#    for species in {Cerryb_50,Meglea_50,Rutmac_50};do

## new pools for three depth: 1_1.5_2x
#for i in {1..3};do

## new pools for three depth: 1_1.5_2_2.5_3x
for i in {1..5};do
    for species in {AphSti_50,BomMaj_50,CerRyb_50,EphDan_50,MegLea_50,NotGla_50,OchPle_50,PhrFul_50,RutMac_50,SteMel_50};do
        ## sfs file
        ## modify xx with number of called sites across the genomes or proportion of genomes
        #sfs1=`cat "$species"_number_called_sites_across_genome.txt | awk -F "\t" -v var=$i 'FNR==var {print $(NF-1)}'`
        
#       get the number of called sites across genome from a specific row corresponding to a different depth (1_3_5_7_10x) and last column in a file
#       387,938,478
#       23,778,604
#       11,049,691
#       6,338,796
#       2,876,814
#       Cerryb_50_number_called_sites_across_genome.txt

        ## numbers without comma
        sfs1=`cat ./"$species"_number_called_sites_across_genome.txt.new | awk -F " " -v var=$i 'FNR==var {print $NF}'`
        
        ## blueprint file names in last column; dir of blueprint files
## early test        
##        sfs2=`cat ./templates/"$species"_dipS.DP_1_3_5_7_10x.sfs.blueprint.folder_name.list | sed 's/.blueprint//' | awk -F " " -v var=$i 'FNR==var {print $NF}'`

## new pools
#        sfs2=`cat ./templates/"$species"_dipS.DP_1_1.5_2x.sfs.blueprint.folder_name.list | sed 's/.blueprint//' | awk -F " " -v var=$i 'FNR==var {print $NF}'`
        sfs2=`cat ./"$species"_dipS.DP_1_1.5_2_2.5_3x.sfs.blueprint.folder_name.list | sed 's/.blueprint//' | awk -F " " -v var=$i 'FNR==var {print $NF}'`
        
        ## replace string in .blueprint files: popid (AA), project_dir (CC), plot title (DD) from the last col (NF)
        sfs3=`cat ./"$species"_dipS.DP_1_1.5_2_2.5_3x.sfs.blueprint.folder_name.list | awk -F " " -v var=$i 'FNR==var {print $NF}'`
        sed -i -e "3s/AA/$sfs2/" -e "12s/CC/$sfs2/" -e "20s/DD/$sfs2/" "$sfs3"
        echo "editing popid, project_dir, plot_title: $sfs3"

        ## modify the number of called sites (xx) and pop BB (sfs) with sfs data in col1
        ## attention to input file (set the last two columns empty $NF=$(NF-1)="")
        sfs4=`cat ./"$species"_dipS.DP_1_1.5_2_2.5_3x.sfs.blueprint.txt | awk -F " " -v var=$i 'FNR==var {$NF=$(NF-1)="";print}' | sed 's/[[:blank:]]*$//'`
        ## issue: sfs4=`grep "$sample_size" $sfs_20_80_200_400 | awk -F "\t" -v var=$i 'FNR==var {$NF=$(NF-1)=""}1' | sed 's/[[:blank:]]*$//'`
        ## remove excess space
        ## https://unix.stackexchange.com/questions/102008/how-do-i-trim-leading-and-trailing-whitespace-from-each-line-of-some-output
        sed -i -e "5s/xx/$sfs1/" -e "7s/BB/$sfs4/" "$sfs3"
        echo "editing called site (xx), pop_sfs: $sfs3"

    done
done


#### run blueprint files ####
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/fsc_sim_stairway/scripts/3_stairway_plot
bees_4pools.DP_1x_3x_5x_7x_10x.P_01_02_03_04_05_06_07_08_09_10.no_singleton.sm_genic.gt_1.sh
