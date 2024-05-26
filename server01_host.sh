
#Google API credential
AIzaSyAsh8H8QRZdawAXfRhnnpJCCqz88coK1-8
AIzaSyAsh8H8QRZdawAXfRhnnpJCCqz88coK1-8

API key created

Use this key in your application by passing it with the key=API_KEY parameter.
Your API key

This key is unrestricted. To prevent unauthorized use, we recommend restricting where and for which APIs it can be used. Edit API key to add restrictions. Learn more 

#windows terminal codes
#Command Prompt: 11 basic commands you should know (cd, dir, mkdir, etc.) 
#https://www.digitalcitizen.life/command-prompt-how-use-basic-commands?page=1
#https://stackoverflow.com/questions/17217476/how-do-i-display-a-text-file-content-in-cmd

#Get-Command
https://ss64.com/ps/get-command.html

#https://devblogs.microsoft.com/scripting/table-of-basic-powershell-commands/
Table of Basic PowerShell Commands

#How do I display a text file content in CMD?
You can use the more command. For example:
more filename.txt
#We can use the 'type' command to see file contents in cmd.
Example -
type abc.txt

#No exact equivalent. However there exist a native DOS command "more" that has a +n option that will start outputting the file after the nth line:
DOS Prompt:
C:\>more +2 myfile.txt
The above command will output everything after the first 2 lines.
This is actually the inverse of Unix head:
Unix console:
root@server:~$ head -2 myfile.txt
The above command will print only the first 2 lines of the file.
#in PS try to use command:
Select -Last 1
This command can be pipelined also.
Example to get first line:
type .\out.txt | Select -Last 1
or to get the first line:
type .\out.txt | Select -First 1

#https://stackoverflow.com/questions/187587/a-windows-equivalent-of-the-unix-tail-command
#A Windows equivalent of the Unix tail command [closed]
If you use PowerShell then this works:
Get-Content filenamehere -Wait -Tail 30
Get-Content filenamehere -Tail 30

#https://stackoverflow.com/questions/1295068/windows-equivalent-of-the-tail-command
#Windows equivalent of the 'tail' command
PowerShell 3.0 (Windows 8 and higher) added Tail command with alias Last. Head and First aliases to TotalCount were also added.
So, commands can be re-written as
Get-Content *filename* -Head *n*
Get-Content *filename* -Tail *n*
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#example (Windows PowerShell (x86))
PS E:\LIU_2> Get-Content .\actin.fasta -Head 2
>JZ511484.1 07RA03.12 WSSP Duckweed cDNA library Landoltia punctata cDNA similar to actin depolymerizing factor, mRNA sequence
CGGTATTTTGTTTGTTCCTCCCGTCCTTTTGATCTCGAGGCTCCGGCGCACCTTTCCGGAGCCCTAGATT
PS E:\LIU_2> more .\actin.fasta
>JZ511484.1 07RA03.12 WSSP Duckweed cDNA library Landoltia punctata cDNA similar to actin depolymerizing factor, mRNA sequence
CGGTATTTTGTTTGTTCCTCCCGTCCTTTTGATCTCGAGGCTCCGGCGCACCTTTCCGGAGCCCTAGATT
TCTGCGGATAAATCGGCCTTGCTGGATCCCGCTTTCCTTGCTCTTGGTTCTGCTGCTACGATCCACTCGG
GCTCTCAGAAATGGCAAATGCTGCGTCGGGAATGGCTGTGGATGATGACTGCAAGTTGAAATTTCTAGAA
CTGAAGGCAAAGAGAACTTATCGCTTTATAGTTTTCAAGATCGATGAGAAGCAGAAGCAAGTTGTCGTTG
AAAAGCTCGGGGAGTCGGCTCCTACTTACGAAGATTTTGCTGCCAGTCTGCCCGAAAATGAATGCCGATA
TGCCATCTACGACTACGACTTTGTCACCGAAGAAAACTGCCAGAAGAGCAAGATCTTCTTCATTGCATGG
TCCCCTGATATCTCAAGGGTGAGAAGCAAGATGCTTTACGCCAGCTCCAAGGACCGATTCAAGAGGGAAC
TGGACGGCATTCAGGTAGAGCTTCAAGCTACTGACCCATCTGAGATGGGCCTCGACGTCATTAGAGGCAG
GGCAAATTAGGTGAGTTCGCTTAATTTCTGGTCTTTTACTGGCGTAATATCCCCTGATTTTGGGGGATTT
CATGAGGGTTTGACTTGACATCCTGAGAGATGAT

