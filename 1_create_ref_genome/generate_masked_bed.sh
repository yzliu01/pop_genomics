## create masked reference genome bed file in two steps
## https://www.danielecook.com/generate-a-bedfile-of-masked-ranges-a-fasta-file/

## I - replace bases in lowercase into N
softmasked_genome_Amel=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Amel_HAv3_1.fa
*********
less -S .
>NC_037638.1 Apis mellifera strain DH4 linkage group LG1, Amel_HAv3.1, whole genome shotgun sequence
GAGAGAATTAACTACCTTAACCTGAACCTAAACCTACCGATAACCTAACTCTAAACTATACCTTTAACCCCTAAACCCTA (80)
CACCTAAGTCCTAAACCAATAACCTTAACCCTAACAACTATATAAAACACTAACCTATAACCTAATCCCCTAACTACTAA (160)
ActactaacctaacctaaaactatatacctaacctaaaccttaCCCTAACCATAACCTATTACTCTAACCCTACCAAGAG
*********
out_softmasked_genome_Amel=${softmasked_genome_Amel/.fa/}
grep -v "^>"tr $softmasked_genome_Amel | tr "[atcg]" "N" > $softmasked_genome_Amel.N.fa

## II - generate bed file using converted fasta file
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/1_create_ref_genome
python generate_masked_region_md.py $out_softmasked_genome_Amel > Amel_masked.bed
*********
less Amel_masked.bed
NC_037638.1	161	203
NC_037638.1	312	334
NC_037638.1	369	403
*********
## mask reference genome in loop
## Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
cd $REF_DIR
generate_masked_region_md_py=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/1_create_ref_genome/generate_masked_region_md.py
for masked_ref in `ls *softmasked.fa`
    do
    out_softmasked_genome=${masked_ref/.fa/}
    grep -v "^>"tr $masked_ref | tr "[atcg]" "N" > $out_softmasked_genome.N.fa
    python $generate_masked_region_md_py $out_softmasked_genome > ./ref_masked_bed/$out_softmasked_genome.bed
done

