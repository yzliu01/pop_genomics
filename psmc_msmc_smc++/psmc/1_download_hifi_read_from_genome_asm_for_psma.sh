# genome download
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR111/052/ERR11180452/ERR11180452.fastq.gz -P ./andrena_marginata/ # create a folder if not existing

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/bombus_pascuorum
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR654/008/ERR6548408/ERR6548408.fastq.gz

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/andrena_harmorrhoa
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR641/008/ERR6412038/ERR6412038.fastq.gz

## 2025
# Aphodius sticticus
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR123/014/ERR12340114/ERR12340114.fastq.gz -P ./Aphodius_sticticus

# Rutpela maculata
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR928/004/ERR9284044/ERR9284044.fastq.gz -P ./Rutpela_maculata
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR928/005/ERR9284045/ERR9284045.fastq.gz -P ./Rutpela_maculata
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR928/006/ERR9284046/ERR9284046.fastq.gz -P ./Rutpela_maculata

# Stenurella melanura
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR116/047/ERR11673247/ERR11673247.fastq.gz -P ./Stenurella_melanura
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR116/046/ERR11673246/ERR11673246.fastq.gz -P ./Stenurella_melanura

# Cerceris rybyensis
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR643/007/ERR6436387/ERR6436387.fastq.gz -P ./Cerceris_rybyensis

# Megachile leachella
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR116/059/ERR11641059/ERR11641059.fastq.gz -P ./Megachile_leachella
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR116/060/ERR11641060/ERR11641060.fastq.gz -P ./Megachile_leachella

# Bombylius major
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR870/003/ERR8705853/ERR8705853.fastq.gz -P ./Bombylius_major

# Notonecta glauca
existing

# Ochropleura plecta
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR640/007/ERR6406207/ERR6406207.fastq.gz -P ./Ochropleura_plecta

# Phragmatobia fuliginosa
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR857/006/ERR8575386/ERR8575386.fastq.gz -P ./Phragmatobia_fuliginosa


# Ephemera danica
# https://www.ncbi.nlm.nih.gov/Traces/study/?acc=SRP028381&o=acc_s%3Aa
#Illumina HiSeq2000: 2x100bp
## (SRA normalized -> through data access icon) https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=SRR946750&display=data-access
wget https://sra-pub-run-odp.s3.amazonaws.com/sra/SRR946750/SRR946750 -P ./Ephemera_danica
wget https://sra-pub-run-odp.s3.amazonaws.com/sra/SRR946749/SRR946749 -P ./Ephemera_danica
wget https://sra-pub-run-odp.s3.amazonaws.com/sra/SRR946748/SRR946748 -P ./Ephemera_danica
wget https://sra-pub-run-odp.s3.amazonaws.com/sra/SRR946747/SRR946747 -P ./Ephemera_danica

https://trace.ncbi.nlm.nih.gov/Traces/?run=SRR946748

# Porcellio scaber: Illumina HiSeq 2000 
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR529/004/SRR5298324/SRR5298324_1.fastq.gz -P ./Porcellio_scaber
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR529/004/SRR5298324/SRR5298324_2.fastq.gz -P ./Porcellio_scaber

# Chorthippus brunneus

# Chorthippus parallelus

# Agelastica alni
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR109/013/ERR10906113/ERR10906113.fastq.gz -P ./Agelastica_alni

# Amphimallon solstitiale
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR114/086/ERR11458786/ERR11458786.fastq.gz -P ./Amphimallon_solstitiale
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR117/070/ERR11788370/ERR11788370.fastq.gz -P ./Amphimallon_solstitiale

# Dorcus parallelipipedus
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR108/047/ERR10879947/ERR10879947.fastq.gz -P ./Dorcus_parallelipipedus

# Malachius bipustulatus
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR643/005/ERR6436375/ERR6436375.fastq.gz -P ./Malachius_bipustulatus

# Phosphuga atrata
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR985/005/ERR9854185/ERR9854185.fastq.gz -P ./Phosphuga_atrata
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR983/008/ERR9836418/ERR9836418.fastq.gz -P ./Phosphuga_atrata
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR983/009/ERR9836419/ERR9836419.fastq.gz -P ./Phosphuga_atrata

# Pterostichus niger
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR102/026/ERR10224926/ERR10224926.fastq.gz -P ./Pterostichus_niger

# Rhagonycha fulva
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR660/008/ERR6606788/ERR6606788.fastq.gz -P ./Rhagonycha_fulva

# Lasioglossum morio
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR693/005/ERR6939225/ERR6939225.fastq.gz -P ./Lasioglossum_morio

# Panurgus banksianus
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR123/031/ERR12370431/ERR12370431.fastq.gz -P ./Panurgus_banksianus

# Bibio marci
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR641/005/ERR6412035/ERR6412035.fastq.gz -P ./Bibio_marci

# Eristalis intricaria
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR112/013/ERR11242113/ERR11242113.fastq.gz -P ./Eristalis_intricaria

# Eristalis pertinax
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR656/009/ERR6560799/ERR6560799.fastq.gz -P ./Eristalis_pertinax

# Tachina fera
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR660/004/ERR6608654/ERR6608654.fastq.gz -P ./Tachina_fera

# Aelia acuminata
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR640/007/ERR6406217/ERR6406217.fastq.gz -P ./Aelia_acuminata
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR654/006/ERR6544656/ERR6544656.fastq.gz -P ./Aelia_acuminata

# Gerris lacustris
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR109/014/ERR10962214/ERR10962214.fastq.gz -P ./Gerris_lacustris

# Leptopterna dolabrata
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR114/024/ERR11458824/ERR11458824.fastq.gz -P ./Leptopterna_dolabrata

# Noctua pronuba
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR659/007/ERR6590587/ERR6590587.fastq.gz -P ./Noctua_pronuba

# Tholera decimalis
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR970/009/ERR9709329/ERR9709329.fastq.gz -P ./Tholera_decimalis
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR970/000/ERR9709330/ERR9709330.fastq.gz -P ./Tholera_decimalis
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR970/001/ERR9709331/ERR9709331.fastq.gz -P ./Tholera_decimalis
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR970/002/ERR9709332/ERR9709332.fastq.gz -P ./Tholera_decimalis


# Xestia c-nigrum
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR693/005/ERR6939245/ERR6939245.fastq.gz -P ./Xestia_c-nigrum
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR693/006/ERR6939246/ERR6939246.fastq.gz -P ./Xestia_c-nigrum


# Mystacides longicornis
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR121/052/ERR12102452/ERR12102452.fastq.gz -P ./Mystacides_longicornis

