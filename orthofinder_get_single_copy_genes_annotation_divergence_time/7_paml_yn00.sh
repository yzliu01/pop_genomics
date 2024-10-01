# http://abacus.gene.ucl.ac.uk/software/paml.html

# how to run yn00
# http://www.mselab.cn/detail/134/
# http://www.chenlianfu.com/?p=3036
# https://biojuse.com/2023/05/04/%E5%85%B3%E4%BA%8E%20PAML%20%E7%9A%84%E4%B8%80%E4%BA%8C%E4%B8%89%E4%BA%8B/

******** step II *********
yn00 yn00_14bee_species.ctl
yn00 $yn00_14bee_species

exit 0

******** step I *********
#yn00_14bee_species=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/paml_mcmctree/paml4.9j/yn00_14bee_species.ctl
yn00_14bee_species=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/paml_mcmctree/paml4.9j/yn00_14bee_species_36OG.ctl

      seqfile = /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds/aligned_seq_14_species/cat.out.14_species.prank_translated.fa.best.nuc.new.phy * sequence data file name
      outfile = substitution_yn00_14species.log           * main result file
      verbose = 0  * 1: detailed output (list sequences), 0: concise output

        icode = 0  * 0:universal code; 1:mammalian mt; 2-10:see below

    weighting = 0  * weighting pathways between codons (0/1)?
   commonf3x4 = 0  * use one set of codon freqs for all pairs (0/1)? 
*       ndata = 1


* Genetic codes: 0:universal, 1:mammalian mt., 2:yeast mt., 3:mold mt.,
* 4: invertebrate mt., 5: ciliate nuclear, 6: echinoderm mt., 
* 7: euplotid mt., 8: alternative yeast nu. 9: ascidian mt., 
* 10: blepharisma nu.
* These codes correspond to transl_table 1 to 11 of GENEBANK.
