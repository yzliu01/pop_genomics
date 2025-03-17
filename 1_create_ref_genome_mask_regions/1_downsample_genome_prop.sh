# https://stackoverflow.com/questions/27104990/sum-of-all-rows-of-all-columns-bash

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/

awk -F '\t' '{sum+=$2;} END {print sum;}' Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai
330670691
# https://stackoverflow.com/questions/77506833/print-specific-rows-of-a-column-using-awk-in-for-loop
awk -F '\t' 'NR==1,NR==7{sum+=$2;} END {print sum;}' Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai
291265543

## bedtools random will generate a random set of intervals in BED6 format. 
# One can specify both the number (-n) and the size (-l) of the intervals that should be generated.

conda activate variant_calling_mapping

genome_fai=(
    "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai"
    "Andrena_marginata_GCA_963932335.1-softmasked.fa.fai"
    "Bombus_pascuorum-GCA_905332965.1-softmasked.fa.fai"
    "Bombus_veteranus.hifi_asm_pl2.fa.fai"
)
# -l length of intervals to enerate
# -n the number of intervals to generate
# proportion to sample genome (0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9)

ref_fai_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
cd $ref_fai_dir

## generate 100,100 kb interval regions
prop=(0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9)
prop_name=(01 02 03 04 05 06 07 08 09)

prop_hae=(331 661 992 1323 1653 1984 2315 2645 2976)
genome_hae=Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai

for i in ${!prop_hae[*]}
do
echo "interval_number: ${prop[i]}"
echo $genome_hae
bedtools random -seed 0 -l 100000 -n ${prop_hae[i]} -g $genome_hae | bedtools sort -i - > ./random_prop_sample_genome/$genome_hae.prop_"${prop[i]}".bed
done

************************************************************************************
conda activate variant_calling_mapping

ref_fai_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
cd $ref_fai_dir

## fai file array variable
genome_fai=(
    "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai"
    "Andrena_marginata_GCA_963932335.1-softmasked.fa.fai"
    "Bombus_pascuorum-GCA_905332965.1-softmasked.fa.fai"
    "Bombus_veteranus.hifi_asm_pl2.fa.fai"
)

for ref_fai in ${genome_fai[*]}
do
echo $ref_fai
#done
#Steps to Generate a Non-Overlapping BED File for a Given Genome Proportion

#    Get the Total Genome Length
#    Extract the total length from the .fai index of your reference genome:

#awk '{sum+=$2} END {print sum}' $ref_fai
# 330670691

#Compute Target Subset Length
#If you want, say, 10% of the genome:
prop=(0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9)
prop_name=(01 02 03 04 05 06 07 08 09)

# prepare full genome prop separately, win_whole

#prop=(1)
#prop_name=(10)

#Divide the Genome into Non-Overlapping Windows
#Use bedtools makewindows to generate evenly spaced non-overlapping regions:
#bedtools makewindows -g $ref_fai -w 100000 > genome_windows.bed
#Adjust -w 100 to change window size to 100bp per fragment.

## generate a separate original bed file
#bedtools makewindows -g $ref_fai -w 100 > ./random_prop_sample_genome/$ref_fai.win_100b.bed

for i in ${!prop[*]}
do
echo "prop: ${prop[i]}"
#done
total_length=$(awk '{sum+=$2} END {print sum}' $ref_fai)
target_length=$(echo "$total_length * ${prop[i]}" | bc)
echo -e "Target genome length: $ref_fai \t $target_length"
#Target genome length: 33067069

#Randomly Sample from Non-Overlapping Windows
#Ensure the selected windows sum up to your target length:
## shuf is produce non-overlapping regions
#shuf ./random_prop_sample_genome/$ref_fai.win_100b.bed | awk -v target="$target_length" '{
# in one step
# random due to shuf
#bedtools makewindows -g $ref_fai -w 100 | shuf | awk -v target="$target_length" '{
# generate consistent regions
bedtools makewindows -g $ref_fai -w 100 | awk -v target="$target_length" '{
        sum += $3 - $2;
    print $0;
    if (sum >= target) exit;
}' | sort -V > ./random_prop_sample_genome/$ref_fai.win_100b.subset_"${prop_name[i]}".bed # for whole genome
# random due to shuf
#}' | sort -V | bedtools merge > ./random_prop_sample_genome/$ref_fai.win_100b.shuf_subset_"${prop_name[i]}".sort.bed # for whole genome
# each region
# | sort -V > ./random_prop_sample_genome/$ref_fai.win_100b.shuf_subset_"${prop_name[i]}".sort.bed
done
done

# then go here
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/data_2025_downsample/Scripts/downsample_bam

6_systematic_sample_genome.1x_3x_5x_7x_10x.Hae.template.sh

exit 0

******************************** below is tests ****************************************************
less ./random_prop_sample_genome/$ref_fai.win_100b.shuf_subset_01.sort.bed | wc -l
330686

