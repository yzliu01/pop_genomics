
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/job_submission
script_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/data_2025/steps/123_genome_mapping_AND_variant_calling
## 05_2025
## submit dependent jobs
for sh in $(ls -t $script_dir/3_fb*sh | head -16 | sort -V);do sbatch --dependency=afterok:60826698 $sh;done

## 04_2025
for sh in $(ls -t $script_dir/3_fb*sh | head -4);do sbatch $sh;done

Submitted batch job 59038164*aphsti
Submitted batch job 59038165
Submitted batch job 59038166
Submitted batch job 59038167*ephdan
Submitted batch job 59038168
Submitted batch job 59038169
Submitted batch job 59038170*ochple
Submitted batch job 59038171
Submitted batch job 59038172
Submitted batch job 59038173*stemel


squeue -u yzliu

## rerun due to wrong bam file names
for sh in $(ls -t $script_dir/3_fb*sh | head -4);do sbatch $sh;done
Submitted batch job 59118100
Submitted batch job 59118101
Submitted batch job 59118102
Submitted batch job 59118103


## check if jobs are killed due to mem issues
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/job_submission

find . -type f -name '3_fb_variant_calling_2025_NotGla_REF_NotGla.100kb_g1500x.chr_regions*e' | sort -V | xargs cat | less -S

find . -type f -name 'PorSca.100kb_g1500x.chr_regions.2*e' | sort -V | xargs cat | less -S

for i in {1..143}; do jobinfo 35021813_$i | xargs grep -E 'TIMEOUT|CANCELLED|OUT_OF_MEMORY'; done

## PorSca

#61207678_[87417-14 short,nor 149999_3    yzliu PD       0:00      1 (Priority)
#61207679_[32226-14 short,nor 280000_3    yzliu PD       0:00      1 (Priority)
#61207689_[709-3508 short,nor 455076_3    yzliu PD       0:00      1 (Priority)


find . -type f -name '*61207678_*.e' | xargs grep 'OUT_OF_MEMORY' | head
find . -type f -name '*61207679_*.e' | xargs grep 'OUT_OF_MEMORY' | head
find . -type f -name '*61207689_*.e' | xargs grep 'OUT_OF_MEMORY' | head
# PorSca_REF_PorSca.100kb_1500x_region_87392.g.vcf

liu in 🌐 fe-open-01 in bee_proj_data/vcf/fb_per_region_PorSca_REF_PorSca on  main [?] via 🅒 variant_calling_mapping took 12m6s 

ls *_20.*g.vcf
PorSca_REF_PorSca.100kb_1500x_region_20.g.vcf        PorSca_REF_PorSca.100kb_1500x_region_20.new.g.vcf
PorSca_REF_PorSca.100kb_1500x_region_20.new_1.g.vcf
