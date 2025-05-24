
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
find . -type f -name '3_fb_variant_calling_2025_NotGla_REF_NotGla.100kb_g1500x.chr_regions*e' | sort -V | xargs cat | less -S

