## download hifi reads
# https://portal.darwintreeoflife.org/data/root/details/Chorthippus%20brunneus
# https://www.ebi.ac.uk/ena/browser/view/PRJEB71307
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/Chorthippus_brunneus
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/076/ERR10224876/ERR10224876.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/077/ERR10224877/ERR10224877.fastq.gz

76-91

for file in `seq 77 91`
#do echo order_$file
do wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/0"$file"/ERR102248"$file"/ERR102248"$file".fastq.gz
done

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi
mkdir Panurgus_banksianus
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR123/031/ERR12370431/ERR12370431.fastq.gz

#https://portal.darwintreeoflife.org/data/root/details/Chorthippus%20parallelus
mkdir /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/Chorthippus_parallelus
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/Chorthippus_parallelus

61-75

for file in `seq 61 75`
#do echo order_$file
#done
# ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/062/ERR10224862/ERR10224862.fastq.gz
do wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/0"$file"/ERR102248"$file"/ERR102248"$file".fastq.gz
done

## download 2025 poolseq
## sequencing data download guide: https://3478602.fs1.hubspotusercontent-na1.net/hubfs/3478602/2019-03 GEN NGS - ATAC-Seq FAQs/13012-M&G-EU 0223 sFTP Data Download Guide EU (3).pdf

Project	Sample ID	Barcode Sequence	# Reads	Yield (Mbases)	Mean Quality Score	% Bases >= 30
90-1123022345	Aphsti	CGGCCTGTTA+GCTCAATACA	165,803,020	49,741	38.65	93.51
90-1123022345	Bommaj	TGTAACCACT+TGGAGCGATT	131,888,510	39,567	38.53	92.90
90-1123022345	Cerryb	TTAGAGAAGC+AGGTACCAGC	353,597,826	106,079	38.29	91.95
90-1123022345	Ephdan	TCTAAGACCA+CCGCTCCTTA	172,856,528	51,857	38.68	93.59
90-1123022345	Meglea	AAGGCCGTAG+TTACCAACAG	329,605,399	98,882	38.61	93.36
90-1123022345	Notgla	TACCATGAAC+TGGCTATTAC	122,278,403	36,684	38.63	93.49
90-1123022345	Ochple	GAGCCAAGTT+GAAGGTGCCT	151,348,588	45,405	38.73	93.79
90-1123022345	Phrful	CATTGGCAGA+ATCGGCGCTA	192,040,045	57,612	38.68	93.59
90-1123022345	Rutmac	CTCTGATGGC+ATTATGAGGC	1,176,688,814	353,007	38.56	93.05
90-1123022345	Stemel	CCGACACAAG+CAATTAGGAG	652,810,254	195,843	38.50	92.67

## 2025-01
## through VS Codes at the local folder, login to the server stored the data
login: sftp pfthomsen_bio_au_dk@gweusftp.azenta.com
Password: ih_Th9AyoFOa6E3UCvbJ
check_data: ls
## go_to_data_folder:
cd 90-1123022345
cd 00_fastq
ls Aphsti*
## download one by one due to storage limits
Aphsti_R1_001.fastq.gz             Aphsti_R1_001.fastq.gz.md5         
Aphsti_R2_001.fastq.gz             Aphsti_R2_001.fastq.gz.md5         
Bommaj_R1_001.fastq.gz             Bommaj_R1_001.fastq.gz.md5         
Bommaj_R2_001.fastq.gz             Bommaj_R2_001.fastq.gz.md5         
Cerryb_R1_001.fastq.gz             Cerryb_R1_001.fastq.gz.md5         
Cerryb_R2_001.fastq.gz             Cerryb_R2_001.fastq.gz.md5         
Ephdan_R1_001.fastq.gz             Ephdan_R1_001.fastq.gz.md5         
Ephdan_R2_001.fastq.gz             Ephdan_R2_001.fastq.gz.md5         
Meglea_R1_001.fastq.gz             Meglea_R1_001.fastq.gz.md5
Meglea_R2_001.fastq.gz             Meglea_R2_001.fastq.gz.md5
Notgla_R1_001.fastq.gz             Notgla_R1_001.fastq.gz.md5
Notgla_R2_001.fastq.gz             Notgla_R2_001.fastq.gz.md5
Ochple_R1_001.fastq.gz             Ochple_R1_001.fastq.gz.md5
Ochple_R2_001.fastq.gz             Ochple_R2_001.fastq.gz.md5
Phrful_R1_001.fastq.gz             Phrful_R1_001.fastq.gz.md5
Phrful_R2_001.fastq.gz             Phrful_R2_001.fastq.gz.md5
Rutmac_R1_001.fastq.gz             Rutmac_R1_001.fastq.gz.md5
Rutmac_R2_001.fastq.gz             Rutmac_R2_001.fastq.gz.md5
Stemel_R1_001.fastq.gz             Stemel_R1_001.fastq.gz.md5
Stemel_R2_001.fastq.gz             Stemel_R2_001.fastq.gz.md5

