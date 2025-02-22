# Unlike python workflow.py, the gwf run command expects the workflow definition file to be named workflow.py automatically. 
# It does not accept the filename as an argument.

import sys
from gwf import Workflow

gwf = Workflow()
#print('x y z')
gwf.target(name='MyTarget', working_dir='/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/gwf/test', inputs=[], outputs=['greeting_2025.txt']) << """
echo "hell world!" > greeting_2025.txt
"""

# Debug: Check registered targets
print("Registered targets:", gwf.targets)


# restart the Workflow if modification is made

#print(gwf.targets)

#import os

#working_dir = '/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/gwf/test'
#os.makedirs(working_dir, exist_ok=True)

'''

sys.exit(0)

1. Check if the Workflow is Executed Correctly

Ensure that you are running the GWF workflow script properly.
Correct Way to Run the Workflow

gwf run workflow.py

Or, if you're inside a specific directory containing the workflow.py script:

gwf run

If you don’t specify workflow.py, GWF assumes the script is named workflow.py in the current directory.
2. Make Sure the Target is Being Run

Check if MyTarget is detected by GWF before execution.
List Available Targets

Before running, list all defined targets using:

gwf status

If "MyTarget" does not appear, it means the target is not registered correctly.
3. Verify If the Target Has Already Been Completed

If the target has already run successfully before, GWF won’t rerun it unless:

    The input/output files change.
    You use the --force option.

Try forcing the execution with:

gwf run --force

Or delete greeting_2025.txt and rerun the workflow.
4. Check for Errors During Execution

Run:

gwf status

If the target fails, check the logs for errors:

cat gwf.logs/MyTarget.err
cat gwf.logs/MyTarget.out

This will show if there were errors executing the echo command.



To stop execution in a Python script, you can use one of the following commands:
1. sys.exit() (Recommended for Scripts)

Stops execution and exits the script completely.

import sys

print("This will print")
sys.exit()  # Stops execution here
print("This will NOT print")

    If you pass a number (sys.exit(1)), it indicates an error exit.
    sys.exit(0) means a successful exit.

2. exit() (For Interactive Mode)

Works the same as sys.exit() but is mainly for interactive mode (e.g., Python shell).

exit()

⚠️ Not recommended for production scripts because it's a wrapper around sys.exit() and may not work in all environments.
3. quit() (Similar to exit())

Like exit(), quit() is mainly for interactive use and is not recommended in scripts.

quit()

'''