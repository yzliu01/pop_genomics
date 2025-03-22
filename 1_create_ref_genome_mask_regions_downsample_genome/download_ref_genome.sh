
## download complete file and in case of corrupted one
## these cause problems when unzip these zip files

https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_029775095.1/
https://askubuntu.com/questions/54904/unzip-error-end-of-central-directory-signature-not-found
https://unix.stackexchange.com/questions/136980/error-when-unzipping-a-file
https://stackoverflow.com/questions/73948328/error-unzip-end-of-central-directory-signature-not-found
unzip ASM1932182v1.zip -d ./Amel.lin.jelly.V1
unzip ncbi_dataset.zip -d ./Amel.lin.jelly.V1

## decompress genome data
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
for i in `ls -t | head`
do bgzip $i -d
done 

ls | grep -v ".bam" | xargs cp $filtered