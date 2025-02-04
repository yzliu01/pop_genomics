import numpy as np
import math
import sys

# Check for correct number of command-line arguments
if len(sys.argv) != 3:
    print("Usage: python ci_calculator.py <input_file> <output_file>")
    sys.exit(1)

# Get input and output file paths from command-line arguments
input_file = sys.argv[1]
output_file = sys.argv[2]

# Load data from the input file (assuming space-separated data)
data = np.loadtxt(input_file)

# Open the output file in write mode
with open(output_file, 'w') as f:
    # Write header (optional)
    f.write("Mean\tLower_95% CI\tUpper_95% CI\n")

    # Loop through each row of the data
    for row in data:
        n = len(row)  # Number of data points
        mean = np.mean(row)  # Calculate the mean
        std_dev = np.std(row, ddof=1)  # Standard deviation with Bessel's correction (ddof=1)

        # Calculate the margin of error
        margin_of_error = 1.96 * (std_dev / math.sqrt(n))

        # Calculate the 95% Confidence Interval
        lower_bound = mean - margin_of_error
        upper_bound = mean + margin_of_error

        # Write the result to the output file in tab-separated format
        f.write(f"{mean:.5f}\t{lower_bound:.5f}\t{upper_bound:.5f}\n")

print(f"Results have been written to {output_file}")
