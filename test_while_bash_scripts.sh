## https://docs.vultr.com/how-to-use-while-loop-in-bash
## example 1

#!/bin/bash
var = 0; while [ $var -lt 10 ];
do
    echo "The current value: $var is less than 10"
    ((var++))
done


## example 2
while IFS= read -r line; do # read command -  Reads each line without interpreting backslashes as escape characters.
while read -r line; do
    if [ -n "$line" ]; then # exclude empty lines
                            # -n operator returns true if the string following it has a length greater than zero (i.e., it is not empty).
                            # The -n flag in Bash is a test operator used to check if a string is non-empty.
        echo "$line"
    fi
done < "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/test_file.py"
