
conda activate HiFiAsm
#conda install bioawk

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/Panurgus_banksianus

#!/usr/bin/env bash
# Create a new file and generate a header line
echo "platform,length" > length.csv
# Add each read length into the length.csv file.
#bioawk -c fastx '{print "PacBio_CLR," length($seq)}' ERR12370431.fastq.gz >> length.csv
bioawk -c fastx '{print "PacBio_HiFi," length($seq)}' ERR12370431.fastq.gz >> length.csv 
#bioawk -c fastx '{print "ONT," length($seq)}' ERR12370431.fastq.gz >> length.csv