mget Cerryb*



## original email to Philip
"
From: BI.Europe@azenta.com <BI.Europe@azenta.com>
Date: Monday, 30 December 2024 at 17.37
To: Philip Francis Thomsen <pfthomsen@bio.au.dk>
Cc: NGS.Europe@azenta.com <NGS.Europe@azenta.com>, BI.Europe@azenta.com <BI.Europe@azenta.com>, Public.Sales@azenta.com <Public.Sales@azenta.com>
Subject: Update: GENEWIZ/Azenta Project 90-1123022345
Hello Philip,
I hope all is well. Your project 90-1123022345 has completed and was uploaded to your account on our sFTP server. Below are your login credentials:
Host:	sftp://gweusftp.azenta.com
User:	pfthomsen_bio_au_dk
Password:	ih_Th9AyoFOa6E3UCvbJ
Port:	22
Notes:
    1. The data is hosted on our sFTP server for 30 days. The data will be automatically removed after this time. Please transfer the data as soon as you can. A raw data report can be found in your sFTP account.
    2. Due to size limitations, the project data and bioinformatics reports (if applicable) are not posted in "My Results" of your online account.
    3. Please click here for a link to our sFTP download guide.
Please let us know if you have any questions, we're happy to help. 
Does your project need follow up Sanger confirmation of sequencing targets? Azenta Life Sciences’ in-house pipeline can use your existing samples to confirm your NGS data. Find out more here.
Thank you for choosing Azenta Life Sciences and have a great day.
Azenta Life Sciences
Phone: +49-341 520 122-41
NGS.Europe@azenta.com 
www.GENEWIZ.com 
Specializing in Genomics Since 1999 
GENEWIZ Germany GmbH
Bahnhofstrasse 86
04158 Leipzig, Germany
Registered Office: Frankfurt a. M.
Register Court: Frankfurt a. M., HRB 109853
Managing Directors: Jason Joseph, David Francis Pietrantoni 
This email message, including any attachments, may contain confidential and proprietary information for the sole use of the intended recipient. If you are not the intended recipient, you are hereby notified that any use, copying or dissemination of this message is strictly prohibited. If you received this message in error, please notify GENEWIZ Germany GmbH immediately by reply email or by calling GENEWIZ European Headquarters at +49 341 520 122-0. Then delete this message from your system, without making any copy or distribution.Thank you. 
"
## 2025-04
"
Hello Jesper,
I hope all is well. Your project 90-1171642133 has completed and was uploaded to your account on our sFTP server. Below are your login credentials:
Host:	sftp://gweusftp.azenta.com
User:	jesper_bechsgaard_bio_au_dk
Password:	kpoFWWpXtn1lshOY_pUP
Port:	22
Notes:
    1. The data is hosted on our sFTP server for 30 days. The data will be automatically removed after this time. Please transfer the data as soon as you can. A raw data report can be found in your sFTP account.
    2. Due to size limitations, the project data and bioinformatics reports (if applicable) are not posted in "My Results" of your online account.
    3. Please click here for a link to our sFTP download guide.
"

