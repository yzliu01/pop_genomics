#!/usr/bin/env python

import sys

chrom = ""
pos = -1
start = -1
in_masked_region = False
infile = sys.argv[1]
with open(sys.argv[1], "r") as fh:
    for line in fh:
        if line.startswith(">"):
            if in_masked_region:  # last masked region from previous chrom
                print(f"{chrom}\t{start}\t{pos}")
                start = -1  # not needed actually
                in_masked_region = False
            pos = 0
            chrom = line.split(" ")[0].replace(">", "").strip()
        else:
            for c in line.strip():
                if not in_masked_region and c == "N":
                    in_masked_region = True
                    start = pos
                elif in_masked_region and c != "N":
                    in_masked_region = False
                    print(f"{chrom}\t{start}\t{pos}")

                pos += 1

if in_masked_region:  # last masked region in last chrom
    print(f"{chrom}\t{start}\t{pos}")