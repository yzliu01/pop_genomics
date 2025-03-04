from gwf import Workflow

gwf = Workflow()

gwf.target('TargetA', inputs=[], outputs=['x.txt']) << """
sleep 2 && echo "this is x." > x.txt
"""

gwf.target('TargetB', inputs=[], outputs=['y.txt']) << """
sleep 3 && echo "this is y." > y.txt
"""

gwf.target('TargetC', inputs=['x.txt', 'y.txt'], outputs=['z.txt']) << """
# sleep 4 && cat x.txt y.txt > z.txt
sleep 4 && echo -e "\nConcatenate TargetA and TargetB\n" > z.txt && cat x.txt y.txt >> z.txt
"""

#eval "$(conda shell.bash hook)"
#conda activate env
'''
quit()

# navigate to the specific dir in one terminal
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/gwf/dependent_test
# run workflows utilizing all cores of your computer 
gwf workers

# open a second terminal
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/gwf/dependent_test
conda activate gwf
gwf config set backend local
gwf run
gwf -v debug status
'''