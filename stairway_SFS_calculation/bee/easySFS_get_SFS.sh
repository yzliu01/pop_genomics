
dro_mel_pop_list_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/easy_SFS_stairway_plot/dro_mel_pop
cd $dro_mel_pop_list_dir

awk 'BEGIN{OFS=FS="\t"}{$1=$1; $2="BP_CS"}1' BP_CS.list
awk 'BEGIN{OFS=FS="\t"}{print $1=$1, $2="BP_CS"}' BP_CS.list
ls *pop.list
# BP_CS.pop.list  SB_RP.pop.list  SB_SE.pop.list  SPD.pop.list

## activate bioproject env to use python for easrSFS
dro_mel_pop_list_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/easy_SFS_stairway_plot/dro_mel_pop
cd $dro_mel_pop_list_dir
conda activate bioproject
easySFS=/home/yzliu/bin/easySFS/easySFS.py
dro_mel_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_gatk_vcf/DB_VCF
dro_mel_vcf=$dro_mel_vcf_dir/concated_dro_mel_all_chr.sorted_chr.SNP_hard_filtered_bi_MQ20_FMT_DP3_MSG03.vcf.gz
pop_assignments=all_4_dro_mel.pop.list
output_sfs_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_gatk_vcf/easy_SFS

for rep in {1..5};do
    #for vcf in `find -print | grep "10000Ne" | grep "20hapS" | grep "15Mb" | grep "high_mu" | grep "$rep.gen.vcf.final_ld05.pruned.vcf$"`;do
    ## figure out error of converting genotype
    for vcf in `find -print | grep "10000Ne" | grep "20hapS" | grep "15Mb" | grep "$rep.gen.modification.new.vcf.final_ld05.pruned.vcf$"`;do
        #vcf_dir=`ls $vcf`
        echo $vcf
        ## replace file name to get output directory name
        out_dir=`echo $vcf | cut -d "/" -f 1,2`
        echo $out_dir
        $easySFS -i $vcf -p $pop20 -a -f --proj 20 -o $out_dir --prefix $out_dir"_1_"$rep
    done
done


## run this command in terminal
$easySFS -i $dro_mel_vcf -p $pop_assignments -a -f --proj 17,17,17,17 -o $output_sfs_dir --prefix dro_mel_4_pop_SFS
## Processing 4 populations - ['BP_CS', 'SB_RP', 'SB_SE', 'SPD']
## subset vcf for each group
for vcf_group in `ls $dro_mel_vcf_dir/concated*list.vcf.gz`;do
    $easySFS -i $vcf_group -p $pop_assignments -a -f --proj 17 -o $out_put_sfs_dir --prefix dro_mel_4_pop_SFS;
done

sample_pop=("BP_CS.pop.list" "SB_RP.pop.list" "SB_SE.pop.list" "SPD.pop.list")
for vcf_group in `ls $dro_mel_vcf_dir/concated*list.vcf.gz`;do
    sample_pop=("BP_CS.pop.list" "SB_RP.pop.list" "SB_SE.pop.list" "SPD.pop.list")
    $easySFS -i $vcf_group -p ${sample_pop[*]} -a -f --proj 17 -o $out_put_sfs_dir --prefix dro_mel_4_pop_SFS;
done

$easySFS -i $dro_mel_vcf_dir/concated_dro_mel_all_chr.sorted_chr.SNP_hard_filtered_bi_MQ20_FMT_DP3_MSG0.BP_CS.list.vcf.gz -p BP_CS.pop.list -a -f --proj 17 -o $out_put_sfs_dir --prefix dro_mel_BP_CS_pop_SFS
$easySFS -i $dro_mel_vcf_dir/concated_dro_mel_all_chr.sorted_chr.SNP_hard_filtered_bi_MQ20_FMT_DP3_MSG0.SB_RP.list.vcf.gz -p SB_RP.pop.list -a -f --proj 17 -o $out_put_sfs_dir --prefix dro_mel_SB_RP_pop_SFS
$easySFS -i $dro_mel_vcf_dir/concated_dro_mel_all_chr.sorted_chr.SNP_hard_filtered_bi_MQ20_FMT_DP3_MSG0.SB_SE.list.vcf.gz -p SB_SE.pop.list -a -f --proj 17 -o $out_put_sfs_dir --prefix dro_mel_SB_SE_pop_SFS
$easySFS -i $dro_mel_vcf_dir/concated_dro_mel_all_chr.sorted_chr.SNP_hard_filtered_bi_MQ20_FMT_DP3_MSG0.SPD.list.vcf.gz -p SPD.pop.list -a -f --proj 17 -o $out_put_sfs_dir --prefix dro_mel_SPD_pop_SFS

