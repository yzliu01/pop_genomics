

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/job_submission

find . -maxdepth 3 -name "3_fb_variant_calling_4_bee_pools.AndHae_New_REF_AndHae*" | head

3_fb_variant_calling_4_bee_pools.AndMar_New_REF_AndMar_0_4_bam.100kb_g1500x.chr_regions.%A_%a.e
3_fb_variant_calling_4_bee_pools.AndMar_New_REF_AndMar_0_6_bam.100kb_g1500x.chr_regions.%A_%a.e
3_fb_variant_calling_4_bee_pools.AndHae_New_REF_AndHae_0_4_bam.100kb_g1500x.chr_regions.short.%A_%a.e
3_fb_variant_calling_4_bee_pools.AndHae_New_REF_AndHae_0_6_bam.100kb_g1500x.chr_regions.short.%A_%a.e

find . -maxdepth 3 -name "3_fb_variant_*RutMac*" | xargs rm 


find . -type f -name '3_fb_*.e' -print
find . -type f -name '3_fb_*.e' -exec rm {} +
find . -type f -name '3_fb_*.o' -exec rm {} +

find . -type f -name '3_fb_*0_4_bam*.e' -exec rm {} +
find . -type f -name '3_fb_*0_6_bam*.o' -exec rm {} +

find . -type f -name '3_fb_*0_4_bam*.e' -print
find . -type f -name '3_fb_*0_*_bam*' -exec rm {} +

find . -type f -name '54113093_*.e' -exec grep 'OUT_OF_MEMORY' | head

find . -type f -name '*54113093_*' | xargs rm
find . -type f -name '*54113094_*' | xargs rm
find . -type f -name '*54113093_*' | xargs rm

## check and delete tem files (storage and computing hours)
gdk-project-usage -p eDNA -u yzliu
## check file and folder sizes
du -h /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/job_submission


cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3
find . -maxdepth 3 -name 50G_05i_20Chr_15Mb_1_3.gen 

find . -maxdepth 3 -name *.gen | rm

find . -maxdepth 3 -name *.gen -exec ls -lh {} +

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/systematic_ft_non_pruned
find . -maxdepth 5 -name *.addTheta -exec ls -lh {} +
find . -maxdepth 5 -name *.addTheta | xargs rm