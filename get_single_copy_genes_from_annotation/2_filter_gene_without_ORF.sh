

******************** step V_a: obtain amino acide sequences for each busco_id if starting with M ********************
## codes from chatGPT
#!/bin/bash
# Loop through all .faa files
annotation_id_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_gene_id/OrthoFinder/Results_Aug29/Single_Copy_Orthologue_Sequences
cd $annotation_id_dir

# ls |sort -V | head
# OG0003399.fa
# OG0003400.fa

# ls *.fa | wc -l
# 1176

for file in `ls *.fa | sort -V`; do
#for file in `ls *.fa | sort -V | head -2`; do
    exclude=false
    seq=""

    # Read through the file line by line
    while IFS= read -r line || [ -n "$line" ]; do
        if [[ "$line" == ">"* ]]; then
            # If line is a header, process the previous sequence
            if [ -n "$seq" ]; then
                if [[ "${seq:0:1}" != "M" ]]; then
                    exclude=true
                    break
                fi
            fi
            # Reset sequence for the next entry
            seq=""
        else
            # Accumulate sequence lines (remove whitespaces)
            seq+=$(echo -n "$line" | tr -d '[:space:]')
        fi
    done < "$file"

    # Handle the last sequence in the file
    if [ -n "$seq" ] && [[ "${seq:0:1}" != "M" ]]; then
        exclude=true
    fi

    # If any sequence did not start with M, rename the file and delete them
    if $exclude; then
        echo "Excluding $file as it contains sequences not starting with M."
        # Uncomment the following line to delete the file
        # rm "$file"
        # Alternatively, rename the file with .retained.faa extension, and delete those without starting "M"
        cp "$file" "$file.without_start_M.fa"
        rm "$file"
    else
        echo "$file passed the filter."
    fi
done

## check how many files left: 636
ls | grep -v "_M.fa" | wc -l

head OG0003401.fa
>And_bic.g14096.t1
MAFFEWRRFNFFDLKKEVDGGKIAKALGDAQVTAATSGNGNLVFGDNTGNVHLVNRTYDV
TTFRAYEITLTLAQQVQHSTFLFTIGEDELGCNPTIKVWNLEKQGSPTCVRISRAIPSYK
NITPKSSPIQKAFVPPKTPIVPSNPFQTVEYDESKNPFFDEKDSNLVKDNDDDDCNKNLN
PFSR*
>And_ful.ENSAFVG00005013433
MAFFEWRRFNFFDLKKEVDGGKIAKALGDAQVTAATSGNGNLVFGDNTGNVHLVNRTYDV
TTFRAYEITLTLAQQVQHSTFLFTIGEDELGCNPTIKVWNLEKQGSPICVRISRAIPSYR
AVPATALCVHSSLTLMAVGFGDGCIMLYRGDLTRERKNKIKVLQDANISITGLAIKSTGK

## extract single_copy_orthologue_id and save them in a file, which will be used in gffread to retreat nucleotide sequences
for single_copy_orthologue_id in $(ls | grep -v "_M.fa")
do
grep ">" $single_copy_orthologue_id | sed 's/>//' > $single_copy_orthologue_id.header.list
done

ls *.header.list | wc -l
636

head OG0003401.fa.header.list
And_bic.g14096.t1
And_ful.ENSAFVG00005013433
And_hae.ENSAHEG00005010799
And_hat.ENSAHTG00000005884
And_mar.g10890.t1
And_tri.ENSFOKG00000011406
Apis_mel.XP_026300747
Bom_con.g12659.t1
Bom_hor.ENSBHTG00000018305
Bom_hyp.ENSBHYG00000014989
# test
file=OG0003401.fa.header.list
while IFS= read -r line
do
echo "read line: "$line
done < $file

# formal

ref_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
# 14 reference species
ref_Apis_mel=$ref_dir/Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa
ref_And_bic=$ref_dir/Andrena_bicolor-GCA_960531205.1.fa
ref_And_ful=$ref_dir/Andrena_fulva-GCA_946251845.1-softmasked.fa
ref_And_hae=$ref_dir/Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa
ref_And_hat=$ref_dir/Andrena_hattorfiana-GCA_944738655.1-softmasked.fa
ref_And_mar=$ref_dir/Andrena_marginata_GCA_963932335.1-softmasked.fa
ref_And_tri=$ref_dir/Andrena_trimmerana-GCA_951215215.1-softmasked.fa
ref_Bom_con=$ref_dir/Bombus_confusus-GCA_014737475.1_ASM1473747v1-softmasked.fa
ref_Bom_hor=$ref_dir/Bombus_hortorum-GCA_905332935.1-softmasked.fa
ref_Bom_hyp=$ref_dir/Bombus_hypnorum-GCA_911387925.1-softmasked.fa
ref_Bom_mus=$ref_dir/Bombus_muscorum-GCA_963971125.1.fa
ref_Bom_pas=$ref_dir/Bombus_pascuorum-GCA_905332965.1-softmasked.fa
ref_Bom_syl=$ref_dir/Bombus_sylvestris-GCA_911622165.2-softmasked.fa
ref_Ves_vul=$ref_dir/Vespula_vulgaris-GCA_905475345.1-softmasked.fa