## bees
conda activate bioproject
easySFS=/home/yzliu/bin/easySFS/easySFS.py
bee_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
BomPas_REF_BomPas_vcf=concated.fb_per_contig_BomPas_REF_BomPas.g600_regions.bi_MQ20_DP270.vcf.gz
output_sfs_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/easy_SFS

$easySFS -i $bee_vcf_dir/$BomPas_REF_BomPas_vcf -p population.list -a -f --proj 68 -o $output_sfs_dir --prefix BomPas_REF_BomPas_SFS

*********************************************
## msprime simulation
msprime_sim_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/msprime
## test on one of the 10kNe_100dip_1000G simulations 
vcf=one_pop_msprime_sim_10kNe_100dip_5rep_20chr_mu36e9_re89e8_5.vcf

vcf=one_pop_msprime_sim_10kNe_100dip_5rep_20chr_mu36e9_re89e8_3.vcf

vcf=one_pop_msprime_sim_10kNe_40dip_5rep_20chr_mu36e9_re89e8_5.vcf

vcf=one_pop_msprime_sim_10kNe_40dip_5rep_20chr_mu36e9_re89e8_3.vcf

sfs_out=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/msprime/sfs
cd $msprime_sim_dir
conda activate variant_calling_mapping

## get biallelic snp to calculate sfs
vcf_biallele=${vcf/"vcf"/"biallel.vcf"}
bcftools view $msprime_sim_dir/$vcf -m2 -M2 -O u -o $vcf_biallele

## sfs sclculation script
sfs_py=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/SFS_stairway_plot/claculate_allele_from_vcf_GT.py

python $sfs_py one_pop_msprime_sim_10kNe_40dip_5rep_20chr_mu36e9_re89e8_3.biallel.vcf \
    $sfs_out/one_pop_msprime_sim_10kNe_40dip_5rep_20chr_mu36e9_re89e8_3.biallel.sfs

## correct way
allele_count=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/msprime/sfs/one_pop_msprime_sim_10kNe_100dip_5rep_20chr_mu36e9_re89e8_5.biallel.sfs
allele_count=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/msprime/sfs/one_pop_msprime_sim_10kNe_100dip_5rep_20chr_mu36e9_re89e8_3.biallel.sfs

allele_count=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/msprime/sfs/one_pop_msprime_sim_10kNe_40dip_5rep_20chr_mu36e9_re89e8_5.biallel.sfs
allele_count=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/msprime/sfs/one_pop_msprime_sim_10kNe_40dip_5rep_20chr_mu36e9_re89e8_3.biallel.sfs

for allele_count in `ls $sfs_out/*40dip*.sfs`
    do
    out_sfs=${allele_count/.sfs/}
    sed '1d' $allele_count | awk '{if ($1 <= $2/2) print $1; if ($1 > $2/2) print $2-$1 }' | sort -V | uniq -c | awk '$1=$1'| cut -d ' ' -f 1 | tr '\n' ' ' > $out_sfs.real.sfs
done

## check if any column value from the 5th column onwards is greater than 1 and skip such lines, while summing the values of the columns otherwise
## example file
genotype_fie=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_200hapS_1E_1000G_2e_i_cons_20Chr_15Mb/ft_sim_10000Ne_200hapS_1E_1000G_2e_i_cons_20Chr_15Mb_1_1.gen
awk 'OFS="\t"{c=0;for(i=5;i<=NF;++i) if ($i > 1) next}{c+=$i}{print $0}' file.txt

