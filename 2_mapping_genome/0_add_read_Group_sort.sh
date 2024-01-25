
#Add read group headers
P23261_106      NexteraUD_UDP0006       illumina        AHCYGKDSX3      M_L006
P23261_110      NexteraUD_UDP0010       illumina        AHCYGKDSX3      M_L010
P23261_111      NexteraUD_UDP0011       illumina        AHCYGKDSX3      M_L011

sed -e 's/\t/\\t:/g' -e 's/P23261/@RG\\tID:P23261/g' -e 's/:Next/LB:Next/g' -e 's/:ill/PL:ill/g' -e 's/:AH/PU:AH/g' -e 's/X3\\t:/X3\\tSM:/g' seed3_ReadGroup |head (> seed3_RG)
@RG\tID:P23261_106\tLB:NexteraUD_UDP0006\tPL:illumina\tPU:AHCYGKDSX3\tSM:M_L006

# empirical Drosophila melanogaster
LB	PL	PU	SM
SRR24680725	Illumina_NovaSeq_6000	gDNA	SB_SE_01

sed '1d' dro_mel_readGroup.list | sort -k1 -n 
sed -e 's/\t/\\t:/g' -e 's/SRR/@RG\\tLB:SRR/g' -e 's/:Illumina/PL:Illumina/g' -e 's/:gDNA/PU:gDNA/g' -e 's/gDNA\\t:/gDNA\\tSM:/g' dro_mel_readGroup.list | head (> seed3_RG)

## sort columns and rows
# https://stackoverflow.com/questions/6438896/sorting-data-based-on-second-column-of-a-file
sed -e '1d' -e 's/\t/\\t:/g' -e 's/SRR/@RG\\tLB:SRR/g' -e 's/:Illumina/PL:Illumina/g' -e 's/:gDNA/PU:gDNA/g' -e 's/gDNA\\t:/gDNA\\tSM:/g' dro_mel_readGroup.list > dro_mel_readGroup.new.list
sed '1d' dro_mel_readGroup.list | sort -k1 -n > dro_mel_readGroup.sort.list
sed '1d' dro_mel_readGroup.list | sort -k1 -n | sed -e 's/\t/\\t:/g' -e 's/SRR/@RG\\tLB:SRR/g' -e 's/:Illumina/PL:Illumina/g' -e 's/:gDNA/PU:gDNA/g' -e 's/gDNA\\t:/gDNA\\tSM:/g' > dro_mel_readGroup.sort.new.list
sort -k1 -n dro_mel_readGroup.sort.new0.list | sed -e 's/\t/\\t:/g' -e 's/SRR/@RG\\tID:SRR/g' -e 's/:S/LB:S/2' -e 's/:Illumina/PL:Illumina/g' -e 's/:gDNA/PU:gDNA/g' -e 's/gDNA\\t:/gDNA\\tSM:/g' > dro_mel_readGroup.sort.new1.list
