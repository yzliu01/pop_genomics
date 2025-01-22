## activate related env
conda activate HiFiAsm


Convert .bam to .fastq and remove reads with remnant PacBio adapter sequences

Dependencies:

    BamTools
    BLAST+

Optional:

    NCBI FCS Adaptor
    pigz

Add script and database to your path using:

    export PATH=$PATH:[PATH TO HiFiAdapterFilt]
    export PATH=$PATH:[PATH TO HiFiAdapterFilt]/DB

export PATH=$PATH:/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/genome_assembly/hifiasm/HiFiAdapterFilt
export PATH=$PATH:/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/genome_assembly/hifiasm/HiFiAdapterFilt/DB


# Usage
# successful test
bash /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/genome_assembly/hifiasm/pbadaptorfilt.sh -p HMW_Bom_m84108_240904_160210_s2.fail_reads.bc2055 -o ./test_pbadaptor

bash hifiadapterfilt.sh [ -p file Prefix ] [ -l minimum Length of adapter match to remove. Default=44 ] [ -m minimum percent Match of adapter to remove. Default=97 ] [ -t Number of threads for blastn. Default=8 ] [ -o outdirectory prefix Default=. ]

bash /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/genome_assembly/hifiasm/pbadaptorfilt.sh -o ./filtered
# ERR9284047.fastq.gz
# ERR9284048.fastq.gz
# to assemble reference genome ourselves
# download long read data of Notonecta glauca from here: https://www.ebi.ac.uk/ena/browser/view/PRJEB51450; https://portal.darwintreeoflife.org/data/root/details/Notonecta%20glauca
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR928/007/ERR9284047/ERR9284047.fastq.gz
# All flags are optional.

# If no -p argument is provided, the script will run on all sequence files (.bam, .fastq, .fastq.gz, .fq, .fq.gz) in the working directory.