#!/bin/bash

# Script splits mpileup file into pileups (pop specific mpileup)
# Then starts Pi and Taj D calls
source /home/anneaa/miniconda3/etc/profile.d/conda.sh
conda activate neutral_div

# calculating fst using the method described in popoolation variance-sliding. #insert link

file_fst=$1
#file_fst=/faststorage/project/EcoGenetics/people/Jesper_Bechsgaard/vcf_filter/scripts/freebayes/Fst_allele_freqs
'EntNic_ARJ      EntNic_ARO      EntNic_BIJ      EntNic_BJJ      EntNic_BRS      EntNic_DOJ      EntNic_DSJ      EntNic_FHJ      EntNic_FUR      EntNic_GEJ      EntNic_GOJ      EntNic_GSJ      EntNic_GUS      EntNic_JHJ      EntNic_JOJ      EntNic_KLJ      EntNic_LEJ  >
0       0       0       0       0       0.15    0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
0       0       0       0       0.04    0       0       0       0       0       0       0       0       0       0       0       0       0.07    0       0       0       0       0       0       0
0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
0.04    0.07    0       0.03    0       0.06    0       0.1     0       0       0       0       0       0       0.06    0.05    0.06    0.07    0       0.05    0.06    0       0.11    0       0
0       0   '
file_out=$2
# file_out=/home/anneaa/EcoGenetics/people/anneaa/derived_dat_scripts/neutral_diversity_pipeline/Entomobrya_nicoleti/EntNic/EntNic_fst_freebayes_fq.fst

diris=`dirname $file_out`
mkdir -p $diris/tmp
cols_N=`awk 'NR == 1{print NF; exit}' $file_fst`
#awk 'NR==1 {print}' $file_fst > /home/anneaa/EcoGenetics/people/anneaa/derived_dat_scripts/neutral_diversity_pipeline/Entomobrya_nicoleti/EntNic/fst_freebayes_fq_0.tmp
colnum=0
for firstpop in `seq 1 $((cols_N-1))`
do
	for secondpop in `seq $((firstpop+1)) $cols_N`
	do
		echo $firstpop -  $secondpop
		colnum=$((colnum+1))
		colnum_pad=`printf "%03d" $colnum`
		echo $colnum
		echo $colnum_pad
		echo 
		awk -v secondpop=$secondpop -v firstpop=$firstpop 'NR=1{print $firstpop "-" $secondpop; exit
		}' $file_fst > $diris/tmp/fst_freebayes_fq_$colnum_pad.tmp

		awk -v secondpop=$secondpop -v firstpop=$firstpop 'NR>1{
			first_pi=1-($firstpop)^2-(1-$firstpop)^2;
			second_pi=1-($secondpop)^2-(1-$secondpop)^2;
			pi_within=(first_pi + second_pi)/2;
			pi_total=1-(($firstpop + $secondpop)/2)^2-(((1-$firstpop) + (1-$secondpop))/2)^2;
			if (pi_total=="0")  # pi tot will be 0, thus zero devision
				{ 	fst=0; 
					#print $firstpop, $secondpop, first_pi, second_pi, pi_within, pi_total, fst;
					print fst;
					first_pi=0; second_pi=0; pi_within=0; pi_total=0; fst=NA	}
			else 
				{ 	fst=(pi_total-pi_within)/pi_total;
					#print $firstpop, $secondpop, first_pi, second_pi, pi_within, pi_total, fst;
					print fst;
					first_pi=0; second_pi=0; pi_within=0; pi_total=0; fst=NA  }
		}' $file_fst >> $diris/tmp/fst_freebayes_fq_$colnum_pad.tmp
	done
done
paste -d'\t' $diris/tmp/fst_freebayes_fq_*.tmp > $file_out

#rm /home/anneaa/EcoGenetics/people/anneaa/derived_dat_scripts/neutral_diversity_pipeline/Entomobrya_nicoleti/EntNic/fst_freebayes_fq_*.tmp
# consider adding pop-names?