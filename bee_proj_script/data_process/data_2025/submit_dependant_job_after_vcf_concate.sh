
*********** deepSeek *********
#Dependency Approach: Instead of submitting the next job at the end of the current script, a more robust approach would be to use SLURM's job dependency feature (--dependency flag):

# First submit the current job and capture its ID
CURRENT_JOB_ID=$(sbatch concate_vcf_10_species.sh | awk '{print $4}')

# Then submit the dependent job
sbatch --dependency=afterok:$CURRENT_JOB_ID 6_2025_10_pools_get_vcf_ind...sh

#Alternative Approach: Your current method (submitting from within the script) will work, but:
#    It submits the next job for each array task (10 times)
#    The next job might start before all array tasks complete

************ run ************
## concate vcf files due to rerun variant calling

## 1. First submit your main job and capture its ID:

#yzliu in 🌐 fe-open-01 in DK_proj/data/job_submission on  main [?] 
sbatch /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/data_2025/steps/456_concate_vcf_genome_fraction_bam_stats/4_5_2025_10_pools_concate_vcf_filtering_genome_fraction_depth_bgzip_decompress.sh
Submitted batch job 60437089

## 2. Then submit the dependent job:

#yzliu in 🌐 fe-open-01 in DK_proj/data/job_submission on  main [?] 
## sbatch -h
## -d, --dependency=type:jobid[:time] defer job until condition on jobid is satisfied
sbatch --dependency=afterok:60437089_10 /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/data_2025/steps/456_concate_vcf_genome_fraction_bam_stats/6_2025_10_pools_get_vcf_ind.DP_1x_1.5x_2x_old_3x_5x_7x_10x.filtering_fun_sort_files_by_names_sizes.sh
Submitted batch job 60437091

## 3. check the submitted jobs
#yzliu in 🌐 fe-open-01 in DK_proj/data/job_submission on  main [?] 
squeue -u yzliu
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
        59624208_2    normal 2_gene_a    yzliu  R 2-01:54:26      1 cn-1003
        59624208_1    normal 2_gene_a    yzliu  R 2-01:57:46      1 cn-1035
        59654452_3    normal 2_gene_a    yzliu  R 2-00:33:56      1 cn-1030
        59654452_2    normal 2_gene_a    yzliu  R 2-00:56:58      1 cn-1016
        59654452_1    normal 2_gene_a    yzliu  R 2-01:06:26      1 cn-1035
       60437089_10     short concate_    yzliu  R       7:40      1 s21n34
   60437091_[28%1] short,nor get_filt    yzliu PD       0:00      1 (Dependency)


**************************************************************************************
For array jobs:
If your main job is an array job, you can either:
    Wait for all array tasks to complete:

# sbatch --dependency=afterok:$MAIN_JOB_ID next_script.sh

(Will wait until all array tasks finish)
#    Or wait for specific array tasks using "aftercorr" instead of "afterok"
To verify dependency options are available:
# Submit first array job with 5 tasks (0-4)
JOB1_ID=$(sbatch --array=0-4 --parsable job1.sh)
echo "First job array ID: $JOB1_ID"

# Submit second job array with same number of tasks, dependent on corresponding tasks from first job
sbatch --array=0-4 --dependency=aftercorr:$JOB1_ID job2.sh



# man sbatch

Then search for "dependency" in the manual page.
The dependency system is quite powerful in SLURM - you can do things like:

#    afterok: only run if previous job succeeded
#    afternotok: only run if previous job failed
#    afterany: run regardless of previous job's status

## 05_2025 third batch
## job_name: 1_bwa_samtools_16REF_clean_fa_2step_sambamba_markDup_stats
# 60826698_[1-16%16]
sbatch --dependency=afterok:60826698 "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/data_2025/steps/456_concate_vcf_genome_fraction_qualimap_bam_stats/0_bee_16_pools_REF_qualimap.marked_dups_&_check_mean_depth.sh"
squeue -u yzliu
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
60826698_[1-16%16]    normal 1_bwa_sa    yzliu PD       0:00      1 (Priority)
60832323_[1-16%16] short,nor qualimap    yzliu PD       0:00      1 (Dependency) # cancelled

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/job_submission

## rename bam files
sbatch --dependency=afterok:60826698 /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/data_2025/steps/456_concate_vcf_genome_fraction_qualimap_bam_stats/dependency_script_rename_bam_file_names.sh
# 61175634 short,nor rename_b    yzliu PD       0:00      1 (Dependency)

## resubmit qualimap script
sbatch --dependency=afterok:61175634 "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/data_2025/steps/456_concate_vcf_genome_fraction_qualimap_bam_stats/0_bee_16_pools_REF_qualimap.marked_dups_&_check_mean_depth.sh"
# 61175635_[1-16%16] short,nor qualimap    yzliu PD       0:00      1 (Dependency)

## variant calling
fb_script_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/data_2025/steps/123_genome_mapping_AND_variant_calling
fb_variant_calling_script=$(ls -t $fb_script_dir/3_fb*.sh | head -16 | sort -V)

fb_variant_calling_PorSca_script=$(ls -t $fb_script_dir/3_fb*PorSca*.sh | head -4 | sort -V)

fb_variant_calling_script=$(ls -t $fb_script_dir/3_fb*.sh | head -19 | sort -V)

## run denpendent jobs after rename job
## Max array 150000 (149999) each
for script in $fb_variant_calling_script
## PorSca
#for script in $fb_variant_calling_PorSca_script
#do sbatch --dependency=afterok:61175634 $script
do sbatch $script
done

sbatch: error: Slurm temporarily unable to accept job, sleeping and retrying
Submitted batch job 61185044
Submitted batch job 61185045
sbatch: error: Slurm temporarily unable to accept job, sleeping and retrying # *.3.sh
sbatch: error: Batch job submission failed: Resource temporarily unavailable
Submitted batch job 61185706


sbatch --dependency=afterok:61175634 $script $fb_script_dir/3_fb_variant_calling_2025_PorSca.100kb_g1500x.chr_regions.3.sh
61187470