#!/bin/bash
#SBATCH --time=00:00:01
#SBATCH --mem 1G
#SBATCH --job-name script_a_test

echo === $(date)
echo $SLURM_JOB_ID "->" "script_a_test"
echo === $(date) $(hostname)
whoami