*********** step I: create a file name list for each blueprint file ************
# to the sfs.blueprint.txt file directory
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint
#sfs_file_name=sfs_Ne1000000_hapS_20_80_200_400_5rep_00d_01d_05d_09d_final.blueprint.txt
compiled_sfs=Hae_39_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.txt
compiled_sfs=Mar_40_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.txt
compiled_sfs=Pas_34_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.txt
compiled_sfs=Vet_29_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.txt

# output file folder names
#blueprint_file_list_5rep=sfs_Ne1000000_hapS_20_80_200_400_5rep_00d_01d_05d_09d_final.5rep_blueprint.file_name.list
blueprint_file_name=Hae_39_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.folder_name.list
blueprint_file_name=Mar_40_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.folder_name.list
blueprint_file_name=Pas_34_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.folder_name.list
blueprint_file_name=Vet_29_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.folder_name.list

## take the (last) 3rd column
#awk '{print $NF".blueprint"}' $sfs_file_name > $blueprint_file_list_5rep
awk '{print $NF".blueprint"}' $compiled_sfs > $blueprint_file_name


# simplier way of using for loop
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/pool_downsample_genome/templates
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/pool_shuf_downsample_genome/templates

for compiled_sfs in `ls -t *_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.txt`
do
echo $compiled_sfs
head -1 $compiled_sfs
blueprint_file_name=${compiled_sfs/txt/folder_name.list}
# create a file of name list of blueprint files
awk '{print $NF".blueprint"}' $compiled_sfs > $blueprint_file_name
done



******************* step II: create blueprint files using blueprint file name list *********************
## make blueprint replicate (5) files
#cd /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint
#blueprint_file_list_5rep=sfs_file_20_80_200hapS_10_2_e_id_cons_non_pruned.5rep_blueprint.file_name.list

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/pool_downsample_genome
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/pool_shuf_downsample_genome

## blueprint.folder_name.list
#Hae_39_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.folder_name.list
#Mar_40_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.folder_name.list
#Pas_34_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.folder_name.list
#Vet_29_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.folder_name.list

## create blueprint files using blueprint file name list
## example lines
#AndHae_REF_AndHae.DP_1x.P_01.blueprint
#AndHae_REF_AndHae.DP_1x.P_02.blueprint
#blueprint_file_name_list=`ls *_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.folder_name.list | sort -V`

for species in {Hae_39,Mar_40,Pas_34,Vet_29};do
    for bp_file in `cat ./templates/"$species"_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.folder_name.list`;do
        #echo $bp_file by using templates
        cat ./templates/template_for_pool_downsample_genome."$species".blueprint > $bp_file
    done
done


****************** step III: replace data and pattern in blueprint files ***********************
## blueprint files
#"$species"_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.folder_name.list`

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/pool_downsample_genome
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/pool_shuf_downsample_genome

for i in {1..50};do
    #for sample_size in {20hapS,80hapS,200hapS,400hapS};do
    for species in {Hae_39,Mar_40,Pas_34,Vet_29};do
        ## sfs file
        ## modify xx with number of called sites across the genomes or proportion of genomes
        #sfs1=`cat "$species"_number_called_sites_across_genome.txt | awk -F "\t" -v var=$i 'FNR==var {print $(NF-1)}'`
        
        # get the number of called sites across genome from a specific row and last column in a file
        #  Hae_39_number_called_sites_across_genome.txt
        
        ## shuf        
        sfs1=`cat ./templates/"$species"_number_called_sites_shuf_across_genome.txt | awk -F " " -v var=$i 'FNR==var {print $NF}'`
        
        ## linear
        #sfs1=`cat ./templates/"$species"_number_called_sites_across_genome.txt | awk -F " " -v var=$i 'FNR==var {print $NF}'`
        
        ## blueprint file names in last column; dir of blueprint files
        sfs2=`cat ./templates/"$species"_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.folder_name.list | sed 's/.blueprint//' | awk -F " " -v var=$i 'FNR==var {print $NF}'`
        
        ## replace string in .blueprint files: popid (AA), project_dir (CC), plot title (DD) from the last col (NF)
        sfs3=`cat ./templates/"$species"_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.folder_name.list | awk -F " " -v var=$i 'FNR==var {print $NF}'`
        sed -i -e "3s/AA/$sfs2/" -e "12s/CC/$sfs2/" -e "20s/DD/$sfs2/" "$sfs3"
        echo "editing popid, project_dir, plot_title: $sfs3"

        ## modify the number of called sites (xx) and pop BB (sfs) with sfs data in col1
        ## attention to input file (set the last two columns empty $NF=$(NF-1)="")
        sfs4=`cat ./templates/"$species"_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.txt | awk -F " " -v var=$i 'FNR==var {$NF=$(NF-1)="";print}' | sed 's/[[:blank:]]*$//'`
        ## issue: sfs4=`grep "$sample_size" $sfs_20_80_200_400 | awk -F "\t" -v var=$i 'FNR==var {$NF=$(NF-1)=""}1' | sed 's/[[:blank:]]*$//'`
        ## remove excess space
        ## https://unix.stackexchange.com/questions/102008/how-do-i-trim-leading-and-trailing-whitespace-from-each-line-of-some-output
        sed -i -e "5s/xx/$sfs1/" -e "7s/BB/$sfs4/" "$sfs3"
        echo "editing called site (xx), pop_sfs: $sfs3"

    done
done

## check the number of snps
dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/SFS_stairway_plot/bee/
1_downsample_genome_reads_sfs_calculation_100percent_snp_count.sh

#### run blueprint files ####
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/fsc_sim_stairway/scripts/3_stairway_plot
bees_4pools.DP_1x_3x_5x_7x_10x.P_01_02_03_04_05_06_07_08_09_10.no_singleton.sm_genic.gt_1.sh
