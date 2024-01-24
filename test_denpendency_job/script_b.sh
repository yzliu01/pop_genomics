#!/bin/bash
#SBATCH --time=00:00:01
#SBATCH --mem 1G
#SBATCH --job-name script_b_test

echo === $(date)
echo $SLURM_JOB_ID "->" "script_b_test"
echo This is a new job "(b)"
echo === $(date) $(hostname)
whoami