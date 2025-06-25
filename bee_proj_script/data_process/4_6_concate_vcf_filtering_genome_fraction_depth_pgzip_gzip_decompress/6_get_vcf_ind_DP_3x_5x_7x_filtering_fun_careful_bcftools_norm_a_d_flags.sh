#!/bin/sh
#SBATCH --account eDNA
##SBATCH --cpus-per-task 20
#SBATCH --mem 10g
##SBATCH --array=1-12%12
##SBATCH --array=14-19%6
##SBATCH --array=20-23%4
#SBATCH --array=23%1
#SBATCH --time=06:00:00
#SBATCH --error=get_vcf_ind_DP_3x_5x_7x.%A_%a.e
#SBATCH --output=get_vcf_ind_DP_3x_5x_7x.%A_%a.o
#SBATCH --job-name=get_vcf_ind_DP_3x_5x_7x
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## run in terminal
#export OPENBLAS_NUM_THREADS=1

## pooled bees
REF_MASKED_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed

## complement (softmasked_regions + gene_regions) bed file - preferred
New_REF_AndHae_mask_region=$REF_MASKED_DIR/Andrena_haemorrhoa-GCA_910592295.1-softmasked_ref_gene.conca_sorted.bed
New_REF_AndHat_mask_region=$REF_MASKED_DIR/Andrena_hattorfiana-GCA_944738655.1-softmasked_ref_gene.conca_sorted.bed
New_REF_BomPas_mask_region=$REF_MASKED_DIR/Bombus_pascuorum-GCA_905332965.1-softmasked_ref_gene.conca_sorted.bed
New_REF_BomHyp_mask_region=$REF_MASKED_DIR/Bombus_hypnorum-GCA_911387925.1-softmasked_ref_gene.conca_sorted.bed
New_REF_ApisMel_mask_region=$REF_MASKED_DIR/Amel_HAv-GCF_003254395.2-softmasked_ref_gene.conca_sorted.bed
New_REF_AndMar_mask_region=$REF_MASKED_DIR/Andrena_marginata_GCA_963932335.1-softmasked_ref_gene.conca_sorted.bed

New_REF_AndFul_mask_region=$REF_MASKED_DIR/Andrena_fulva-GCA_946251845.1-softmasked_ref_gene.conca_sorted.bed
New_REF_AndTri_mask_region=$REF_MASKED_DIR/Andrena_trimmerana-GCA_951215215.1-softmasked_ref_gene.conca_sorted.bed
New_REF_BomCon_mask_region=$REF_MASKED_DIR/Bombus_confusus-GCA_014737475.1_ASM1473747v1-softmasked_ref_gene.conca_sorted.bed
New_REF_BomHor_mask_region=$REF_MASKED_DIR/Bombus_hortorum-GCA_905332935.1-softmasked_ref_gene.conca_sorted.bed

New_REF_AndBic_mask_region=$REF_MASKED_DIR/Andrena_bicolor-GCA_960531205.1-softmasked_ref_gene.conca_sorted.bed
New_REF_alt_BomMus_mask_region=$REF_MASKED_DIR/Bombus_muscorum-GCA_963971125.1-softmasked_ref_gene.conca_sorted.bed
New_REF_BomSyl_mask_region=$REF_MASKED_DIR/Bombus_sylvestris-GCA_911622165.2-softmasked_ref_gene.conca_sorted.bed

New_REF_BomVet_mask_region=$REF_MASKED_DIR/Bombus_veteranus.hifi_asm_pl2-softmasked_ref_gene.conca_sorted.bed

## only softmasked_regions bed file
#New_REF_AndHae_mask_region=$REF_MASKED_DIR/Andrena_haemorrhoa-GCA_910592295.1-softmasked.bed
#New_REF_AndHat_mask_region=$REF_MASKED_DIR/Andrena_hattorfiana-GCA_944738655.1-softmasked.bed
#New_REF_BomPas_mask_region=$REF_MASKED_DIR/Bombus_pascuorum-GCA_905332965.1-softmasked.bed
#New_REF_BomHyp_mask_region=$REF_MASKED_DIR/Bombus_hypnorum-GCA_911387925.1-softmasked.bed
#New_REF_ApisMel_mask_region=$REF_MASKED_DIR/Amel_HAv-GCF_003254395.2-softmasked.bed
#New_REF_AndMar_mask_region=$REF_MASKED_DIR/Andrena_marginata_GCA_963932335.1-softmasked.bed

