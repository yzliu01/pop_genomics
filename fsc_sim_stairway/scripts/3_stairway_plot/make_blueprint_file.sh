
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