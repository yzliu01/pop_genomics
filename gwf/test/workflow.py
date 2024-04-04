from gwf import Workflow

gwf = Workflow()
print('x y z')
gwf.target('MyTarget',inputs=[],outputs=['greeting.txt']) << """
echo "hell world " > greeting_test.txt
"""