awk 'OFS="\t"{c=0;for(i=5;i<=NF;++i) if ($i > 1) next } {c+=$i} {print $1,$2,$3,$4, c,"200"}' $genotype_fie | less | sed '1d' |

## ft_sim_10000Ne_200hapS_1E_1000G_2e_i_cons_20Chr_15Mb_MAFpop0.obs
5 observations
d0_0	d0_1	d0_2	d0_3	d0_4	d0_5	d0_6	d0_7	d0_8	d0_9	d0_10	d0_11	d0_12	d0_13	d0_14	d0_15	d0_16	d0_17	d0_18	d0_19	d0_20	d0_21	d0_22	d0_23	d0_24	d0_25	d0_26	d0_27	d0_28	d0_29	d0_30	d0_31	d0_32	d0_33	d0_34	d0_35	d0_36	d0_37	d0_38	d0_39	d0_40	d0_41	d0_42	d0_43	d0_44	d0_45	d0_46	d0_47	d0_48	d0_49	d0_50	d0_51	d0_52	d0_53	d0_54	d0_55	d0_56	d0_57	d0_58	d0_59	d0_60	d0_61	d0_62	d0_63	d0_64	d0_65	d0_66	d0_67	d0_68	d0_69	d0_70	d0_71	d0_72	d0_73	d0_74	d0_75	d0_76	d0_77	d0_78	d0_79	d0_80	d0_81	d0_82	d0_83	d0_84	d0_85	d0_86	d0_87	d0_88	d0_89	d0_90	d0_91	d0_92	d0_93	d0_94	d0_95	d0_96	d0_97	d0_98	d0_99	d0_100	d0_101	d0_102	d0_103	d0_104	d0_105	d0_106	d0_107	d0_108	d0_109	d0_110	d0_111	d0_112	d0_113	d0_114	d0_115	d0_116	d0_117	d0_118	d0_119	d0_120	d0_121	d0_122	d0_123	d0_124	d0_125	d0_126	d0_127	d0_128	d0_129	d0_130	d0_131	d0_132	d0_133	d0_134	d0_135	d0_136	d0_137	d0_138	d0_139	d0_140	d0_141	d0_142	d0_143	d0_144	d0_145	d0_146	d0_147	d0_148	d0_149	d0_150	d0_151	d0_152	d0_153	d0_154	d0_155	d0_156	d0_157	d0_158	d0_159	d0_160	d0_161	d0_162	d0_163	d0_164	d0_165	d0_166	d0_167	d0_168	d0_169	d0_170	d0_171	d0_172	d0_173	d0_174	d0_175	d0_176	d0_177	d0_178	d0_179	d0_180	d0_181	d0_182	d0_183	d0_184	d0_185	d0_186	d0_187	d0_188	d0_189	d0_190	d0_191	d0_192	d0_193	d0_194	d0_195	d0_196	d0_197	d0_198	d0_199	d0_200		(17 sites with multiple mutations were discarded)
299878723	2185	1961	2222	2362	2354	2319	2376	2261	1788	2166	1853	1780	1812	1771	1993	1407	1145	1464	1582	1368	1636	1660	1402	1304	1329	1146	1522	1329	1428	1307	1210	1179	978	1053	1093	1341	1466	994	1283	1197	1096	1307	1200	1117	1187	1202	1175	1145	986	925	987	1125	1001	1224	962	1046	1108	955	1109	905	1028	1044	894	947	1013	992	864	913	927	902	875	886	815	911	863	953	1097	913	936	793	886	894	835	826	836	874	882	875	830	822	868	917	894	928	812	901	857	878	835	449	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	
299878964	2170	2720	1998	1856	2524	2225	1991	2100	1880	1699	1939	1603	2046	1674	1574	1169	1944	1563	1687	1333	1396	1491	1276	1231	1216	1403	1302	1381	1181	1279	969	1698	1359	1156	1437	1287	1232	1190	1297	1270	1362	1243	1247	1183	1093	1158	1048	1030	951	1180	985	1060	924	958	965	1046	910	982	994	1050	955	1148	1044	997	974	893	909	920	957	927	943	945	895	933	883	862	911	969	853	870	914	841	863	847	881	830	920	898	865	943	831	807	852	891	880	803	919	903	958	467	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	
299878576	1834	2866	1704	1942	1705	1908	1751	2450	1509	2228	1476	2369	1653	1621	1786	1831	2158	1930	1626	1861	1428	1361	1505	1417	1458	1497	1421	1388	1185	1552	1484	1059	1326	1239	1347	1545	1115	1187	1005	1145	1256	1125	1091	1141	1006	1037	1191	1272	1056	1002	1035	1076	912	1075	921	1034	1028	1001	922	943	950	890	857	974	881	942	954	874	1019	918	965	960	795	901	910	851	942	897	850	938	877	836	911	897	862	871	862	845	894	865	799	913	834	934	1012	864	894	897	858	412	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	
299877950	2663	1703	2647	2057	2280	1824	2019	1947	1637	1369	1680	2185	1493	2013	1793	1869	1242	1752	1595	1468	1499	1433	1531	1696	1416	1544	1309	1364	1492	1307	1540	1338	1377	1311	1331	1184	1351	1319	1123	1332	1182	1125	1103	1079	1196	1106	1103	974	1158	1105	1027	1036	965	1092	973	1023	988	1038	922	951	963	964	952	971	1018	942	972	883	904	917	946	1051	894	886	889	919	976	973	869	930	838	917	837	789	846	875	881	884	886	860	920	927	837	891	876	924	868	852	881	441	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	
299879669	2048	2257	2633	1975	2225	2147	2048	1623	2183	1941	1846	2020	1748	1609	1728	1850	1602	1345	1494	1480	1252	1668	1455	1794	1403	1381	1257	1438	1230	1086	1393	1235	1260	1260	1053	1373	1226	1054	1130	1082	1143	1185	1006	1122	999	1075	1041	1090	1059	997	1059	1017	971	1127	990	1040	964	997	1163	947	861	1089	958	939	906	907	965	927	982	917	843	935	871	895	904	938	844	930	888	925	870	903	899	932	935	846	890	845	897	850	867	894	816	866	884	847	852	837	891	449	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	

