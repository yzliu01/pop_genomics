
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