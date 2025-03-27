
#!/bin/bash

# Read numbers from a file
rm *.prop
for file in $(ls *Rutmac*.sfs | sort)
do
cat $file | tr " " "\n" > $file.col
cat "$file.col"
numbers=($(cat "$file.col"))

#done

    # Calculate the sum of the numbers
    sum=0
    for num in "${numbers[@]}"; do
    sum=$((sum + num))
    done

    # Calculate and print the proportion for each number
    for num in "${numbers[@]}"; do
    #proportion=$(echo "scale=4; ($num / $sum) * 100" | bc)
    #echo "Number: $num, Proportion: $proportion%"
    proportion=$(echo "scale=4; ($num / $sum)" | bc)
    echo "$proportion" >> $file.prop
    done

done



********    "sfs for softmasked+gene_regions"   ********
## New REF ($3 <= $4/2)
## 2025
conda activate variant_calling_mapping
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
output_SFS_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data

## downsample genomes
for vcf in `ls -t *P_[0-1][0-9].vcf.gz | sort -V`

    do
    output_sfs_name=${vcf/vcf.gz/equal_self}
    bcftools query -f '%CHROM\t%POS\t%AC\t%AN\t%DP' $vcf | \
        awk '{if ($3 <= $4/2) print $3; if ($3 > $4/2) print $4-$3 }' | sort -V | uniq -c | \
        awk '$1=$1'| cut -d ' ' -f 1 | tr '\n' ' ' > $output_SFS_dir/$output_sfs_name.sfs
        ## $1=$1 is an assignment operation in awk. 
        ## It reassigns the first field ($1) to itself, which forces awk to rebuild the current line using the default output field separator (a single space).

        ## print the sfs in terminal
        echo -e $output_sfs_name.sfs"\n"
        cat $output_SFS_dir/$output_sfs_name.sfs
        echo -e "\n"
done