## ref
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
REF_AndHae=$REF_DIR/Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa
REF_AndHat=$REF_DIR/Andrena_hattorfiana-GCA_944738655.1-softmasked.fa
REF_BomPas=$REF_DIR/Bombus_pascuorum-GCA_905332965.1-softmasked.fa
REF_BomHyp=$REF_DIR/Bombus_hypnorum-GCA_911387925.1-softmasked.fa
REF_ApisMel=$REF_DIR/Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa
REF_AndMar=$REF_DIR/Andrena_marginata_GCA_963932335.1-softmasked.fa
## new
REF_BomCon=$REF_DIR/Bombus_confusus-GCA_014737475.1_ASM1473747v1-softmasked.fa
REF_BomHor=$REF_DIR/Bombus_hortorum-GCA_905332935.1-softmasked.fa
REF_AndTri=$REF_DIR/Andrena_trimmerana-GCA_951215215.1-softmasked.fa
REF_AndFul=$REF_DIR/Andrena_fulva-GCA_946251845.1-softmasked.fa

## new
REF_AndBic=$REF_DIR/Andrena_bicolor-GCA_960531205.1.fa
REF_BomMus=$REF_DIR/Bombus_muscorum-GCA_963971125.1.fa
REF_BomSyl=$REF_DIR/Bombus_sylvestris-GCA_911622165.2-softmasked.fa

REF_BomVet=$REF_DIR/Bombus_veteranus.hifi_asm_pl2.fa

## vcf
concated_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
cd $concated_vcf_dir

## earlier (GQ_issue? and attention to VCF file names)
Andhae_New_REF_AndHae_VCF=concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andhae_New_REF_AndHae_VCF_filter=${Andhae_New_REF_AndHae_VCF/.vcf.gz/}
Andhae_New_REF_BomPas_VCF=concated.AndHae_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andhae_New_REF_BomPas_VCF_filter=${Andhae_New_REF_BomPas_VCF/.vcf.gz/}
Bompas_New_REF_BomPas_VCF=concated.BomPas_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Bompas_New_REF_BomPas_VCF_filter=${Bompas_New_REF_BomPas_VCF/.vcf.gz/}
Bomvet_New_REF_BomPas_VCF=concated.BomVet_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Bomvet_New_REF_BomPas_VCF_filter=${Bomvet_New_REF_BomPas_VCF/.vcf.gz/}
Bompas_New_REF_ApisMel_VCF=concated.BomPas_New_REF_ApisMel.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Bompas_New_REF_ApisMel_VCF_filter=${Bompas_New_REF_ApisMel_VCF/.vcf.gz/}
Bomvet_New_REF_ApisMel_VCF=concated.BomVet_New_REF_ApisMel.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Bomvet_New_REF_ApisMel_VCF_filter=${Bomvet_New_REF_ApisMel_VCF/.vcf.gz/}

## March 2024 - later (GQ_issue?)
Andmar_New_REF_AndMar_VCF=concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andmar_New_REF_AndMar_VCF_filter=${Andmar_New_REF_AndMar_VCF/.vcf.gz/}

Andmar_New_REF_AndHae_VCF=concated.AndMar_New_REF_AndHae.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andmar_New_REF_AndHae_VCF_filter=${Andmar_New_REF_AndHae_VCF/.vcf.gz/}
Andmar_New_REF_BomPas_VCF=concated.AndMar_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andmar_New_REF_BomPas_VCF_filter=${Andmar_New_REF_BomPas_VCF/.vcf.gz/}
Andmar_New_REF_AndHat_VCF=concated.AndMar_New_REF_AndHat.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andmar_New_REF_AndHat_VCF_filter=${Andmar_New_REF_AndHat_VCF/.vcf.gz/}
Andhae_New_REF_AndHat_VCF=concated.AndHae_New_REF_AndHat.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andhae_New_REF_AndHat_VCF_filter=${Andhae_New_REF_AndHat_VCF/.vcf.gz/}
Bompas_New_REF_BomHyp_VCF=concated.BomPas_New_REF_BomHyp.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Bompas_New_REF_BomHyp_VCF_filter=${Bompas_New_REF_BomHyp_VCF/.vcf.gz/}
Bomvet_New_REF_BomHyp_VCF=concated.BomVet_New_REF_BomHyp.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Bomvet_New_REF_BomHyp_VCF_filter=${Bomvet_New_REF_BomHyp_VCF/.vcf.gz/}

