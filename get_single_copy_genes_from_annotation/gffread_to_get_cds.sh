
## conda install bioconda::gffread
#gff_species=$test_folder/apis_mel_10027at7399_busco/10027at7399.gff
gff_species=$test_folder/And_bic_10027at7399_busco/10027at7399.gff
ref_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
#ref_apis_mel=$ref_dir/Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa
ref_And_bic=$ref_dir/Andrena_bicolor-GCA_960531205.1.fa

#gffread_output=${gff_species/gff/gff.gffread.fa}
#gffread -w $gffread_output -g $ref_apis_mel $gff_species

conda activate myproject

gffread_output=${gff_species/gff/gff.gffread_cds.fa}
gffread -x $gffread_output -g $ref_And_bic $gff_species

ref_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
## ref_And_bic=$ref_dir/Andrena_bicolor-GCA_960531205.1.fa ## header name issues
ref_And_bic=$ref_dir/Andrena_bicolor-GCA_960531205.1.simple_header_new.fa
gtf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/braker_AndBic_results_for_protseq
gtf_species=braker_copy.gtf

gffread_output=${gtf_species/_copy.gtf/.gffread_cds.fa}
cds_output_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/cds_gffread
cd $cds_output_dir
gffread -x $gffread_output -g $ref_And_bic $gtf_dir/$gtf_species

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/braker_AndBic_results_for_protseq
sed 's/\(g[0-9]\+\)/And_bic.\1/g' braker_copy.gtf > braker_copy_new_gene_id.gtf

*************** change id names in the gtf and fa files **************
***************         self annotated genomes          **************
primary_transcripts=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts
cd $primary_transcripts
new_transcript_id_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id

species_list=(
    "And_bic"
    "And_mar"
    "Bom_con"
    "Bom_mus"
)

gtf_list=(
    "Andrena_bicolor-GCA_960531205.1_braker-genes.gtf"
    "Andrena_marginata_GCA_963932335.1_braker-genes.gtf"
    "Bombus_confusus-GCA_014737475.1_ASM1473747v1_braker-genes.gtf"
    "Bombus_muscorum-GCA_963971125.1_braker-genes.gtf"
)

fa_list=(
    "Andrena_bicolor-GCA_960531205.1_braker-pep.fa"
    "Andrena_marginata_GCA_963932335.1_braker-pep.fa"
    "Bombus_confusus-GCA_014737475.1_ASM1473747v1_braker-pep.fa"
    "Bombus_muscorum-GCA_963971125.1_braker-pep.fa"
)

