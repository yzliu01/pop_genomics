
# https://stackoverflow.com/questions/60508333/export-all-created-conda-environments
# https://stackoverflow.com/questions/76203459/how-do-i-export-all-conda-environments

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/conda_envs

for env in $(conda env list | cut -d" " -f1); do 
   if [[ ${env:0:1} == "#" ]] ; then continue; fi;
   conda env export -n $env > ${env}.yml
done


# Creating an environment from an environment.yml file
    # Use the terminal for the following steps:
    # Create the environment from the environment.yml file:

conda env create -f environment.yml

    # The first line of the yml file sets the new environment's name. For details see Creating an environment file manually.
    # Activate the new environment: conda activate myenv
    # Verify that the new environment was installed correctly:

conda env list
    # You can also use 
conda info --envs