awk 'OFS="\t"{c=0; skip=0; for(i=5;i<=NF;++i) { if ($i > 1) { skip=1; break } c+=$i } if (!skip) print $1,$2,$3,$4,c,"200" }' $genotype_fie | \
    awk '{if ($5 <= $6/2) print $5; if ($5 > $6/2) print $6-$5 }' | sort -V | uniq -c | awk '$1=$1'| cut -d ' ' -f 1 | tr '\n' ' '

## final
awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 2) { $i = "1/1"; } else {$i="0/1";}} } 1' $genotype_fie | sed '1d' | sed 's/\// /g' | awk 'OFS="\t"{c=0; skip=0; for(i=5;i<=NF;++i) { if ($i > 1) { skip=1; break } c+=$i } if (!skip) print $1,$2,$3,$4,c,"200" }' | awk '{if ($5 <= $6/2) print $5; if ($5 > $6/2) print $6-$5 }' | sort -V | uniq -c | awk '$1=$1'| cut -d ' ' -f 1 | tr '\n' ' '

1 3 2185 1961 2222 2362 2354 2319 2376 2261 1788 2167 1854 1780 1812 1771 1993 1407 1145 1464 1582 1368 1636 1661 1402 1304 1329 1147 1522 1329 1429 1307 1210 1179 978 1054 1093 1341 1466 994 1283 1198 1096 1307 1200 1117 1187 1203 1176 1145 988 925 987 1125 1001 1224 962 1046 1108 955 1109 905 1028 1044 894 947 1013 992 864 913 927 902 876 886 815 911 864 953 1097 913 937 793 886 894 836 827 836 875 883 875 830 822 869 917 894 929 812 901 857 878 835 450
## same as the first line
awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 2) { $i = "1/1"; } else {$i="0/1";}} } 1' $genotype_fie | sed '1d' | sed 's/\// /g' | awk 'OFS="\t"{c=0; skip=0; for(i=5;i<=NF;++i) { if ($i > 1) { skip=1; break } c+=$i } if (!skip) print $1,$2,$3,$4,c,"200" }' | awk '{if ($5 <= $6/2) print $5; if ($5 > $6/2) print $6-$5 }' | sort -V | uniq -c | awk 'NR > 2 {$1=$1;print}' | cut -d ' ' -f 1 | tr '\n' ' '
2185 1961 2222 2362 2354 2319 2376 2261 1788 2167 1854 1780 1812 1771 1993 1407 1145 1464 1582 1368 1636 1661 1402 1304 1329 1147 1522 1329 1429 1307 1210 1179 978 1054 1093 1341 1466 994 1283 1198 1096 1307 1200 1117 1187 1203 1176 1145 988 925 987 1125 1001 1224 962 1046 1108 955 1109 905 1028 1044 894 947 1013 992 864 913 927 902 876 886 815 911 864 953 1097 913 937 793 886 894 836 827 836 875 883 875 830 822 869 917 894 929 812 901 857 878 835 450
**********************************

