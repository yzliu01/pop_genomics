

# python script.py --ref original_ref.fasta --vcf variants.vcf --output modified_ref.fasta
'''
sim_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/simulated_reference_genomes
original_ref=reference_genome_chr1_100Mb.fasta
#tsk_99_vcf=chromosome_1_tsk_99.vcf.gz
tsk_99_vcf=chromosome_1_tsk_99_100lines.vcf.gz
output_md_ref=reference_genome_chr1_100Mb.mapped_ref.fasta
convert_script=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/fsc_sim_stairway/scripts/msprime/replace_ref_alleles_ref_genome_by_ref_alleles_vcf.py
python $convert_script --ref $original_ref --vcf $tsk_99_vcf --output $output_md_ref

original_ref=reference_genome.fasta
concat_vcf=concat_sim_100hap_N_0_1000_Nt_1200_200000.new.vcf.gz
output_md_ref=reference_genome_md.fasta
python $convert_script --ref $original_ref --vcf $concat_vcf --output $output_md_ref

Replacing 1:64 (0-based 63-64) from 'T' to 'G'
Replacing 1:93 (0-based 92-93) from 'T' to 'A'
Replacing 1:294 (0-based 293-294) from 'C' to 'G'
Replacing 1:1233 (0-based 1232-1233) from 'G' to 'C'

1:18712642 (0-based 18712641-18712642) from 'G' to 'C'

'''

#from Bio import SeqIO
#import vcf
#pip install SeqIO
#pip install vcf
# pip install pyvcf3
#pip install pysam

from Bio import SeqIO
import gzip

def replace_ref_alleles(ref_fasta, vcf_file, output_fasta):
    # Load the reference genome into a dictionary of lists for mutable sequences
    ref_dict = {}
    for record in SeqIO.parse(ref_fasta, "fasta"):
        ref_dict[record.id] = list(str(record.seq))

    # Open the compressed VCF file
    with gzip.open(vcf_file, 'rt') as vcf_f:  # 'rt' mode reads as text
        for line in vcf_f:
            if line.startswith('#'):
                continue  # Skip header lines
            parts = line.strip().split('\t')
            chrom = parts[0]
            pos = int(parts[1])  # 1-based position
            ref_allele = parts[3]

            if chrom not in ref_dict:
                print(f"Warning: Chromosome {chrom} not found in reference. Skipping.")
                continue

            # Convert to 0-based start and calculate end position
            start = pos - 1
            end = start + len(ref_allele)
            current_seq = ref_dict[chrom]

            # Check if the variant's position exceeds the reference length
            if start > len(current_seq):
                print(f"Warning: Position {pos} on {chrom} is beyond reference length. Skipping.")
                continue

            # Extract the current reference segment
            current_ref = ''.join(current_seq[start:end]) if end <= len(current_seq) else None

            # Check if replacement is needed
            if current_ref != ref_allele:
                print(f"Replacing {chrom}:{pos} (0-based {start}-{end}) from '{current_ref}' to '{ref_allele}'")

                # Handle out-of-bounds by padding with 'N's if needed
                if end > len(current_seq):
                    pad_length = end - len(current_seq)
                    current_seq.extend(['N'] * pad_length)

                # Replace the segment
                del current_seq[start:end]
                for i, base in enumerate(ref_allele):
                    current_seq.insert(start + i, base)

    # Save the modified reference genome
    records = []
    for chrom_id, seq_list in ref_dict.items():
        seq_str = ''.join(seq_list)
        # Ensure the sequence is not empty or invalid
        if not seq_str:
            print(f"Warning: Chromosome {chrom_id} has an empty sequence. Skipping.")
            continue
        # Create a SeqRecord with a valid sequence
        records.append(SeqIO.SeqRecord(seq=seq_str, id=chrom_id, description=''))

    # Write the output FASTA file
    with open(output_fasta, "w") as f:
        SeqIO.write(records, f, "fasta")

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description='Replace reference genome alleles using REF alleles from a VCF.')
    parser.add_argument('--ref', required=True, help='Input reference genome FASTA file.')
    parser.add_argument('--vcf', required=True, help='Input VCF file containing REF alleles.')
    parser.add_argument('--output', required=True, help='Output FASTA file for the modified reference genome.')
    args = parser.parse_args()

    replace_ref_alleles(args.ref, args.vcf, args.output)