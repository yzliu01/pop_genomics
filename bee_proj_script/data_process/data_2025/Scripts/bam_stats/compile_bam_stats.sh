
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/bamtools_stats

rm compiled_10_pools_bam.stats
for stat in `ls -t *.bam | head -10`
do
#cat $stat
echo -e "**********************************************\n$stat.stats" >> compiled_10_pools_bam.stats
cat $stat >> compiled_10_pools_bam.stats
done

Ephdan.REF_EphDan.sort.marked_dups.bam
Bommaj.REF_BomMaj.sort.marked_dups.bam

