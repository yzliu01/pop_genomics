

source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate myproject

## fast program to build ML-tree (The evolutionary history of bees in time and space - 10.1016/j.cub.2023.07.005)
## installination: http://www.iqtree.org/
conda install -c bioconda iqtree

iqtree -h