## 1. open the terminal from local terminal
## sftp username@gweusftp.azenta.com
sftp jesper_bechsgaard_bio_au_dk@gweusftp.azenta.com
## 2. enter the password
kpoFWWpXtn1lshOY_pUP
## 3. set the directory where to store the data files using "lcd"
lcd C:/Users/au749953/"OneDrive - Aarhus universitet"/proj_DK/project-dk/pool_data_01_2025/extra_poolseq
lcd D:\pool_data_04_2025
ls
sftp> cd 90-1171642133 
sftp> ls
00_fastq                                 90-1171642133_Azenta_Data_Report.html    

cd 90-1171642133/00_fastq

Aphsti_R1_001.fastq.gz                                Aphsti_R1_001.fastq.gz.md5
Aphsti_R2_001.fastq.gz                                Aphsti_R2_001.fastq.gz.md5
Bommaj_R1_001.fastq.gz                                Bommaj_R1_001.fastq.gz.md5
Bommaj_R2_001.fastq.gz                                Bommaj_R2_001.fastq.gz.md5
Cerryb_R1_001.fastq.gz                                Cerryb_R1_001.fastq.gz.md5
Cerryb_R2_001.fastq.gz                                Cerryb_R2_001.fastq.gz.md5
Ephdan_R1_001.fastq.gz                                Ephdan_R1_001.fastq.gz.md5
Ephdan_R2_001.fastq.gz                                Ephdan_R2_001.fastq.gz.md5
Meglea_R1_001.fastq.gz                                Meglea_R1_001.fastq.gz.md5
Meglea_R2_001.fastq.gz                                Meglea_R2_001.fastq.gz.md5
Notgla_R1_001.fastq.gz                                Notgla_R1_001.fastq.gz.md5
Notgla_R2_001.fastq.gz                                Notgla_R2_001.fastq.gz.md5
Ochple_R1_001.fastq.gz                                Ochple_R1_001.fastq.gz.md5
Ochple_R2_001.fastq.gz                                Ochple_R2_001.fastq.gz.md5
Phrful_R1_001.fastq.gz                                Phrful_R1_001.fastq.gz.md5
Phrful_R2_001.fastq.gz                                Phrful_R2_001.fastq.gz.md5
Stemel_R1_001.fastq.gz                                Stemel_R1_001.fastq.gz.md5
Stemel_R2_001.fastq.gz                                Stemel_R2_001.fastq.gz.md5
# not working
# mget [Aph|Bom|Cer|Eph|Meg|Not|Och|Phr|Ste]*001.fastq.gz*

# not working
# Aphsti_R1_001.fastq.gz.md5
#for species in Aph Bom Cer Eph Meg Not Och Phr Ste; do
for species in Bom Cer Eph Meg Not Och Phr Ste; do
    mget ${species}*001.fastq.gz.md5
done

#mget Aph*001.fastq.gz*
mget Bom*001.fastq.gz*
mget Cer*001.fastq.gz*
mget Eph*001.fastq.gz*
mget Meg*001.fastq.gz*
mget Not*001.fastq.gz*
mget Och*001.fastq.gz*
mget Phr*001.fastq.gz*
mget Ste*001.fastq.gz*

## mget will only download files in the directory that you are in. then
## please use mget within each subdirectory to download your data.
## Downloading all files within a directory: mget*
mget 90-1171642133_Azenta_Data_Report.html
## get -r will recursively download all files and folders within the project folder.
## get -r Project_folder

## rename fastq files and concatenate fastq files for the same species
cd /home/yzliu/eDNA/faststorage/yzliu/BACKUP/pool_raw_data/pool_04_2025
rename 001 002 *.gz
cd /home/yzliu/eDNA/faststorage/yzliu/BACKUP/pool_raw_data/pool_04_2025

ls
Aphsti_R1_001.fastq.gz
Aphsti_R1_002.fastq.gz
Aphsti_R2_001.fastq.gz
Aphsti_R2_002.fastq.gz

for species in Aphsti Bommaj Cerryb Ephdan Meglea Notgla Ochple Phrful Stemel; do
#for species in Bom Cer Eph Meg Not Och Phr Ste; do
    cat ${species}_R1_00*.fastq.gz > ${species}_R1_000.fastq.gz
    cat ${species}_R2_00*.fastq.gz > ${species}_R2_000.fastq.gz
done