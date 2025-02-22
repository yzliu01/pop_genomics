#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 20
#SBATCH --mem 60g
#SBATCH --time=00:15:00
#SBATCH --array=1-6%6
#SBATCH --error=busco_orthodb_Bom_vet_assembly.%A_%a.e
#SBATCH --output=busco_orthodb_Bom_vet_assembly.%A_%a.o
#SBATCH --job-name=busco_orthodb_Bom_vet_assembly
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## Step II: reorder the chromosome order
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate busco_v5.7.1

## run busco
# fasta files
assembly_fa_stats=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/bombus_veteranus/filtered/assembly_fa_stats
## make array jobs
#fa_list=$(ls $assembly_fa_stats/Bombus_veteranus.pl*asm.bp.p_ctg.gfa.fa | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)
fa_list=$(ls $assembly_fa_stats/Bombus_veteranus.pl_3.asm.bp.p_ctg.gfa.fa | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)

#echo $fa_list

hifiasm_busco_out=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/hifi_asm
#cd $hifiasm_busco_out

## run busco: https://busco.ezlab.org/busco_userguide.html
## database dir
busco_data_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test
cd $busco_data_dir
## Interpreting the results
## BUSCO provides a quantitative assessment of the completeness in terms of expected gene content of a genome assembly, transcriptome, or annotated gene set. 
## The results are simplified into categories of Complete and single-copy, Complete and duplicated, Fragmented, or Missing BUSCOs, where "BUSCOs" is shorthand for "BUSCO marker genes".
busco -i $fa_list -m genome -c 20 --lineage_dataset hymenoptera_odb10 --restart --out_path $hifiasm_busco_out
## Bombus_veteranus.pl_0.asm.bp.p_ctg.gfa.fa
## Bombus_veteranus.pl_0.with_fail.asm.bp.p_ctg.gfa.fa

## busco -i $REF_BomSyl -m genome --lineage_dataset hymenoptera_odb10 --restart
## -i or --in defines the input file to analyse which is either a nucleotide fasta file or a protein fasta file, depending on the BUSCO mode.
## -m or --mode sets the assessment MODE: genome, proteins, transcriptome

exit 0

************* plot busco summaries ***********
# https://currentprotocols.onlinelibrary.wiley.com/doi/full/10.1002/cpz1.323

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/hifi_asm
busco_summaries=$(find . -maxdepth 2 -type f -name 'short_summary*.txt' | grep -v 'with_fail')
cp $busco_summaries ./busco_summary

conda activate busco_v5.7.1
# find out the plot script in the conda env
generate_plot=/home/yzliu/miniforge3/envs/busco_v5.7.1/bin/generate_plot.py
python3 $generate_plot -wd ./busco_summary


## install busco
## https://busco.ezlab.org/busco_userguide.html
mamba create -n busco_v5.7.1 -c bioconda busco=5.7.1

## A full list of available datasets can be viewed 
busco --list-datasets

- metazoa_odb10
         - arthropoda_odb10
             - arachnida_odb10
             - insecta_odb10
                 - endopterygota_odb10
                     - diptera_odb10
                     - hymenoptera_odb10
                     - lepidoptera_odb10
                 - hemiptera_odb10
         - mollusca_odb10
         - nematoda_odb10
         - vertebrata_odb10

## https://www.orthodb.org/
# hymenoptera_odb10


stats for Bombus_veteranus.pl_2.asm.bp.p_ctg.gfa.fa
sum = 356460956, n = 742, ave = 480405.60, largest = 18528387
N50 = 5110199, n = 16
N60 = 2938816, n = 25
N70 = 2078258, n = 39
N80 = 634596, n = 68
N90 = 189603, n = 172
N100 = 7959, n = 742
N_count = 0
Gaps = 0


## output
# BUSCO version is: 5.7.1 
# The lineage dataset is: hymenoptera_odb10 (Creation date: 2024-01-08, number of genomes: 40, number of BUSCOs: 5991)
# Summarized benchmarking in BUSCO notation for file /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/bombus_veteranus/filtered/assembly_fa_stats/Bombus_veteranus.pl_2.with_fail.asm.bp.p_ctg.gfa.fa
# BUSCO was run in mode: euk_genome_min
# Gene predictor used: miniprot

	***** Results: *****

	C:98.4%[S:97.8%,D:0.6%],F:0.7%,M:0.9%,n:5991,E:2.8%	   
	5895	Complete BUSCOs (C)	(of which 163 contain internal stop codons)		   
	5859	Complete and single-copy BUSCOs (S)	   
	36	Complete and duplicated BUSCOs (D)	   
	41	Fragmented BUSCOs (F)			   
	55	Missing BUSCOs (M)			   
	5991	Total BUSCO groups searched		   

Assembly Statistics:
	758	Number of scaffolds
	758	Number of contigs
	355486961	Total length
	0.000%	Percent gaps
	4 MB	Scaffold N50
	4 MB	Contigs N50


Dependencies and versions:
	hmmsearch: 3.1
	bbtools: 39.01
	miniprot_index: 0.13-r248
	miniprot_align: 0.13-r248
	python: sys.version_info(major=3, minor=7, micro=12, releaselevel='final', serial=0)
	busco: 5.7.1

