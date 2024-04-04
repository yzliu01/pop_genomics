from gwf import Workflow

gwf = Workflow()

gwf.target('TargetA', inputs=[], outputs=['x.txt']) << """
echo "this is x" > x.txt
"""

gwf.target('TargetB', inputs=[], outputs=['y.txt']) << """
echo "this is y" > y.txt
"""

gwf.target('TargetC', inputs=['x.txt', 'y.txt'], outputs=['z.txt']) << """
cat x.txt y.txt > z.txt
"""