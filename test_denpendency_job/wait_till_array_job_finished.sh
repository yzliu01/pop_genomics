#!/bin/bash
#SBATCH --time=00:00:01
#SBATCH --mem 1G
#SBATCH --job-name Dependency

JID=$(sbatch --parsable script_a.sh)

sbatch --dependency=afterok:$JID script_b.sh

exit 0

#!/bin/bash
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/
JID=$(sbatch --parsable script_a)      # The job-array. We capture the jobid when it's submitted.
sbatch -d afterany:$JID cript_b       # This job waits for the job-array to finish before starting
            #
            # afterany - the job will run when all tasks in the given jobid have completed (any status)
            # afterok  - The job will run when all tasks in the given jobid have completed successfully
## https://ri.itservices.manchester.ac.uk/csf4/batch/job-arrays/#Wait_for_entire_job_array_to_finish