echo "total number of species in the list: "${#species_list[@]}
length=${#species_list[@]}
#eval echo {1..$length}

## modify gene id (not right)
## need transcript id that is also done

for ((index=0;index < $length;index++))
do
## debug
#echo $length $index ${species_list[index]} ${fa_list[index]} 
#done

echo "modifying gene/tranwscript id in gtf files for: "${species_list[index]}
output_gtf_file_name=${gtf_list[index]/gtf/new_transcript_id.gtf}
sed "s/\(g[0-9]\+\)/${species_list[index]}.\1/g" ${gtf_list[index]} > $new_transcript_id_dir/$output_gtf_file_name

echo "modifying transcript id in fa files for: "${species_list[index]}
output_fa_file_name=${fa_list[index]/fa/new_transcript_id.fa}
sed "s/>\(g[0-9]\+\)/>${species_list[index]}.\1/g" ${fa_list[index]} > $new_transcript_id_dir/$output_fa_file_name
done

# >.*transcript:\([^ ]*\) gene_biotype.*

***********   extra changes for Apis mel *****************
gene_id in gtf file Bom_hor: ENSBHTG00000016233
header_name in pep.fa file Bom_hor: >ENSBHTG00000016233.1

protein_id in gft file Apis_mel: XP_625277.1
# NC_037638.1	Gnomon	CDS	11159018	11159326	.	+	0	gene_id "LOC552067"; transcript_id "XM_625274.6"; db_xref "GeneID:552067"; gbkey "CDS"; gene "LOC552067"; product "uncharacterized protein LOC552067"; protein_id "XP_625277.1"; exon_number "1"; 
# NC_037638.1	Gnomon	CDS	11159514	11159629	.	+	0	gene_id "LOC552067"; transcript_id "XM_625274.6"; db_xref "GeneID:552067"; gbkey "CDS"; gene "LOC552067"; product "uncharacterized protein LOC552067"; protein_id "XP_625277.1"; exon_number "2"; 

header_name in pep.fa file Apis_mel: >XP_625277.1 uncharacterized protein LOC552067 [Apis mellifera]
# >XP_625277.1 uncharacterized protein LOC552067 [Apis mellifera]
# MKRSKIQMIKVFIFLLIFQLKQSAVCNESFRIDKDIPDPMENKNVETVKKDNAHNSLDGEKFQQNAVLSGGTTILENNRT

# it's a bit messy so below codes making it shorter
primary_transcripts=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts
cd $primary_transcripts
Apis_mel_pep=GCF_003254395.2_Amel_HAv3.1-pep.fa
out_file_name=${Apis_mel_pep/pep.fa/new_header-pep.fa}

# >NP_001010975.1 ADP/ATP translocase [Apis mellifera]
# MSGLADPVAFAKDFLAGGVAAAISKTTVAPIERVKLLLQVQHISKQISEEQRYKGMIDCFVRIPKEQGFLSYWRGNLANV
sed "s/ .*//" $Apis_mel_pep > $out_file_name

## get list of the protein_id so to extract lines with these patterns from gtf file
# step I:
grep '>' $out_file_name | sed 's/>//' | head
NP_001010975.1
NP_001011562.1

# step II:
Apis_mel_gtf=GCF_003254395.2_Amel_HAv3.1-genes.gtf
protein_id=$(grep '>' $out_file_name | sed 's/>//' | head)
extracted_gtf=${Apis_mel_gtf/gtf/extracted.gtf}

for id in ${protein_id[@]}
do
echo "extract gtf data for: "$id
grep $id $Apis_mel_gtf >> $extracted_gtf
done

#rm *extracted.gtf


***********            for downloaded genomes              ***********

primary_transcripts=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts
cd $primary_transcripts

new_transcript_id_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id

species_list=(
    "And_ful"
    "And_hae"
    "And_hat"
    "And_tri"
    "Apis_mel"
    "Bom_hor"
    "Bom_hyp"
    "Bom_pas"
    "Bom_syl"
    "Ves_vul"
)

#ls | grep -v -e "braker" -e "\.fa$"

gtf_list=(
    "Andrena_fulva-GCA_946251845.1-2023_02-genes.gtf"
    "Andrena_haemorrhoa-GCA_910592295.1-2021_11-genes.gtf"
    "Andrena_hattorfiana-GCA_944738655.1-2022_08-genes.gtf"
    "Andrena_trimmerana-GCA_951215215.1-2023_07-genes.gtf"
    "Apis_mellifera-GCF_003254395.2_Amel_HAv3.1-genes.extracted.gtf"
    "Bombus_hortorum-GCA_905332935.1-2021_11-genes.gtf"
    "Bombus_hypnorum-GCA_911387925.1-2021_11-genes.gtf"
    "Bombus_pascuorum-GCA_905332965.1-2021_11-genes.gtf"
    "Bombus_sylvestris-GCA_911622165.2-2023_03-genes.gtf"
    "Vespula_vulgaris-GCA_905475345.1-2021_11-genes.gtf"

)

#ls | grep -v -e "braker" -e "\.gtf$"

fa_list=(
    "Andrena_fulva-GCA_946251845.1-2023_02-pep.fa"
    "Andrena_haemorrhoa-GCA_910592295.1-2021_11-pep.fa"
    "Andrena_hattorfiana-GCA_944738655.1-2022_08-pep.fa"
    "Andrena_trimmerana-GCA_951215215.1-2023_07-pep.fa"
    "Apis_mellifera-GCF_003254395.2_Amel_HAv3.1-new_header-pep.fa"
    "Bombus_hortorum-GCA_905332935.1-2021_11-pep.fa"
    "Bombus_hypnorum-GCA_911387925.1-2021_11-pep.fa"
    "Bombus_pascuorum-GCA_905332965.1-2021_11-pep.fa"
    "Bombus_sylvestris-GCA_911622165.2-2023_03-pep.fa"
    "Vespula_vulgaris-GCA_905475345.1-2021_11-pep.fa"

)

#echo "total number of species in the list: "${#species_list[@]}
length=${#species_list[@]}
eval echo {1..$length}

for ((index=0;index < $length;index++))
do
## debug
#echo $length $index ${species_list[index]} ${fa_list[index]} 
#done

echo "modifying gene id in gtf files for: "${species_list[index]}
## 1	ensembl	gene	27963796	27985797	.	+	.	gene_id "ENSAHEG00005013983"; gene_version "1"; gene_name "OCA2"; gene_source "ensembl"; gene_biotype "protein_coding";
## 1	ensembl	transcript	27963796	27985797	.	+	.	gene_id "ENSAHEG00005013983"; gene_version "1"; transcript_id "ENSAHET00005022701"; transcript_version "1"; gene_name "OCA2"; gene_source "ensembl"; gene_biotype "protein_coding"; transcript_source "ensembl"; transcript_biotype "protein_coding"; tag "Ensembl_canonical";

## old
#output_gtf_file_name=${gtf_list[index]/gtf/new_gene_id.gtf}

## new
output_gtf_file_name=${gtf_list[index]/gtf/new_transcript_id.gtf}

sed "s/\(gene_id \"\|transcript_id \"\|exon_id \"\|protein_id \"\)\([^\"]*\)\"/\1${species_list[index]}.\2\"/g" ${gtf_list[index]} > $new_transcript_id_dir/$output_gtf_file_name
## 1       ensembl exon    27966467        27966623        .       +       .       gene_id "And_hae.ENSAHEG00005013983"; gene_version "1"; transcript_id "And_hae.ENSAHET00005022701"; transcript_version "1"; exon_number "3"; gene_name "OCA2"; gene_source "ensembl"; gene_biotype "protein_coding"; transcript_source "ensembl"; transcript_biotype "protein_coding"; exon_id "And_hae.ENSAHEE00005066928"; exon_version "1"; tag "Ensembl_canonical";

#echo "modifying gene id in fa files for: "${species_list[index]}
## >ENSAHEG00005013983.1
## MSPNDTSEDETGLQTPMFLRKGSRCSRGTPGTPSSVSSSVIFGQIPEEVLRVWSQLPEAI
## Apis_mel
## >XP_006566774.2
## MIFNKIVLLIIYFELQLIWTQTTIPKSLRECYKNNVTLNPPIPLNLRILIDIIQKMEKYSYSTIDMRIMSSSILHRFRFD
## Bom_syl
## >ENSBSYG00000006910.2
## MAGVKMFQINFKTMDESPVIKRPKPSDSEEELFRMQEEFLRNKQQPSAKVINLRRSETFL

#output_fa_file_name=${fa_list[index]/fa/new_gene_id.fa}
#sed "s/>\(.*\)\.[1-9]/>${species_list[index]}\.\1/g" ${fa_list[index]} > $output_fa_file_name


echo "modifying transcript id in fa files for: "${species_list[index]}
output_fa_file_name=${fa_list[index]/fa/new_transcript_id.fa}
sed "s/>.*transcript:\([^ ]*\) gene_biotype.*/>${species_list[index]}\.\1/g" ${fa_list[index]} > $new_transcript_id_dir/$output_fa_file_name
# And_hae.ENSAHET00005022701
done

**************     move new_gene_id files to folder: new_gene_id ***************
mv *new_gene_id* ./new_gene_id


********** need transcript id NOT gene id **********
Bombus_hortorum_pep_fa=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/Bombus_hortorum-GCA_905332935.1-2021_11-pep.fa

>ENSBHTP00000025110.1 pep iyBomHort1.1:1:20238027:20239177:-1 gene:ENSBHTG00000016230.1 transcript:ENSBHTT00000037555.1 gene_biotype:protein_coding transcript_biotype:protein_coding
MIKTFIFLDLETTGLITKNYMPKITEMSLIAVSRSAICDTTNISPRILQKLVLPIHPNVP
ISKDIQKLTGLSNENLKEFPCFNCDIHNLVVNFINRLAAPACFIAYNGNNYDYPIFLSEF
KNIEKNFSENVLSIDMMHLVKEFFSRKQNPIKEMNIVQPTASSSNYTEDRRGSNVRRQLD
FTNSQPINFKLGSVYKHIFGNKPEDAHSAEGDCLTMIRCAIKLGNFFVEWTDCNAVPLTN
YASK


        ## match string before and include "gene_id"
        new_gtf_name=${gtf_list[i]#*gene_id/}
        ## keep string before "_GCA"
        new_gtf_name=${new_gtf_name%[_-]GCA*}

## >.*gene:\([^ ]*\) transcript.*: This regular expression captures everything between gene: and transcript.
## The \([^ ]*\) captures the gene ID, which is assumed to not contain spaces.
sed 's/>.*transcript:\([^ ]*\) gene_biotype.*/>\1/g' $Bombus_hortorum_pep_fa | less -S

>ENSBHTT00000037560.1
MTRGRHKKMLMLIPILLVAVFAEPDPTDELYRGFPKYRDEDKCYDDSGKPQRCIPPFENA
AFNVLMEATNTCGQDRPTEFCKQTGVQKKSCEICQYGDHQALYLTDHDNNDNATWWQSET
MFEGIEYPNQVNLTLHLGKTFDITYVRALFESPRPESWGIYKRKNEKSPWEPFQFYSATC
RDTYDLPDLKETVRGDDTRVLCTSDYSDISPLTKGTVAFSTLEGRPSAYNFETNPALQEW
VQATDLRITLDRLNTFGDEVFGDDHVLKSYYYAIADVAVGARCACNGHAGECVNSTSVDG
KTRRVCRCEHNTAGPDCNECLPFYNDAPWGRATTKDAHECKHRHRIACYKSNILAYIVIS
NMKVFYTRENNFFGIASITFPSSRREFAFTITLALPNQLYLLRSLLVLKWGLLAIQEHTM
QLFCRSRAQCSRYYDTSRYLLHRVD
>ENSBHTT00000037555.1
MIKTFIFLDLETTGLITKNYMPKITEMSLIAVSRSAICDTTNISPRILQKLVLPIHPNVP
ISKDIQKLTGLSNENLKEFPCFNCDIHNLVVNFINRLAAPACFIAYNGNNYDYPIFLSEF
KNIEKNFSENVLSIDMMHLVKEFFSRKQNPIKEMNIVQPTASSSNYTEDRRGSNVRRQLD
FTNSQPINFKLGSVYKHIFGNKPEDAHSAEGDCLTMIRCAIKLGNFFVEWTDCNAVPLTN
YASK