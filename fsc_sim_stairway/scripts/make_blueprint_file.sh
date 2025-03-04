
## downsample
for i in `ls -t *.blueprint | head -6`; do cp $i "$i.0_3";done
for i in `ls -t *.blueprint.0_3`; do sed -i 's/_0_2/_0_3/g' $i;done

## create new blueprint files and rename them
#for i in `ls -t *blueprint | head -6`
for i in $(ls -t *blueprint | head -6) # preferred
do
cp $i $i.new
#rename 's/0_5/0_6/; s/\.new$//' $i.new 
# rename: not enough arguments
# Try 'rename --help' for more information.

new_name=$(echo $i | sed 's/0_5/0_6/;s/\.new$//'); mv $i.new $new_name # change file names
done

## change text in place in the files
for file in $(ls -t *_0_6*blueprint | head -6) # preferred
do
sed -i 's/0_5/0_6/g' $file
done


cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/bee_pools_blueprint
## convert space in filename into "_"
## https://linuxconfig.org/remove-or-substitute-space-within-a-file-name
ls . | grep copy | while read -r f; do mv "$f" `echo $f | tr ' ' '_'`; done

rename copy softmasked *copy*
sed -i 's/sfs_200x_extended/sfs_200x_extended_softmasked/' *copy*

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/bee_pools_blueprint/New_REF
## make copies of blueprint files
for bp in `ls *extended.blueprint`
    do
    new_bp=${bp/extended.blueprint/extended.sm_ann_no_mis.blueprint}
    cp $bp $new_bp
done
## modify blueprint files
sed -i 's/sfs_200x_extended/sfs_200x_extended_sm_ann_no_mis/' *sm_ann_no_mis.blueprint

## mel_dro
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/dro_mel_4_groups_blueprint
for bp in `ls *recent*blueprint`
    do
    new_bp=${bp/recent.blueprint/New_REF.blueprint}
    cp $bp $new_bp
done
sed -i 's/dro_mel_4_groups_recent_plot/dro_mel_4_groups_New_REF/' *New_REF.blueprint

for bp in `ls *New_REF*blueprint`
    do
    new_bp=${bp/New_REF.blueprint/no_singleton.New_REF.blueprint}
    cp $bp $new_bp
done
sed -i 's/dro_mel_4_groups_New_REF/dro_mel_4_groups_no_singleton_New_REF/' *no_singleton.New_REF.blueprint
for bp in `ls *no_singleton*New_REF*blueprint`
    do
    new_bp=${bp/no_singleton/doubleton}
    cp $bp $new_bp
    sed -i 's/dro_mel_4_groups_no_singleton_New_REF/dro_mel_4_groups_no_doubleton_New_REF/' $new_bp
done

## singletons removed

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/1000000Ne_5rep_no_singletons
cp ../1000000Ne_5rep/*.blueprint .

ls *.blueprint | sed -i '8s/#smallest/smallest/'
sed -i 's/1000000Ne/1MNe_no_singleton/g' *.blueprint

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/job_submission

sbatch /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/fsc_sim_stairway/scripts/3_stairway_plot/fsc2stairway_1MNe_no_singleton_20_80_200hapS_1E_cons_1.1i_1.5i_1.9i_20Chr_15Mb.sh
Submitted batch job 38325916