PS E:\LIU_2> type .\actin.fasta | Select -First 2
>JZ511484.1 07RA03.12 WSSP Duckweed cDNA library Landoltia punctata cDNA similar to actin depolymerizing factor, mRNA sequence
CGGTATTTTGTTTGTTCCTCCCGTCCTTTTGATCTCGAGGCTCCGGCGCACCTTTCCGGAGCCCTAGATT
PS E:\LIU_2> type .\actin.fasta | Select -Last 6
AAAAGCTCGGGGAGTCGGCTCCTACTTACGAAGATTTTGCTGCCAGTCTGCCCGAAAATGAATGCCGATA
TGCCATCTACGACTACGACTTTGTCACCGAAGAAAACTGCCAGAAGAGCAAGATCTTCTTCATTGCATGG
TCCCCTGATATCTCAAGGGTGAGAAGCAAGATGCTTTACGCCAGCTCCAAGGACCGATTCAAGAGGGAAC
TGGACGGCATTCAGGTAGAGCTTCAAGCTACTGACCCATCTGAGATGGGCCTCGACGTCATTAGAGGCAG
GGCAAATTAGGTGAGTTCGCTTAATTTCTGGTCTTTTACTGGCGTAATATCCCCTGATTTTGGGGGATTT
CATGAGGGTTTGACTTGACATCCTGAGAGATGAT
PS E:\LIU_2> Get-Content .\actin.fasta -Tail 5
TGCCATCTACGACTACGACTTTGTCACCGAAGAAAACTGCCAGAAGAGCAAGATCTTCTTCATTGCATGG
TCCCCTGATATCTCAAGGGTGAGAAGCAAGATGCTTTACGCCAGCTCCAAGGACCGATTCAAGAGGGAAC
TGGACGGCATTCAGGTAGAGCTTCAAGCTACTGACCCATCTGAGATGGGCCTCGACGTCATTAGAGGCAG
GGCAAATTAGGTGAGTTCGCTTAATTTCTGGTCTTTTACTGGCGTAATATCCCCTGATTTTGGGGGATTT
CATGAGGGTTTGACTTGACATCCTGAGAGATGAT
+++++++++++++++++++++++++++++++++++++++++++++++++++++++

[yliu@submit01 ~]$ 1003G work space
host: yliu@submit.unibe.ch
session: ubelix
password: Lyb881002 


[yliu@binfservms01 ~]$
password: Jah@ro4uiwea
Lyb881002 (changed with passwd)
Honeyman88
username: yliu
host: yliu@binfservms01.unibe.ch
Fafu@17134537 (2020-2021) latest 

man top
  775  mpstat -P ALL
  776  mpstat -P 0
  777  mpstat 5 7
  778  time
  779  squeue --user yliu
  780  ps -u yliu
  782  top
  783  ps
  784  seff
  785  seff 6169074
  
  
#### https://superuser.com/questions/1423371/sshfs-remote-directory-mounting-syntax
#### https://phoenixnap.com/kb/sshfs#ftoc-heading-8
Mount cluster network
C:\Users\Liu>
net use X: \\sshfs\yliu@submit.unibe.ch
net use X: \\sshfs\yliu@binfservms01.unibe.ch\..\..

########## Uppmax Smount a project in server
net use X: \\sshfs\yzliu@rackham.uppmax.uu.se			# home directory
net use X: \\sshfs\yzliu@rackham.uppmax.uu.se:\crex\project\snic2020-6-58\private\bumblebee_project\
net use X: \\sshfs\yzliu@rackham.uppmax.uu.se:\crex\project\snic2021-6-145\private\bumblebee_project\
net use X: \\sshfs\yzliu@rackham.uppmax.uu.se\..\..		# parent directory
net use w: \\sshfs\yzliu@rackham.uppmax.uu.se\..\..\..	# proj directory
net use X: \\sshfs\yzliu@rackham.uppmax.uu.se:\crex\project\snic2020-6-58\private\seq_data\P23261_feb22_bombus_osmia\

Delete network drive from command line
by Srini
https://www.windows-commandline.com/delete-network-drive-from-command-line/
We can delete mapped drive command line using ‘net use’ command. For example to disconnect the network share mapped to the drive z: we can run the below command.

net use /del Z:

Similarly to delete all the mapped drives we can run the below command.

net use /del *
net use del Z:
net use /del *

