from Bio import SeqIO

# Define the start and stop codons
START_CODON = "ATG"
STOP_CODONS = {"TGA", "TAA", "TAG"}

def has_correct_codons(seq):
    # Check for start codon
    if not seq.startswith(START_CODON):
        return False
    
    # Check for stop codon
    if not (seq.endswith(STOP_CODONS)):
        return False
    
    # Remove start and end codons for internal check
    trimmed_seq = seq[3:-3]
    
    # Check for internal stop codons
    for i in range(0, len(trimmed_seq) - 2, 3):
        codon = trimmed_seq[i:i+3]
        if codon in STOP_CODONS:
            return False
            
    return True

# Load sequences from a FASTA file
input_file = "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/shared_CDS_with_M_seq_align/test/Apis_mel_10027at7399_busco/10027at7399.gff.gffread_cds.fa"
output_file = "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/shared_CDS_with_M_seq_align/test/Apis_mel_10027at7399_busco/10027at7399.gff.gffread_cds.filtered_sequences.fasta"

with open(output_file, "w") as out_handle:
    for record in SeqIO.parse(input_file, "fasta"):
        if has_correct_codons(str(record.seq)):
            SeqIO.write(record, out_handle, "fasta")