## different vcf file names
## June 2024
Andmar_New_REF_AndTri_VCF=concated.AndMar_New_REF_AndTri.100kb_g1500x_regions.all_chr.sorted.vcf.gz
Andmar_New_REF_AndTri_VCF_filter=${Andmar_New_REF_AndTri_VCF/.vcf.gz/}
Andhae_New_REF_AndFul_VCF=concated.AndHae_New_REF_AndFul.100kb_g1500x_regions.all_chr.sorted.vcf.gz
Andhae_New_REF_AndFul_VCF_filter=${Andhae_New_REF_AndFul_VCF/.vcf.gz/}

Bompas_New_REF_BomCon_VCF=concated.BomPas_New_REF_BomCon.100kb_g1500x_regions.all_chr.sorted.vcf.gz
Bompas_New_REF_BomCon_VCF_filter=${Bompas_New_REF_BomCon_VCF/.vcf.gz/}
Bomvet_New_REF_BomCon_VCF=concated.BomVet_New_REF_BomCon.100kb_g1500x_regions.all_chr.sorted.vcf.gz
Bomvet_New_REF_BomCon_VCF_filter=${Bomvet_New_REF_BomCon_VCF/.vcf.gz/}

Bompas_New_REF_BomHor_VCF=concated.BomPas_New_REF_BomHor.100kb_g1500x_regions.all_chr.sorted.vcf.gz
Bompas_New_REF_BomHor_VCF_filter=${Bompas_New_REF_BomHor_VCF/.vcf.gz/}
Bomvet_New_REF_BomHor_VCF=concated.BomVet_New_REF_BomHor.100kb_g1500x_regions.all_chr.sorted.vcf.gz
Bomvet_New_REF_BomHor_VCF_filter=${Bomvet_New_REF_BomHor_VCF/.vcf.gz/}

## 23 June 2024
Andmar_New_REF_AndBic_VCF=concated.AndMar_New_REF_AndBic.100kb_g1500x_regions.vcf.gz
Andmar_New_REF_AndBic_VCF_filter=${Andmar_New_REF_AndBic_VCF/.vcf.gz/}

##Bompas_New_alt_REF_BomMus_VCF=concated.BomPas_New_alt_REF_BomMus.100kb_g1500x_regions.all_chr.sorted.vcf.gz
Bompas_New_alt_REF_BomMus_VCF=concated.BomPas_New_alt_REF_BomMus.100kb_g1500x_regions.vcf.gz
Bompas_New_alt_REF_BomMus_VCF_filter=${Bompas_New_alt_REF_BomMus_VCF/.vcf.gz/}

Bompas_New_REF_BomSyl_VCF=concated.BomPas_New_REF_BomSyl.100kb_g1500x_regions.vcf.gz
Bompas_New_REF_BomSyl_VCF_filter=${Bompas_New_REF_BomSyl_VCF/.vcf.gz/}
Bomvet_New_REF_BomSyl_VCF=concated.BomVet_New_REF_BomSyl.100kb_g1500x_regions.vcf.gz
Bomvet_New_REF_BomSyl_VCF_filter=${Bomvet_New_REF_BomSyl_VCF/.vcf.gz/}

Bomvet_New_REF_BomVet_VCF=concated.BomVet_New_REF_BomVet.100kb_g1500x_regions.vcf.gz
Bomvet_New_REF_BomVet_VCF_filter=${Bomvet_New_REF_BomVet_VCF/.vcf.gz/}

## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>  NEW  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
## keep biallelic snp, remove duplicates and normalize snp with long base (bcftools norm -d none/-m-snps), also remove monomorphic snps

