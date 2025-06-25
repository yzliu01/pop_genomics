#!/bin/bash
#SBATCH --account=eDNA
##SBATCH --array=1-28%28
##SBATCH --array=1-149999%1000 ## worked
##SBATCH --array=1-150000%1000 ## not work
#SBATCH --array=150001-150002   # Test if index 160000 is allowed
##SBATCH --array=160000-160000   # Test if index 160000 is allowed
##SBATCH --array=140001-160000%10

#SBATCH --output=test-%A_%a.out

echo "Task ID: $SLURM_ARRAY_TASK_ID"

