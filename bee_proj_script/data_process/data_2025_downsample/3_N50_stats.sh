#!/usr/bin/env bash 
conda activate HiFiAsm

# Unzipped FASTA/Q files are required for assembly-stats 
# Reports sequence length statistics from fasta and/or fastq files

# You can unzip your fastq.gz files using the command 
gzip -d file_name.fastq.gz
gunzip -dk ERR12370431.fastq.gz # keep the input file
# For general usage, specify the read or contig file names after ‘‘assembly-stats’’
# Calculate summary stats and save the output as an ‘‘N50_stat’’ file 
assembly-stats SRR11906525_WGS_of_drosophila_melanogaster_female_adult_subreads.fastq >> N50_stat

assembly-stats SRR12473480_Drosophila_PacBio_HiFi_UltraLow_subreads.fastq >> N50_stat 
assembly-stats SRR13070625_1.fastq >> N50_stat
assembly-stats ERR12370431.fastq >> Panurgus_banksianus.raw_reads_N50.stat