## interpretation by chatgtp

This summary provides the results of a BUSCO analysis and key assembly statistics for a genome assembly. Here's a detailed breakdown of the results:
BUSCO Results:

    C: 98.4% (Complete BUSCOs):
        98.4% of the conserved genes (BUSCOs) were found to be complete in the assembly. This indicates a highly complete genome assembly.
        S: 97.8% (Single-copy): Most of these BUSCOs (97.8%) are present as single copies, which is expected for most single-copy orthologs.
        D: 0.6% (Duplicated): A small proportion (0.6%) of the BUSCOs are duplicated, which could either reflect real biological duplications or assembly artifacts.

    F: 0.7% (Fragmented BUSCOs):
        0.7% of the BUSCO genes are fragmented, meaning they are partially present but incomplete.

    M: 0.9% (Missing BUSCOs):
        0.9% of the BUSCO genes are completely missing from the assembly, indicating a very small fraction of unrepresented genes.

    n = 5991 (Total BUSCO groups searched):
        The analysis was run against a set of 5,991 conserved genes (BUSCO orthologs).

    E: 2.8% (Errors):
        This refers to 2.8% of the BUSCOs containing potential errors, such as internal stop codons (e.g., 163 genes). This may indicate issues like frame shifts or sequencing errors that interrupt the reading frame.

Assembly Statistics:

    Number of scaffolds = 758:
        The genome assembly contains 758 scaffolds.

    Number of contigs = 758:
        There are also 758 contigs, meaning that the assembly consists entirely of contigs, with no additional scaffolding done.

    Total length = 355,486,961 bp:
        The total length of the genome assembly is 355,486,961 base pairs (~355 Mb).

    Percent gaps = 0.000%:
        There are no gaps in the assembly, which is a very positive indicator of a contiguous and high-quality assembly.

    Scaffold N50 = 4 MB:
        The N50 value of the scaffolds is 4 MB (4,000,000 base pairs). This means that 50% of the total assembly length is contained in scaffolds that are at least 4 Mb in size.

    Contig N50 = 4 MB:
        Similarly, the N50 for contigs is also 4 MB, meaning the assembly is highly contiguous, as no additional scaffolding has been done beyond contig-level assembly.

Conclusion:

    This genome assembly is very high quality, with a high N50 of 4 MB, no gaps, and a high percentage of complete BUSCOs (98.4%).
    Only 0.9% of BUSCOs are missing, which suggests near-complete representation of conserved genes in the genome.
    The lack of gaps and the high N50 further support that this is a well-assembled genome.

# ************ older *************

This output comes from a BUSCO (Benchmarking Universal Single-Copy Orthologs) analysis, which assesses the completeness of genome assemblies or annotations by comparing them to a set of highly conserved genes (orthologs) found across many species. Here's a breakdown of the metrics:
Key Terms:

    C (Complete BUSCOs): BUSCO genes that are fully assembled and present in the genome.
    S (Single-copy BUSCOs): Complete BUSCO genes that are present in a single copy, as expected.
    D (Duplicated BUSCOs): Complete BUSCO genes that are present in more than one copy.
    F (Fragmented BUSCOs): BUSCO genes that are partially present but incomplete or fragmented.
    M (Missing BUSCOs): BUSCO genes that are absent in the assembly.
    n: The total number of BUSCO groups searched.

Breakdown of the Results:

    C: 98.4% (Complete BUSCOs):
        98.4% of the BUSCO genes were found to be complete in the genome.
            Of these, 97.8% are single-copy BUSCOs.
            0.6% are duplicated BUSCOs.
            This is a strong indicator of genome completeness.

    F: 0.7% (Fragmented BUSCOs):
        0.7% of the BUSCO genes are fragmented, meaning they are only partially present in the assembly.

    M: 0.9% (Missing BUSCOs):
        0.9% of the BUSCO genes are completely missing from the genome.

    n = 5991 (Total BUSCO groups searched):
        The analysis was run against a set of 5,991 BUSCO genes (orthologs).

    E: 2.8%:
        E refers to the proportion of BUSCOs with potential errors, such as the 163 that contain internal stop codons.

Interpretation:

    Complete BUSCOs (C) = 98.4%: This indicates that the genome assembly is highly complete, with the vast majority of conserved genes present in full.
    Duplicated BUSCOs (D) = 0.6%: The presence of duplicated genes could be a sign of biological duplication (e.g., paralogs or gene duplication) or assembly artifacts.
    Fragmented and Missing BUSCOs (F + M = 1.6%): This small proportion suggests that only a few regions of the genome might be incomplete or missing entirely.
    E: 2.8%: The proportion of BUSCO genes with potential errors (e.g., internal stop codons) is low, but worth noting for further investigation.

Conclusion:

This is a very high-quality genome assembly, with 98.4% of conserved genes present and complete. Only 0.9% of BUSCO genes are missing, and a small percentage are fragmented or duplicated, indicating that the genome assembly is nearly complete.