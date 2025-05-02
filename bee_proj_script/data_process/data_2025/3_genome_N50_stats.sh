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


# step V: stats of assembly fasta
conda activate HiFiAsm
#conda install bioconda::assembly-stats
#conda install bioconda::quast
# help
assembly-stats

ref_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
cd $ref_dir
assembly-stats Porcellio_scaber-GCA_034700385.1.fa.masked > Porcellio_scaber_stats.log

sum = 396179840, n = 455076, ave = 870.58, largest = 17937
N50 = 1242, n = 92003 # 50% of the total assembly length is contained in 92003 contigs that are at least 92003 bp in size.
N60 = 998, n = 127607
N70 = 771, n = 172567
N80 = 552, n = 233349
N90 = 383, n = 319430
N100 = 200, n = 455076
N_count = 106
Gaps = 3

## quast
out_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/data_2025/quast_results_new
mkdir $out_dir
#quast Porcellio_scaber-GCA_034700385.1.fa.masked --min-contig 100 > Porcellio_scaber_quast_stats.log
quast Porcellio_scaber-GCA_034700385.1.fa.masked --min-contig 100 --output-dir $out_dir > Porcellio_scaber_quast_stats.log

cd ./assembly_fa_stats
assembly-stats Panurgus_banksianus.pl*.asm.bp.p_ctg.gfa.fa > stats_hifi_asm.log
assembly-stats Panurgus_banksianus.pl_3.asm.bp.p_ctg.gfa.fa >> stats_hifi_asm.log
