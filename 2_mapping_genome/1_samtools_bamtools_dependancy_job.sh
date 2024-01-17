#!/bin/bash
#SBATCH --time=00:00:01
#SBATCH --mem 1G
#SBATCH --job-name 1_sam_bamtools_dependancy_job


JID=$(sbatch --parsable 1_bwa_samtools_mapping_index_dro_mel.sh)

sbatch --dependency=afterok:$JID 1_bamtools_stats.sh

exit 0