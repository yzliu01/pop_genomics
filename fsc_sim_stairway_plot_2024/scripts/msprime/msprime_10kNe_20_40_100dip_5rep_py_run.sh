#!/bin/bash
#SBATCH --account eDNA
##SBATCH --cpus-per-task 12
#SBATCH --mem 80g
#SBATCH --array=1-3%3
#SBATCH --time=06:14:00
#SBATCH --error=one_pop_msprime_sim_10kNe_20_40_100dip_5rep_20chr_mu36e9_re89e8.%A_%a.e.txt
#SBATCH --output=one_pop_msprime_sim_10kNe_20_40_100dip_5rep_20chr_mu36e9_re89e8.%A_%a.o.txt
#SBATCH --job-name=one_pop_msprime_sim_10kNe_20_40_100dip_5rep_20chr_mu36e9_re89e8
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## call env
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
conda activate bioproject

## execute python script
sim_10kNe=$(ls msprime_10kNe_{20,40,100}dip_5rep.py | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
python $sim_10kNe