## from beginning till the sum meets desired length
awk -v target="$target_length_01" '{

    sum += $3 - $2;
    print $0;
    if (sum >= target) exit;
}' ./random_prop_sample_genome/$ref_fai.win_100b.bed > ./random_prop_sample_genome/$ref_fai.win_100b.subset_01.bed

#bedtools sort -i ./random_prop_sample_genome/$ref_fai.win_100b.subset_01.bed > ./random_prop_sample_genome/$ref_fai.win_100b.subset_01.sort.bed

wc -l ./random_prop_sample_genome/$ref_fai.win_100b.subset_01.bed

## bedtools merge combines overlapping or “book-ended” features in an interval file into 
# a single feature which spans all of the combined features.
bedtools merge -i ./random_prop_sample_genome/$ref_fai.win_100b.subset_01.bed | wc -l
0

#Subset the VCF Using the Selected Regions
#Use bcftools to extract variants:

bcftools view -R subset.bed input.vcf -o subset.vcf

#This method ensures non-overlapping regions that sum up to the desired proportion of the genome.

#Would you like further adjustments, such as selecting regions proportionally from different chromosomes?

************************************************************************************










## check if overlapping exists
random_regions_0_9=Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.prop_0.9.bed
bedtools intersect -a $random_regions_0_9 -b $random_regions_0_9 -wa -wb | awk '$1==$4 && $2<$5'

## merge overlapped regions
dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/random_prop_sample_genome
bedtools merge -i Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.prop_0.9.bed > prop_09.test.bed
bedtools merge -i Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.prop_0.9.bed | wc -l
1143
wc -l prop_09.test.bed
1143
## original one
wc -l Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.prop_0.9.bed
2976 Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.prop_0.9.bed

## check the length of genome proportion
cat prop_09.test.bed | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'

cat random_prop_sample_genome/Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.prop_0.9.bed \
 | awk -F'\t' 'BEGIN{SUM=0}{ SUM+=$3-$2 }END{print SUM}'
# 297600000









prop_mar=(297 593 892 1189 1486 1783 2081 2378 2675)
genome_mar=Andrena_marginata_GCA_963932335.1-softmasked.fa.fai
for num in ${prop_mar[*]}
do
echo "interval_number: $num"
echo $genome_mar
bedtools random -seed 0 -l 100000 -n $num -g $genome_mar > $genome_mar.prop.bed
done

prop_pas=(308 615 923 1230 1538 1845 2153 2460 2768)
genome_pas=Bombus_pascuorum-GCA_905332965.1-softmasked.fa.fai
for num in ${prop_pas[*]}
do
echo "interval_number: $num"
echo $genome_pas
bedtools random -seed 0 -l 100000 -n $num -g $genome_pas > $genome_pas.prop.bed
done

prop_vet=(356 713 1069 1426 1782 2139 2495 2852 3208)
genome_vet=Bombus_veteranus.hifi_asm_pl2.fa.fai
for num in ${prop_vet[*]}
do
echo "interval_number: $num"
echo $genome_vet
bedtools random -seed 0 -l 100000 -n $num -g $genome_vet > ./random_prop_sample_genome/$genome_vet.prop.bed
done


exit 0


By default, the bedtools random tool generates non-overlapping random regions. However, depending on the parameters you use (e.g., region size and number of regions), there is a possibility of overlap, especially if the genome is small or the regions are large relative to the genome size.
Key Points About bedtools random:

    Non-Overlapping by Design:

        The bedtools random tool attempts to generate non-overlapping regions by default.

        It uses the chromosome sizes provided in the genome.txt file to ensure that regions do not exceed chromosome boundaries.

    Potential Overlap:

        If you request a large number of regions or regions that are too large relative to the genome size, overlaps may occur because the tool cannot fit all regions without overlap.

        For example, if you request 320 regions of 1 Mbp each for the human genome (3.2 Gbp), there should be no overlap. However, if you request 500 regions of 10 Mbp each, overlaps are likely.

    Check for Overlaps:

        You can check for overlaps in the generated BED file using bedtools intersect:
        bash
        Copy

        bedtools intersect -a random_regions.bed -b random_regions.bed -wa -wb | awk '$1==$4 && $2<$5'

            This command will output any overlapping regions.

How to Ensure Non-Overlapping Regions:

If you want to guarantee non-overlapping regions, you can:

    Reduce the Number of Regions or Their Size:

        Ensure that the total length of all regions does not exceed the genome size.

        Example: For the human genome (3.2 Gbp), 320 regions of 1 Mbp each will not overlap.

    Use bedtools shuffle:

        The bedtools shuffle tool can generate non-overlapping regions by shuffling existing intervals.

        Example:
        bash
        Copy

        bedtools shuffle -i existing_regions.bed -g genome.txt -noOverlapping > non_overlapping_regions.bed

    Manually Check and Filter:

        After generating regions, use bedtools intersect to check for overlaps and filter them out if necessary.