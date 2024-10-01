
# from this paper: https://academic.oup.com/nar/article/51/D1/D445/6814468
# https://gitlab.com/salvo981/sonicparanoid2
# https://genomebiology.biomedcentral.com/articles/10.1186/s13059-024-03298-4
conda activate myproject

conda install bioconda::sonicparanoid

sonicparanoid -h

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_14species

sonicparanoid -i . -o ./sonicparanoid_new/

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_14species/OrthoFinder/Results_Sep19/Orthogroup_Sequences

grep 'And_bic.g14134.t1' *
OG0008728.fa:>And_bic.g14134.t1

# seem to be OK

conda install bioconda::orthomcl
# after installation
Preparing transaction: done                                                                                                           
Verifying transaction: done                                                                                                           
Executing transaction: | To run OrthoMCL you need to copy the config file located in /home/yzliu/miniforge3/envs/myproject/share/orthomcl/orthomcl.config.template to your working directory as orthomcl.config.                                                            
e.g. cp /home/yzliu/miniforge3/envs/myproject/share/orthomcl/orthomcl.config.template location_to_your_working_dir/orthomcl.config
done
## this did not work and I have to install it myself from the github issue

wget https://github.com/apetkau/orthomcl-pipeline/archive/refs/heads/master.zip
unzip master.zip
rm master.zip
cd orthomcl-pipeline-master


#This command should output the version of the DBI module, confirming that it's installed correctly.
#perl scripts/orthomcl-setup-database.pl --user orthomcl_database_user --password orthomcl_database_password --host orthomcl_database_host --database orthomcl_database --outfile configure_outfile.conf [--no-create-database]
#Can't locate DBI.pm in @INC (you may need to install the DBI module) (@INC contains: /usr/local/lib64/perl5 /usr/local/share/perl5 /usr/lib64/perl5/vendor_perl /usr/share/perl5/vendor_perl /usr/lib64/perl5 /usr/share/perl5) at scripts/orthomcl-setup-database.pl line 10.
#BEGIN failed--compilation aborted at scripts/orthomcl-setup-database.pl line 10.

## install gcc first, it will use it in conda base env
conda install -c conda-forge gcc_linux-64

***** "chatgpt solutions" *****

If you're not using conda and want to install the Perl modules (DBI and DBD::mysql) via the VS Code terminal, you can use Perl's CPAN (Comprehensive Perl Archive Network). Here's how to do it:
Step-by-Step Guide:
1. Open the VS Code terminal:

    Open VS Code, and press Ctrl + ~ to open the terminal, or go to View > Terminal.

2. Install the required Perl modules using CPAN:

You can install Perl modules using the CPAN tool. First, ensure you have CPAN installed by running:

bash

perl -MCPAN -e shell

If it's your first time using CPAN, it may ask you to configure it. You can either choose automatic configuration or go through the manual steps (automatic is usually fine).
3. Install DBI and DBD::mysql modules using CPAN:

Once inside the CPAN shell, you can install the required modules:

    To install DBI (the general database interface for Perl):

    bash

install DBI

To install DBD::mysql (the MySQL driver for DBI):

bash

    install DBD::mysql

Alternatively, you can install these modules directly from the VS Code terminal (without opening the CPAN shell):

bash

cpan DBI
cpan YAML
cpan DBD::mysql

4. Verify the installation:

After the installation completes, verify that the DBI module was installed successfully by running:

bash

perl -MDBI -e 'print $DBI::VERSION,"\n";'

This should output the installed version of DBI.
5. Install DBD::mysql dependencies (if needed):

    You may need to have the MySQL client libraries installed on your system for the DBD::mysql module to work properly. To install them, run:
        On Ubuntu/Debian:

        bash

sudo apt-get install libmysqlclient-dev

On CentOS/Fedora:

bash

        sudo yum install mysql-devel

Troubleshooting:

    Permission issues: If you encounter permission issues during installation, try running the commands with sudo:

    bash

sudo cpan DBI
sudo cpan DBD::mysql

Missing system libraries: If CPAN encounters errors related to missing libraries (e.g., MySQL development libraries), install the required dependencies using your system’s package manager.

***** "check if perl is installed in the base env" *****
conda install -c conda-forge perl-dbi


conda install hcc::justorthologs

# after installation
Specifications:

  - hcc::justorthologs -> python[version='>=2.7,<2.8.0a0']

Your python: python=3.10

If python is on the left-most side of the chain, that's the version you've asked for.
When python appears to the right, that indicates that the thing on the left is somehow
not available for the python version you are constrained to. Note that conda will not
change your python version to a different minor version unless you explicitly specify
that.

The following specifications were found to be incompatible with your system:

  - feature:/linux-64::__glibc==2.28=0
  - feature:|@/linux-64::__glibc==2.28=0

Your installed version is: 2.28