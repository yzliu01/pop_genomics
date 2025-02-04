#!/bin/bash

# Check if input and output files are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_file> <output_file>"
    exit 1
fi

input_file=$1
output_file=$2

# Process the input file and trim excess bases
while read -r line; do
    if [[ $line == ">"* ]]; then
        # Header line
        header=$line
        echo "$header" >> "$output_file"
    else
        # Sequence line
        seq_length=${#line}
        excess=$(( seq_length % 3 ))
        if (( excess != 0 )); then
            trimmed_seq=${line:0:seq_length-excess}
            echo "Sequence $header has excess $excess base(s). Original length: $seq_length, Trimmed length: $((seq_length-excess))"
        else
            trimmed_seq=$line
        fi
        # Write trimmed sequence to output file
        echo "$trimmed_seq" >> "$output_file"
    fi
done < "$input_file"
