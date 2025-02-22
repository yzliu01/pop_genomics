# Unlike python workflow.py, the gwf run command expects the workflow definition file to be named workflow.py automatically. 
# It does not accept the filename as an argument.

import sys
from gwf import Workflow

gwf = Workflow()
#print('x y z')
gwf.target(name='MyTarget', working_dir='/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/gwf/test', inputs=[], outputs=['greeting_2025.txt']) << """
echo "hell world!" > greeting_2025.txt
"""
