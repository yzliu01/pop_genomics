
# rename file names
ls -t *blueprint | head -24 | xargs rename 'no_doubleton' 'no_singleton'

ls -t *blueprint | head -24 | xargs sed -i '8s/smallest_size_of_SFS_bin_used_for_estimation: 3/smallest_size_of_SFS_b
in_used_for_estimation: 2/'

ls -t *blueprint | head -24 | xargs sed -i 's/doubleton/singleton/g'


sed -i '12s/systematic_ft_non_pruned/systematic_ft_non_pruned\/10KNe_swp/' *.blueprint


# exclude doubleton for AndHae_REF_BomPas
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/bee_pools_blueprint/New_REF
ls AndHae_New*AndHae.no_doubleton*1500x*blueprint

for i in $(ls AndHae_New*AndHae.no_doubleton*1500x*blueprint)
do cp $i $i.copy
done

rename REF_AndHae REF_BomPas AndHae_New*AndHae.no_doubleton*1500x*blueprint.copy
ls AndHae_New*BomPas.no_doubleton*1500x*blueprint.copy
sed -i 's/AndHae_New_REF_AndHae/AndHae_New_REF_BomPas/' AndHae_New*BomPas.no_doubleton*1500x*blueprint.copy
# change the blueprint file names finally
rename blueprint.copy blueprint AndHae_New*BomPas.no_doubleton*1500x*blueprint.copy

# for other species
for i in $(ls AndMar_New*.no_singleton*1500x*blueprint)
do cp $i $i.copy
done

rm BomPas_New_REF_BomPas.no_singleton_sfs_400_1500x.sm_genic.blueprint BomPas_New_REF_BomPas.no_singleton_sfs_600_1500x.sm_genic.blueprint

ls BomPas_New*.no_singleton*1500x*blueprint
for i in $(ls BomPas_New*.no_singleton*1500x*blueprint)
do cp $i $i.copy
done

rm BomVet_New_REF_BomPas.no_singleton_sfs_400_1500x.sm_genic.blueprint BomVet_New_REF_BomPas.no_singleton_sfs
_600_1500x.sm_genic.blueprint
ls BomVet_New*.no_singleton*1500x*blueprint
for i in $(ls BomVet_New*.no_singleton*1500x*blueprint)
do cp $i $i.copy
done

# all
ls *_New*.no_singleton*1500x*blueprint.copy
rename no_singleton no_doubleton *_New*.no_singleton*1500x*blueprint.copy

sed -i 's/no_singleton_sfs/no_doubleton_sfs/' *_New*.no_doubleton*1500x*blueprint.copy
sed -i 's/_estimation: 2/_estimation: 3/' *_New*.no_doubleton*1500x*blueprint.copy

# change the blueprint file names finally
rename blueprint.copy blueprint *_New*.no_doubleton*1500x*blueprint.copy

ls -t *_New*.no_doubleton*1500x*blueprint | head -60