ref_list=(
    "$ref_And_bic"
    "$ref_And_ful"
    "$ref_And_hae"
    "$ref_And_hat"
    "$ref_And_mar"
    "$ref_And_tri"
    "$ref_Apis_mel"
    "$ref_Bom_con"
    "$ref_Bom_hor"
    "$ref_Bom_hyp"
    "$ref_Bom_mus"
    "$ref_Bom_pas"
    "$ref_Bom_syl"
    "$ref_Ves_vul"
)

## path to gft files
gtf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_gene_id
#cd $gtf_dir

gtf_And_bic=$gtf_dir/Andrena_bicolor-GCA_960531205.1_braker-genes.new_gene_id.gtf
gtf_And_ful=$gtf_dir/Andrena_fulva-GCA_946251845.1-2023_02-genes.new_gene_id.gtf
gtf_And_hae=$gtf_dir/Andrena_haemorrhoa-GCA_910592295.1-2021_11-genes.new_gene_id.gtf
gtf_And_hat=$gtf_dir/Andrena_hattorfiana-GCA_944738655.1-2022_08-genes.new_gene_id.gtf
gtf_And_mar=$gtf_dir/Andrena_marginata_GCA_963932335.1_braker-genes.new_gene_id.gtf
#gtf_And_tri=$gtf_dir/Andrena_trimmerana-GCA_951215215.1-2023_07-genes.new_gene_id.gtf
gtf_And_tri=$gtf_dir/Andrena_trimmerana-GCA_951215215.1-2023_07-genes.new_gene_id.md_chr.gtf
gtf_Apis_mel=$gtf_dir/Apis_mellifera-GCF_003254395.2_Amel_HAv3.1-genes.extracted.new_gene_id.gtf
gtf_Bom_con=$gtf_dir/Bombus_confusus-GCA_014737475.1_ASM1473747v1_braker-genes.new_gene_id.gtf
gtf_Bom_hor=$gtf_dir/Bombus_hortorum-GCA_905332935.1-2021_11-genes.new_gene_id.gtf
gtf_Bom_hyp=$gtf_dir/Bombus_hypnorum-GCA_911387925.1-2021_11-genes.new_gene_id.gtf
gtf_Bom_mus=$gtf_dir/Bombus_muscorum-GCA_963971125.1_braker-genes.new_gene_id.gtf
gtf_Bom_pas=$gtf_dir/Bombus_pascuorum-GCA_905332965.1-2021_11-genes.new_gene_id.gtf
gtf_Bom_syl=$gtf_dir/Bombus_sylvestris-GCA_911622165.2-2023_03-genes.new_gene_id.gtf
gtf_Ves_vul=$gtf_dir/Vespula_vulgaris-GCA_905475345.1-2021_11-genes.new_gene_id.gtf

#gtf_Ves_vul=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_gene_id/Vespula_vulgaris-GCA_905475345.1-2021_11-genes.new_gene_id.gtf
#new_gtf_name=${gtf_Ves_vul%%[_-]GCA*}
#echo $new_gtf_name

gtf_list=(
    "$gtf_And_bic"
    "$gtf_And_ful"
    "$gtf_And_hae"
    "$gtf_And_hat"
    "$gtf_And_mar"
    "$gtf_And_tri"
    "$gtf_Apis_mel"
    "$gtf_Bom_con"
    "$gtf_Bom_hor"
    "$gtf_Bom_hyp"
    "$gtf_Bom_mus"
    "$gtf_Bom_pas"
    "$gtf_Bom_syl"
    "$gtf_Ves_vul"
)

## call gffread
conda activate myproject
#gffread -h

single_copy_orthologue_with_start_M=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_gene_id/OrthoFinder/Results_Aug29/Single_Copy_Orthologue_Sequences

extracted_cds_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds
cd $extracted_cds_dir

