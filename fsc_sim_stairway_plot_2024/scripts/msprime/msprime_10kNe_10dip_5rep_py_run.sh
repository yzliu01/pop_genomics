#!/bin/bash
#SBATCH --account eDNA
##SBATCH --cpus-per-task 12
#SBATCH --mem 40g
##SBATCH --array=1-11%2
#SBATCH --time=04:14:00
#SBATCH --error=one_pop_msprime_sim_5rep_20chr_mu36e9_re89e8.%A_%a.e.txt
#SBATCH --output=one_pop_msprime_sim_5rep_20chr_mu36e9_re89e8.%A_%a.o.txt
#SBATCH --job-name=one_pop_msprime_sim_5rep_20chr_mu36e9_re89e8
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## call env
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
conda activate bioproject
## execute python script
python msprime_5rep.py