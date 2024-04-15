## declare the workflow
from gwf import Workflow
import numpy as np

gwf = Workflow(defaults={'account': 'HDSSandbox'})

#############################
### Process all fastq files 
### with fastqc 
#############################


## Extract all file names from the folder data which end with .fastq.gz
#  and make a list with all the names
import os
import glob

pattern = os.path.join('data', '*.fastq.gz') #pattern for path
fastq_files = glob.glob(pattern) #list with names and their path
print("Fastq files in the data folder")
print(fastq_files)
fastq_files = [os.path.basename(file) for file in fastq_files] #remove the path from the file
print("Fastq files after removing path from the name")
print(fastq_files) #print names

for FASTQ in fastq_files:
    ## A target doing FastQC on a file
    FASTQ_BASENAME = FASTQ.split(".")[0] #name without extensions
    gwf.target( f'FastQC_{FASTQ_BASENAME}', 
           cores=1,
           memory='8gb',
           walltime='00:05:00',	
           inputs=[f'data/{FASTQ}'], 
           outputs=[f'data/{FASTQ_BASENAME}_fastqc.html', 
                    f'data/{FASTQ_BASENAME}_fastqc.zip']) << """ 
    fastqc data/{FASTQ}
    """.format(FASTQ=FASTQ)
