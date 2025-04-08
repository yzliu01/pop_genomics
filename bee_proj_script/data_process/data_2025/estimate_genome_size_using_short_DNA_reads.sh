

#!/usr/bin/env bash 
# KAT is a toolkit for addressing assembly completeness through k-mer counts (Mapleson et al., 2017) 
# More information about KAT in: https://github.com/TGAC/KAT 
# You can use the short-read DNA sequencing data provided in the Key Resource Table (Accession number: SRX8624462) to run the following script 
# You need to provide the file path to the sequencing data or run this script in the same folder where the sequencing data is saved 
kat hist -o prefix -t 10 SRR12099722* 1> kat.output.txt 
echo dme_size >> genome_size.txt 
grep -i "Estimated" kat.output.txt >> genome_size.txt 
# hist: a kat module for drawing histograms and estimating genome size
# -o: output prefix; you can specify ‘‘prefix’’ for your species or strain names