## 1. Andhae_New_REF_AndHae_VCF *************   New Version afterwards
Andhae_New_REF_AndHae_VCF(){
for depth in {234,390,546}
do
    ## depth_upper=`echo $(($depth+50))`
    bcftools filter --soft-filter mask --mask-file $New_REF_AndHae_mask_region $Andhae_New_REF_AndHae_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHae | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Andhae_New_REF_AndHae_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 2. Andhae_New_REF_BomPas_VCF ****************
Andhae_New_REF_BomPas_VCF(){
for depth in {234,390,546}
do
    bcftools filter --soft-filter mask --mask-file $New_REF_BomPas_mask_region $Andhae_New_REF_BomPas_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomPas | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Andhae_New_REF_BomPas_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}


## TYPE=complex,snp
CAJOSQ010000037.1	54	.	CATAT	AATAC,AATAT	0.000123005	.	AB=0.0666667,0.3;ABP=51.9408,13.4334;AC=0,23;AF=0,0.338235;AN=68;AO=2,9;CIGAR=1X3M1X,1X4M;DP=30;DPB=30.2;DPRA=0,0;EPP=7.35324,22.5536;EPPR=42.0968;GTI=0;LEN=5,1;MEANALT=3,3;MQM=1.5,21;MQMR=26.1667;NS=1;NUMALT=2;ODDS=12.8807;PAIRED=1,1;PAIREDR=1;PAO=0,0;PQA=0,0;PQR=0;PRO=0;QA=70,166;QR=629;RO=18;RPL=0,0;RPP=7.35324,22.5536;RPPR=42.0968;RPR=2,9;RUN=1,1;SAF=2,9;SAP=7.35324,22.5536;SAR=0,0;SRF=18;SRP=42.0968;SRR=0;TYPE=complex,snp;technology.BGI_DNBSEQ=1,1	GT:GQ:DP:AD:RO:QR:AO:QA	0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/2/2/2/2/2/2/2/2/2/2/2/2/2/2/2/2/2/2/2/2/2/2/2:0:30:18,2,9:18:629:2,9:70,166

## TYPE=snp
CAJOSQ010000037.1	204	.	A	C,G	2.40645e-07	.	AB=0,0;ABP=0,0;AC=0,0;AF=0,0;AN=68;AO=2,21;CIGAR=1X,1X;DP=313;DPB=313;DPRA=0,0;EPP=7.35324,3.94093;EPPR=156.659;GTI=0;LEN=1,1;MEANALT=3,3;MQM=10.5,10.7143;MQMR=20.2145;NS=1;NUMALT=2;ODDS=16.7099;PAIRED=1,1;PAIREDR=0.99654;PAO=0,0;PQA=0,0;PQR=0;PRO=0;QA=74,749;QR=10266;RO=289;RPL=1,6;RPP=3.0103,11.386;RPPR=178.9;RPR=1,15;RUN=1,1;SAF=1,18;SAP=3.0103,26.2761;SAR=1,3;SRF=282;SRP=571.237;SRR=7;TYPE=snp,snp;technology.BGI_DNBSEQ=1,1	GT:GQ:DP:AD:RO:QR:AO:QA	0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0/0:73:313:289,2,21:289:10266:2,21:74,749


## 3. Bompas_New_REF_BomPas_VCF ****************
bcftools filter --soft-filter mask --mask-file $New_REF_BomPas_mask_region $Bompas_New_REF_BomPas_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomPas | bcftools view -Oz -o ./"$Bompas_New_REF_BomPas_VCF_filter".SNP_softmask_genic_all_norm.vcf.gz

## test "bcftools norm"
test_vcf_norm=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/fb_per_region_BomPas_New_REF_BomPas/Bompas.New_REF_BomPas.100kb_1500x_region_3072.g.vcf

bcftools filter --soft-filter mask --mask-file $New_REF_BomPas_mask_region $test_vcf_norm | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomPas | bcftools view -Oz -o ./"$Bompas_New_REF_BomPas_VCF_filter".SNP_softmask_genic_norm.vcf.gz

bcftools filter --soft-filter mask --mask-file $New_REF_BomPas_mask_region $test_vcf_norm | \
bcftools filter --SnpGap 5:indel | bcftools norm -d snps -f $REF_BomPas | bcftools view -Oz -o ./"$Bompas_New_REF_BomPas_VCF_filter".SNP_softmask_genic_norm_d_snp.vcf.gz

## the following correct
bcftools filter --soft-filter mask --mask-file $New_REF_BomPas_mask_region $test_vcf_norm | \
bcftools filter --SnpGap 5:indel | bcftools norm -a -f $REF_BomPas | bcftools view -Oz -o ./"$Bompas_New_REF_BomPas_VCF_filter".SNP_softmask_genic_norm.vcf.gz


Bompas_New_REF_BomPas_VCF(){
for depth in {204,340,476}
do
    bcftools filter --soft-filter mask --mask-file $New_REF_BomPas_mask_region $Bompas_New_REF_BomPas_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomPas | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Bompas_New_REF_BomPas_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 4. Bomvet_New_REF_BomPas_VCF ****************
Bomvet_New_REF_BomPas_VCF(){
for depth in {174,290,416}
do
    bcftools filter --soft-filter mask --mask-file $New_REF_BomPas_mask_region $Bomvet_New_REF_BomPas_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomPas | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Bomvet_New_REF_BomPas_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 5. Bompas_New_REF_ApisMel_VCF ****************
Bompas_New_REF_ApisMel_VCF(){
for depth in {204,340,476}
do
    bcftools filter --soft-filter mask --mask-file $New_REF_ApisMel_mask_region $Bompas_New_REF_ApisMel_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_ApisMel | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Bompas_New_REF_ApisMel_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 6. Bomvet_New_REF_ApisMel_VCF ****************
Bomvet_New_REF_ApisMel_VCF(){
for depth in {174,290,416}
do
    bcftools filter --soft-filter mask --mask-file $New_REF_ApisMel_mask_region $Bomvet_New_REF_ApisMel_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_ApisMel | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Bomvet_New_REF_ApisMel_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## later
## 7. Andmar_New_REF_AndMar_VCF
Andmar_New_REF_AndMar_VCF(){
for depth in {240,400,560}
do
bcftools filter --soft-filter mask --mask-file $New_REF_AndMar_mask_region $Andmar_New_REF_AndMar_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndMar | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andmar_New_REF_AndMar_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 8. Andmar_New_REF_AndHae_VCF
Andmar_New_REF_AndHae_VCF(){
for depth in {240,400,560}
do
bcftools filter --soft-filter mask --mask-file $New_REF_AndHae_mask_region $Andmar_New_REF_AndHae_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHae | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andmar_New_REF_AndHae_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 9. Andmar_New_REF_AndHat_VCF
Andmar_New_REF_AndHat_VCF(){
for depth in {240,400,560}
do
bcftools filter --soft-filter mask --mask-file $New_REF_AndHat_mask_region $Andmar_New_REF_AndHat_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHat | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andmar_New_REF_AndHat_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 10. Andmar_New_REF_BomPas_VCF
Andmar_New_REF_BomPas_VCF(){
for depth in {240,400,560}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomPas_mask_region $Andmar_New_REF_BomPas_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomPas | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andmar_New_REF_BomPas_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 11. Andhae_New_REF_AndHat_VCF
Andhae_New_REF_AndHat_VCF(){
for depth in {234,390,546}
do
bcftools filter --soft-filter mask --mask-file $New_REF_AndHat_mask_region $Andhae_New_REF_AndHat_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHat | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andhae_New_REF_AndHat_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 12. Bompas_New_REF_BomHyp_VCF
Bompas_New_REF_BomHyp_VCF(){
for depth in {204,340,476}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomHyp_mask_region $Bompas_New_REF_BomHyp_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomHyp | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Bompas_New_REF_BomHyp_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 13. Bomvet_New_REF_BomHyp_VCF
Bomvet_New_REF_BomHyp_VCF(){
for depth in {174,290,416}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomHyp_mask_region $Bomvet_New_REF_BomHyp_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomHyp | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Bomvet_New_REF_BomHyp_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 14. Andhae_New_REF_AndFul_VCF
Andhae_New_REF_AndFul_VCF(){
for depth in {234,390,546}
do
bcftools filter --soft-filter mask --mask-file $New_REF_AndFul_mask_region $Andhae_New_REF_AndFul_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndFul | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andhae_New_REF_AndFul_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 15. Andmar_New_REF_AndTri_VCF
Andmar_New_REF_AndTri_VCF(){
for depth in {240,400,560}
do
bcftools filter --soft-filter mask --mask-file $New_REF_AndTri_mask_region $Andmar_New_REF_AndTri_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndTri | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andmar_New_REF_AndTri_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 16. Bompas_New_REF_BomCon_VCF
Bompas_New_REF_BomCon_VCF(){
for depth in {204,340,476}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomCon_mask_region $Bompas_New_REF_BomCon_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomCon | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Bompas_New_REF_BomCon_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 17. Bomvet_New_REF_BomCon_VCF
Bomvet_New_REF_BomCon_VCF(){
for depth in {174,290,416}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomCon_mask_region $Bomvet_New_REF_BomCon_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomCon | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Bomvet_New_REF_BomCon_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 18. Bompas_New_REF_BomHor_VCF
Bompas_New_REF_BomHor_VCF(){
for depth in {204,340,476}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomHor_mask_region $Bompas_New_REF_BomHor_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomHor | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Bompas_New_REF_BomHor_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 19. Bomvet_New_REF_BomHor_VCF
Bomvet_New_REF_BomHor_VCF(){
for depth in {174,290,416}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomHor_mask_region $Bomvet_New_REF_BomHor_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomHor | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Bomvet_New_REF_BomHor_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}


## 20. Andmar_New_REF_AndBic_VCF
Andmar_New_REF_AndBic_VCF(){
for depth in {240,400,560}
do
bcftools filter --soft-filter mask --mask-file $New_REF_AndBic_mask_region $Andmar_New_REF_AndBic_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndBic | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andmar_New_REF_AndBic_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 21. Bompas_New_alt_REF_BomMus_VCF
Bompas_New_alt_REF_BomMus_VCF(){
for depth in {204,340,476}
do
bcftools filter --soft-filter mask --mask-file $New_REF_alt_BomMus_mask_region $Bompas_New_alt_REF_BomMus_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomMus | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Bompas_New_alt_REF_BomMus_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 22. Bompas_New_REF_BomSyl_VCF
Bompas_New_REF_BomSyl_VCF(){
for depth in {204,340,476}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomSyl_mask_region $Bompas_New_REF_BomSyl_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomSyl | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Bompas_New_REF_BomSyl_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 23. Bomvet_New_REF_BomSyl_VCF
Bomvet_New_REF_BomSyl_VCF(){
for depth in {174,290,416}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomSyl_mask_region $Bomvet_New_REF_BomSyl_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomSyl | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Bomvet_New_REF_BomSyl_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 24. Bomvet_New_REF_BomVet_VCF
Bomvet_New_REF_BomVet_VCF(){
for depth in {174,290,416}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomVet_mask_region $Bomvet_New_REF_BomVet_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomVet | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Bomvet_New_REF_BomVet_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

*********  function list of array jobs   *************
function_list=(
    "Bomvet_New_REF_BomPas_VCF"
    "Bomvet_New_REF_BomHyp_VCF"
    "Bomvet_New_REF_ApisMel_VCF"
    "Andmar_New_REF_AndMar_VCF"
    "Andmar_New_REF_AndHae_VCF"
    "Andmar_New_REF_AndHat_VCF"
    "Andmar_New_REF_BomPas_VCF"
    "Andhae_New_REF_AndHae_VCF"    
    "Andhae_New_REF_AndHat_VCF"
    "Andhae_New_REF_BomPas_VCF"
    "Bompas_New_REF_BomPas_VCF"
    "Bompas_New_REF_BomHyp_VCF"
    "Bompas_New_REF_ApisMel_VCF"
    "Andhae_New_REF_AndFul_VCF"
    "Andmar_New_REF_AndTri_VCF"
    "Bompas_New_REF_BomCon_VCF"
    "Bomvet_New_REF_BomCon_VCF"
    "Bompas_New_REF_BomHor_VCF"
    "Bomvet_New_REF_BomHor_VCF"
    "Andmar_New_REF_AndBic_VCF"
    "Bompas_New_REF_BomSyl_VCF"
    "Bomvet_New_REF_BomSyl_VCF"
    "Bompas_New_alt_REF_BomMus_VCF"

)

## make array jobs
function_array=$(echo ${function_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)
#function_array=$(echo ${function_list[*]} | tr ' ' '\n' | sed -n 3p)

## execute array jon function
## https://www.cyberciti.biz/faq/unixlinux-bash-shell-script-function-call-in-echo-command/
echo $($function_array)

exit 0

## run function in for loop in terminal
for i in {1..12}
do
function_array=$(echo ${function_list[*]} | tr ' ' '\n' | sed -n "$i"p)
echo $($function_array)
done

## function test
sleep_fun(){
    sleep 5s
}

vcf_DP(){
    echo "Hello!"
}
#vcf_DP
fun_vcf_DP=vcf_DP
echo $($fun_vcf_DP)

sleep_fun
vcf_DP

## older test
## Andmar_New_REF_AndHae_VCF
Andmar_New_REF_AndHae_VCF(){
for depth in {234,400,600}
do
    ## depth_upper=`echo $(($depth+50))`
    bcftools filter --soft-filter mask --mask-file $New_REF_AndHae_mask_region $Andmar_New_REF_AndHae_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHae | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Andmar_New_REF_AndHae_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## Andmar_New_REF_AndMar_VCF ## later
Andmar_New_REF_AndMar_VCF(){
for depth in {234,400,600}
do
    ## depth_upper=`echo $(($depth+50))`
    bcftools filter --soft-filter mask --mask-file $New_REF_AndMar_mask_region $Andmar_New_REF_AndMar_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHae | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Andmar_New_REF_AndMar_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}