---------------------------------------------------------------
https://groups.google.com/g/winfsp/c/8RsLm_Ye-OQ
------------------
C:\Users\Liu>net use X: \\sshfs\yliu@submit.unibe.ch
System error 67 has occurred.

The network name cannot be found.

################## solution ######################
C:\Users\Liu>
cd C:\Program Files (x86)\SSHFS-Win\bin
set CYGFUSE=WinFsp
set PATH=C:\Program Files (x86)\SSHFS-Win\bin
sshfs.exe -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -f -o idmap=user yliu@submit.unibe.ch: z:
sshfs.exe -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -f -o idmap=user yliu@submit.unibe.ch: X:

2022-03-08
#1 Working
sshfs.exe -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -f -o idmap=user yzliu@rackham.uppmax.uu.se: X:
#1 Not working
sshfs.exe -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -f -o idmap=user yzliu@rackham.uppmax.uu.se:\crex\project\snic2020-6-58\private\seq_data\P23261_feb22_bombus_osmia\ X:

#2 path for windows after connecting server 2022-06-20
W:\crex\proj\snic2020-6-58\private\seq_data\P23261_feb22_bombus_osmia\Sweden_Colorado\bal_bal_alp_hyp_pol\DB_VCF\vcf_per_contig_new2


Could not create directory '/home/Liu/.ssh'.
Warning: Permanently added 'rackham.uppmax.uu.se,89.44.250.83' (ECDSA) to the list of known hosts.
yzliu@rackham.uppmax.uu.se's password:
The service sshfs has been started.


####################################################
Could not create directory '/home/Liu/.ssh'.
The authenticity of host 'submit.unibe.ch (130.92.9.143)' can't be established.
ECDSA key fingerprint is SHA256:Po1ErGQf+v5GMJBhb2PQYUzUN+Y1a+CjngTH9RyFXwk.
Are you sure you want to continue connecting (yes/no)? yes
Failed to add the host to the list of known hosts (/home/Liu/.ssh/known_hosts).
Password:
The service sshfs has been started.
Connection to submit.unibe.ch closed by remote host.
remote host has disconnected
The service sshfs has been stopped.

C:\Program Files (x86)\SSHFS-Win\bin>
----------------------------------------------------------------------------------------------------------
#copy data from cluster to local PC
#download pscp.exe in the desktop
C:\Users\Liu>net use
New connections will be remembered.

There are no entries in the list.

C:\Users\Liu>pscp.exe yliu@submit.unibe.ch:/gpfs/homefs/vetsuisse/yliu/Raw_Data_Group_1_6/1_13_L1_R2_001_d7hFev0caHuN.fastq.gz G:\RawData
Using keyboard-interactive authentication.
Password:
1_13_L1_R2_001_d7hFev0caH | 47424 kB | 2964.0 kB/s | ETA: 00:11:03 |   2%





[yliu@binfservms01 yliu]$ lsquota
Disk quotas for user yliu (uid 4045):
Filesystem        Used  S-Quota  H-Quota   Grace  #Files   Quota   Limit   Grace
/home               8G      20G      21G    none     49k      0k      0k    none
/data/users       827G    9728G   10240G    none     10k      0k      0k    none
[yliu@binfservms01 yliu]$ quota -s
Disk quotas for user yliu (uid 4045):
     Filesystem   space   quota   limit   grace   files   quota   limit   grace
/dev/mapper/binfservms01-HOME
                  8902M  20480M  21504M           49677       0       0


http://chtc.cs.wisc.edu/check-quota.shtml

1. Checking Your User Quota and Usage

From any directory location within your home directory, type quota -vs. See the example below:

[alice@submit]$ quota -vs
Disk quotas for user alice (uid 20384): 
     Filesystem  blocks   quota   limit   grace   files   quota   limit   grace
      /dev/sdb1  12690M  20480M  30720M            161k       0       0        

[yliu@binfservms01 yliu]$ du -h

Using du with the -h or --human-readable flags will display the same values with only two significant digits and a K, M, or G to denote the byte units. The -s or --summarize flags will total up the size of the current directory without listing the size of directory contents . You can also specify which directory you'd like to query, without moving to it, by adding the relative filepath after the flags. See the below example from the home directory which contains the directory dir:

[alice@submit]$ du -sh dir
7.1K    dir


https://askubuntu.com/questions/961553/cant-see-shared-folders-in-virtualbox-ubuntu-vm

sudo mount -t vboxsf ShareUbuntu /home/liu/Desktop/WinMount

