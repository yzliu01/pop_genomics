#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 11:00:00
## for estimat 
#SBATCH -a 3
#SBATCH -J 36mu_smc++
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=smc++.syl_35_90.mon3.ph_mu36_knot38.%A.e
#SBATCH --output=smc++.syl_35_90.mon3.ph_mu36_knot38.%A.o

# 2.Convert your VCF(s) to the SMC++ input format with vcf2smc
module load bioinfo-tools SMC++/1.15.4
# python bcftools
# python/3.9.5 bcftools/1.14

VCF=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/merged_vcf_per_contig
#VCF_FILE=Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.oneway.imp.with_header.vcf.gz

OUT=$VCF/smc
#REF=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/
#chr=`awk '{print $1}' $REF/Bombus_sylvicola_v1.fna.fai | sort -V`
#mapability_bed=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/SNPable_syl/syl_35_50.contig_001_592.mask.bed.gz

cd $OUT

# This function is to run the jobs in parallel
function pwait() {
	while [ $(jobs -p | wc -l) -ge $1 ]; do
	sleep $2
done
}

#for results in {lap_3ind,syl_3ind,inc_3ind}; do
		# run parallel jobs
#		pwait 3 10s
#		smc++ estimate --cores 9 3.60e-9 --timepoints 1e1 1e6 --spline cubic --knots 40 $OUT/$results/$results.contig*.txt -o $OUT/$results
		# better parameter
		# --ftol 1e-3
		# --knots 24
		# --timepoints 10 100000000
		# --timepoints 1e1 1e7
		# 0.89e-10 better https://www.nature.com/articles/s42003-020-1060-8
		# 3.60e-9 for bumblebee based on other insect
		# 2.10e-9 https://doi.org/10.1093/molbev/msac016
		
#done

#for species in {xx_o,yy_o,zz_o,xyz_o};do
#mkdir $species
#done
## problem
#for file in `ls *_o`;do
#rm -r $file
#done

#rm -r *_o


# change file names to exclude them
#for results in {mon_3ind,lap_3ind,inc_3ind,syl_3ind}; do
#	cd $results
#		for chr in {293,448,486,584};do
#		rename $results _$results *contig_$chr*.txt
##		rename lap_3ind _lap_3ind  *contig_$chr*.txt; done
##		mv $results.contig_$chr*.txt _$results.contig_$chr*.txt
#		done
#	cd ..
#done


## parallel jobs
#INPUT_BAM=$(cat pas.sorted_marked_dups.bam.list | sed -n ${SLURM_ARRAY_TASK_ID}p)
# only list folder name
# ls -d */ | sed 's/\///g'
# ls -l | grep '^d' | awk -F " " '{print $9}'
# ls -l | awk '/^d/ {print $9}'
# ls -d */ | cut -f 1 -d '/'
# find * -maxdepth 0 -type d
INPUT_Results=$(find * -maxdepth 0 -type d | sed -n ${SLURM_ARRAY_TASK_ID}p)
smc++ estimate --cores 4 3.60e-9 --timepoints 1e1 1e7 --knots 38 $OUT/$INPUT_Results/$INPUT_Results.contig*.txt -o $OUT/$INPUT_Results
#--spline cubic

# 4.Visualize the results using plot
## -g sets the generation time (in years) used to scale the x-axis. If not given, the plot will be in coalescent units.
smc++ plot -g 1 $OUT/syl_35_90.mon3_lap3_inc3_sy3.ph_composite_likelihood_36.knots38.pdf \
$OUT/mon_3ind/model.final.json $OUT/lap_3ind/model.final.json $OUT/syl_3ind/model.final.json $OUT/inc_3ind/model.final.json

# --xlim 0 100000000 --ylim 0 100000000
#smc++ plot $OUT/pas_mon_plot.pdf $OUT/pas/model.pas.json $OUT/mon/mon_model.final.json

## rename files using for
#OUT=/crex/proj/snic2020-6-58/private/yzliu/test/fastq_bt/gVCF/DB_VCF/merged_gvcf_genotyping/SMC
#cd $OUT
#for i in {$OUT/Atum_BF1/model.final.json,$OUT/Atum_BF2/model.final.json,$OUT/Atum_LB/model.final.json,$OUT/Atum_GZ/model.final.json,\
#$OUT/Atum_SA/model.final.json,$OUT/Atum_TZ/model.final.json}; do
#mv $i $i.old_unph_089e
#done 
# method 2
# rename knot24.old_unph_089e_knot22 knot22 ./Atum*/model.final.json.old_unph_089e_knot24.old_unph_089e_knot22
# rename json json.unph_089e_knot22 ./Atum*/model.final.json

#for results in {mon_3ind,lap_3ind,inc_3ind,syl_3ind}; do
#	cd $results
##		for chr in {293,448,486,584};do
#	rename model.final model.final.mu36knot38 model.final.json
##		rename lap_3ind _lap_3ind  *contig_$chr*.txt; done
##		mv $results.contig_$chr*.txt _$results.contig_$chr*.txt
#		done
#	cd ..
#done

# rename txt unph_089e_knot22.txt ./Atum*/.debug.txt

# A useful diagnostic for understanding the final output of SMC++ are the sequence of intermediate estimates .model.iter<k>.json
#smc++ plot -g 0.17 $OUT/TZ_iteraction.unph_composite_likelihood_089.plot.pdf .model.iter0.json .model.iter2.json .model.iter4.json .model.iter6.json .model.iter8.json .model.iter1.json .model.iter3.json .model.iter5.json .model.iter7.json .model.iter9.json model.final.json