for orthologue_id in $(ls $single_copy_orthologue_with_start_M/*.fa.header.list | head -2)
# Single_Copy_Orthologue_Sequences/OG0003401.fa.header.list
do
#echo $orthologue_id
new_orthologue_id=${orthologue_id#*_Sequences/}
new_orthologue_id=${new_orthologue_id%.fa*}
echo $new_orthologue_id
#done
    while IFS= read -r line
    do
    
        for i in $(seq 0 13)
        do
        #echo $i
        #done
        echo -e "read_line_$i: "$new_orthologue_id.$line
        echo -e "\n${gtf_list[i]}\n"
        ## match gene_id and extract lines from gtf file of each species
        ## match string before and include "gene_id"
        new_gtf_name=${gtf_list[i]#*gene_id/}
        ## keep string before "_GCA"
        new_gtf_name=${new_gtf_name%[_-]GCA*}
        echo ./$new_orthologue_id.$line.$new_gtf_name.gtf
        grep "$line" ${gtf_list[i]} > ./$new_orthologue_id.$line.$new_gtf_name.gtf
        #| gffread -g ${ref_list[i]} >> ./$orthologue_id.out
        ## write sequences to a file
        #gffread -g ${ref_list[i]} ./$new_orthologue_id.$new_gtf_name.gtf >> ./$new_orthologue_id.$new_gtf_name.cds.out
        gffread -x ./$new_orthologue_id.$line.$new_gtf_name.cds.fa -g ${ref_list[i]} ./$new_orthologue_id.$line.$new_gtf_name.gtf
        echo -e "\nwrite cds to ./$new_orthologue_id.$line.$new_gtf_name.cds.fa\n"
        ## delete empty files that are not matched
        #find . -type f -size 0 -delete
        done
    done < $orthologue_id
done


and_tri_gtf=OG0003404.And_tri.ENSFOKG00000007827.Andrena_trimmerana.gtf
gffread -x $and_tri_gtf.CDS.fa  -g $ref_And_tri $and_tri_gtf
# delete file empty files
find . -type f -size 0 -delete

rm *list.out

less -S $ref_And_tri | grep '>' | head

# make sure the chromosome names in gtf file are the same as that in genome.fa file
_CAXAQ -> |CAXAQ
ENA_OZ010664_OZ010664.1
ENA|OZ010664|OZ010664.1

less $ref_And_tri | grep '>'
>ENA|OX578059|OX578059.1 Andrena trimmerana genome assembly, chromosome: 1
>ENA|OX578060|OX578060.1 Andrena trimmerana genome assembly, chromosome: 2
>ENA|OX578061|OX578061.1 Andrena trimmerana genome assembly, chromosome: 3
>ENA|OX578062|OX578062.1 Andrena trimmerana genome assembly, chromosome: 4
>ENA|OX578063|OX578063.1 Andrena trimmerana genome assembly, chromosome: 5
>ENA|OX578064|OX578064.1 Andrena trimmerana genome assembly, organelle: mitochondrion
>ENA|CATNUO010000001|CATNUO010000001.1 Andrena trimmerana genome assembly, contig: scaffold_100
>ENA|CATNUO010000002|CATNUO010000002.1 Andrena trimmerana genome assembly, contig: scaffold_112
>ENA|CATNUO010000003|CATNUO010000003.1 Andrena trimmerana genome assembly, contig: scaffold_32

less Andrena_trimmerana-GCA_951215215.1-2023_07-genes.new_gene_id.gtf | awk '{print "ENA|"$1"|"$1}' > \
    Andrena_trimmerana-GCA_951215215.1-2023_07-genes.new_gene_id.md_chr.gtf

awk 'NR==7{print NF}' OFS="\t" Andrena_trimmerana-GCA_951215215.1-2023_07-genes.new_gene_id.gtf

## replace chr in numbers that are at the beginning of each line
sed -e 's/^1\b/OX578059.1/g' \
    -e 's/^2\b/OX578060.1/g' \
    -e 's/^3\b/OX578061.1/g' \
    -e 's/^4\b/OX578062.1/g' \
    -e 's/^5\b/OX578063.1/g' \
    -e 's/^mitochondrion\b/OX578064.1/g' \
    Andrena_trimmerana-GCA_951215215.1-2023_07-genes.new_gene_id.gtf \
    > Andrena_trimmerana-GCA_951215215.1-2023_07-genes.new_gene_id.md_chr_tem_1.gtf
# CATNUO010000051.1       ensembl exon

## remove the first 5 lines
grep -v '^#' Andrena_trimmerana-GCA_951215215.1-2023_07-genes.new_gene_id.md_chr_tem_1.gtf | \
    awk '{print "ENA|"$1"|"$1, substr($0, index($0,$2))}' | sed 's/\.1|/|/' \
    > Andrena_trimmerana-GCA_951215215.1-2023_07-genes.new_gene_id.md_chr.gtf
## need to change it
# ENA|OX578059.1|OX578059.1
## below is desired
# ENA|OX578059|OX578059.1
rm *md_chr_tem_1.gtf



## $1: Prints the first column (which contains chr_x)
## substr($0, index($0,$2)): Starts printing from the second column ($2) to the last. 
## index($0,$2) finds where the second column starts, and substr extracts everything from that position to the end of the line.
awk '{print $1, substr($0, index($0,$2))}'