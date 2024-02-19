

for i in `ls /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/*REF_And*`;
    do sbatch $i;
done

Submitted batch job 32731046
Submitted batch job 32731047
Submitted batch job 32731048
Submitted batch job 32731049

## count the number of row
awk 'END{print NR}' /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_freebayes_vcf/empiri
cal_dro_mel_68samples.fb_qual20_dp1000.g.vcf