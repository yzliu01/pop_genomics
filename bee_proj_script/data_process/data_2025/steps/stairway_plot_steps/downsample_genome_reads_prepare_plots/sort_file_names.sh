#Solution Code from wenxiaobai

#Bash
cat filenames.txt | perl -pe 'm/_(\d+)P_downsample_reads\.(\d+)x/; ($p, $xn) = ($1, $2); $_ = sprintf("%05d_%05d_%s", $xn, $p, $_);' | sort -t '_' -k1,1n -k2,2n | cut -d'_' -f3-

# test
echo "./Andhae.New_REF_AndHae_0_5P_downsample_reads.10x.equal_self.sfs" | awk -F'[_x]' '{ print($1,"\t",$2,"\t",$3,"\t",$4
,"\t",$5,"\t",$6) }'

./Andhae.New     REF     AndHae          0       5P      downsample

#Step-by-Step Explanation

    Extract Sorting Keys:
        Use Perl to parse both the xn (digits before "x") and P-value (digits before "P") from filenames
        Format them as zero-padded numbers (e.g., 5 → 00005, 10 → 00010) to enable proper numeric sorting

    Add Sorting Prefix:

    Perl
    # Input line: ./Andhae..._10P_downsample_reads.7x...
    # Becomes: 00007_00010_./Andhae..._10P_downsample_reads.7x...

        Creates a temporary sorting header with format: {xn}_{P-value}_original_name

    Numerical Sorting:

    Bash
    sort -t '_' -k1,1n -k2,2n  # 1. Sort by xn (1st field) numerically
                                # 2. Then sort by P-value (2nd field) numerically

    Remove Temporary Prefix:

    Bash
    cut -d'_' -f3-  # Remove the first two sorting key fields

Example Sorted Output

 # 5x files first (lowest xn)
./Andhae..._7P_downsample_reads.5x...
./Andhae..._8P_downsample_reads.5x...
./Andhae..._9P_downsample_reads.5x...

# 7x files next 
./Andhae..._1P_downsample_reads.7x...
./Andhae..._2P_downsample_reads.7x...
...
./Andhae..._10P_downsample_reads.7x...

# 10x files last (highest xn)
./Andhae..._1P_downsample_reads.10x...
./Andhae..._2P_downsample_reads.10x...
...
./Andhae..._10P_downsample_reads.10x...