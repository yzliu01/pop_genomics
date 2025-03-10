cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF

less -S concated.Rutmac.REF_RutMac.100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_DP200_1500x_noMS.vcf.gz


##bcftools_viewCommand=view -v snps -A -m 2 -M 2 -f PASS; Date=Tue Feb 25 18:09:12 2025
##bcftools_filterCommand=filter -e 'AC==0 || AC == AN'; Date=Tue Feb 25 18:09:12 2025
##bcftools_viewCommand=view -e 'MEAN(FMT/DP) < 200 || MEAN(FMT/DP) > 1500' -Oz -o ./concated.Rutmac.REF_RutMac.100kb_g150>
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  Col_RutMac
OW386285.2      9462    .       T       C       0.000846148     PASS    AB=0.0152284;ABP=807.249;AC=2;AF=0.02;AN=100;AO=6>
OW386285.2      9510    .       T       C       0.000251031     PASS    AB=0.00309598;ABP=1388.46;AC=1;AF=0.01;AN=100;AO=>
OW386285.2      9514    .       C       T       61.9004 PASS    AB=0.0763359;ABP=1024.18;AC=8;AF=0.08;AN=100;AO=50;CIGAR=>
OW386285.2      9554    .       G       A       349.232 PASS    AB=0.0796748;ABP=946.768;AC=8;AF=0.08;AN=100;AO=49;CIGAR=>
OW386285.2      9564    .       T       A       189.806 PASS    AB=0.106181;ABP=853.047;AC=11;AF=0.11;AN=100;AO=67;CIGAR=>
OW386285.2      9962    .       A       T       0.00457152      PASS    AB=0.0339623;ABP=502.932;AC=3;AF=0.03;AN=100;AO=9>
OW386285.2      10108   .       G       A       0.000290011     PASS    AB=0.0377358;ABP=593.241;AC=4;AF=0.04;AN=100;AO=1>
OW386285.2      10191   .       C       T       90.2578 PASS    AB=0.0338266;ABP=895.844;AC=4;AF=0.04;AN=100;AO=16;CIGAR=>
OW386285.2      10199   .       C       T       129.198 PASS    AB=0.0443548;ABP=897.447;AC=5;AF=0.05;AN=100;AO=22;CIGAR=>
OW386285.2      10515   .       G       C       0.0925506       PASS    AB=0.00921659;ABP=457.008;AC=1;AF=0.01;AN=100;AO=>


less concated.Rutmac.REF_RutMac.100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_DP250_1500x_noMS.vcf.gz

##bcftools_viewCommand=view -v snps -A -m 2 -M 2 -f PASS; Date=Wed Feb 26 10:12:42 2025
##bcftools_filterCommand=filter -e 'AC==0 || AC == AN'; Date=Wed Feb 26 10:12:42 2025
##bcftools_viewCommand=view -e 'MEAN(FMT/DP) < 250 || MEAN(FMT/DP) > 1500' -Oz -o ./concated.Rutmac.REF_RutMac.100kb_g150>
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  Col_RutMac
OW386285.2      9462    .       T       C       0.000846148     PASS    AB=0.0152284;ABP=807.249;AC=2;AF=0.02;AN=100;AO=6>
OW386285.2      9510    .       T       C       0.000251031     PASS    AB=0.00309598;ABP=1388.46;AC=1;AF=0.01;AN=100;AO=>
OW386285.2      9514    .       C       T       61.9004 PASS    AB=0.0763359;ABP=1024.18;AC=8;AF=0.08;AN=100;AO=50;CIGAR=>
OW386285.2      9554    .       G       A       349.232 PASS    AB=0.0796748;ABP=946.768;AC=8;AF=0.08;AN=100;AO=49;CIGAR=>
OW386285.2      9564    .       T       A       189.806 PASS    AB=0.106181;ABP=853.047;AC=11;AF=0.11;AN=100;AO=67;CIGAR=>
OW386285.2      9962    .       A       T       0.00457152      PASS    AB=0.0339623;ABP=502.932;AC=3;AF=0.03;AN=100;AO=9>
OW386285.2      10108   .       G       A       0.000290011     PASS    AB=0.0377358;ABP=593.241;AC=4;AF=0.04;AN=100;AO=1>
OW386285.2      10191   .       C       T       90.2578 PASS    AB=0.0338266;ABP=895.844;AC=4;AF=0.04;AN=100;AO=16;CIGAR=>
OW386285.2      10199   .       C       T       129.198 PASS    AB=0.0443548;ABP=897.447;AC=5;AF=0.05;AN=100;AO=22;CIGAR=>

OW386285.2      10564   .       G       T       1.72836e-05     PASS    AB=0.0366667;ABP=562.411;AC=4;AF=0.04;AN=100;AO=1>
OW386285.2      10630   .       T       C       1.42061e-07     PASS    AB=0.0191304;ABP=1157.89;AC=2;AF=0.02;AN=100;AO=1>
OW386285.2      10631   .       G       A       16.8844 PASS    AB=0.0393162;ABP=1081.4;AC=4;AF=0.04;AN=100;AO=23;CIGAR=1>
OW386285.2      10661   .       G       T       0.000745135     PASS    AB=0.0248276;ABP=1424.86;AC=3;AF=0.03;AN=100;AO=1>
OW386285.2      10662   .       A       C       41.519  PASS    AB=0.0622463;ABP=1233.05;AC=6;AF=0.06;AN=100;AO=46;CIGAR=>
OW386285.2      10697   .       G       A       25.0472 PASS    AB=0.0971098;ABP=1222.57;AC=10;AF=0.1;AN=100;AO=84;CIGAR=>
OW386285.2      10709   .       T       C       101.132 PASS    AB=0.0544835;ABP=1521.87;AC=5;AF=0.05;AN=100;AO=48;CIGAR=>