bcftools query -l $msprime_sim_dir/$vcf > $sfs_out/10kNe_100dip_2e_d_cons_5rep_20chr_mu36e9_re89e8.pop.list
bcftools query -l $msprime_sim_dir/$vcf > $sfs_out/10kNe_40dip_2e_d_cons_5rep_20chr_mu36e9_re89e8.pop.list
conda deactivate

## make pop file with pop1
awk 'OFS= "\t" {$2="pop1";print $0}' $sfs_out/10kNe_100dip_2e_d_cons_5rep_20chr_mu36e9_re89e8.pop.list > $sfs_out/10kNe_100dip_2e_d_cons_5rep_20chr_mu36e9_re89e8.pop.new.list
awk 'OFS= "\t" {$2="pop1";print $0}' $sfs_out/10kNe_40dip_2e_d_cons_5rep_20chr_mu36e9_re89e8.pop.list > $sfs_out/10kNe_40dip_2e_d_cons_5rep_20chr_mu36e9_re89e8.pop.new.list

## run easySFS
$easySFS -i $msprime_sim_dir/$vcf -p $sfs_out/10kNe_100dip_2e_d_cons_5rep_20chr_mu36e9_re89e8.pop.list -a -f --proj 100 -o $sfs_out --prefix 10kNe_100dip_2e_d_cons_5rep_20chr_mu36e9_re89e8_5
## haploid?
$easySFS -i $msprime_sim_dir/$vcf -p $sfs_out/10kNe_100dip_2e_d_cons_5rep_20chr_mu36e9_re89e8.pop.list --ploidy 1 -a -f --proj 100 -o $sfs_out --prefix 10kNe_200hap_2e_d_cons_5rep_20chr_mu36e9_re89e8_5


*********************************

## thin vcf variants using vcftools
conda activate variant_calling_mapping

vcftools 
rename deo_mel dro_mel /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_gatk_vcf/DB_VCF/*d
eo_mel*
# compress with bgzip not gzip, GATK cannot recognize correctly otherwise
time vcftools --gzvcf $dro_mel_vcf --exclude-positions heterozygous_site_male.cut.list --recode --recode-INFO-all --stdout | bgzip -c > gatk_female_52mon_66lap_B_syl.remove_het_sites_found_in_male_for_female_mon_lap_207_B_syl.vcf.gz
time vcftools --gzvcf $dro_mel_vcf --thin 10 --recode --recode-INFO-all --stdout | bgzip -c > $dro_mel_vcf_dir/concated_dro_mel_all_chr.sorted_chr.SNP_hard_filtered_bi_MQ20_FMT_DP3_MSG03.thin_10.vcf.gz

After filtering, kept 68 out of 68 Individuals
Outputting VCF file...
After filtering, kept 1439474 out of a possible 1919861 Sites
Run Time = 306.00 seconds
