    1  pwd
    2  ls
    3  exit
    4  ls
    5  mkdir pollinator_proj
    6  ls
    7  pwd
    8  ls
    9  pwd
   10  ls
   11  ll
   12  pwd
   13  ll
   14  quota
   15  quta
   16  which
   17  ll
   18  ls
   19  pwd
   20  touch test.txt << 12345
   21  333
   22  ls
   23  ll
   24  touch test.txt < 1234
   25  touch test.txt
   26  ll
   27  12345 > test.txt 
   28  echo 12345 > test.txt 
   29  cat test.txt 
   30  uquota
   31  quota
   32  ls
   33  pwd
   34  echo
   35  echo $PATH
   36  ls -a
   37  exit
   38  gdk-auth-show-qr
   39  gdk-auth-activate-twofactor 309399
   40  exit
   41  pwd
   42  ls
   43  cd DK_proj/
   44  ls
   45  cd software/
   46  ls
   47  pwd
   48  echo $PATH
   49  vim ~/.bash_profile
   50  echo $PATH
   51  vim ~/.bashrc 
   52  echo $PATH
   53  cd
   54  ls
   55  mkdir bin
   56  cd /home/yzliu/bin
   57  ls
   58  ls -a
   59  vim ~/.bash_profile 
   60  echo $PATH
   61  vim ~/.bash_profile 
   62  ls
   63  ls -a
   64  ll
   65  cd DK_proj/
   66  ll
   67  echo $PATH
   68  mkdir software
   69  cd software/
   70  mkdir fastsimcoal
   71  cd ..
   72  ll
   73  cd ..
   74  ll
   75  cd yzliu/
   76  ll
   77  ls
   78  cd DK_proj/
   79  mkdir software
   80  cd software
   81  ls
   82  cd fastsimcoal/
   83  wget http://cmpg.unibe.ch/software/fastsimcoal27/downloads/fsc27_linux64.zip
   84  ls
   85  tar -h
   86  tar --help
   87  unzip fsc27_linux64.zip 
   88  ls
   89  cd fsc27_linux64/
   90  ls
   91  echo $0
   92  pwd
   93  vim ~/.bashrc 
   94  cat ~/.bashrc
   95  echo $PATH
   96  source ~/.bashrc
   97  echo $PATH
   98  export=$PATH:/home/yzliu/DK_proj/software
   99  source ~/.bashrc
  100  echo $PATH
  101  cd /home/yzliu/bin
  102  cd
  103  ls
  104  ls -a
  105  cat .bash_profile
  106  export=$PATH:/home/yzliu/DK_proj/software
  107  source ~/.bash_profile
  108  echo $PATH
  109  vim ~/.bash_profile
  110  echo $PATH
  111  cat ~/.bash_profile
  112  vim ~/.bash_profile
  113  echo $PATH
  114  vim ~/.bashrc 
  115  echo $PATH
  116  vim ~/.bash_profile
  117  cat ~/.bash_profile
  118  cat ~/.bashrc 
  119  cat ~/.bash_profile
  120  vim ~/.bash_profile
  121  ls
  122  ls -a
  123  vim ~/.bash_profile.swp 
  124  rm ~/.bash_profile.swp
  125  ls -a
  126  vim ~/.bash_profile
  127  echo $PATH
  128  vim ~/.bash_profile
  129  echo $PATH
  130  exit
  131  pwd
  132  echo $PATH
  133  exit
  134  echo $PATH
  135  exit
  136  echo $PATH
  137  history
  138  ls
  139  cd bin
  140  ls
  141  wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh -O miniforge.sh
  142  ls
  143  ll
  144  chmod +x miniforge.sh 
  145  ll
  146  bash --help
  147  bash man
  148  bash -man
  149  q
  150  exit
  151  ls
  152  pwd
  153  cd bin
  154  ls
  155  bash miniforge.sh -b
  156  ls
  157  ../miniforge3/bin/conda init bash
  158  exit
  159  ls
  160  ll
  161  cd miniforge3/
  162  ls
  163  ll
  164  cd bin
  165  ls
  166  ll
  167  conda
  168  conda config --append channels bioconda
  169  conda config --append channels genomedk
  170  conda config --set channel_priority strict
  171  conda config --help
  172  conda config --show
  173  conda config --set auto_active_base false
  174  conda config --set auto_activate_base false
  175  ls
  176  ll
  177  ls -a
  178  cat .condarc
  179  cat .conda
  180  conda install -b base --yes conda-libmamba-solver
  181  conda install -n base --yes conda-libmamba-solver
  182  echo $PATH
  183  conda search restdio
  184  conda search rstdio-desktop
  185  conda list
  186  conda activate myproject
  187  conda list
  188  conda activate bcftools
  189  conda list
  190  conda search bcftools
  191  conda -h
  192  conda install -h
  193  conda search rstudio
  194  s
  195  ls
  196  cd DK_proj/
  197  for i in {data steps results plots scripts docs}; touch $i/README.txt;done
  198  for i in {data steps results plots scripts docs}; do touch $i/README.txt;done
  199  for i in {data steps results plots scripts docs}; do mkdir $i;touch $i/README.txt;done
  200  ls
  201  for i in (data steps results plots scripts docs); do mkdir $i;touch $i/README.txt;done
  202  for i in {data steps results plots scripts docs}; do mkdir $i;touch $i/README.txt;done
  203  for i in ‘{data steps results plots scripts docs}’; do mkdir $i;touch $i/README.txt;done
  204  for i in ${data steps results plots scripts docs}; do mkdir $i;touch $i/README.txt;done
  205  for i in $'{data steps results plots scripts docs}'; do mkdir $i;touch $i/README.txt;done
  206  for i in {"data", "steps", "results", "plots", "scripts", "docs"}; do mkdir $i;touch $i/README.txt;done
  207  for i in {data, steps, results, plots, scripts, docs}; do mkdir $i;touch $i/README.txt;done
  208  for i in {data, steps, results, plots, scripts, docs}; do mkdir $i touch $i/README.txt;done
  209  for i in {data, steps, results, plots, scripts, docs}; do mkdir $i; touch $i/README.txt;done
  210  rm -r 
  211  rm -r *
  212  ls
  213  for i in {data,steps,results,plots,scripts,docs}; do mkdir $i; touch $i/README.txt;done
  214  conda -h
  215  conda activate
  216  python -V
  217  conda create -h
  218  conda create -n myproject python=3.10
  219  conda activate myproject
  220  ls
  221  source activate myproject
  222  python -V
  223  python
  224  python
  225  conda install numpy
  226  python
  227  conda deactivate
  228  conda search bcftools
  229  conda search paml
  230  conda config --add channels r
  231  cat ./condarc
  232  ls -a
  233  cat ~/condarc
  234  cat ~/.condarc
  235  conda activate myproject
  236  conda env create -f environment.yml
  237  conda env export > environment.yml
  238  ls
  239  cat environment.yml
  240  conda install bcftools
  241  bcftools -h
  242  conda env export > environment.yml
  243  cat environment.yml
  244  conda search fastsimcoal2
  245  conda install fastsimcoal2
  246  conda list myproject
  247  conda list
  248  micromamba install -c bioconda fastsimcoal2
  249  pixi add fastsimcoal2
  250  conda install -c bioconda fastsimcoal2
  251  conda install -h
  252  conda create -h
  253  conda create -n bcftools -c bioconda bcftools -y
  254  conda list
  255  conda activate bcftools
  256  conda list
  257  conda create -n bcftools -c bioconda fastsimcoal2 -y
  258  conda list
  259  conda deactivate
  260  conda create -n bcftools -c bioconda fastsimcoal2 -y
  261  conda list
  262  conda activate fastsimcoal2
  263  conda create -n fastsimcoal2 -c bioconda fastsimcoal2 -y
  264  conda activate fastsimcoal2
  265  conda deactivate
  266  conda create -n bcftools -c bioconda bcftools -y
  267  conda activate fastsimcoal2
  268  conda create -n bcftools -c bioconda bcftools -y
  269  conda list
  270  deactivate
  271  conda deactivate
  272  conda activate bcftools
  273  conda list
  274  bcftools -h
  275  pwd
  276  ls
  277  histrory
  278  history
  279  gnodes
  280  srun sss
  281  pwd
  282  srun -h
  283  gnodes
  284  srun -h
  285  gnodes
  286  gnodes | grep core
  287  gnodes
  288  pwd
  289  ls
  290  gdk-project-list
  291  gdk-project-list -h
  292  gdk-project-list -f owner
  293  gdk-project-list -f member
  294  gnodes
  295  gdk-project-list -f all
  296  gdk-project-list -f member
  297  jobinfo
  298  jobinfo ednaddd 
  299  srun --help
  300  srun --account eDNA --pty bash
  301  pwd
  302  ls
  303  conda
  304  cd miniforge3/
  305  ls
  306  cd bin
  307  ls
  308  cd ..
  309  pwd
  310  conda activate myproject
  311  pwd
  312  conda -h
  313  conda info -h
  314  conda info -e
  315  conda activate fastsimcoal2
  316  fsc27 -h
  317  fsc27
  318  conda activate bcftools
  319  bcftools -h
  320  cd
  321  ls
  322  cd DK_proj/
  323  ls
  324  cd steps/
  325  mkdir fastsimcoal_test
  326  cd fastsimcoal_test/
  327  conda activate fastsimcoal2
  328  fastsimcoal2 -h
  329  fsc27 --help
  330  ls
  331  pwd
  332  ls ~/miniforge3/
  333  ls ~/miniforge3/bin
  334  conda info -e
  335  ls /home/yzliu/miniforge3/envs/fastsimcoal2
  336  ls /home/yzliu/miniforge3/envs/fastsimcoal2/bin
  337  fsc27093
  338  srun --account eDNA bash
  339  fsc27093 -i fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb.par -n1 -G
  340  fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb.par -n1 -G
  341  cd
  342  ls
  343  conda search stairway
  344  ls
  345  cd bin
  346  ls
  347  ls -a
  348  https://github.com/xiaoming-liu/stairway-plot-v2/tree/master
  349  wget https://github.com/xiaoming-liu/stairway-plot-v2/blob/93dbd60925d5ef0595d28bd73ccab213e3527fdb/stairway_plot_v2.1.2.zip
  350  ls
  351  unzip stairway_plot_v2.1.2.zip 
  352  ll
  353  gzip -h
  354  ls
  355  gzip -d stairway_plot_v2.1.2.zip
  356  ls
  357  unzip -h
  358  unzip stairway_plot_v2.1.2.zip
  359  cd stairway_plot_v2.1.2.zip
  360  ll
  361  jar xvf stairway_plot_v2.1.2.zip 
  362  conda search jar
  363  scontrol show node s21n21
  364  srun --constraint "gen3"
  365  srun --constraint "gen3" --account eDNA --mem 16g --pty bash
  366  cd bin
  367  ls
  368  unzip stairway_plot_v2.1.2.zip 
  369  gunzip -hA
  370  gunzip -d stairway_plot_v2.1.2.zip
  371  ll
  372  gunzip -d stairway_plot_v2.1.2.zip
  373  unzip stairway_plot_v2.1.2.zip
  374  ll
  375  rm stairway_plot_v2.1.2
  376  rm -r stairway_plot_v2.1.2*
  377  ll
  378  wget https://github.com/xiaoming-liu/stairway-plot-v2/raw/93dbd60925d5ef0595d28bd73ccab213e3527fdb/stairway_plot_v2.1.2.zip
  379  ll
  380  unzip stairway_plot_v2.1.2.zip
  381  ll
  382  cd stairway_plot_v2.1.2/
  383  ll
  384  ls
  385  conda -e
  386  conda info -e
  387  cd bin
  388  ls
  389  unzip stairway_plot_v2.1.2.zip 
  390  jar --help
  391  gzip -d stairway_plot_v2.1.2.zip
  392  gzip -h
  393  ls
  394  cd bin
  395  ll
  396  cd stairway_plot_v2.1.2/
  397  ll
  398  stairway_plot_es -h
  399  cd stairway_plot_es
  400  ll
  401  pwd
  402  cd ..
  403  ll
  404  wget https://github.com/xiaoming-liu/stairway-plot-v2/raw/master/stairway_plot_v2.1.1.zip
  405  ll
  406  unzip stairway_plot_v2.1.1.zip
  407  ll
  408  cd stairway_plot_v2.1.1
  409  ll
  410  cd stairway_plot_es
  411  ll
  412  swarmops.jar -h
  413  cd DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb/
  414  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq - | awk '$1=$1' | cut -d ' ' -f 1 | tr '\n' ' '
  415  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq - | awk '$1=$1'
  416  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c
  417  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | awk '$1=$1' | cut -d ' ' -f 1 | tr '\n' ' '
  418  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | awk '$1=$1' | cut -d ' ' -f 1 | tr '\n' '  '
  419  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | awk '$1=$1' | cut -d ' ' -f 1 | tr '\n' '   '
  420  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | awk '$1=$1' | cut -d ' ' -f 1 | tr '\n' '\t'
  421  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | awk '$1=$1' | cut -d ' ' -f 1 | tr '\n' "  "
  422  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | awk '$2=$2' | cut -d ' ' -f 1 | tr '\n' '\t'
  423  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | awk '$2=$2' | cut -d ' ' -f 2 | tr '\n' '\t'
  424  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | awk '$1=$1' | cut -d ' ' -f 2 | tr '\n' '\t'
  425  cd ..
  426  conda -e list
  427  conda -e
  428  conda info -e
  429  conda activate fastsimcoal2
  430  fsc27093 -i
  431  fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_150Mb.par -n1 -G
  432  gnodes
  433  cd DK_proj/scripts/fastsimcoal2_batch.sh
  434  cd DK_proj/scripts/
  435  sbatch fastsimcoal2_batch.sh 
  436  squeue -u yzliu
  437  sbatch fastsimcoal2_150Mb.sh 
  438  squeue -u yzliu
  439  scancel 25425826
  440  sbatch fastsimcoal2_150Mb.sh
  441  squeue -u yzliu
  442  jobinfo -u yzliu
  443  jobs
  444  bg
  445  fg
  446  fg %n
  447  ps
  448  ps T
  449  top
  450  conda activate fastsimcoal2
  451  squeue -u yzliu
  452  cd /home/yzliu/DK_proj/steps/fastsimcoal_test
  453  fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_150Mb.par -n1 -G
  454  fsc27093
  455  conda init -h
  456  squeue -u yzliu
  457  scancel 25425854
  458  sbatch fastsimcoal2_150Mb.sh
  459  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_150Mb.sh
  460  squeue -u yzliu
  461  conda init bash
  462  cd /home/yzliu/DK_proj/scripts/
  463  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_150Mb.sh
  464  scancel 25427085
  465  conda init -h
  466  sbatch fastsimcoal2_150Mb.sh
  467  squeue -u yzliu
  468  sbatch fastsimcoal2_150Mb.sh
  469  squeue -u yzliu
  470  conda activate fastsimcoal2
  471  squeue -u yzliu
  472  scancel 25427319
  473  sbatch fastsimcoal2_150Mb.sh
  474  conda info | grep -i 'base environment'
  475  squeue -u yzliu
  476  scancel 25427541
  477  sbatch fastsimcoal2_150Mb.sh
  478  squeue -u yzliu
  479  sbatch fastsimcoal2_150Mb.sh
  480  ls
  481  cd DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb/
  482  ll
  483  awk '{$1=$2=$3=$4="";print $0}' *gen | head
  484  awk '{$1=$2=$3=$4="";print $0}' *gen > out
  485  sed '1d' out > out1
  486  head out1
  487  awk '{for(i=t=0;i<NF;) t+=$++i;$0=t}1' out1 > out2
  488  head out2
  489  less out2
  490  tr -s '' '\n' < out2 | sort | uniq -c -d > out3
  491  less out3
  492  cat out3
  493  sort -n -k2 out3
  494  sort -n -k2 out3 > out4
  495  awk '{$2="";print$0}' out4 > out5
  496  cat out5
  497  tr '\n' '' < out5 > sfs
  498  cat sfs
  499  cat out5
  500  tr '\n' ' ' < out5 > sfs
  501  cat sfs
  502  ls *gen
  503  ls
  504  awk '{(if i > 4;) print $i}' fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen 
  505  awk '{for(i=1;i<=30;i++) print $i}' fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen 
  506  awk '{for(i=1;i<=30;i++) print $i"\n"}' fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen 
  507  awk '{for(i=1;i<=30;i++) print "$i\n"}' fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen 
  508  for i in {1..4}; do awk -v col="$i" '{print "$col"}' fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen | head
  509  for i in {1..4}; do awk -v col="$i" '{print "$col"}' fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen ;done | head
  510  for i in {1..4}; do awk -v col="$i" '{print $col}' fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen ;done | head
  511  for i in {1..4}; do awk -v col="$i" '{print $col}' fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen ;done
  512  for i in {1..4}; do awk -v col="$i" '{print $col"\n"}' fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen ;done | head
  513  awk '{for(i=1;i<=NF;i++) print $i}' fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen | head
  514  awk '{for(i=1;i<=NF-1;i++) print $i}' fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen | head
  515  awk '{for(i=1;i<=NF-1;i++) print $i}' fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen
  516  awk '{for(i=1;i<=NF-1;i++) print $i"\t"}' fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen | head
  517  awk '{for(i=1;i<=NF-1;i++) print $i"\t";print ""}' fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen | head
  518  awk '{print $1,$2}' fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen | head
  519  awk '{print $1-$3}' fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen | head
  520  awk '{print $1,$3}' fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen | head
  521  awk '{for(i=1;i<=NF-1;i++) print $i" "; print ""}' fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen | head
  522  awk '{for(i=1;i<=NF-1;i++) print $i" "; pr
  523  ls -l | awk '{for(i=1;i<=NF-1;i++) print $i" "; print ""}' fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen
  524  ls -l | awk '{for(i=1;i<=NF-1;i++) print $i" "; print ""}
  525  ls -l | awk '{for(i=1;i<=NF-1;i++) print $i" "; print ""}'
  526  for i in {1..5};do ls -l | awk -v i="$i" {print $i}'
  527  for i in {1..5};do ls -l | awk -v i="$i" {print $i}';done
  528  for i in {1..5};do ls -l | awk -v i="$i" '{print $i}';done
  529  for i in {1..5};do ls -l | awk -v i="$i" '{print "$i\n"}';done
  530  for i in {1..5};do ls -l | awk -v i="$i" '{print '$i\n'}';done
  531  for i in {1..5};do ls -l | awk -v i="$i" '{print $i;print "\n"}';done
  532  cut -f 1,2,3,4 fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen | head
  533  cut -h
  534  cut --help
  535  cut -f 1-,2,3,4 fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen | head
  536  cut -f -1,2,3,4 fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen | head
  537  cut -f -1,2-3 fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen | head
  538  cut --complement -f 1,2-4 fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen | head
  539  cut --complement -f 1,2-4 fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen > fastsimcoal_gen.txt
  540  sed '1d' fastsimcoal_gen.txt > fastsimcoal_gen_new.txt
  541  head fastsimcoal_gen.txt
  542  cat fastsimcoal_gen.txt | awk '{sum +=$1} END {print sum}'
  543  cat fastsimcoal_gen.txt | awk '{sum +=$1} {print sum}'
  544  cat fastsimcoal_gen.txt | awk '{for(i=1;i<=NF;i++) sum +=$i} END {print sum}'
  545  cat fastsimcoal_gen.txt | awk '{for(i=1;i<=NF;i++) sum[i] +=$i;} END {print sum}'
  546  cat fastsimcoal_gen.txt | awk '{for(i=1;i<=NF;i++) sum[i] +=$i;} END {print sum[i]}'
  547  cat fastsimcoal_gen.txt | awk '{for(i=1;i<=NF;i++) sum[i] +=$i;} END {for(i in sum) print sum[i]}'
  548  cat fastsimcoal_gen.txt | awk '{for(i=1;i<=NF;i++) sum[i] +=$i;} END {for(i in sum) print sum[i]}' | wc
  549  cat fastsimcoal_gen.txt | awk '{for(i=1;i<=NR;i++) sum[i] +=$i;} END {for(i in sum) print sum[i]}' | wc
  550  cat fastsimcoal_gen.txt | awk '{for(i=1;i<=NR;i++) sum[i] +=$i;} END {for(i in sum) print sum[i]}'
  551  ls
  552  head fastsimcoal_gen.txt 
  553  'NR>1{sum=0; for(i=1; i<=NF; i++) sum += $i; NF++; $NF=sum } 1' 'NR>1{sum=0; for(i=1; i<=NF; i++) sum += $i; NF++; $NF=sum } 1'
  554  awk 'NR>1{sum=0; for(i=1; i<=NF; i++) sum += $i; NF++; $NF=sum } 1' fastsimcoal_gen.txt 
  555  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt
  556  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}'
  557  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort
  558  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n
  559  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq
  560  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt
  561  uniq --help
  562  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c
  563  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq
  564  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""}' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq
  565  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | tr '\n' ' '
  566  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | cut -f 1 | tr '\n' ' '
  567  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | cut -f 1
  568  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | cut -f ' ' -f 1
  569  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | cut -f '' -f 1
  570  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | cut -d ' ' -f 1
  571  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c > sfs_order.txt
  572  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | tr 's+' ' '
  573  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | sed 's/s+/ /g'
  574  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | sed 's/^s+//g'
  575  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | sed 's/^[s+]//g'
  576  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | sed 's/^[s+]*//g'
  577  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | sed 's/^[[:blank:]]*//g
  578  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | awk '$1=$1'
  579  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | awk '$1=$1' > sfs_order.new.txt
  580  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | awk '$1=$1' | tr '\n' ' '
  581  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | awk '$1=$1' | cut -f 1 | tr '\n' ' '
  582  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | awk '$1=$1' | cut -d ' ' -f 1 | tr '\n' ' '
  583  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | awk '$1=$1' | cut -f 1 | awk 'BEGIN {ORS=" "} {print}'
  584  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | awk '$1=$1' | cut -d ' ' -f 1 | awk 'BEGIN {ORS=" "} {print}'
  585  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | awk '$1=$1' | cut -d ' ' -f 1 | awk 'BEGIN {ORS=" "} {print "\n"}'
  586  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | awk '$1=$1' | cut -d ' ' -f 1 | awk 'BEGIN {ORS=" "} {print "\n"}'
  587  java
  588  cd /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_es
  589  ll
  590  jave -cp stairway_plot_es Stairbuilder twp-epoch_fold.test.blueprint
  591  java -cp stairway_plot_es Stairbuilder twp-epoch_fold.test.blueprint
  592  java
  593  cd ..
  594  java -cp stairway_plot_es Stairbuilder twp-epoch_fold.test.blueprint
  595  ls *blue*
  596  java -cp stairway_plot_es Stairbuilder two-epoch_fold.test.blueprint
  597  uniq --help
  598  pwd
  599  cd
  600  cd DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb/
  601  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c | awk '$1=$1' | cut -d ' ' -f 1 | tr '\n' ' '
  602  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c
  603  awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c -d
  604  cd /home/yzliu/bin/stairway_plot_v2.1.2
  605  java -cp stairway_plot_es Stairbuilder two-epoch_fold.test.blueprint
  606  bash two-epoch_fold.test.blueprint.sh
  607  srun -h
  608  srun -c eDNA
  609  srun -A eDNA 
  610  srun -A eDNA --pty
  611  srun --account eDNA --pty
  612  srun -A eDNA --pty bash
  613  srun -A eDNA --pty --mem=12g bash
  614  top
  615  squeue -u yzliu
  616  srun -A eDNA --mem 16g bash
  617  squeue -u yzliu
  618  gnodes
  619  squeue -u yzliu
  620  scancel 25427960
  621  cd /home/yzliu/DK_proj/scripts/
  622  sbatch fastsimcoal2_150Mb.sh
  623  squeue -u yzliu
  624  less /home/yzliu/DK_proj/scripts/fastsimcoal.test_150Mb.25431677.o.txt
  625  tail /home/yzliu/DK_proj/scripts/fastsimcoal.test_150Mb.25431677.o.txt
  626  squeue -u yzliu
  627  tail /home/yzliu/DK_proj/scripts/fastsimcoal.test_150Mb.25431677.o.txt
  628  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -h
  629  tail /home/yzliu/DK_proj/scripts/fastsimcoal.test_150Mb.25431677.o.txt
  630  ll /home/yzliu/DK_proj/scripts/fastsimcoal.test_150Mb.25431677.o.txt
  631  ls -h
  632  ls --help
  633  ls --size M
  634  tail /home/yzliu/DK_proj/scripts/fastsimcoal.test_150Mb.25431677.o.txt
  635  ls --help
  636  ls --block-size M 
  637  ls -l --block-size M 
  638  tail /home/yzliu/DK_proj/scripts/fastsimcoal.test_150Mb.25431677.o.txt
  639  ls -l --block-size M 
  640  less /home/yzliu/DK_proj/scripts/fastsimcoal.test_150Mb.25431677.o.txt
  641  less /home/yzliu/DK_proj/scripts/fastsimcoal.test_150Mb.25431677.o.txt | grep 'Chrom struct'
  642  less /home/yzliu/DK_proj/scripts/fastsimcoal.test_150Mb.25431677.o.txt
  643  less /home/yzliu/DK_proj/scripts/fastsimcoal.test_150Mb.25431677.o.txt | grep 'locus 147310462'
  644  less /home/yzliu/DK_proj/scripts/fastsimcoal.test_150Mb.25431677.o.txt
  645  tail /home/yzliu/DK_proj/scripts/fastsimcoal.test_150Mb.25431677.o.txt
  646  less /home/yzliu/DK_proj/scripts/fastsimcoal.test_150Mb.25431677.o.txt | grep 'locus 147310462'
  647  squeue -u yzliu
  648  tail /home/yzliu/DK_proj/scripts/fastsimcoal.test_150Mb.25431677.o.txt
  649  squeue -u yzliu
  650  tail /home/yzliu/DK_proj/scripts/fastsimcoal.test_150Mb.25431677.o.txt
  651  squeue -u yzliu
  652  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -h
  653  sbatch fastsimcoal2_150Mb.sh 
  654  sbatch fastsimcoal2_80Mb.sh 
  655  squeue -u yzliu
  656  ls -l --block-size M 
  657  less /home/yzliu/DK_proj/scripts/fastsimcoal.test_80Mb.25436831.o.txt | grep 'locus 147310462'
  658  tail /home/yzliu/DK_proj/scripts/fastsimcoal.test_80Mb.25436831.o.txt
  659  sbatch fastsimcoal2_80Mb.sh 
  660  sbatch fastsimcoal2_150Mb.sh 
  661  less /home/yzliu/DK_proj/scripts/fastsimcoal.test_80Mb.25436831.o.txt | grep 'locus 18759761'
  662  squeue -u yzliu
  663  ls -l --block-size M 
  664  squeue -u yzliu
  665  ls -l --block-size M 
  666  top
  667  squeue -u yzliu
  668  srun --account eDNA --mem 26g --pty bash
  669  srun --account eDNA --mem 36g --time=10:00:00 --pty bash
  670  squeue -u yzliu
  671  ls -l --block-size M 
  672  cd /home/yzliu/DK_proj/scripts/
  673  ls -l --block-size M 
  674  tail fastsimcoal.test_80Mb.25444579.o.txt
  675  less /home/yzliu/DK_proj/scripts/fastsimcoal.test_80Mb.25444579.o.txt | grep 'ocus 38552462'
  676  ls -l --block-size M 
  677  squeue -u yzliu
  678  ls -l --block-size M 
  679  tail fastsimcoal.test_8Mb.25483466.o.txt
  680  ls -l --block-size M 
  681  squeue -u yzliu
  682  ls -l --block-size M 
  683  squeue -u yzliu
  684  ls -l --block-size M 
  685  pwd
  686  cd /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_8Mb
  687  ls -l --block-size M 
  688  squeue -u yzliu
  689  finishedjobinfo -h
  690  less /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_8Mb.par
  691  cd /home/yzliu/DK_proj/scripts/
  692  sbatch fastsimcoal2_8MbChr.sh
  693   squeue -u yzliu
  694  cd /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb
  695  ll
  696  ls
  697  cut --complement -f 1,2-4 | head
  698  cut --complement -f 1,2-4 fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.gen | head
  699  cut --complement -f 1,2-4 fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.gen | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | head
  700  cut --complement -f 1,2-4 fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.gen | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | wc -l
  701  cut --complement -f 1,2-4 fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.gen | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}'
  702  cut --complement -f 1,2-4 fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.gen | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c -d | awk '$1=$1'
  703  sed '1d' fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.gen |  cut --complement -f 1,2-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c -d | awk '$1=$1'
  704  sed '1d' fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.gen |  cut --complement -f 1,2-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n
  705  sed '1d' fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.gen |  cut --complement -f 1,2-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | head
  706  sed '1d' fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.gen |  cut --complement -f 1,2-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | less
  707  sed '1d' fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.gen |  cut --complement -f 1,2-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | grep 0 | less
  708  sed '1d' fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.gen |  cut --complement -f 1,2-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | less -N
  709  sed '1d' fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.gen |  cut --complement -f 1,2-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | less -N > allel_freq_line.txt
  710  lss -l --block-size m /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb
  711  ls -l --block-size m /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb
  712  awk '$1=0 {print $0}' allel_freq_line.txt | head
  713  awk '$1==0 {print $0}' allel_freq_line.txt | head
  714  sed '1d' fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.gen |  cut --complement -f 1,2-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | less -N
  715  sed '1d' fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.gen |  cut --complement -f 1,2-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | less -N | head
  716  awk '$1==0 {print $0}' allel_freq_line.txt | head
  717  grep '^0$' allel_freq_line.txt | head
  718  grep -N '^0$' allel_freq_line.txt | head
  719  grep --help
  720  grep -n '^0$' allel_freq_line.txt | head
  721  less -S fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.gen
  722  less fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.gen
  723  head fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.gen
  724  head fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.copy.gen 
  725  less -S fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.copy.gen 
  726  sed '1d' fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.copy.gen |  cut --complement -f 1,2-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | less -N > allel_freq_line.txt
  727  grep -n '^0$' allel_freq_line.txt | head
  728  less -S allel_freq_line.txt
  729  less -NS allel_freq_line.txt
  730  sed '1d' fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.copy.gen | less -S
  731  grep -n '^0$' allel_freq_line.txt | head
  732  sed '1d' fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.copy.gen |  cut --complement -f 1,2-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c -d | awk '$1=$1' | cut -d ' ' -f 1 | tr '\n' ' '
  733  uniq -h
  734  uniq --help
  735  sed '1d' fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.copy.gen |  cut --complement -f 1,2-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c -d | head
  736  sed '1d' fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.copy.gen |  cut --complement -f 1,2-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c -D | head
  737  sed '1d' fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.copy.gen |  cut --complement -f 1,2-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -D | head
  738  sed '1d' fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.copy.gen |  cut --complement -f 1,2-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c -d | head
  739  sed '1d' /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb/fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen |  cut --complement -f 1,2-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c -d | head
  740  sed '1d' /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb/fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen |  cut --complement -f 1,2-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c -d
  741  sed '1d' /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb/fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen |  cut --complement -f 1,2-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c
  742  sed '1d' /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb/fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen |  cut --complement -f 1,2-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c | head
  743  sed '1d' fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.copy.gen |  cut --complement -f 1,2-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c | head
  744  sed '1d' fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.copy.gen |  cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c | head
  745  sed '1d' /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb/fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen |  cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c | head
  746  sed '1d' fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.copy.gen |  cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c -d | awk '$1=$1' | cut -d ' ' -f 1 | tr '\n' ' '
  747  sed '1d' /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb/fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb_1_1.gen |  cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c | head -25
  748  sed '1d' fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.copy.gen |  cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c | head -15
  749  cd cd /home/yzliu/bin/stairway_plot_v2.1.2
  750  cd /home/yzliu/bin/stairway_plot_v2.1.2
  751  java -cp stairway_plot_es Stairbuilder eno-epoch_fold.20Samples500K_test.blueprint
  752  java -cp stairway_plot_es Stairbuilder ten-epoch_fold.20Samples500K_test.blueprint
  753  sbatch ten-epoch_fold.20Samples500K_test.blueprint.sh 
  754  squeue -u yzliu
  755  sbatch ten-epoch_fold.20Samples500K_test.blueprint.plot.sh
  756  java -cp stairway_plot_es Stairbuilder ten-epoch_fold.20Samples500K_test.blueprint
  757  sbatch ten-epoch_fold.20Samples500K_test.blueprint.sh 
  758  sbatch ten-epoch_fold.20Samples500K_test.blueprint.sh
  759  squeue -u yzliu
  760  java -cp stairway_plot_es Stairbuilder ten-epoch_fold.20Samples500K_test.blueprint
  761  sbatch ten-epoch_fold.20Samples500K_test.blueprint.sh
  762  squeue -u yzliu
  763  ls *.plot.sh
  764  bash ten-epoch_fold.20Samples500K_test.blueprint.plot.sh
  765  java -cp stairway_plot_es Stairbuilder/en-epoch_fold.20Samples500K_test.blueprint
  766  java -cp stairway_plot_es Stairbuilder ten-epoch_fold.20Samples500K_test.blueprint
  767  bash '\home\yzliu\bin\stairway_plot_v2.1.2\ten-epoch_fold.20Samples500K_test.blueprint.sh'
  768  bash ten-epoch_fold.20Samples500K_test.blueprint.sh
  769  java -cp stairway_plot_es Stairbuilder x-epoch_fold.test.blueprint 
  770  bax-epoch_fold.test.blueprint.sh
  771  ls *.sh
  772  bash x-epoch_fold.test.blueprint.sh
  773  java -cp stairway_plot_es Stairbuilder x-epoch_fold.test.blueprint 
  774  java -cp stairway_plot_es Stairbuilder x-epoch_fold.test.blueprint
  775  bash x-epoch_fold.test.blueprint.sh
  776  bash ten-epoch_fold.20Samples500K_test.blueprint.plot.sh
  777  bash ten-epoch_fold.20Samples500K_test.blueprint.sh
  778  java -cp stairway_plot_es Stairbuilder ten-epoch_fold.20Samples500K_test.blueprint
  779  sbatch ten-epoch_fold.20Samples500K_test.blueprint.sh
  780  squeue -u yzliu
  781  sbatch ten-epoch_fold.20Samples500K_test.blueprint.sh
  782  java -cp stairway_plot_es Stairbuilder ten-epoch_fold.20Samples500K_test.2.blueprint
  783  squeue -u yzliu
  784  java -cp stairway_plot_es Stairbuilder ten-epoch_fold.20Samples500K_test.2.blueprint
  785  sbatch ten-epoch_fold.20Samples500K_test.2.blueprint.sh 
  786  squeue -u yzliu
  787  java -cp stairway_plot_es Stairbuilder two-epoch_fold.2Events20Samples500Chr500K_test.blueprint
  788  bash two-epoch_fold.2Events20Samples500Chr500K_test.blueprint.sh
  789  java -cp stairway_plot_es Stairbuilder two-epoch_fold.blueprint 
  790  bash two-epoch_fold.blueprint.sh
  791  cd /home/yzliu/DK_proj/scripts/
  792  ls
  793  ls -l /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_8Mb
  794  sbatch fastsimcoal2_8MbChr.sh
  795  ls -l /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb
  796  ls -l --block-size M /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_100KNe_20S_10E_30Chr_5Mb
  797  ls
  798  ls -l
  799  tail fastsimcoal.test_8Mb.25501917.o.txt
  800  sbatch fastsimcoal2_5MbChr.sh
  801   squeue -u yzliu
  802  ls -l --block-size m /home/yzliu/DK_proj/steps/fastsimcoal_test
  803  ls -l --block-size m /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_8Mb
  804  ls -l --block-size m /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_8Mb/garbage0/
  805  ls -l --block-size m /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_8Mb/
  806   squeue -u yzliu
  807  sbatch fastsimcoal2_5MbChr.new.sh
  808   squeue -u yzliu
  809  ls -l --block-size m /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_8Mb/
  810  ls -l --block-size m /home/yzliu/DK_proj/steps/fastsimcoal_test/
  811  ls -l --block-size m /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_5Mb.new
  812  joninfo -h
  813  job -h
  814  job --help
  815  jobs
  816  finished
  817  man
  818  sbatch fastsimcoal2_10KbChr.sh
  819   squeue -u yzliu
  820  less -S /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_10K.par
  821  less -S /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_10Kb.par
  822  sbatch fastsimcoal2_10KbChr.sh
  823   squeue -u yzliu
  824  sbatch fastsimcoal2_100KbChr.sh
  825   squeue -u yzliu
  826  sbatch fastsimcoal2_1000KbChr.sh
  827   squeue -u yzliu
  828  ls -l --block-size m /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_1000Kb/
  829  less -S /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_1000Kb/*.arp
  830  tail /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_1000Kb/*.arp
  831   squeue -u yzliu
  832  sbatch fastsimcoal2_500KbChr.sh
  833   squeue -u yzliu
  834  tail /home/yzliu/DK_proj/scripts/fastsimcoal.test_500Kb.25505066.o.txt
  835  ls -l --block-size m /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb/
  836   squeue -u yzliu
  837  history
  838  ls -l --block-size m /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb/
  839  ls -l --block-size kb /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb/
  840  ls -l --block-size Kb /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb/
  841  ls -l --block-size K /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb/
  842  ls -l --block-size b /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb/
  843  ls -l --block-size B /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb/
  844  head /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.gen
  845  head /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb/fastsimcoal_simulation_10KNe_20Sample_10Event_30Chr_500Kb_1_1.copy.gen
  846  cd /home/yzliu/bin/stairway_plot_v2.1.2
  847  java -cp Stairbuilder ten-epoch_fold.20Samples500K_test.blueprint 
  848  java -cp stairway_plot_es Stairbuilder ten-epoch_fold.20Samples500K_test.blueprint 
  849  bash ten-epoch_fold.20Samples500K_test.blueprint.sh 
  850  sbatch ten-epoch_fold.20Samples500K_test.blueprint.sh 
  851  cd /home/yzliu/DK_proj/scripts
  852  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_10KNe_20S_2E_500Kb500Chr.sh
  853   squeue -u yzliu
  854  less -S /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_20Sample_3Event_500Chr_500Kb.par
  855  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_10KNe_20S_2E_500Kb500Chr.sh
  856   squeue -u yzliu
  857  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_10KNe_20S_2E_500Kb500Chr.sh
  858   squeue -u yzliu
  859  ls -l --block-size 
  860  ls -l --block-size M
  861  tail fastsimcoal2_10KNe_20S_2E_500Kb500Chr.25518367.o.txt
  862  ls -l --block-size M
  863  tail fastsimcoal2_10KNe_20S_2E_500Kb500Chr.25518367.o.txt
  864  sed '1d' /home/yzliu/DK_proj/steps/fastsimcoal_test/*.gen |  cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c | head -15
  865  sed '1d' /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_2Event_500Chr_500Kb_1_1.gen |  cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c | head -15
  866  sed '1d' /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_2Event_500Chr_500Kb/fastsimcoal_simulation_10KNe_20Sample_2Event_500Chr_500Kb_1_1.gen |  cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c | head -15
  867  sed '1d' /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_2Event_500Chr_500Kb/fastsimcoal_simulation_10KNe_20Sample_2Event_500Chr_500Kb_1_1.gen |  cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | head -15
  868  sed '1d' /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_2Event_500Chr_500Kb/fastsimcoal_simulation_10KNe_20Sample_2Event_500Chr_500Kb_1_1.gen |  cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c -d | head -15
  869  sed '1d' /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_2Event_500Chr_500Kb/fastsimcoal_simulation_10KNe_20Sample_2Event_500Chr_500Kb_1_1.gen |  cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c -d | awk '$1=$1' | cut -d ' ' -f 1 | tr '\n' ' ' | head -15
  870  cd /home/yzliu/bin/stairway_plot_v2.1.2
  871  cd /home/yzliu/DK_proj/scripts
  872  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_100KNe_30S_2E_500Kb500Chr.sh
  873  scancel 25518486
  874  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_100KNe_30S_2E_500Kb500Chr.sh
  875   squeue -u yzliu
  876  tail /home/yzliu/DK_proj/scripts/fastsimcoal2_100KNe_30S_2E_500Kb500Chr.25518499.o.txt 
  877  ls -l --block-size M /home/yzliu/DK_proj/scripts/
  878   squeue -u yzliu
  879  ls -l --block-size M /home/yzliu/DK_proj/scripts/
  880  tail fastsimcoal2_100KNe_30S_2E_500Kb500Chr.25518499.o.txt
  881  less -S  fastsimcoal2_100KNe_30S_2E_500Kb500Chr.25518499.o.txt
  882  ls -l --block-size M /home/yzliu/DK_proj/scripts/
  883   squeue -u yzliu
  884  tail fastsimcoal2_100KNe_30S_2E_500Kb500Chr.25518499.o.txt
  885  ls -l --block-size M /home/yzliu/DK_proj/scripts/
  886   squeue -u yzliu
  887  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_10KNe_20S_2E_500Kb200Chr.sh
  888   squeue -u yzliu
  889  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_10KNe_20S_2E_500Kb200Chr.neg.sh
  890   squeue -u yzliu
  891  cd cd /home/yzliu/bin/stairway_plot_v2.1.2
  892  cd /home/yzliu/bin/stairway_plot_v2.1.2
  893  java -cp stairway_plot_es Stairbuilder two-epoch_fold.2Events20Samples500Chr500K_test.neg.blueprint
  894  java -cp stairway_plot_es Stairbuilder two-epoch_fold.2Events20Samp2es500Chr500K_test.neg.blueprint
  895  java -cp stairway_plot_es Stairbuilder two-epoch_fold.2Events20Samples200Chr500K_test.neg.blueprint
  896  bash two-epoch_fold.2Events20Samples200Chr500K_test.neg.blueprint.sh
  897  java -cp stairway_plot_es Stairbuilder two-epoch_fold.2Events20Samples200Chr500K_test.neg.blueprint.plot-.sh 
  898   squeue -u yzliu
  899  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_10KNe_20S_1E_500Kb500Chr.sh
  900  scancel 25528255
  901  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_10KNe_20S_1E_500Kb500Chr.sh
  902   squeue -u yzliu
  903  sed '1d' /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_2Event_500Chr_500Kb/fastsimcoal_simulation_10KNe_20Sample_1Event_500Chr_500Kb_1_1.gen |  cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c -d | awk '$1=$1' | cut -d ' ' -f 1 | tr '\n' ' ' | head -15
  904  sed '1d' /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_1Event_500Chr_500Kb/fastsimcoal_simulation_10KNe_20Sample_1Event_500Chr_500Kb_1_1.gen |  cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c -d | awk '$1=$1' | cut -d ' ' -f 1 | tr '\n' ' ' | head -15
  905  sed '1d' /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_1Event_500Chr_500Kb.neg/fastsimcoal_simulation_10KNe_20Sample_1Event_500Chr_500Kb.neg_1_1.gen |  cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c -d | awk '$1=$1' | cut -d ' ' -f 1 | tr '\n' ' ' | head -15
  906  java -cp stairway_plot_es Stairbuilder two-epoch_fold.1Events20Samples500Chr500K_test.neg.blueprint
  907  bash two-epoch_fold.1Events20Samples500Chr500K_test.neg.blueprint.sh
  908  cd /home/yzliu/DK_proj/scripts
  909  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_10KNe_24S_1E_5Mb10Chr.new_server.sh
  910  ls -l --block-size M
  911  ls -l --block-size M fastsimcoal_simulation_10KNe_24Sample_1Event_10Chr_5Mb.new
  912  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_10KNe_24S_1E_5Mb10Chr.new_server.sh
  913   squeue -u yzliu
  914  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_10KNe_24S_1E_10Mb1Chr.sh
  915   squeue -u yzliu
  916  ls -l --block-size M
  917  ls -lr --block-size M
  918  ls -lt --block-size M
  919  ls -lt --block-size M /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_24Sample_1Event_1Chr_10Mb
  920  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -i fastsimcoal_simulation_10KNe_24Sample_1Event_1Chr_1Mb.new2.par -n1 -q -s0 -d -k 1000000 -c 4 -G &
  921  top
  922  ps
  923  fg
  924  bg
  925  ps
  926  top
  927  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_10KNe_24S_1E_1Mb1Chr.new2.sh 
  928   squeue -u yzliu
  929  sed '1d' /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_1Event_500Chr_500Kb.neg/fastsimcoal_simulation_10KNe_24Sample_1Event_1Chr_1Mb.new2_1_1.gen |  cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c -d | awk '$1=$1' | cut -d ' ' -f 1 | tr '\n' ' ' | head -15
  930  sed '1d' /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_24Sample_1Event_1Chr_1Mb.new2/fastsimcoal_simulation_10KNe_24Sample_1Event_1Chr_1Mb.new2_1_1.gen |  cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c -d | awk '$1=$1' | cut -d ' ' -f 1 | tr '\n' ' ' | head -15
  931  cd /home/yzliu/bin/stairway_plot_v2.1.2
  932  java -cp stairway_plot_es Stairbuilder two-epoch_fold.1Events24Samples1Chr1Mb.blueprint
  933  bash two-epoch_fold.1Events24Samples1Chr1Mb.blueprint.sh
  934   squeue -u yzliu
  935  cd /home/yzliu/DK_proj/scripts
  936  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_10KNe_24S_1E_1Mb1Chr.new3.sh 
  937   squeue -u yzliu
  938  scancel 25538552
  939   squeue -u yzliu
  940  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_10KNe_24S_1E_1Mb1Chr.new3.sh 
  941  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_10KNe_24S_1E_1Mb1Chr.new4.sh 
  942   squeue -u yzliu
  943  cd /home/yzliu/bin/stairway_plot_v2.1.2
  944  java -cp stairway_plot_es Stairbuilder two-epoch_fold.1Events24Samples1Chr1Mb.new4.blueprint
  945  bash two-epoch_fold.1Events24Samples1Chr1Mb.new4.blueprint.sh
  946  java -cp stairway_plot_es Stairbuilder two-epoch_fold.1Events24Samples1Chr1Mb.new4.blueprint
  947  bash two-epoch_fold.1Events24Samples1Chr1Mb.new4.blueprint.sh
  948  squeue -u yzliu
  949  sed '1d' /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_24Sample_1Event_1Chr_1Mb.new4/fastsimcoal_simulation_10KNe_24Sample_1Event_1Chr_1Mb.new4_1_1.gen |  cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c -d | awk '$1=$1' | cut -d ' ' -f 1 | tr '\n' ' ' | head -15
  950  cd /home/yzliu/DK_proj/scripts
  951  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_10KNe_24S_1E_1Mb1Chr.new5.sh 
  952  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_10KNe_14S_1E_1Mb1Chr.new5.sh 
  953  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_10KNe_24S_1E_1Mb1Chr_mu.new4to6.sh
  954  squeue -u yzliu
  955  cd /home/yzliu/bin/stairway_plot_v2.1.2
  956  java -cp stairway_plot_es Stairbuilder two-epoch_fold.1Events24Samples1Chr1Mb.new4to6.blueprint 
  957  bash two-epoch_fold.1Events24Samples1Chr1Mb.new4to6.blueprint.sh 
  958  java -cp stairway_plot_es Stairbuilder two-epoch_fold.1Events14Samples1Chr1Mb.blueprint 
  959  bash two-epoch_fold.1Events14Samples1Chr1Mb.blueprint.sh 
  960  java -cp stairway_plot_es Stairbuilder two-epoch_fold.1Events14Samples1Chr1Mb.blueprint 
  961  bash two-epoch_fold.1Events14Samples1Chr1Mb.blueprint.sh 
  962  cd /home/yzliu/DK_proj/scripts
  963  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_10KNe_30S_1E_1Mb5Chr_low_mu.new7.sh 
  964  sbatch fastsimcoal2_10KNe_24S_2E_1Mb1Chr_mu.new4to6to8.sh
  965  squeue -u yzliu
  966  cd /home/yzliu/bin/stairway_plot_v2.1.2
  967  java -cp stairway_plot_es Stairbuilder two-epoch_fold.2Events30Samples5Chr1Mb.new7.blueprint
  968  bash two-epoch_fold.2Events30Samples5Chr1Mb.new7.blueprint.sh &
  969  fg
  970  bg
  971  fg
  972  bash two-epoch_fold.2Events30Samples5Chr1Mb.new7.blueprint.sh &
  973  java -cp stairway_plot_es Stairbuilder two-epoch_fold.2Events30Samples5Chr1Mb.new7.blueprint
  974  bash two-epoch_fold.2Events30Samples5Chr1Mb.new7.blueprint.sh &
  975  squeue -u yzliu
  976  java -cp stairway_plot_es Stairbuilder two-epoch_fold.2Events24Samples1Chr1Mb.new4to6to8.blueprint
  977  bash two-epoch_fold.2Events24Samples1Chr1Mb.new4to6to8.blueprint.sh
  978  java -cp stairway_plot_es Stairbuilder two-epoch_fold.2Events24Samples1Chr1Mb.new4to6to8.blueprint
  979  bash two-epoch_fold.2Events24Samples1Chr1Mb.new4to6to8.blueprint.sh
  980  cd /home/yzliu/DK_proj/scripts
  981  sbatch fastsimcoal2_10KNe_30S_4E_1Mb5Chr_low_mu.new7to9.sh
  982  squeue -u yzliu
  983  cd /home/yzliu/bin/stairway_plot_v2.1.2
  984  java -cp stairway_plot_es Stairbuilder two-epoch_fold.4Events30Samples5Chr1Mb_low_mu.new7to9.blueprint
  985  bash two-epoch_fold.4Events30Samples5Chr1Mb_low_mu.new7to9.blueprint.sh
  986  cd /home/yzliu/bin/stairway_plot_v2.1.2
  987  cd /home/yzliu/DK_proj/scripts
  988  sbatch fastsimcoal2_10KNe_30S_4E_1Mb5Chr_low_mu.new7to9.sh
  989  squeue -u yzliu
  990  ll /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_30Sample_4Event_5Chr_1Mb_low_mu.new7to9
  991  sbatch fastsimcoal2_10KNe_30S_4E_1Mb5Chr_low_mu.new7to9.sh
  992  squeue -u yzliu
  993  scancel 25540802
  994  sbatch fastsimcoal2_10KNe_30S_4E_1Mb5Chr_low_mu.new7to9.sh
  995  squeue -u yzliu
  996  ll /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_30Sample_4Event_5Chr_1Mb_low_mu.new7to9
  997  cd /home/yzliu/bin/stairway_plot_v2.1.2
  998  java -cp stairway_plot_es Stairbuilder two-epoch_fold.4Events30Samples5Chr1Mb_low_mu.new7to9.blueprint
  999  bash two-epoch_fold.4Events30Samples5Chr1Mb_low_mu.new7to9.blueprint.sh
 1000  cd /home/yzliu/DK_proj/scripts
 1001  sbatch fastsimcoal2_10KNe_30S_4E_1Mb5Chr_low_mu.new7to9.sh
 1002  squeue -u yzliu
 1003  cd /home/yzliu/bin/stairway_plot_v2.1.2
 1004  java -cp stairway_plot_es Stairbuilder two-epoch_fold.4Events30Samples5Chr1Mb_low_mu.new7to9.blueprint
 1005  bash two-epoch_fold.4Events30Samples5Chr1Mb_low_mu.new7to9.blueprint.sh
 1006  cd /home/yzliu/DK_proj/steps/fastsimcoal_test/fastsimcoal_simulation_10KNe_20Sample_2Event_200Chr_500Kb.neg
 1007  sed '1d' fastsimcoal_simulation_10KNe_20Sample_2Event_200Chr_500Kb.neg_1_1.gen |  cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c | head -15
 1008  sed '1d' fastsimcoal_simulation_10KNe_20Sample_2Event_200Chr_500Kb.neg_1_1.gen  cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c | head -15
 1009  sed '1d' fastsimcoal_simulation_10KNe_20Sample_2Event_200Chr_500Kb.neg_1_1.gen | cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c | head -15
 1010  sed '1d' fastsimcoal_simulation_10KNe_20Sample_2Event_200Chr_500Kb.neg_1_1.gen | cut --complement -f 1-4 | head
 1011  sed '1d' fastsimcoal_simulation_10KNe_20Sample_2Event_200Chr_500Kb.neg_1_1.gen | cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | head -15
 1012  sed '1d' fastsimcoal_simulation_10KNe_20Sample_2Event_200Chr_500Kb.neg_1_1.gen | cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1
 1013  sed '1d' fastsimcoal_simulation_10KNe_20Sample_2Event_200Chr_500Kb.neg_1_1.gen | cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1
 1014  sed '1d' fastsimcoal_simulation_10KNe_20Sample_2Event_200Chr_500Kb.neg_1_1.gen | cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""}1'
 1015  sed '1d' fastsimcoal_simulation_10KNe_20Sample_2Event_200Chr_500Kb.neg_1_1.gen | cut --complement -f 1-4 awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c \-d | awk '$1=$1' | cut -d ' ' -f 1 | tr '\n' ' '
 1016  sed '1d' fastsimcoal_simulation_10KNe_20Sample_2Event_200Chr_500Kb.neg_1_1.gen | cut --complement -f 1-4 | head
 1017  sed '1d' fastsimcoal_simulation_10KNe_20Sample_2Event_200Chr_500Kb.neg_1_1.gen | head
 1018  sed '1d' fastsimcoal_simulation_10KNe_20Sample_2Event_200Chr_500Kb.neg_1_1.gen | cut --complement -f 1-4 | head
 1019  sed '1d' fastsimcoal_simulation_10KNe_20Sample_2Event_200Chr_500Kb.neg_1_1.gen | cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' fastsimcoal_gen_new.txt | awk '{print $NF}' | sort -n | uniq -c \-d | awk '$1=$1' | cut -d ' ' -f 1 | tr '\n' ' '
 1020  sed '1d' fastsimcoal_simulation_10KNe_20Sample_2Event_200Chr_500Kb.neg_1_1.gen | cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c \-d | awk '$1=$1' | cut -d ' ' -f 1 | tr '\n' ' '
 1021  sed '1d' fastsimcoal_simulation_10KNe_20Sample_2Event_200Chr_500Kb.neg_1_1.gen | cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c \-d | awk '$1=$1' | cut ' ' -f 1 | tr '\n' ' '
 1022  sed '1d' fastsimcoal_simulation_10KNe_20Sample_2Event_200Chr_500Kb.neg_1_1.gen | cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c | awk '$1=$1' | cut ' ' -f 1 | tr '\n' ' '
 1023  cut --complement -f 1-4 fulation_10KNe_20Sample_2Event_200Chr_500Kb.neg_1_1.gen > fastsimcoal_gen.txt
 1024  head fulation_10KNe_20Sample_2Event_200Chr_500Kb.neg_1_1.gen
 1025  sed '1d' fastsimcoal_simulation_10KNe_20Sample_2Event_200Chr_500Kb.neg_1_1.gen |  cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c | head -15
 1026  sed '1d' fastsimcoal_simulation_10KNe_20Sample_2Event_200Chr_500Kb.neg_1_1.gen | cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c | head -15
 1027  sed '1d' fastsimcoal_simulation_10KNe_20Sample_2Event_200Chr_500Kb.neg_1_1.gen | cut --complement -f 1-4 | awk '{for(i=1;i<=NF;i++){NUM=NUM?NUM+$i:$i};$(NF+1)=NUM;NUM=""} 1' | awk '{print $NF}' | sort -n | uniq -c
 1028  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -h
 1029   squeue -u yzliu
 1030  cd ..
 1031  cd /home/yzliu/DK_proj/scripts
 1032  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -i fastsimcoal_simulation_10KNe_24Sample_1Event_10Chr_5Mb.new.par -n1 -q -s0 -d -k 1000000 -c 4
 1033  cd /home/yzliu/DK_proj/scripts
 1034  sbatch fastsimcoal2_10KNe_30S_2E_1Mb5Chr_high_mu.new7to9_1.sh
 1035   squeue -u yzliu
 1036  less -S /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_2Event_5Chr_1Mb_high_mu.new7to9_1.par
 1037  sbatch fastsimcoal2_10KNe_30S_2E_1Mb5Chr_high_mu.new7to9_1.sh
 1038   squeue -u yzliu
 1039  sbatch fastsimcoal2_10KNe_30S_2E_1Mb5Chr_high_mu.new7to9_1.sh
 1040   squeue -u yzliu
 1041  sbatch fastsimcoal2_10KNe_30S_2E_1Mb5Chr_high_mu.new7to9_2.sh
 1042   squeue -u yzliu
 1043  scancel 25586132
 1044  sbatch fastsimcoal2_10KNe_30S_2E_1Mb5Chr_high_mu.new7to9_2.sh
 1045   squeue -u yzliu
 1046  sbatch fastsimcoal2_10KNe_30S_2E_1Mb5Chr_high_mu.new7to9_2.sh
 1047   squeue -u yzliu
 1048  scancel 25590007
 1049  sbatch fastsimcoal2_10KNe_30S_2E_1Mb5Chr_high_mu.new7to9_2.sh
 1050  squeue -u yzliu
 1051  cd /home/yzliu/DK_proj/steps/fastsimcoal_test/
 1052  ls -l /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_24Sample_1Event_10Chr_5Mb.new
 1053  cd 
 1054  cd DK_proj/scripts/
 1055  sbatch *_high_mu.new7to9.sh
 1056  squeue -u yzliu
 1057  pwd
 1058  cd /home/yzliu/bin/stairway_plot_v2.1.2
 1059  java -cp stairway_plot_es/ Stairbuilder two-epoch_fold.4Events30Samples5Chr1Mb_high_mu.new7to9.blueprint 
 1060  bash two-epoch_fold.4Events30Samples5Chr1Mb_high_mu.new7to9.blueprint.sh
 1061  squeue -u yzliu
 1062  java -cp stairway_plot_es/ Stairbuilder two-epoch_fold.4Events30Samples5Chr1Mb_high_mu.new7to9.abs_size.blueprint
 1063  bash two-epoch_fold.4Events30Samples5Chr1Mb_high_mu.new7to9.abs_size.blueprint.sh
 1064  cd DK_proj/scripts/
 1065  cd ../DK_proj/scripts/
 1066  cd ~/DK_proj/scripts/
 1067  cd /home/yzliu/bin/stairway_plot_v2.1.2
 1068  java -cp stairway_plot_es/ Stairbuilder two-epoch_fold.4Events30Samples5Chr1Mb_high_mu.new7to9.abs_size.blueprint
 1069  bash two-epoch_fold.4Events30Samples5Chr1Mb_high_mu.new7to9.abs_size.blueprint.sh
 1070  java -cp stairway_plot_es/ Stairbuilder two-epoch_fold.4Events30Samples10Chr10Mb_high_mu.new7to9.abs_size.blueprint
 1071  bash two-epoch_fold.4Events30Samples10Chr10Mb_high_mu.new7to9.abs_size.blueprint.sh
 1072  java -cp stairway_plot_es/ Stairbuilder two-epoch_fold.4Events30Samples10Chr10Mb_high_mu.new7to9.abs_size.blueprint
 1073  bash two-epoch_fold.4Events30Samples10Chr10Mb_high_mu.new7to9.abs_size.blueprint.sh
 1074  java -cp stairway_plot_es/ Stairbuilder two-epoch_fold.4Events30Samples10Chr10Mb_high_mu.new7to9.abs_size--.blueprint
 1075  bash two-epoch_fold.4Events30Samples10Chr10Mb_high_mu.new7to9.abs_size--.blueprint.sh &
 1076  top
 1077  cd ~/DK_proj/scripts/
 1078  cd /home/yzliu/DK_proj/steps/fastsimcoal_test
 1079  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_2Event_5Chr_1Mb_high_mu.new10.par -n1 -q -s0 --foldedSFS -d -m -c 4 -G
 1080  cd ~/DK_proj/scripts/
 1081  sbatch fastsimcoal2_10KNe_30S_2E_1Mb5Chr_low_mu.new10.sh 
 1082  squeue -u yzliu
 1083  sbatch fastsimcoal2_10KNe_30S_2E_1Mb5Chr_low_mu.new10.sh 
 1084  cd /home/yzliu/bin/stairway_plot_v2.1.2
 1085  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -i /home/yzliu/DK_proj/two-epoch_fold.1Events24Samples1Chr1Mb.new3.blueprint -n1 -q -s0 --foldedSFS -d -m -c 4 -G
 1086  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -i /home/yzliu/bin/stairway_plot_v2.1.2/two-epoch_fold.1Events24Samples1Chr1Mb.new3.blueprint -n1 -q -s0 --foldedSFS -d -m -c 4 -G
 1087  java -cp stairway_plot_es/ Stairbuilder two-epoch_fold.1Events24Samples1Chr1Mb.new3.blueprint
 1088  bash two-epoch_fold.1Events24Samples1Chr1Mb.new3.blueprint.sh
 1089  java -cp stairway_plot_es/ Stairbuilder two-epoch_fold.2Events30Samples5Chr1Mb_high_mu.new7to9_1.blueprint
 1090  bash two-epoch_fold.2Events30Samples5Chr1Mb_high_mu.new7to9_1.blueprint.sh 
 1091  squeue -u yzliu
 1092  cd DK_proj/scripts/
 1093  sbatch fastsimcoal2_10KNe_30S_1E_1Mb5Chr_high_mu.new7to9_2.sh
 1094  squeue -u yzliu
 1095  sbatch fastsimcoal2_10KNe_30S_1E_1Mb5Chr_high_mu.new7to9_2.sh
 1096  squeue -u yzliu
 1097  sbatch fastsimcoal2_10KNe_30S_1E_1Mb5Chr_high_mu.new7to9_2.sh
 1098  squeue -u yzliu
 1099  sbatch fastsimcoal2_10KNe_30S_1E_1Mb5Chr_high_mu.new7to9_1.sh
 1100  sbatch fastsimcoal2_10KNe_30S_2E_1Mb5Chr_high_mu.new7to9_1.sh
 1101  squeue -u yzliu
 1102  sbatch fastsimcoal2_10KNe_30S_2E_1Mb5Chr_high_mu.new7to9_1.sh
 1103  squeue -u yzliu
 1104  scancel 25616407
 1105  sbatch fastsimcoal2_10KNe_30S_2E_1Mb5Chr_high_mu.new7to9_1.sh
 1106  squeue -u yzliu
 1107  sbatch fastsimcoal2_10KNe_30S_2E_1Mb5Chr_low_mu.new7to9_1.sh
 1108  squeue -u yzliu
 1109  cd ../../bin/stairway_plot_v2.1.2/
 1110  java -cp stairway_plot_es Stairbuilder two-epoch_fold.2Events30Samples5Chr1Mb_low_mu.new7to9_1.blueprint
 1111  bash two-epoch_fold.2Events30Samples5Chr1Mb_low_mu.new7to9_1.blueprint.sh
 1112  java -cp stairway_plot_es Stairbuilder two-epoch_fold.2Events30Samples5Chr1Mb_low_mu.new7to9_1.blueprint
 1113  srun -A eDNA --pty bash
 1114  srun -A eDNA -c 4 --time=06:00:00 --pty bash
 1115  java -cp stairway_plot_es Stairbuilder two-epoch_fold.3Events30Samples5Chr10Mb_high_mu.new7to9_11.blueprint
 1116  bash two-epoch_fold.3Events30Samples5Chr10Mb_high_mu.new7to9_11.blueprint.sh
 1117  java -cp stairway_plot_es Stairbuilder two-epoch_fold.3Events30Samples5Chr10Mb_high_mu.new7to9_11.blueprint
 1118  bash two-epoch_fold.3Events30Samples5Chr10Mb_high_mu.new7to9_11.blueprint.sh
 1119  sbatch --help
 1120  squeue -u yzliu
 1121  cd ~/DK_proj/scripts/
 1122  sbatch fastsimcoal2_10KNe_30S_4E_5Mb10Chr_high_mu.new7to9.abs_size----.sh 
 1123  squeue -u yzliu
 1124  tail fastsimcoal2_10KNe_30S_3E_10Mb5Chr_high_mu.new7to9_11.25642961.e.txt 
 1125  cd /home/yzliu/DK_proj/steps/fastsimcoal_test
 1126  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_1Event_5Chr_1Mb_high_mu.new7to9_2.par -n1 -q -s0 -d -c 4 -G
 1127  cd /home/yzliu/DK_proj/steps/fastsimcoal_test
 1128  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_1Event_5Chr_1Mb_high_mu.new7to9_2.par -n1 -q -s0 -d -c 4 -G
 1129  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_2Event_5Chr_1Mb_high_mu.new7to9_2.par -n1 -q -s0 -d -c 4 -G
 1130  cd /home/yzliu/DK_proj/scripts
 1131  cd /home/yzliu/DK_proj/steps/fastsimcoal_test
 1132  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_4Event_5Chr_1Mb_high_mu.new7to9.abs_size.par -n1 -q -s0 -d -c 4 -G
 1133  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_4Event_10Chr_10Mb_high_mu.new7to9.abs_size.par -n1 -q -s0 -d -c 4 -G
 1134  bash -h
 1135  bash --help
 1136  cd /home/yzliu/bin/stairway_plot_v2.1.2
 1137  java -cp stairway_plot_es/ Stairbuilder two-epoch_fold.4Events30Samples10Chr10Mb_high_mu.new7to9.abs_size-.blueprint 
 1138  bash two-epoch_fold.4Events30Samples10Chr10Mb_high_mu.new7to9.abs_size-.blueprint.sh &
 1139  cd DK_proj/scripts/
 1140  cd /home/yzliu/DK_proj/steps/fastsimcoal_test
 1141  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_24Sample_1Event_1Chr_1Mb.new3.par -n1 -q -s0 -d -k 1000000 -c 4 -G
 1142  ls
 1143  ls --help
 1144  ls -t
 1145  squeue -u yzliu
 1146  cd DK_proj/scripts/
 1147  cd ~/DK_proj/scripts/
 1148  sbatch fastsimcoal2_10KNe_30S_2E_1Mb5Chr_high_mu.new7to9_1.sh
 1149  squeue -u yzliu
 1150  scancel 25633987
 1151  sbatch fastsimcoal2_10KNe_30S_2E_1Mb5Chr_high_mu.new7to9_1.sh
 1152  squeue -u yzliu
 1153  sbatch fastsimcoal2_10KNe_30S_2E_1Mb5Chr_high_mu.new7to9_1.sh
 1154  squeue -u yzliu
 1155  sbatch fastsimcoal2_10KNe_30S_2E_1Mb5Chr_high_mu.new7to9_1.sh
 1156  sbatch fastsimcoal2_10KNe_30S_2E_1Mb5Chr_high_mu.new7to9_11.sh
 1157  squeue -u yzliu
 1158  sbatch fastsimcoal2_10KNe_30S_3E_1Mb5Chr_high_mu.new7to9_11.sh 
 1159  squeue -u yzliu
 1160  sbatch fastsimcoal2_10KNe_30S_3E_10Mb5Chr_high_mu.new7to9_11.sh 
 1161  squeue -u yzliu
 1162  sbatch fastsimcoal2_10KNe_30S_3E_10Mb5Chr_high_mu.new7to9_11.sh 
 1163  squeue -u yzliu
 1164  less -S fastsimcoal2_10KNe_30S_3E_10Mb5Chr_high_mu.new7to9_11.25642961.e.txt 
 1165  squeue -u yzliu
 1166  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_4Event_10Chr_10Mb_high_mu.new7to9.abs_size---.par -n1 -q -s0 -d --foldedSFS -c 4 -G
 1167  conda -h
 1168  conda install -c conda-forge msprime
 1169  conda -h
 1170  conda uninstall msprime
 1171  conda list
 1172  conda env -h
 1173  conda env list
 1174  conda -h
 1175  conda env -h
 1176  conda create -h
 1177  conda search msprime
 1178  conda create -h
 1179  conda create -n msprime -c conda-forge msprime -y
 1180  conda activate msprime
 1181  python
 1182  pip install svglib
 1183  pip install display
 1184  python
 1185  conda list
 1186  help('modules')
 1187  python
 1188  python --version
 1189  conda list
 1190  pip -V
 1191  conda -V
 1192  conda deactivate
 1193  conda list
 1194  conda env list
 1195  conda install -c conda-forge notebook -y
 1196  conda env list
 1197  conda list
 1198  conda activate bcftools
 1199  conda list
 1200  conda deactivate
 1201  conda create --name bioproject -c gwforg -c conda-forge -c bioconda -c kaspermunch slurm-jupyter gwf jupyterlab jupyterlab-git pandas seaborn biopython
 1202  conda activate bioproject
 1203  conda list
 1204  config-slurm-jupyter.sh
 1205  slurm-jupyter -C yzliu -A eDNA -e bioproject
 1206  slurm-jupyter -C -u yzliu -A eDNA -e bioproject
 1207  hostname
 1208  slurm-jupyter -C -u yzliu -A eDNA -e bioproject
 1209  screen -R persistentJupyterServer
 1210  echo $UID
 1211  ssh -L7699:s21n13:7699 yzliu@login.genome.au.dk
 1212  exit
 1213  srun --pty bash
 1214  q()
 1215  exit()
 1216  exit
 1217  ls
 1218  ll
 1219  ls -a
 1220  pwd
 1221  ls .local/
 1222  ls .local/share/jupyter/runtime/
 1223  less .local/share/jupyter/runtime/nbserver-2523577-open.html
 1224  ls .local/share/jupyter/runtime/
 1225  less .local/share/jupyter/runtime/nbserver-2550649-open.html 
 1226  ls .local/share/jupyter/runtime/
 1227  less .local/share/jupyter/runtime/nbserver-2759059-open.html 
 1228  ls
 1229  ls bin
 1230  conda activate bioproject
 1231  ls
 1232  conda activate msprime
 1233  ls
 1234  conda deactivate
 1235  conda search ipykernel
 1236  conda install -c conda-forge ipykernel
 1237  conda list
 1238  ls
 1239  python -V
 1240  conda activate bioproject
 1241  python -V
 1242  conda list
 1243  help('modules')
 1244  python
 1245  jupyter notebook
 1246  ssh yzliu@login.genome.au.dk
 1247  conda activate bioproject
 1248  pip install -U ipykernel
 1249  conda list
 1250  ls
 1251  conda env list
 1252  ll
 1253  pip uninstall ipynb
 1254  conda -e list
 1255  conda env list
 1256  conda activate bioproject
 1257  jupyter-notebook --no-browser --port=$UID --ip=0.0.0.0
 1258  conda deactivate
 1259  unset XDG_RUNTIME_DIR
 1260  conda activate bioproject
 1261  jupyter-notebook --no-browser --port=$UID --ip=0.0.0.0
 1262  conda activate bioproject
 1263  jupyter-notebook --no-browser --port=$UID --ip=0.0.0.0
 1264  conda activate bioproject
 1265  conda list
 1266  ls
 1267  ls
 1268  source activate msprime
 1269  jupyter-notebook --no-browser --port=$UID --ip=0.0.0.0
 1270  conda activate bioproject
 1271  jupyter-notebook --no-browser --port=$UID --ip=0.0.0.0
 1272  echo $UID
 1273  hostname
 1274  ssh -L7669:node:s21n13 yzliu@login.genome.au.dk
 1275  hostname -s
 1276  ssh -L7669:s21n13:7669 yzliu@login.genome.au.dk
 1277  source activate msprime
 1278  conda activate bioproject
 1279  jupyter-notebook --no-browser --port=$UID --ip=0.0.0.0
 1280  source activate msprime
 1281  jupyter kernelspec list
 1282  conda activate bioproject
 1283  jupyter kernelspec list
 1284  conda list
 1285  conda uninstall ipykernel
 1286  conda remove ipykernel
 1287  conda install ipykernel
 1288  conda -h
 1289  conda remove -all
 1290  conda remove --all
 1291  deactivate
 1292  conda deactivate
 1293  conda remove bioproject --all
 1294  conda remove -n bioproject --all
 1295  conda create --name bioproject -c gwforg -c conda-forge -c bioconda -c kaspermunch slurm-jupyter gwf jupyterlab jupyterlab-git pandas biopython ipykernel
 1296  conda activate bioproject
 1297  config-slurm-jupyter.sh
 1298  ls
 1299  conda env list
 1300  conda deactivate
 1301  conda create -n py_ipykernel
 1302  conda activate py_ipykernel
 1303  pip install ipykernel
 1304  py -m pip install --user --upgrade pip
 1305  python3 -m pip install --user --upgrade pip
 1306  conda list
 1307  ll
 1308  conda list
 1309  conda env list
 1310  pip install ipykernel
 1311  python3 -m pip --version
 1312  conda install pip python ipykernel
 1313  conda list
 1314  source activate msprime
 1315  conda activate bioproject
 1316  conda deactivate
 1317  conda env list
 1318  source activate msprime
 1319  conda -h
 1320  conda activate bioproject
 1321  conda env list
 1322  conda list
 1323  conda -h
 1324  conda info
 1325  conda list
 1326  conda -h
 1327  conda list
 1328  conda list | grep ipyker
 1329  conda search ipykernel
 1330  conda list | grep ipyker
 1331  conda list | grep pandas
 1332  conda list
 1333  conda list | grep svg
 1334  conda activate msprime
 1335  conda list | grep svg
 1336  python
 1337  conda search -c conda-forge svg
 1338  conda list
 1339  conda env list
 1340  conda activate bioproject
 1341  conda list
 1342  conda activate msprime
 1343  conda list
 1344  conda deactivate
 1345  conda install -c conda-forge msprime
 1346  conda search SVG
 1347  conda search svg.py
 1348  conda install -c conda-forge svg.py
 1349  conda install -c conda-forge ipython
 1350  jupyter-notebook --no-browser --port=$UID --ip=0.0.0.0
 1351  conda bioproject
 1352  conda activate bioproject
 1353  jupyter-notebook --no-browser --port=$UID --ip=0.0.0.0
 1354  conda activate bioproject
 1355  jupyter-notebook --no-browser --port=$UID --ip=0.0.0.0
 1356  source activate msprime
 1357  conda activate bioproject
 1358  conda install -c conda-forge tskit msprime numpy random math
 1359  conda list
 1360  ls
 1361  pwd
 1362  ls
 1363  conda remove msprime
 1364  conda activate msprime
 1365  conda remove msprime
 1366  conda deactivate
 1367  conda env list
 1368  conda remove --name msprime --all
 1369  conda env list
 1370  conda activate bioproject
 1371  conda list
 1372  source activate bioproject
 1373  cd DK_proj/scripts/msprime/
 1374  ls
 1375  tail -6 pop_sim_output_file_xx_hap.vcf
 1376  tail +6 pop_sim_output_file_xx_hap.vcf
 1377  head -n -2 pop_sim_output_file_xx_hap.vcf
 1378  head -n -2 pop_sim_output_file_xx_hap.vcf | head
 1379  head -n -6 pop_sim_output_file_xx_hap.vcf | head
 1380  he+6-n -6 pop_sim_output_file_xx_hap.vcf
 1381  ls
 1382  conda activate fastsimcoal
 1383  conda env list
 1384  conda list
 1385  conda env fastsimcoal2
 1386  conda env list
 1387  conda activate fastsimcoal2
 1388  fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_4Event_1Chr_1Mb_high_mu.new10.par -n1 -q -s0 -d -G
 1389  cd /home/yzliu/DK_proj/steps/fastsimcoal_test
 1390  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_4Event_5Chr_1Mb_high_mu.new10.par -n1 -q -s0 -d --foldedSFS -c 6 -G
 1391  cd /home/yzliu/DK_proj/scripts/
 1392  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal2_10KNe_30S_4E_1Mb5Chr_high_mu.new10.sh
 1393  squeue -u yzliu
 1394  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_4Event_5Chr_1Mb_high_mu.new10.par -n1 -q -s0 -d --foldedSFS -c 6 -G
 1395  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_4Event_1Chr_1Mb_high_mu.new10.par -n1 -q -s0 -d --foldedSFS -c 6 -G
 1396  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_4Event_1Chr_1Mb_high_mu.new10.par -n1 -q -s0 -d --foldedSFS -G
 1397  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_4Event_1Chr_1Mb_high_mu.new10.par -n1 -q -s0 -d --foldedSFS -G -c 4
 1398  source activate bioproject
 1399  cd DK_proj/scripts/
 1400  java -cp /bin/st /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_4Event_5Chr_1Mb_high_mu.new7to10.par
 1401  conda list
 1402  conda env list
 1403  conda activate fastsimcoal2
 1404  fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_4Event_5Chr_1Mb_high_mu.new7to10.par -n1 -q -s0 -d -c 4 -G
 1405  fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_4Event_5Chr_1Mb_high_mu.new7to10.par -n1 -q -s0 -d -G
 1406  fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_4Event_1Chr_1Mb_high_mu.new10.par -n1 -q -s0 -d -G
 1407  fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_4Event_1Chr_1Mb_high_mu.new10.par -n1 -q -s0 -d -G -c 4
 1408  fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_4Event_1Chr_1Mb_high_mu.new10.par -n1 -q -s0 -d -G -c 6
 1409  fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_4Event_1Chr_1Mb_high_mu.new10.par -n1 -q -s0 -d -G -c 8
 1410  fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_4Event_1Chr_1Mb_high_mu.new10.par -n1 -q -s0 -d -G -c 12
 1411  fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal_simulation_10KNe_30Sample_4Event_1Chr_1Mb_high_mu.new10.par -n1 -q -s0 -d -G -c 4
 1412  sbatch fastsimcoal2_10KNe_30S_4E_1Mb5Chr_high_mu.new10.sh 
 1413  squeue -u yzliu
 1414  sbatch fastsimcoal2_10KNe_30S_4E_1Mb5Chr_high_mu.new10.sh 
 1415  squeue -u yzliu
 1416  sbatch fastsimcoal2_10KNe_30S_4E_1Mb1Chr_high_mu.new10.sh 
 1417  sbatch fastsimcoal2_10KNe_30S_5E_1MbChr_high_mu.new10.sh 
 1418  squeue -u yzliu
 1419  sbatch fastsimcoal2_10KNe_30S_5E_1MbChr_high_mu.new10.sh 
 1420  squeue -u yzliu
 1421  conda search demesdraw
 1422  conda search matplotlib
 1423  squeue -u yzliu
 1424  sbatch fastsimcoal2_10KNe_30S_5E_1MbChr_high_mu.new10_long.sh
 1425  squeue -u yzliu
 1426  source activate bioproject
 1427  cd /home/yzliu/DK_proj/scripts/
 1428  srun -A eDNA --mem 16g --pty bash
 1429  conda activate bioproject
 1430  conda install -c cond-forge demesdraw matplotlib
 1431  conda install -c conda-forge demesdraw matplotlib
 1432  squeue -u yzliu
 1433  conda search ms
 1434  conda activate biporoject
 1435  conda activate bioproject
 1436  conda install -c bioconda ms
 1437  conda env list
 1438  conda env bioproject list
 1439  conda bioproject list
 1440  conda list
 1441  conda create --name ms -c bioconda ms
 1442  conda list
 1443  conda env list
 1444  conda activate ms
 1445  ms
 1446  ms 10 30 -t 4.0 -eN 0.2 .02
 1447  ms 15 1000 -t 6.4 -G 6.93 -eG 0.2 0.0 -eN 0.3 0.5
 1448  ms 5 2 -T
 1449  ms
 1450  ms 5 2 -T
 1451  ms 15 1000 -t 6.4 -G 6.93 -eG 0.2 0.0 -eN 0.3 0.5 -T
 1452  cd /home/yzliu/DK_proj/scripts/msprime
 1453  ll
 1454  ll --block-size m
 1455  ls -a
 1456  ls -a | grep ^.
 1457  ls -a | grep ^.[a-z]?
 1458  ls -a | grep ^.[a-z]+
 1459  ls -a | grep ^.[a-z]
 1460  ls -a | grep ^\.[a-z]
 1461  ls -a | grep ^\.
 1462  ls -a | grep ^[\.]
 1463  ls .
 1464  ls -a | grep ^[\.]
 1465  sbatch --help
 1466  cd /home/yzliu/DK_proj/steps/
 1467  mkdir systematic_ftsm_test
 1468  cd systematic_ftsm_test
 1469  cd /home/yzliu/DK_proj/scripts/
 1470  ls *long_time.sh
 1471  sbatch *long_time.sh
 1472  squeue -u yzliu
 1473  cd fastsimcoal/
 1474  rm *txt
 1475  cd para_test/
 1476  sbatch *.sh
 1477  squeue -u yzliu
 1478  sbatch *.sh
 1479  squeue -u yzliu
 1480  sbatch *.sh
 1481  squeue -u yzliu
 1482  nodes
 1483  gnode
 1484  gnodes
 1485  squeue -u yzliu
 1486  sbatch *200Kb.sh
 1487  sbatch fastsimcoal_simulation_100KNe_10S_3E_20D_30Chr_500Kb.sh 
 1488  ls *5Chr*.par
 1489  for i in `ls *5Chr*.par`;do cp $i-;done 
 1490  for i in `ls *5Chr*.par`;do cp $i- .;done 
 1491  for i in `ls *5Chr*.par`;do cp $i $i- .;done 
 1492  cp --help
 1493  touch xxxxxxxxx
 1494  cp xxxxxxxxx yyyyyy
 1495  for i in `ls *5Chr*.par`;do cp $i $i-;done 
 1496  for i in `ls *.par-`;do sed -e 's/5Chr/10Chr/g' -e 's/par-/par/g';done
 1497  for i in `ls *.par-`;do sed -e 's/5Chr/10Chr/g' -e 's/par-/par/g' $i;done
 1498  for i in `ls *.par-`;do sed 's/5Chr/10Chr/g' $i;done
 1499  sed --help
 1500  for i in `ls *.par-`;do sed -q 's/5Chr/10Chr/g' $i;done
 1501  for i in `ls *.par-`;do sed -n 's/5Chr/10Chr/g' $i;done
 1502  for i in `ls *.par-`;do sed -n 's/5Chr/10Chr/' $i;done
 1503  for i in `ls *.par-`;ls $i;done
 1504  for i in `ls *.par-`;do sed 's///' $i;done
 1505  for i in `ls *.par-`;do sed -e 's/*5Chr*/10Chr/g' -e 's/*par-$/par/g' $i;done
 1506  for i in `ls *.par-`;do sed -n -e 's/*5Chr*/10Chr/g' -e 's/*par-$/par/g' $i;done
 1507  for i in `ls *.par-`;do sed -n -e 's/*.5Chr.*/10Chr/g' -e 's/*.par-$/par/g' $i;done
 1508  for i in `ls *.par-`;do ls $i | sed -n -e 's/5Chr/10Chr/g' -e 's/par-/par/g';done
 1509  for i in `ls *.par-`;do ls $i;done
 1510  for i in `ls *.par-`;do ls $i | sed -n 's/5Chr/10Chr/g';done
 1511  rename --help
 1512  for i in `ls *.par-`;do rename 5Chr 10Chr ls $i;done
 1513  for i in `ls *.par-`;do rename par- par ls $i;done
 1514  for i in `ls ft_sim*.par`;do cp $i $i-;rename 20D 10D ls $i;done
 1515  for i in `ls *.par-`;do rename par- par ls $i;done
 1516  ls ft_* | wc -l
 1517  for i in `ls ft_sim*20D*.par`;do rename 20D 20DD ls $i;done
 1518  for i in `ls ft_sim*10D*.par`;do rename 10D 20D ls $i;done
 1519  for i in `ls ft_sim*20DD*.par`;do rename 20DD 10D ls $i;done
 1520  ls *.par
 1521  ls *.par | wc -l
 1522  for i in `ls *copy.par`;do rename 10D 50D ls $i;done
 1523  for i in `ls * copy.par`;do rename 10D 50D ls $i;done
 1524  for i in `ls *.copy.par`;do rename 10D 50D ls $i;done
 1525  ls *.copy.par
 1526  ls *copy.par
 1527  ls * copy.par
 1528  ls *.copy.par
 1529  ls *copy.par
 1530  for i in `ls *copy.par`;do rename 10D 50D ls $i;done
 1531  for i in `ls *Kb\scopy.par`;do rename 10D 50D ls $i;done
 1532  for i in `ls "*Kb\scopy.par"`;do rename 10D 50D ls $i;done
 1533  for i in `ls *copy.par`;do rename " copy" "" ls $i;done
 1534  for i in `ls *copy.par`;do rename ' copy' '' ls $i;done
 1535  for i in `ls *copy.par`;do ls $i;done
 1536  ls *.copy.par
 1537  ls *copy.par
 1538  for i in `ls *copy.par`;do rename ' ' '_' ls $i;done
 1539  for i in `ls *_copy.par`;do sed 's/\scopy/_copy/g' ls $i;done
 1540  rename 's/ /_/g' *
 1541  for f in *\ *; do mv "$f" "${f// /_}"; done
 1542  for i in `ls *_copy.par`;do rename 10D 50D ls $i;done
 1543  for i in `ls *_copy.par`;do rename '_copy' '' ls $i;done
 1544  ls ft_sim* | wc -l
 1545  for f in *\ *; do mv "$f" "${f// /_}"; done
 1546  for i in `ls *_copy.par`;do rename 1KNe 10KNe ls $i;done
 1547  for i in `ls *_copy.par`;do rename '_copy' '' ls $i;done
 1548  for i in `ls *10KNe*.par`; do sed -i '4s/1000/10000/g' $i
 1549  for i in `ls *10KNe*.par`; do sed -i '4s/1000/10000/g' $i;done
 1550  ls ft*.par | wc -l
 1551  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -h
 1552  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test/
 1553  ls $par_folder/*1Chr*.par
 1554  ls $par_folder/*1Chr*.par | wc -l
 1555  sbatch \home\yzliu\DK_proj\scripts\fastsimcoal\para_test\ft_sim_1_10KNe_10_80S_3E_10_20D_1Chr_200_2000Kb.sh
 1556  sbatch ft_sim_1_10KNe_10_80S_3E_10_20D_1Chr_200_2000Kb.sh
 1557  squeue -u yzliu
 1558  ls $par_folder/*1Chr*.par`
 1559  ls $par_folder/*1Chr*.par
 1560  sbatch ft_sim_1_10KNe_10_80S_3E_10_20D_1Chr_200_2000Kb.sh
 1561  squeue -u yzliu
 1562  ls $par_folder/*1Chr*.par
 1563  squeue -u yzliu
 1564  sbatch ft_sim_1_10KNe_10_80S_3E_10_20D_1Chr_200_2000Kb.sh
 1565  scancel 25854537
 1566  ls $par_folder/*1Chr*.par | sort
 1567  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test
 1568  ls $par_folder/*1Chr*.par | sort
 1569  ls $par_folder/*1Chr*.par | sort -n
 1570  sort --help
 1571  ls $par_folder/*1Chr*.par | sort -V
 1572  ls $par_folder/*1Chr*.par | sort -n
 1573  sbatch ft_sim_1_10KNe_10_80S_3E_10_20D_1Chr_200_2000Kb.sh
 1574  source activate bioproject
 1575  exit()
 1576  exit
 1577  source activate bioproject
 1578  cd /home/yzliu/DK_proj/steps/systematic_ftsm_test
 1579  ls
 1580  ll
 1581  ll /home/yzliu/DK_proj/steps/systematic_ftsm_test/ft_sim_1KNe_10S_3E_50D_1Chr_200Kb/garbage0
 1582  ll --block-size m /home/yzliu/DK_proj/steps/systematic_ftsm_test/ft_sim_1KNe_10S_3E_50D_1Chr_200Kb/garbage0
 1583  cd /home/yzliu/bin/stairway_plot_v2.1.2
 1584  blueprint_file=`ls fsc_fold*blueprint`
 1585  ls fsc_fold*blueprint
 1586  cd /home/yzliu/bin/stairway_plot_v2.1.2
 1587  blueprint_file=`ls fsc_fold*blueprint`
 1588  ## create a function to run blueprint file
 1589  run_blueprint(){     for file in $blueprint_file; do     java -cp stairway_plot_es Stairbuilder $file;     done; }
 1590  ## run the function and output **blueprint.sh files
 1591  run_blueprint
 1592  ls fsc_fold*blueprint
 1593  ll fsc_fold*blueprint
 1594  cd /home/yzliu/bin/stairway_plot_v2.1.2
 1595  blueprint_file=`ls fsc_fold*blueprint`
 1596  ## create a function to run blueprint file
 1597  run_blueprint(){     for file in $blueprint_file; do     java -cp stairway_plot_es Stairbuilder $file;     done; }
 1598  ## run the function and output **blueprint.sh files
 1599  run_blueprint
 1600  blueprint_sh=`ls fsc_fold*blueprint.sh`
 1601  stairway_plot(){     for file in $blueprint_sh; do     bash $file;     done; }
 1602  ## execute the function
 1603  stairway_plot
 1604  squeue -u yzliu
 1605  cd /home/yzliu/bin/stairway_plot_v2.1.2/systematic_ftsm_test/fsc_fold_1KNe_3E_20S_10D_1Chr_2000Kb
 1606  for i in `ls fsc_fold*`;do rename '3E' '3E_10D' ls $i;done
 1607  cd /home/yzliu/bin/stairway_plot_v2.1.2/systematic_ftsm_test/fsc_fold_1KNe_3E_20S_10D_1Chr_200Kb
 1608  for i in `ls fsc_fold*`;do rename '3E' '3E_10D' ls $i;done
 1609  cd /home/yzliu/bin/stairway_plot_v2.1.2/systematic_ftsm_test/fsc_fold_1KNe_3E_20S_10D_1Chr_200Kb
 1610  cd /home/yzliu/bin/stairway_plot_v2.1.2/systematic_ftsm_test/fsc_fold_1KNe_3E_20S_20D_1Chr_200Kb
 1611  for i in `ls fsc_fold*`;do rename '3E' '3E_10D' ls $i;done
 1612  for i in `ls fsc_fold*`;do rename '3E_10D' '3E_20D' ls $i;done
 1613  cd /home/yzliu/bin/stairway_plot_v2.1.2/systematic_ftsm_test/fsc_fold_1KNe_3E_10S_20D_1Chr_200Kb
 1614  for i in `ls fsc_fold*`;do rename '3E_10S' '3E_10S_20D' ls $i;done
 1615  cd /home/yzliu/bin/stairway_plot_v2.1.2/systematic_ftsm_test/fsc_fold_1KNe_3E_20S_20D_1Chr_200Kb
 1616  for i in `ls fsc_fold*`;do rename '3E_20D_20S' '3E_20S_20D' ls $i;done
 1617  cd /home/yzliu/bin/stairway_plot_v2.1.2/systematic_ftsm_test/fsc_fold_1KNe_3E_20S_10D_1Chr_2000Kb
 1618  for i in `ls fsc_fold*`;do rename '3E_10D_10D_20S' '3E_20S_10D' ls $i;done
 1619  squeue -u yzliu
 1620  conda env list
 1621  conda activate fastsimcoal2
 1622  fsc27093 -h
 1623  cd /home/yzliu/DK_proj/steps/systematic_ftsm_test
 1624  INPUT_NAMES=$(ls $par_folder/*1Chr*.par | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p
 1625  INPUT_NAMES=$(ls $par_folder/*1Chr*.par | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
 1626  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test
 1627  INPUT_NAMES=$(ls $par_folder/*1Chr*.par | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
 1628  echo $INPUT_NAMES 
 1629  echo $INPUT_NAMES | wc -l
 1630  echo $INPUT_NAMES | wc -c
 1631  ls $par_folder/*1Chr*.par | wc -l
 1632  ls $par_folder/*1Chr*.par | less -
 1633  ls $par_folder/*1Chr*.par | wc -l
 1634  cd /home/yzliu/DK_proj/scripts/fastsimcoal
 1635  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal/para_test/ft_sim_1_10KNe_10_80S_3E_10_20D_1Chr_200_2000Kb.sh
 1636  squeue -u yzliu
 1637  sbatch ft_sim_1_10KNe_10_80S_3E_10_20D_1Chr_200_2000Kb.sh
 1638  squeue -u yzliu
 1639  sbatch ft_sim_1_10KNe_10_80S_3E_10_20D_1Chr_200_2000Kb.sh
 1640  squeue -u yzliu
 1641  sbatch ft_sim_1_10KNe_10_80S_3E_10_20D_1Chr_200_2000Kb.sh
 1642  squeue -u yzliu
 1643  ls $par_folder/*5Chr*.par
 1644  ls $par_folder/*5Chr*.par | wc -l
 1645  squeue -u yzliu
 1646  sbatch ft_sim_1_10KNe_10_80S_3E_10_20D_5Chr_200_2000Kb.sh
 1647  cd para_test/
 1648  sbatch fastsimcoal_simulation_100KNe_10S_3E_20D_30Chr_500Kb
 1649  sbatch fastsimcoal_simulation_100KNe_10S_3E_20D_30Chr_500Kb.sh 
 1650  for i in `ls *_50D_*`;do cp $i $i-;done`
 1651  for i in `ls *_10D_*`;do cp $i $i-;done
 1652  for i in `ls *.par-`;do rename 50D 10D ls $i;done
 1653  for i in `ls *.par-`;do rename par- par ls $i;done
 1654  for i in `ls *10D*.par`; do sed -i -e '13s/100 0 0 0 20 0 0/100 0 0 0 10 0 0/' -e '14s/500 0 0 0 20 0 0/500 0 0 0 10 0 0/' -e '15s/15000 0 0 0 20 0 0/15000 0 0 0 10 0 0/' $i;done
 1655  for i in `ls *10D*.par`; do sed -i -e '13s/100 0 0 0 50 0 0/100 0 0 0 10 0 0/' -e '14s/500 0 0 0 50 0 0/500 0 0 0 10 0 0/' -e '15s/15000 0 0 0 50 0 0/15000 0 0 0 10 0 0/' $i;done
 1656  squeue -u yzliu
 1657  for i in `ls *_10D_*`;do rename Kb Kb_ ls $i;done
 1658  ls *Kb_* | wc -l
 1659  ls *10D* | wc -l
 1660  ls *20D* | wc -l
 1661  ls *50D* | wc -l
 1662  ls *20D* | wc -l
 1663  ls *20D*par | wc -l
 1664  ls *20D_1Chr*par | wc -l
 1665  squeue -u yzliu
 1666  scancel 25870403
 1667  ls $par_folder/*5Chr*.par | wc -l
 1668  ls $par_folder/*5Chr*.par
 1669  ls $par_folder/*1Chr*.par
 1670  ls $par_folder/*1Chr*.par | wc -l
 1671  ls $par_folder/ft*5Chr*.par
 1672  sbatch ft_sim_1_10KNe_10_80S_3E_10_20D_5Chr_200_2000Kb.sh
 1673  cd ..
 1674  sbatch ft_sim_1_10KNe_10_80S_3E_10_20D_5Chr_200_2000Kb.sh
 1675  sbatch ft_sim_1_10KNe_10_80S_3E_10_50D_5Chr_200_2000Kb.sh
 1676  ls $par_folder/ft*10D_1Chr*.par 
 1677  ls $par_folder/ft*10D_1Chr*.par |  wc -l
 1678  ls $par_folder/ft*10D_1Chr*_.par
 1679  sbatch ft_sim_1_10KNe_10_80S_3E_10D_1Chr_200_2000Kb.sh 
 1680  squeue -u yzliu
 1681  scancel 25879188
 1682  squeue -u yzliu
 1683  ls $par_folder/*1Chr*.par | wc -l
 1684  ls $par_folder/*1Chr*.par
 1685  ls $par_folder/*1Chr*.par | sort -n
 1686  ls $par_folder/*1Chr*.par | sort -V
 1687  sbatch ft_sim_1_10KNe_10_80S_3E_10D_1Chr_200_2000Kb.sh 
 1688  squeue -u yzliu
 1689  gdk-auth-show-qr
 1690  cd /home/yzliu/DK_proj/scripts/fastsimcoal
 1691  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -i /home/yzliu/DK_proj/scripts/fsc_sim_10KNe_30Sample_2Event_1Chr_200Kb_high_mu.par -n1 -q -s0 -d --foldedSFS -c 4 -G
 1692  less /home/yzliu/DK_proj/scripts/fsc_sim_10KNe_30Sample_2Event_1Chr_200Kb_high_mu.par
 1693  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal/fsc_sim_10KNe_30Sample_2Event_1Chr_200Kb_high_mu.par -n1 -q -s0 -d --foldedSFS -c 4 -G
 1694  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal/fsc_sim_10KNe_30Sample_2Event_1Chr_100Kb_high_mu.par -n1 -q -s0 -d --foldedSFS -c 4 -G
 1695  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -i /home/yzliu/DK_proj/scripts/fastsimcoal/fsc_sim_10KNe_30Sample_2Event_1Chr_10Kb_high_mu.par -n1 -q -s0 -d --foldedSFS -c 4 -G
 1696  conda activate bioproject
 1697  conda list
 1698  conda create plink -c bioconda plink -y
 1699  conda create -n plink -c bioconda plink -y
 1700  conda env list
 1701  conda activate plink
 1702  plink -h
 1703  plink --help
 1704  plink --help | grep recode
 1705  plink --help | less 
 1706  conda activate bioproject
 1707  conda search plink
 1708  conda env list
 1709  conda install -c bioconda plink -y
 1710  squeue -u yzliu
 1711  cd /home/yzliu/bin/stairway_plot_v2.1.2
 1712  file=/home/yzliu/bin/stairway_plot_v2.1.2/fsc_fold_1000KNe_4E_200S_1_10_50_90d_5Chr_1000Kb.blueprint
 1713  java -cp stairway_plot_es Stairbuilder $file
 1714  bash /home/yzliu/bin/stairway_plot_v2.1.2/fsc_fold_1000KNe_4E_200S_1_10_50_90d_5Chr_1000Kb.blueprint.sh
 1715  cd /home/yzliu/DK_proj/steps/systematic_fsc_test1
 1716  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 1717  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test1
 1718  ls $par_folder/ft*10Chr*.par | wc -l
 1719  squeue -u yzliu
 1720  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test1
 1721  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal/para_test1/ft_sim_100_1000_1000KNe_20_60_100_200S_4E_1_10_50_90d_5Chr_1000Kb.sh
 1722  scancel 25879386
 1723  squeue -u yzliu
 1724  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal/para_test1/ft_sim_100_1000_1000KNe_20_60_100_200S_4E_1_10_50_90d_10Chr_1000Kb.sh
 1725  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 1726  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test1
 1727  ls $par_folder/ft*5Chr*.par
 1728  ls $par_folder/ft*5Chr*.par | wc -l
 1729  ls *.par | wc -l
 1730  ls $par_folder/*.par | wc -l
 1731  ls $par_folder/ft*5Chr*.par | wc -l
 1732  cd /home/yzliu/DK_proj/steps/systematic_fsc_test1
 1733  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 1734  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test1
 1735  par=ft_sim_1000KNe_200S_4E_1_10_50_90d_5Chr_1000Kb.par
 1736  $fsc -i $par -n 1 -q -s 0 -d --foldedSFS -c 8 -G -k 10000000
 1737  par=$par_folder/ft_sim_1000KNe_200S_4E_1_10_50_90d_5Chr_1000Kb.par
 1738  $fsc -i $par -n 1 -q -s 0 -d --foldedSFS -c 8 -G -k 10000000
 1739  cd /crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon_bif_van/DB_VCF/merged_vcf_per_contig
 1740  squeue -u yzliu
 1741  squeue -u yzliu
 1742  cd /home/yzliu/bin/stairway_plot_v2.1.2
 1743  blueprint_file=`ls fsc_fold*5Chr_1000Kb.blueprint$`
 1744  blueprint_file=`ls fsc_fold*5Chr_1000Kb.blueprint`
 1745  echo $blueprint_file=
 1746  ls fsc_fold*5Chr_1000Kb.blueprint
 1747  blueprint_file=`ls fsc_fold*5Chr_1000Kb.blueprint`
 1748  ## create a function to run blueprint file
 1749  ## attention to nrand as integer
 1750  run_blueprint(){     for file in $blueprint_file; do     java -cp stairway_plot_es Stairbuilder $file;     done; }
 1751  ## run the function and output **blueprint.sh files
 1752  run_blueprint
 1753  ll fsc_fold*5Chr_1000Kb.blueprint.sh
 1754  sbatch /home/yzliu/bin/stairway_plot_v2.1.2/fsc2stairway.sh
 1755  squeue -u yzliu
 1756  scancel 26053595
 1757  run_blueprint
 1758  run_blueprint(){     for file in $blueprint_file; do     java -cp stairway_plot_es Stairbuilder $file;     done; }
 1759  run_blueprint
 1760  sbatch /home/yzliu/bin/stairway_plot_v2.1.2/fsc2stairway.sh
 1761  squeue -u yzliu
 1762  ls fsc_fold*5Chr_1000Kb.blueprint
 1763  scancel 26053651
 1764  blueprint_file=`ls fsc_fold*5Chr_1000Kb.blueprint`
 1765  ## create a function to run blueprint file
 1766  ## attention to nrand as integer
 1767  run_blueprint(){     for file in $blueprint_file; do     java -cp stairway_plot_es Stairbuilder $file;     done; }
 1768  ## run the function and output **blueprint.sh files
 1769  run_blueprint
 1770  sbatch /home/yzliu/bin/stairway_plot_v2.1.2/fsc2stairway.sh
 1771  squeue -u yzliu
 1772  scancel 26053880
 1773  sbatch /home/yzliu/bin/stairway_plot_v2.1.2/fsc2stairway.sh
 1774  squeue -u yzliu
 1775  sbatch /home/yzliu/bin/stairway_plot_v2.1.2/fsc2stairway.sh
 1776  squeue -u yzliu
 1777  jobs -p | wc -l
 1778  jobs -p
 1779  scancel 26060552
 1780  sbatch /home/yzliu/bin/stairway_plot_v2.1.2/fsc2stairway.sh
 1781  squeue -u yzliu
 1782  time
 1783  squeue -u yzliu
 1784  cd .
 1785  cd /home/yzliu/bin/stairway_plot_v2.1.2
 1786  ## current dir
 1787  blueprint_folder=.
 1788  ls $blueprint_folder/fsc_fold*5Chr_1000Kb.blueprint.sh
 1789  ls $blueprint_folder/fsc_fold*5Chr_1000Kb.blueprint.sh | sort -V
 1790  time echo 'Hello'
 1791  time sleep 10
 1792  squeue -u yzliu
 1793  less fsc2stairway_parallel.sh
 1794  cbatch fsc2stairway_parallel.sh
 1795  sbatch fsc2stairway_parallel.sh
 1796  squeue -u yzliu
 1797  ls fsc_fold*5Chr_1000Kb.blueprint.s
 1798  ls fsc_fold*5Chr_1000Kb.blueprint.sh
 1799  ls $blueprint_folder/fsc_fold*5Chr_1000Kb.blueprint.sh | sort -V
 1800  ls $blueprint_folder/fsc_fold*5Chr_1000Kb.blueprint.sh | sort -V | wc -l
 1801  ls $blueprint_folder/fsc_fold*5Chr_1000Kb.blueprint.sh | sort -V | less -N
 1802  squeue -u yzliu
 1803  scancel 26067050
 1804  sbatch fsc2stairway_parallel.sh
 1805  squeue -u yzliu
 1806  scancel 26067066
 1807  squeue -u yzliu
 1808  cd /home/yzliu/bin/stairway_plot_v2.1.2
 1809  blueprint_file=`ls fsc_fold*5Chr_1000Kb.blueprint`
 1810  ## create a function to run blueprint file
 1811  ## attention to nrand as integer
 1812  run_blueprint(){     for file in $blueprint_file; do     time java -cp stairway_plot_es Stairbuilder $file;     done; }
 1813  ## run the function and output **blueprint.sh files
 1814  #run_blueprint
 1815  ## make plot
 1816  blueprint_sh=`ls fsc_fold*5Chr_1000Kb.blueprint.sh`
 1817  blueprint_folder=.
 1818  ls $blueprint_folder/fsc_fold*5Chr_1000Kb.blueprint.sh | sort -V
 1819  ls fsc_fold*5Chr_1000Kb.blueprint
 1820  ls fsc_fold*5Chr_1000Kb.blueprint | sort -V
 1821  ls $blueprint_folder/fsc_fold*5Chr_1000Kb.blueprint.sh | sort -V
 1822  ls fsc_fold*5Chr_1000Kb.blueprint | sort -V | less -N
 1823  blueprint_sh=$(ls fsc_fold*5Chr_1000Kb.blueprint.sh | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
 1824  squeue -u yzliu
 1825  scancel 25877589
 1826  squeue -u yzliu
 1827  ls fsc_fold_1000Kb*5Chr_1000Kb.blueprint
 1828  ls fsc_fold_1000K*5Chr_1000Kb.blueprint
 1829  ls fsc_fold_1000K*5Chr_1000Kb.blueprint | sort -V
 1830  ls fsc_fold_1000K*5Chr_1000Kb.blueprint | sort -V | head -3
 1831  blueprint_file=`ls fsc_fold_1000K*5Chr_1000Kb.blueprint | sort -V | head -3`
 1832  run_blueprint(){     for file in $blueprint_file; do     time java -cp stairway_plot_es Stairbuilder $file;     done; }
 1833  ## run the function and output **blueprint.sh files
 1834  run_blueprint
 1835  cd /home/yzliu/DK_proj/steps/systematic_fsc_test1
 1836  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 1837  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test1
 1838  ls $par_folder/ft*5Chr*.par | sort -V
 1839  ls $par_folder/ft*5Chr*.par | sort -V | less -N
 1840  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test1/
 1841  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal/para_test1/ft_sim_100_1000_1000KNe_20_60_100_200S_4E_1_10_50_90d_5Chr_1000Kb_100S.sh
 1842  blueprint_file=`ls fsc_fold_100*5Chr_1000Kb.blueprint | sort -V | head -3`
 1843  ls $blueprint_folder/fsc_fold*5Chr_1000Kb.blueprint.sh | sort -V
 1844  cd /home/yzliu/bin/stairway_plot_v2.1.2
 1845  ## current dir
 1846  blueprint_folder=.
 1847  ls $blueprint_folder/fsc_fold*5Chr_1000Kb.blueprint.sh | sort -V
 1848  squeue -u yzliu
 1849  ls $par_folder/ft*5Chr*.par | sort -V | less -N
 1850  scancel 26150456
 1851  cd /home/yzliu/DK_proj/steps/systematic_fsc_test1
 1852  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 1853  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test2
 1854  ls $par_folder/ft*10000Chr*.par | sort -V
 1855  for i in `ls ft_sim*1E_*10000Chr_1000b.par`;do rename 1E 1E_50G $i;done
 1856  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test2
 1857  for i in `ls ft_sim*1E_*10000Chr_1000b.par`;do rename 1E 1E_50G $i;done
 1858  for i in `ls ft_sim*1E_*10000Chr_1000b.par`;do rename 1E_50G_100G 1E_100G $i;done
 1859  for i in `ls ft_sim*1E_100G*10000Chr_1000b.par`;do copy $i $i_;done
 1860  for i in `ls ft_sim*1E_100G*10000Chr_1000b.par`;do cp $i $i_;done
 1861  ls $par_folder/ft*1E_100G*10000Chr*.par | sort -V
 1862  for i in `ls ft_sim*1E_100G*10000Chr_1000b.par`;do cp $i ./$i_;done
 1863  for i in `ls ft_sim*1E_100G*10000Chr_1000b.par`;do cp $i ./"$i-";done
 1864  for i in `ls ft_sim*1E_*10000Chr_1000b.par-`;do rename 1E_100G 1E_500G $i;done
 1865  for i in `ls ft_sim*1E_*10000Chr_1000b.par-`;do rename par- par $i;done
 1866  ls ft_sim*1E_*10000Chr_1000b.par | sort -V
 1867  for i in `ft_sim*1E_*10000Chr_1000b.par | sort -V`;do cp $i ./"$i-";done
 1868  less ft_sim_100Ne_100S_1E_100G_10d_10000Chr_1000b.par:
 1869  ft_sim*1E_*10000Chr_1000b.par | sort -V
 1870  ls *100S_1E_100G_10d*
 1871  less ft_sim_100Ne_100S_1E_100G_10d_10000Chr_1000b.par
 1872  ft_sim*1E_*10000Chr_1000b.par | sort -V
 1873  less /home/yzliu/DK_proj/scripts/fastsimcoal/para_test2/ft_sim_100Ne_100S_1E_100G_10d_10000Chr_1000b.par
 1874  for i in `ft_sim*1E_*10000Chr_1000b.par | sort -V`;do cp $i ./"$i-";done
 1875  for i in `ls ft_sim*1E_*10000Chr_1000b.par | sort -V`;do cp $i ./"$i-";done
 1876  for i in `ls ft_sim*1E_*10000Chr_1000b.par-`;do rename 100Ne 1000KNe $i;done
 1877  for i in `ls ft_sim*1E_*10000Chr_1000b.par-`;do rename par- par $i;done
 1878  for i in `ls ft_sim*100Ne*1E_*10000Chr_1000b.par | sort -V`;do sed -i '4s/1000000/1000/g' $i;done
 1879  for i in `ls ft_sim*100Ne*1E_*10000Chr_1000b.par | sort -V`;do sed -i '4s/1000/100/g' $i;done
 1880  for i in `ls ft_sim*100Ne*1E_*10000Chr_1000b.par | sort -V`;do cp $i ./"$i-";done
 1881  for i in `ls ft_sim*100Ne*100Ne*1E_*10000Chr_1000b.par- | sort -V`;do sed -i '4s/100/1000/g' $i;done
 1882  for i in `ls ft_sim*100Ne*1E_*10000Chr_1000b.par- | sort -V`;do sed -i '4s/100/1000/g' $i;done
 1883  for i in `ls ft_sim*100Ne*1E_*10000Chr_1000b.par-`;do rename 100Ne 1000Ne $i;done
 1884  for i in `ls ft_sim*100Ne*1E_*10000Chr_1000b.par-`;do rename par- par $i;done
 1885  for i in `ls ft_sim*1000Ne*1E_*10000Chr_1000b.par-`;do rename par- par $i;done
 1886  ls $par_folder/ft_sim*100Ne*1E_*10000Chr_1000b.par
 1887  ls $par_folder/ft_sim*100Ne*1E_*10000Chr_1000b.par | wc -l
 1888  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal/para_test2/ft_sim_100Ne_20_60_100_200S_1E_1d_10000Chr_1000b.sh
 1889  squeue -u yzliu
 1890  scancel 26197137
 1891  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal/para_test2/ft_sim_100Ne_20_60_100_200S_1E_1d_10000Chr_1000b.sh
 1892  ls $par_folder/ft_sim*1000Ne*1E_*10000Chr_1000b.par | sort -V | wc -l
 1893  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal/para_test2/ft_sim_1000Ne_20_60_100_200S_1E_1d_10000Chr_1000b.sh
 1894  squeue -u yzliu
 1895  cd /home/yzliu/DK_proj/steps/systematic_fsc_test2
 1896  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 1897  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test2
 1898  ## test par
 1899  ls $par_folder/ft_sim*1000Ne*1E_*10000Chr_1300b.par
 1900  ls $par_folder/ft_sim*1000Ne*1E_*10000Chr_1500b.par
 1901  ls $par_folder/ft_sim*Ne*1E_*10000Chr_1500b.par
 1902  ls $par_folder/ft_sim*Ne*1E_*170000Chr_1500b.par
 1903  par=`ls $par_folder/ft_sim*Ne*1E_*170000Chr_1500b.par`
 1904  ls $par_folder/ft_sim*Ne*1E_*170000Chr_1500b.par | sort -V
 1905  par=`ls $par_folder/ft_sim*Ne*1E_*170000Chr_1500b.par sort -V`
 1906  par=`ls $par_folder/ft_sim*Ne*1E_*170000Chr_1500b.par | sort -V`
 1907  for i in $par;do $fsc -i $par -n 1 -q -s 0 -d --foldedSFS -c 8 -G -k 10000000;done
 1908  for par_file in $par;do $fsc -i $par_file -n 1 -q -s 0 -d --foldedSFS -c 8 -G -k 10000000;done
 1909  cd /home/yzliu/DK_proj/steps/systematic_fsc_test2
 1910  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 1911  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test2
 1912  par=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test2/ft_sim_1000Ne_20S_1E_50G_1d_10000Chr_10Kb.par
 1913  $fsc -i $par -n 1 -q -s 0 -d --foldedSFS -c 8 -G -k 10000000
 1914  par=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test2/ft_sim_1000Ne_20S_1E_50G_1d_100000Chr_10Kb.par
 1915  $fsc -i $par -n 1 -q -s 0 -d --foldedSFS -c 8 -G -k 10000000
 1916  par=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test2/ft_sim_1000Ne_20S_1E_50G_1d_20Chr_13000Kb.par
 1917  $fsc -i $par -n 1 -q -s 0 -d --foldedSFS -c 8 -G -k 10000000
 1918  par=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test2/ft_sim_1000Ne_20S_1E_500G_1d_20Chr_13000Kb.par
 1919  $fsc -i $par -n 1 -q -s 0 -d --foldedSFS -c 8 -G -k 10000000
 1920  par=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test2/ft_sim_1000Ne_60S_1E_500G_1d_20Chr_13000Kb.par
 1921  $fsc -i $par -n 1 -q -s 0 -d --foldedSFS -c 8 -G -k 10000000
 1922  par=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test2/ft_sim_1000Ne_60S_1E_500G_1d_40Chr_1300Kb.par
 1923  $fsc -i $par -n 1 -q -s 0 -d --foldedSFS -c 8 -G -k 10000000
 1924  par=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test2/ft_sim_1000Ne_60S_1E_500G_1d_170000Chr_1500b.par
 1925  $fsc -i $par -n 1 -q -s 0 -d --foldedSFS -c 8 -G -k 10000000
 1926  cd /home/yzliu/bin/stairway_plot_v2.1.2
 1927  ## current dir
 1928  blueprint_folder=.
 1929  blueprint_plot_sh=/home/yzliu/bin/stairway_plot_v2.1.2/fsc_fold_1000Ne_1E_60S_1d_170000Chr_1500b.blueprint
 1930  file=/home/yzliu/bin/stairway_plot_v2.1.2/fsc_fold_1000Ne_1E_60S_1d_170000Chr_1500b.blueprint
 1931  time java -cp stairway_plot_es Stairbuilder $file
 1932  blueprint_plot_sh=/home/yzliu/bin/stairway_plot_v2.1.2/fsc_fold_1000Ne_1E_60S_1d_170000Chr_1500b.blueprint.sh 
 1933  time bash $blueprint_plot_sh
 1934  blueprint_plot_sh=/home/yzliu/bin/stairway_plot_v2.1.2/fsc_fold_100Ne_1E_500G_60S_5d_170000Chr_1500b.blueprint 
 1935  time java -cp stairway_plot_es Stairbuilder $blueprint_plot_sh
 1936  blueprint_plot_sh=/home/yzliu/bin/stairway_plot_v2.1.2/fsc_fold_100Ne_1E_500G_60S_5d_170000Chr_1500b.blueprint.sh 
 1937  time bash $blueprint_plot_sh
 1938  conda search VCF-Simplify
 1939  ls
 1940  cd bin
 1941  ls
 1942  git clone https://github.com/everestial/VCF-Simplify
 1943  cd VCF-Simplify
 1944  ls
 1945  cd ..
 1946  ll
 1947  cd VCF-Simplify
 1948  ls
 1949  python3 VcfSimplify.py -h
 1950  python3 VcfSimplify.py BuildVCF -h
 1951  cd /home/yzliu/DK_proj/steps/systematic_fsc_test2
 1952  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 1953  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test2
 1954  ## test par
 1955  $fsc -h
 1956  par=ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb.par
 1957  $fsc -i $par -n 1 -q -s 0 -d --foldedSFS -c 8 -G -k 10000000
 1958  $fsc -i $par_folder/$par -n 1 -q -s 0 -d --foldedSFS -c 8 -G -k 10000000
 1959  $fsc -i $par_folder/$par -n 1 -q -s 0 -d --foldedSFS -c 8 -g -G -k 10000000
 1960  par=ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_10Kb.par
 1961  $fsc -i $par_folder/$par -n 1 -q -s 0 -d --foldedSFS -c 8 -g -G -k 10000000
 1962  par=ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb.par
 1963  $fsc -i $par_folder/$par -n 1 -q -s 0 -d --foldedSFS -c 8 -g -G -k 10000000
 1964  awk '{ for (i = 5; i <= NF; i++) { if ($i == 0) { $i = 0/0; } else if ($i == 1) { $i = 1/1; } else {$i==0/1}} } 1' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen | head
 1965  awk '{ for (i = 5; i <= NF; i++;FNR>=2) { if ($i == 0) { $i = 0/0; } else if ($i == 1) { $i = 1/1; } else {$i==0/1}} } 1' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen | head
 1966  awk '{ for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i=="0/1"}} } 1' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen | head
 1967  awk '{ for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i=="0/1"}} } 1' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen
 1968  awk '{ for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i=="0/1"}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen
 1969  awk '{ for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i=="0/1"} } } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen
 1970  awk '{ for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else if ($i==2) {$i=="0/1"}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen
 1971  awk '{ for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else if ($i==2) {$i=="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen
 1972  awk '{ for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i=="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen
 1973  awk '{ for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen
 1974  awk '{ for (i = 5; i <= NF; i++;NFR>=2) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen
 1975  awk '{ for (i = 5; i <= NF; i++) { if ($i == 0 && NFR >= 2) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen
 1976  awk '{for (NFR>=2) {print}}'/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen
 1977  awk '{for (NFR>=2) {print}}' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen
 1978  awk 'for (NFR>=2) {print}' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen
 1979  awk 'NR >=2 { for (i = 5; i <= NF; i++;NFR>=2) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen
 1980  awk 'FNR >=2 { for (i = 5; i <= NF; i++;NFR>=2) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen
 1981  awk 'FNR >=2 && { for (i = 5; i <= NF; i++;NFR>=2) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen
 1982  awk 'NR >1 { for (i = 5; i <= NF; i++;NFR>=2) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen
 1983  awk 'FNR!=1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen | head
 1984  awk 'NR >1 { for (i = 5; i <= NF; i++;) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen
 1985  awk '{ for (i = 5; i <= NF; i++;) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen | head
 1986  awk '{ for (i = 5; i <= NF; i++) { if ($i == 0 && NFR >= 2) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen
 1987  awk '{ for (i = 5; i <= NF; i++;) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen | head
 1988  awk '{ for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen
 1989  awk '{ for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen | head
 1990  awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen | head
 1991  awk 'NR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen | head
 1992  awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen /home/yzliu/DK_proj/steps/system
 1993  awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen > /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen
 1994  awk 'NR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen | sed 's/\s/\t/g' | head
 1995  awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen | sed 's/\s/\t/g' > /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen
 1996  awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen | sed -e 's/Chrom/#Chrom/' -e 's/\s/\t/g' > /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen
 1997  awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.gen | sed -e 's/Chrom/#Chrom/' -e 's/\s/\t/g' > /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen
 1998  conda env list
 1999  conda activate plink
 2000  plink -h
 2001  plink recode -h
 2002  vcf=ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.vcf
 2003  vcf=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.vcf
 2004  plink --vcf $vcf --recode
 2005  vcf2=/home/yzliu/DK_proj/scripts/msprime/one_pop_msprime_sim_output_file.vcf
 2006  plink --vcf $vcf2 --recode
 2007  cd /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb
 2008  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | head
 2009  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk '{print $1,$2,".",$3,$4}' | head
 2010  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{print $1,$2,".",$3,$4}' | head
 2011  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$4 = "." OFS $4}' | head
 2012  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$4 = "." OFS $4}1' | head
 2013  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS "."}1' | head
 2014  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS "." "."}1' | head
 2015  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS ".","."}1' | head
 2016  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS ".";$4=$4 OFS "."}1' | head
 2017  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS ".";$4=$4 OFS ".";$5=$5 OFS ".";$5=$6 OFS "."}1' | head
 2018  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "."}1' | head
 2019  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "."}1' | sed -i.back '1i CHROM\tPOS\tID\tANC\tDER\tQUAL\tFILTER\tINFO\tFORMAT' | head
 2020  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "."}1' | sed '1i CHROM\tPOS\tID\tANC\tDER\tQUAL\tFILTER\tINFO\tFORMAT' | head
 2021  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "."}1' | sed '1i CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT' | head
 2022  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "."}1' | sed '1i CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' | head
 2023  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "."}1' | sed '1i CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' > ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.vcf
 2024  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "."}1' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' > ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.vcf
 2025  cat vcf_headers.txt ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.vcf > ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final.vcf
 2026  vcf2=ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final.vcf
 2027  plink --vcf $vcf2 --recode
 2028  plink --vcf $vcf2 --recode --id-delim
 2029  plink --vcf $vcf2 --recode --double-id
 2030  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "."}1' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' > ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.vcf
 2031  plink --vcf $vcf2 --recode --double-id
 2032  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' > ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.vcf
 2033  plink --vcf $vcf2 --recode --double-id
 2034  cat vcf_headers.txt ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.vcf > ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final.vcf
 2035  plink --vcf $vcf2 --recode --double-id
 2036  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS ++cnt[$2];$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' > ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.vcf
 2037  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS ++cnt[$2];$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | head
 2038  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS ++cnt[$1];$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | head
 2039  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS "++cnt[$1]";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | head
 2040  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{print $2 = $2 OFS "++cnt[$1]";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | head
 2041  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{print $2 = $2 OFS ++cnt[$1];$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | head
 2042  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{print $2 = $2 OFS ++cnt[$1]}1' | head
 2043  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{print $2 = $2 OFS ++cnt[$1]}' | head
 2044  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{print $2 = $2 OFS ++cnt[$2]}' | head
 2045  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{print $1 ++cnt[$2]}' | head
 2046  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{print $1 ++cnt[$1]}' | head
 2047  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{print $1 ++cnt[$1],$2}' | head
 2048  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{print $1, ++cnt[$1],$2}' | head
 2049  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | awk 'BEGIN{OFS="\t"}{print $1, ++cnt[$1],$2}' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' > ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.vcf
 2050  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | awk 'BEGIN{OFS="\t"}{$1=$1 OFS ++cnt[$1]}' | head
 2051  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | awk 'BEGIN{OFS="\t"}{$1=$1 OFS ++cnt[$1]}'
 2052  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS ++cnt[$2];$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | head
 2053  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS '++cnt[$2]';$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | head
 2054  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | head
 2055  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$4=$4 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | awk ' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' > ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.vcf
 2056  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "."}1' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' > ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.vcf
 2057  cat vcf_headers.txt ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.vcf > ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final.vcf
 2058  plink --vcf $vcf2 --recode --double-id
 2059  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "."}1' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' | sed '$d'> ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.vcf
 2060  plink --vcf $vcf2 --recode --double-id
 2061  cat vcf_headers.txt ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.vcf > ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final.vcf
 2062  plink --vcf $vcf2 --recode --double-id
 2063  sed '1d' ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' | sed '$d'> ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.vcf
 2064  cat vcf_headers.txt ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.vcf > ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final.vcf
 2065  plink --vcf $vcf2 --recode --double-id
 2066  conda activate plink
 2067  ls
 2068  plink -h
 2069  plink --help | more
 2070  cd /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/
 2071  vcf=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final.vcf
 2072  plink --vcf $vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 10 0.1 --out ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final
 2073  plink --vcf $vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --extract ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final.prune.in --out ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final.pruned
 2074  plink --vcf $vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --extract ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final.prune.in --out ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final.pruned --make-bed
 2075  plink --vcf $vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 10 0.1 --out ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01
 2076  plink --vcf $vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 10 0.5 --out ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld05
 2077  plink --vcf $vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --extract ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final.prune.in --out ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01.pruned --make-bed
 2078  plink --vcf $vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --extract ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01.prune.in --out ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01.pruned --make-bed
 2079  plink --vcf $vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --extract ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01.prune.in --out ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01.pruned --recode 
 2080  plink --vcf $vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --extract ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01.prune.in --out ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01.pruned --recode vcf
 2081  plink --vcf $vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --extract ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01.prune.in --out ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01.pruned_order --keep-allele-order --recode vcf
 2082  plink --help | more
 2083  plink --vcf $vcf --allow-extra-chr --set-missing-var-ids @:# --extract ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01.prune.in --out ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01.pruned_order1 --keep-allele-order --recode vcf
 2084  plink --vcf $vcf --no-fid --allow-extra-chr --set-missing-var-ids @:# --extract ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01.prune.in --out ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01.pruned_order1 --keep-allele-order --recode vcf
 2085  plink --vcf $vcf --id-delim ' ' --allow-extra-chr --set-missing-var-ids @:# --extract ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01.prune.in --out ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01.pruned_order1 --keep-allele-order --recode vcf
 2086  cd 
 2087  cd bin
 2088  ls
 2089  git clone https://github.com/isaacovercast/easySFS.git
 2090  ls
 2091  cd easySFS/
 2092  ls
 2093  pwd
 2094  easySFS.py
 2095  less easySFS.py
 2096  python easySFS.py
 2097  py easySFS.py
 2098  conda activate bioproject
 2099  conda create -n bcftools -c conda-forge bcftools -y
 2100  echo "12:23:11" | awk '{split($0,a,":"); print a[3] a[2] a[1]}'
 2101  echo "12|23|11" | awk '{split($0,a,"|"); print a[3],a[2],a[1]}'
 2102  bcftools -h
 2103  conda activate bcftools
 2104  bcftools -h
 2105  cd /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/
 2106  bcftools query -h
 2107  vcf=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01.pruned_order.vcf
 2108  bcftools query -l $vcf
 2109  bcftools query -l $vcf | grep 'G_1' 
 2110  bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1}'
 2111  bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print a[1]}'
 2112  bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1}'
 2113  bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1}' > pop_file
 2114  /home/yzliu/bin/easySFS/easySFS.py -h
 2115  /home/yzliu/bin/easySFS/easySFS.py
 2116  py /home/yzliu/bin/easySFS/easySFS.py
 2117  conda activate bioproject
 2118  py /home/yzliu/bin/easySFS/easySFS.py
 2119  /home/yzliu/bin/easySFS/easySFS.py
 2120  /home/yzliu/bin/easySFS/easySFS.py -i $vcf -p pop_file -a -f --preview
 2121  bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1,"G"}' > pop_file
 2122  conda activate bcftools
 2123  bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1,"G"}' > pop_file
 2124  bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1,"G"}'
 2125  conda activate bioproject
 2126  /home/yzliu/bin/easySFS/easySFS.py -i $vcf -p pop_file -a -f --preview
 2127  /home/yzliu/bin/easySFS/easySFS.py -h
 2128  /home/yzliu/bin/easySFS/easySFS.py -i $vcf -p pop_file -a -f --proj 10,10
 2129  /home/yzliu/bin/easySFS/easySFS.py -i $vcf -p pop_file -a -f --proj 1,1
 2130  /home/yzliu/bin/easySFS/easySFS.py -i $vcf -p pop_file -a -f
 2131  /home/yzliu/bin/easySFS/easySFS.py -i $vcf -p pop_file -a -f --proj 5,5
 2132  /home/yzliu/bin/easySFS/easySFS.py -i $vcf -p pop_file -a -f --proj 20,32
 2133  /home/yzliu/bin/easySFS/easySFS.py -i $vcf -p pop_file -a -f --proj 20
 2134  conda install -n my_project rstudio
 2135  conda install -n bioproject rstudio
 2136  conda activate bioproject 
 2137  rstudio
 2138  conda list
 2139  conda install -h
 2140  conda install -n bioproject rstudio
 2141  rstudio
 2142  r
 2143  conda list
 2144  conda env list
 2145  conda create -n rstudio -c conda-forge rstudio
 2146  conda deactivate
 2147  conda create -n rstudio -c conda-forge rstudio
 2148  conda search rstudio-desktop
 2149  conda create -n rstudio -c conda-forge rstudio-desktop
 2150  conda activate rstudio
 2151  r
 2152  list.file() list.file()
 2153  rstudio
 2154  conda search r
 2155  conda install -h
 2156  conda install -n rstudio r
 2157  conda list
 2158  rstudio
 2159  conda create -n R -c conda-forge r
 2160  conda activate R  
 2161  conda install -n R rstudio-desktop
 2162  conda list
 2163  conda env list
 2164  ls /home/yzliu/miniforge3/envs/R
 2165  ls /home/yzliu/miniforge3/envs/R/bin
 2166  # get quantile threshshold
 2167  #https://stats.stackexchange.com/questions/13399/calculating-the-95th-percentile-comparing-normal-distribution-r-quantile-and
 2168  getwd() getwd()
 2169  # get quantile threshshold
 2170  #https://stats.stackexchange.com/questions/13399/calculating-the-95th-percentile-comparing-normal-distribution-r-quantile-and
 2171  getwd() setwd("/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon_bif_van/DB_VCF/merged_vcf_per_contig/stats")
 2172  # get quantile threshshold
 2173  #https://stats.stackexchange.com/questions/13399/calculating-the-95th-percentile-comparing-normal-distribution-r-quantile-and
 2174  getwd() setwd("/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon_bif_van/DB_VCF/merged_vcf_per_contig/stats")
 2175  # get quantile threshshold
 2176  #https://stats.stackexchange.com/questions/13399/calculating-the-95th-percentile-comparing-normal-distribution-r-quantile-and
 2177  getwd()
 2178  conda list
 2179  conda env list
 2180  conda activate R
 2181  conda list
 2182  conda activate r
 2183  conda env list
 2184  conda activate R
 2185  r
 2186  sudo apt update
 2187  apt update
 2188  install r-base
 2189  r
 2190  R
 2191  conda env list
 2192  /home/yzliu/miniforge3/envs/R/bin/R
 2193  conda install -c conda-forge radian -y
 2194  conda evn list
 2195  conda env list
 2196  conda list
 2197  radiant
 2198  which radiant
 2199  ls
 2200  R
 2201  conda activate R
 2202  R
 2203  conda env list
 2204  conda activate rstudio
 2205  rstudio
 2206  srun --mem=4g -c 1 --time=01:0:0 --pty bash
 2207  # get quantile threshshold
 2208  #https://stats.stackexchange.com/questions/13399/calculating-the-95th-percentile-comparing-normal-distribution-r-quantile-and
 2209  getwd() getwd()
 2210  # get quantile threshshold
 2211  #https://stats.stackexchange.com/questions/13399/calculating-the-95th-percentile-comparing-normal-distribution-r-quantile-and
 2212  getwd() getwd()
 2213  conda list
 2214  which radiant
 2215  pwd
 2216  conda env list
 2217  ls /home/yzliu/miniforge3/
 2218  ls /home/yzliu/miniforge3/bin
 2219  pwd
 2220  cd /home/yzliu/miniforge3/bin
 2221  ls
 2222  pwd
 2223  /home/yzliu/miniforge3/bin/radiant
 2224  /home/yzliu/miniforge3/bin/radian
 2225  conda activate R
 2226  R
 2227  ls /home/yzliu/miniforge3/bin/radian
 2228  ls /home/yzliu/miniforge3/bin/
 2229  ls /home/yzliu/miniforge3/bin/radian 
 2230  /home/yzliu/miniforge3/bin/radian 
 2231  ls
 2232  ls /home/yzliu/miniforge3/envs/R/lib/R
 2233  ls /home/yzliu/miniforge3/envs/R/lib/R/bin
 2234  ls /home/yzliu/miniforge3/envs/R/lib/R/bin/R
 2235  /home/yzliu/miniforge3/envs/R/lib/R/bin/R
 2236  conda env list
 2237  conda activate R
 2238  R
 2239  mkdir -p ~/.R
 2240  echo 'CXX17 = g++-7 -std=gnu++17 -fPIC' > ~/.R/Makevars
 2241  cat ~/.R/Makevars
 2242  conda list
 2243  conda env list
 2244  ls /home/yzliu/miniforge3/bin/radian
 2245  ls /home/yzliu/miniforge3/bin/
 2246  ls /home/yzliu/miniforge3/bin/radian
 2247  /home/yzliu/miniforge3/bin/radian
 2248  version
 2249  conda envs list
 2250  conda-env list
 2251  conda -h
 2252  conda env -h
 2253  conda env list
 2254  R
 2255  /home/yzliu/miniforge3/bin/radian
 2256  conda -h
 2257  conda env -h
 2258  conda env list
 2259  conda create -n Radian -c conda-forge radian -y
 2260  conda activate Radian
 2261  which Radian
 2262  conda env list
 2263  /home/yzliu/miniforge3/envs/Radian
 2264  ls /home/yzliu/miniforge3/envs/Radian
 2265  ls /home/yzliu/miniforge3/envs/Radian/bin/
 2266  /home/yzliu/miniforge3/envs/Radian/bin/radian 
 2267  /home/yzliu/miniforge3/envs/Radian/bin/radian
 2268  Radian
 2269  /home/yzliu/miniforge3/envs/Radian
 2270  ls /home/yzliu/miniforge3/envs/Radian/bin/radian 
 2271  /home/yzliu/miniforge3/envs/Radian/bin/radian
 2272  conda env list
 2273  conda deactivate
 2274  conda install -n base -c conda-forge radian -y 
 2275  conda deactivate
 2276  conda install -n base -c conda-forge radian -y 
 2277  conda list
 2278  pwd
 2279  ls
 2280  conda list
 2281  conda env list
 2282  conda activate
 2283  ls /home/yzliu/miniforge3/
 2284  ls /home/yzliu/miniforge3/bin/radian 
 2285  /home/yzliu/miniforge3/bin/radian
 2286  export R_HOME=/Library/Frameworks/R.framework/Resources
 2287  /home/yzliu/miniforge3/bin/radian
 2288  conda deactivate
 2289  conda env list
 2290  conda activate R
 2291  /home/yzliu/miniforge3/bin/radian
 2292  conda list
 2293  /home/yzliu/miniforge3/bin/radian
 2294  ls /home/yzliu/miniforge3/
 2295  ls /home/yzliu/miniforge3/envs
 2296  ls /home/yzliu/miniforge3/envs/Radian/
 2297  /home/yzliu/miniforge3/envs/Radian
 2298  /home/yzliu/miniforge3/envs/Radian/bin
 2299  ls /home/yzliu/miniforge3/envs/Radian/bin
 2300  ls /home/yzliu/miniforge3/envs/Radian/bin/radian 
 2301  /home/yzliu/miniforge3/envs/Radian/bin/radian
 2302  ls /home/yzliu/miniforge3/bin/radian
 2303  ls /home/yzliu/miniforge3/bin/
 2304  ls /home/yzliu/miniforge3/
 2305  conda list
 2306  conda env list
 2307  conda base list
 2308  conda activate base
 2309  conda list
 2310  pwd
 2311  /home/yzliu/miniforge3/envs/Radian/bin/radian
 2312  export R_HOME="/home/xxx/miniconda3/bin/R"
 2313  export R_HOME="/home/yzliu/miniforge3/envs/R/lib/R/bin/R"
 2314  /home/yzliu/miniforge3/envs/Radian/bin/radian
 2315  /home/yzliu/miniforge3/envs/R/lib/R/bin/R
 2316  conda activate Radian
 2317  radian --r-binary=/home/yzliu/miniforge3/envs/R/lib/R/bin/R
 2318  conda activate R
 2319  R home
 2320  R RHOME
 2321  env R_HOME=/home/yzliu/miniforge3/envs/R/lib/R radian
 2322  env R_HOME=/home/yzliu/miniforge3/envs/R/lib/R Radian
 2323  conda env list
 2324  conda activate Radian
 2325  env R_HOME=/home/yzliu/miniforge3/envs/R/lib/R Radian
 2326  Radian
 2327  radian
 2328  radian --r-binary=/home/yzliu/miniforge3/envs/R/lib/R
 2329  ls /home/yzliu/miniforge3/envs/R/lib/R
 2330  export PATH=/home/yzliu/miniforge3/envs/R/lib/R
 2331  radian
 2332  Radian
 2333  export PATH=/home/yzliu/miniforge3/envs/R/lib/R
 2334  ls /home/yzliu/miniforge3/envs/R/lib/R
 2335  ls /home/yzliu/miniforge3/envs/R/lib
 2336  ls
 2337  conda deactivate
 2338  ls
 2339  conda deactivate
 2340  ls
 2341  ll
 2342  pwd
 2343  conda env list
 2344  conda search angsd
 2345  /home/yzliu/miniforge3/envs/bcftools -h
 2346  ls /home/yzliu/miniforge3/envs/bcftools
 2347  ls /home/yzliu/miniforge3/envs/bcftools/bin
 2348  ls /home/yzliu/miniforge3/envs/bcftools/bin/bcftools -h
 2349  ls /home/yzliu/miniforge3/envs/bcftools/bin/bcftools
 2350  /home/yzliu/miniforge3/envs/bcftools/bin/bcftools -h
 2351  python
 2352  conda env list
 2353  ls /home/yzliu/miniforge3/envs/bioproject
 2354  ls /home/yzliu/miniforge3/envs/bioproject/bin
 2355  ls /home/yzliu/miniforge3/envs/bioproject/bin/python
 2356  /home/yzliu/miniforge3/envs/bioproject/bin/python
 2357  conda create -n angsd -c bioconda angsd
 2358  conda activate angsd
 2359  angsd -h
 2360  angsd GL -h
 2361  angsd -vcf-gl -h
 2362  angsd -vcf-gl
 2363  angsd -vcf-GL
 2364  angsd- GL
 2365  angsd -GL
 2366  angsd -domaf
 2367  misc/realSFS
 2368  /realSFS
 2369  conda env list
 2370  ls /home/yzliu/miniforge3/envs/angsd
 2371  ls /home/yzliu/miniforge3/envs/angsd/bin
 2372  ls /home/yzliu/miniforge3/envs/angsd/bin/realSFS 
 2373  /home/yzliu/miniforge3/envs/angsd/bin/realSFS 
 2374  angsd -vcf-GL
 2375  angsd -b
 2376  angsd -minInd
 2377  angsd
 2378  angsd -minQ
 2379  angsd -GL
 2380  /home/yzliu/miniforge3/envs/angsd/bin/realSFS 
 2381  angsd -doSaf
 2382  /home/yzliu/miniforge3/envs/angsd/bin/realSFS -h
 2383  /home/yzliu/miniforge3/envs/angsd/bin/realSFS
 2384  /home/yzliu/miniforge3/envs/angsd/bin/realSFS -nsites
 2385  conda activate bioproject
 2386  python=/home/yzliu/miniforge3/envs/bioproject/bin/python
 2387  freq_py=/home/yzliu/bin/SM_genomics_general/freq.py
 2388  sfs_py=/home/yzliu/bin/SM_genomics_general/sfs.py
 2389  geno=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/raw_output.geno
 2390  pop1=/home/yzliu/DK_proj/steps/systematic_fsc_test2
 2391  vcf_dir=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb
 2392  python=/home/yzliu/miniforge3/envs/bioproject/bin/python
 2393  freq_py=/home/yzliu/bin/SM_genomics_general/freq.py
 2394  sfs_py=/home/yzliu/bin/SM_genomics_general/sfs.py
 2395  geno=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/raw_output.geno
 2396  pop1=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/pop1.txt
 2397  cd $vcf_dir
 2398  $python $freq_py -h
 2399  conda activate bioproject
 2400  conda install -c bioconda angsd
 2401  conda deactivate
 2402  git clone https://github.com/simonhmartin/genomics_general.git
 2403  ls
 2404  mv genomics_general/ bin
 2405  ll
 2406  ls bin
 2407  cd bin
 2408  mv genomics_general/ SM_genomics_general
 2409  ll
 2410  cd SM_genomics_general/
 2411  ll
 2412  popgenWindows.py -h
 2413  popgenWindows.py
 2414  ./popgenWindows.py
 2415  py popgenWindows.py
 2416  python popgenWindows.py
 2417  pwd
 2418  python /home/yzliu/bin/SM_genomics_general/popgenWindows.py
 2419  python
 2420  conda activate bioproject
 2421  python
 2422  python popgenWindows.py -h
 2423  tree
 2424  python /home/yzliu/bin/SM_genomics_general/tools/VCF_processing/parseVCFs.py -h
 2425  python /home/yzliu/bin/SM_genomics_general/VCF_processing/parseVCFs.py -h
 2426  parseVCFs=/home/yzliu/bin/SM_genomics_general/VCF_processing/parseVCFs.py
 2427  bgzip -h
 2428  conda env list 
 2429  conda activate bcftools
 2430  bgzip -h
 2431  vcf_dir=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb
 2432  vcf=ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01.pruned_order.vcf
 2433  cd $vcf_dir
 2434  python $parseVCFs i $vcf --skipIndels --minQual 30 --gtf flag=DP min=5 max=100 --threads 4 | bgzip > ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01.pruned_order.geno.gz
 2435  conda activate bioproject
 2436  conda list
 2437  conda env list
 2438  conda activate bcftools
 2439  /home/yzliu/miniforge3/envs/bioproject/bin/python $parseVCFs i $vcf --skipIndels --minQual 30 --gtf flag=DP min=5 max=100 --threads 4 | bgzip > ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01.pruned_order.geno.gz
 2440  /home/yzliu/miniforge3/envs/bioproject/bin/python $parseVCFs -i $vcf --skipIndels --minQual 30 --gtf flag=DP min=5 max=100 --threads 4 | bgzip > ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01.pruned_order.geno.gz
 2441  less -S ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01.pruned_order.geno.gz
 2442  cut -h
 2443  cut --help
 2444  cut -f 3,4 --complement ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen | head
 2445  cut -f 3,4 --complement ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen > output.geno
 2446  cut -f 3,4 --complement ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen > raw_output.geno
 2447  /home/yzliu/miniforge3/envs/bioproject/bin/python freq.py -h
 2448  parseVCFs=/home/yzliu/bin/SM_genomics_general/VCF_processing/freq.py
 2449  /home/yzliu/miniforge3/envs/bioproject/bin/python freq.py -h
 2450  freq_py=/home/yzliu/bin/SM_genomics_general/VCF_processing/freq.py
 2451  /home/yzliu/miniforge3/envs/bioproject/bin/python $freq_py -h
 2452  freq_py=/home/yzliu/bin/SM_genomics_general/freq.py
 2453  /home/yzliu/miniforge3/envs/bioproject/bin/python $freq_py -h
 2454  sfs_py =/home/yzliu/bin/SM_genomics_general/sfs.py
 2455  /home/yzliu/miniforge3/envs/bioproject/bin/python $sfs_py -h
 2456  sfs_py =/home/yzliu/bin/SM_genomics_general/sfs.py
 2457  sfs_py=/home/yzliu/bin/SM_genomics_general/sfs.py
 2458  /home/yzliu/miniforge3/envs/bioproject/bin/python $sfs_py -h
 2459  geno=raw_output.geno
 2460  /home/yzliu/miniforge3/envs/bioproject/bin/python $sfs_py -g $geno --inputType baseCounts -f phased -t 4 -p pop1 --FSpops pop1 --subsample 10 --pref sim_data --suff sample.sfs
 2461  head $geno
 2462  head -1 $geno
 2463  head -1 $geno | sed '/\\t/\\n/'
 2464  head -1 $geno | sed '/\t/\n/'
 2465  head -1 $geno | sed 's/\t/\n/'
 2466  head -1 $geno | sed 's/\\t/\\n/'
 2467  head -1 $geno | sed 's/\\t/\\n/g'
 2468  head -1 $geno | sed 's/\t/\n/g'
 2469  head -1 $geno | sed 's/\t/\n/g' | awk '{$0,"pop1"}1'
 2470  head -1 $geno | sed 's/\t/\n/g' | awk 'BEGIN{OFS="\t"}{$1=$1 OFS "pop1"}1'
 2471  head -1 $geno | sed 's/\t/\n/g' | awk 'BEGIN{OFS="\t"}{$1=$1 OFS "pop1"}1' > pop1.txt
 2472  python=/home/yzliu/miniforge3/envs/bioproject/bin/python
 2473  freq_py =/home/yzliu/bin/SM_genomics_general/freq.py
 2474  sfs_py =/home/yzliu/bin/SM_genomics_general/sfs.py
 2475  python=/home/yzliu/miniforge3/envs/bioproject/bin/python
 2476  freq_py=/home/yzliu/bin/SM_genomics_general/freq.py
 2477  sfs_py=/home/yzliu/bin/SM_genomics_general/sfs.py
 2478  geno=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/raw_output.geno
 2479  $python $freq_py -g $geno -f phased -t 4 -p pop1 | $python --inputType -p pop1 baseCounts --FSpops pop1 --subsample 10 --pref sim_data --suff sample.sfs
 2480  pop1=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/pop1.txt
 2481  $python $freq_py -g $geno -f phased -t 4 -p $pop1 | $python --inputType -p pop1 baseCounts --FSpops $pop1 --subsample 10 --pref sim_data --suff sample.sfs
 2482  $python $freq_py -g $geno -f phased -t 4 -p $pop1
 2483  $python $freq_py -g $geno -f phased -t 4 -p pop1.txt 
 2484  /home/yzliu/miniforge3/envs/bioproject/bin/python $sfs_py -h
 2485  $python $freq_py -g $geno -f phased -t 4 -p $pop1 --popsFile pop1.txt
 2486  head pop1.txt 
 2487  echo $pop1
 2488  $python $freq_py -g $geno -f phased -t 4 -p pop1 --popsFile pop1.txt
 2489  conda activate R
 2490  R
 2491  conda evn list
 2492  conda env list
 2493  conda activate R
 2494  conda list
 2495  conda env list
 2496  conda activate base
 2497  conda list
 2498  conda uninstall -h
 2499  conda remove radian
 2500  conda list
 2501  vcf_dir=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb
 2502  python=/home/yzliu/miniforge3/envs/bioproject/bin/python
 2503  freq_py=/home/yzliu/bin/SM_genomics_general/freq.py
 2504  sfs_py=/home/yzliu/bin/SM_genomics_general/sfs.py
 2505  geno=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/raw_output.geno
 2506  pop1=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/pop1.txt
 2507  cd $vcf_dirvcf_dir=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb
 2508  python=/home/yzliu/miniforge3/envs/bioproject/bin/python
 2509  freq_py=/home/yzliu/bin/SM_genomics_general/freq.py
 2510  sfs_py=/home/yzliu/bin/SM_genomics_general/sfs.py
 2511  geno=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/raw_output.geno
 2512  pop1=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/pop1.txt
 2513  cd $vcf_dirvcf_dir=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb
 2514  python=/home/yzliu/miniforge3/envs/bioproject/bin/python
 2515  freq_py=/home/yzliu/bin/SM_genomics_general/freq.py
 2516  sfs_py=/home/yzliu/bin/SM_genomics_general/sfs.py
 2517  geno=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/raw_output.geno
 2518  pop1=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/pop1.txt
 2519  cd $vcf_dirvcf_dir=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb
 2520  python=/home/yzliu/miniforge3/envs/bioproject/bin/python
 2521  freq_py=/home/yzliu/bin/SM_genomics_general/freq.py
 2522  sfs_py=/home/yzliu/bin/SM_genomics_general/sfs.py
 2523  geno=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/raw_output.geno
 2524  pop1=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/pop1.txt
 2525  cd $vcf_dirvcf_dir=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb
 2526  python=/home/yzliu/miniforge3/envs/bioproject/bin/python
 2527  freq_py=/home/yzliu/bin/SM_genomics_general/freq.py
 2528  sfs_py=/home/yzliu/bin/SM_genomics_general/sfs.py
 2529  geno=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/raw_output.geno
 2530  pop1=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/pop1.txt
 2531  cd $vcf_dirvcf_dir=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb
 2532  python=/home/yzliu/miniforge3/envs/bioproject/bin/python
 2533  freq_py=/home/yzliu/bin/SM_genomics_general/freq.py
 2534  sfs_py=/home/yzliu/bin/SM_genomics_general/sfs.py
 2535  geno=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/raw_output.geno
 2536  pop1=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/pop1.txt
 2537  cd $vcf_dirvcf_dir=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb
 2538  python=/home/yzliu/miniforge3/envs/bioproject/bin/python
 2539  freq_py=/home/yzliu/bin/SM_genomics_general/freq.py
 2540  sfs_py=/home/yzliu/bin/SM_genomics_general/sfs.py
 2541  geno=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/raw_output.geno
 2542  pop1=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/pop1.txt
 2543  cd $vcf_dirvcf_dir=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb
 2544  python=/home/yzliu/miniforge3/envs/bioproject/bin/python
 2545  freq_py=/home/yzliu/bin/SM_genomics_general/freq.py
 2546  sfs_py=/home/yzliu/bin/SM_genomics_general/sfs.py
 2547  geno=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/raw_output.geno
 2548  pop1=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/pop1.txt
 2549  cd $vcf_dirvcf_dir=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb
 2550  python=/home/yzliu/miniforge3/envs/bioproject/bin/python
 2551  freq_py=/home/yzliu/bin/SM_genomics_general/freq.py
 2552  sfs_py=/home/yzliu/bin/SM_genomics_general/sfs.py
 2553  geno=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/raw_output.geno
 2554  pop1=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/pop1.txt
 2555  geno=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/raw_output.geno
 2556  $python $freq_py -g $geno -f phased -t 6 -p pop1 --popsFile pop1.txt
 2557  $python $freq_py -g $geno -f phased -t 6 -p pop1 --popsFile pop.txt
 2558  pop1=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/pop.txt
 2559  $python $freq_py -g $geno -f phased -t 6 -p pop1 --popsFile pop.txt
 2560  pop1=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/pop.txt
 2561  $python $freq_py -g $geno -f phased -t 6 -p pop1 --popsFile pop.txt
 2562  $python $freq_py -g $geno -f phased -t 6 -p pop1 --popsFile $pop
 2563  pop=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/pop.txt
 2564  $python $freq_py -g $geno -f phased -t 6 -p pop1 --popsFile $pop
 2565  $python $freq_py -g $geno -f phased -t 4 -p pop1 --popsFile $pop | $python --inputType -p pop1 baseCounts --FSpops pop1 --subsample 10 --pref sim_data --suff sample.sfs
 2566  $python $freq_py -g $geno -f phased -t 4 -p pop1 --popsFile $pop | $python $sfs_py --inputType -p pop1 baseCounts --FSpops pop1 --subsample 10 --pref sim_data --suff sample.sfs
 2567  $python $freq_py -g $geno -f phased -t 4 -p pop1 --popsFile $pop | $python $sfs_py --inputType baseCounts -p pop1 --FSpops pop1 --subsample 10 --pref sim_data --suff sample.sfs
 2568  ls
 2569  $python $sfs_py -h
 2570  cd $geno
 2571  cd /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/
 2572  $python $freq_py -g $geno -f phased -t 4 -p pop1 --popsFile $pop | $python $sfs_py --inputType baseCounts -p pop1 --FSpops pop1 --subsample 10 --pref sim_data --suff sample.sfs
 2573  parseVCFs=/home/yzliu/bin/SM_genomics_general/VCF_processing/parseVCFs.py
 2574  vcf_dir=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb
 2575  vcf=ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final_ld01.pruned_order.vcf
 2576  /home/yzliu/miniforge3/envs/bioproject/bin/python $parseVCFs -i $vcf --skipIndels --minQual 30 --gtf flag=DP min=5 max=100 --threads 4
 2577  parseVCF=/home/yzliu/bin/SM_genomics_general/VCF_processing/parseVCF.py
 2578  /home/yzliu/miniforge3/envs/bioproject/bin/python $parseVCF -i $vcf --skipIndels --minQual 30 --gtf flag=DP min=5 max=100 --threads 4
 2579  /home/yzliu/miniforge3/envs/bioproject/bin/python $parseVCF -i $vcf --skipIndels --minQual 30 --gtf flag=DP min=5 max=100
 2580  /home/yzliu/miniforge3/envs/bioproject/bin/python $parseVCF -i $vcf
 2581  /home/yzliu/miniforge3/envs/bioproject/bin/python $parseVCF -i $vcf > sim_data.geno
 2582  geno=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/sim_data.geno
 2583  $python $freq_py -g $geno -f phased -t 4 -p pop1 --popsFile $pop | $python $sfs_py --inputType baseCounts -p pop1 --FSpops pop1 --subsample 10 --pref sim_data --suff sample.sfs
 2584  geno=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/sim_data_edit.geno
 2585  $python $freq_py -g $geno -f phased -t 4 -p pop1 --popsFile $pop | $python $sfs_py --inputType baseCounts -p pop1 --FSpops pop1 --subsample 10 --pref sim_data --suff sample.sfs
 2586  vcf=ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen.final.vcf
 2587  /home/yzliu/miniforge3/envs/bioproject/bin/python $parseVCF -i $vcf > sim_gen_raw_data.geno
 2588  $python $freq_py -g $geno -f phased -t 4 -p pop1 --popsFile $pop | $python $sfs_py --inputType baseCounts -p pop1 --FSpops pop1 --subsample 10 --pref sim_raw_data.geno. --suff sample.sfs
 2589  geno=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/sim_gen_raw_data.geno 
 2590  $python $freq_py -g $geno -f phased -t 4 -p pop1 --popsFile $pop | $python $sfs_py --inputType baseCounts -p pop1 --FSpops pop1 --subsample 10 --pref sim_raw_data.geno. --suff sample.sfs
 2591  history
 2592  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test2/
 2593  head ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb.par
 2594  cp ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb.par ../para_test3
 2595  cd ../para_test3
 2596  cd ../para_test2
 2597  cp ft_sim_1000Ne_20_60_100_200S_1E_1d_10000Chr_1000b.sh ../para_test3
 2598  pwd
 2599  conda env list
 2600  conda activate bioproject
 2601  /home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093 -h
 2602  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3
 2603  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 2604  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3
 2605  ## test par
 2606  par=$par_folder/ft_sim_10000Ne_10dipS_1E_50G_10d_10Chr_1000Kb.par
 2607  #par=$(ls $par_folder/ft_sim*1000Ne*1E_*10000Chr_1000b.par | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
 2608  $fsc -i $par -n 2 -q -s 0 -d --foldedSFS -c 8 -g -G -k 10000000
 2609  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3
 2610  $fsc -i $par -n 2 -q -s 0 -d --foldedSFS -c 8 -g -G -k 10000000
 2611  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 2612  $fsc -h
 2613  cd /home/yzliu/DK_proj/steps/systematic_fsc_test2
 2614  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 2615  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3
 2616  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3
 2617  $fsc -i $par -n 1 -q -s 0 -d -c 8 -g -G -k 10000000
 2618  $fsc -i $par -n 2 -q -s 0 -d -c 8 -g -G -k 10000000
 2619  par=$par_folder/ft_sim_10000Ne_10dipS_1E_50G_10d_10Chr_1000Kb.par
 2620  $fsc -i $par -n 1 -q -s 0 -d -c 8 -g -G -k 10000000
 2621  $fsc -i $par -n 1 -q -s 0 -d --foldSFS -c 8 -g -G -k 10000000
 2622  $fsc -i $par -n 1 -q -s 0 --foldSFS -d -c 8 -g -G -k 10000000
 2623  $fsc -i $par -n 1 -q -s 0 --foldSFS -c 8 -g -G -k 10000000
 2624  rm -r *1000Kb-*
 2625  $fsc -i $par -n 1 -q -s 0 -d -c 8 -g -G -k 10000000
 2626  $fsc -i $par -n 1 -q -s 0 --foldSFS -d -c 8 -g -G -k 10000000
 2627  $fsc -i $par -n 1 -q -s 0 --foldSFS -d -m -c 8 -g -G -k 10000000
 2628  $fsc -i $par -n 3 -q -s 0 --foldSFS -d -m -c 8 -g -G -k 10000000
 2629  $fsc -i $par -n 3 -q -s 0 --foldSFS -c 8 -g -G -k 10000000
 2630  $fsc -i $par -n 1 -q -s 0 --foldSFS -c 8 -g -G -k 10000000
 2631  $fsc -i $par -n 1 -q -s 0 -m --foldSFS -c 8 -g -G -k 10000000
 2632  $fsc -i $par -n 1 -q -s 0 -m -c 8 -g -G -k 10000000
 2633  $fsc -h
 2634  par=$par_folder/ft_sim_1000Ne_20dipS_1E_50G_1d_20Chr_15Mb.par
 2635  #par=$(ls $par_folder/ft_sim*1000Ne*1E_*10000Chr_1000b.par | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
 2636  $fsc -i $par -n 1 -q -s 0 -m --foldedSFS -c 8 -g -G -k 300000000
 2637  cp /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/ft_sim_1000Ne_20dipS_1E_50G_1d_20Chr_15Mb.par /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/ft_sim_10000Ne_40dipS_1E_50G_1d_20Chr_15Mb.par
 2638  par=$par_folder/ft_sim_1000Ne_20hapS_1E_50G_1d_20Chr_15Mb.par
 2639  par=$par_folder/ft_sim_1000Ne_20hapS_1E_50G_01d_20Chr_15Mb.par
 2640  $fsc -i $par -n 1 -q -s 0 -m --foldedSFS -c 8 -g -G -k 300000000
 2641  par=$par_folder/ft_sim_10000Ne_20hapS_1E_50G_01d_20Chr_15Mb.par
 2642  $fsc -i $par -n 1 -q -s 0 -m --foldedSFS -c 8 -g -G -k 300000000
 2643  par=$par_folder/ft_sim_10000Ne_80hapS_1E_50G_01d_20Chr_15Mb.par
 2644  $fsc -i $par -n 1 -q -s 0 -m --foldedSFS -c 8 -g -G -k 300000000
 2645  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3
 2646  for i in {20,80,200};do     for j in {01,05,09};do         for k in {50,100,500,1000};do         cp ft_sim_10000Ne_{$i}hapS_1E_50G_01d_20Chr_15Mb.par ft_sim_10000Ne_{$i}hapS_1E_{$k}G_{$j}d_20Chr_15Mb.par;         done;     done; done
 2647  for i in {20,80,200};do     for j in {01,05,09};do         for k in {50,100,500,1000};do         cp ft_sim_10000Ne_"$i"hapS_1E_50G_01d_20Chr_15Mb.par ft_sim_10000Ne_"$i"hapS_1E_"$k"G_"$j"d_20Chr_15Mb.par;         done;     done; done
 2648  for i in {20,80,200};do     for j in {01,05,09};do         for k in {50,100,500,1000};do         cp ft_sim_10000Ne_"$i"hapS_1E_50G_01d_20Chr_15Mb.par- ft_sim_10000Ne_"$i"hapS_1E_"$k"G_"$j"d_20Chr_15Mb.par;         done;     done; done
 2649  ls *.par
 2650  ls *.par | wc -l
 2651  for sample in {80,200};do     `ft_sim_10000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par` | sed -i '13s/50 0 0 0 1.10 0 0/100 0 0 0 1.10 0 0/g';     done
 2652  for sample in {80,200};do     `ls ft_sim_10000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par` | sed -i '13s/50 0 0 0 1.10 0 0/100 0 0 0 1.10 0 0/g';     done
 2653  for sample in {80,200};do     `less ft_sim_10000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par` | sed -i '13s/50 0 0 0 1.10 0 0/100 0 0 0 1.10 0 0/g';     done
 2654  for sample in {80,200};do     `ls ft_sim_10000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par | less` | sed -i '13s/50 0 0 0 1.10 0 0/100 0 0 0 1.10 0 0/g';     done
 2655  for sample in {80,200};do     `ls ft_sim_10000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par` | less | sed -i '13s/50 0 0 0 1.10 0 0/100 0 0 0 1.10 0 0/g';     done
 2656  for sample in {80,200};do     `ls ft_sim_10000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par` ;     done
 2657  for sample in {80,200};do ls ft_sim_10000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par;     done
 2658  for sample in {80,200};do     ls ft_sim_10000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par | sed -i '13s/50 0 0 0 1.10 0 0/100 0 0 0 1.10 0 0/g';     done
 2659  for sample in {80,200};do ls ft_sim_10000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par | sed -i '13s/50 0 0 0 1.10 0 0/100 0 0 0 1.10 0 0/g';     done
 2660  for sample in {80,200};do ls ft_sim_10000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par done; 
 2661  for sample in {80,200};do ls ft_sim_10000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par;done; 
 2662  for sample in {80,200};do ls ft_sim_10000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par | sed -i '13s/50 0 0 0 1.10 0 0/100 0 0 0 1.10 0 0/g';done
 2663  for sample in {80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/100 0 0 0 1.10 0 0/g' ft_sim_10000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par;     done
 2664  for sample in {80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/100 0 0 0 1.10 0 0/g' ft_sim_10000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par;     done
 2665  for sample in {80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/500 0 0 0 1.10 0 0/g' ft_sim_10000Ne_"$sample"hapS_1E_500G_01d_20Chr_15Mb.par;     done
 2666  for sample in {80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/1000 0 0 0 1.10 0 0/g' ft_sim_10000Ne_"$sample"hapS_1E_1000G_01d_20Chr_15Mb.par;     done
 2667  for generation in {100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.50 0 0/g" ft_sim_10000Ne_20hapS_1E_"generation"G_05d_20Chr_15Mb.par;     done
 2668  for generation in {100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.50 0 0/g" ft_sim_10000Ne_20hapS_1E_"$generation"G_05d_20Chr_15Mb.par;     done
 2669  for generation in {100,500,1000};do     sed -i '13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.90 0 0/g' ft_sim_10000Ne_20hapS_1E_"$generation"G_09d_20Chr_15Mb.par;     done
 2670  for generation in {100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.90 0 0/g" ft_sim_10000Ne_20hapS_1E_"$generation"G_09d_20Chr_15Mb.par;     done
 2671  for generation in {100,500,1000};do     sed -i "13s/\$generation 0 0 0 1.10 0 0/$generation 0 0 0 1.90 0 0/g" ft_sim_10000Ne_20hapS_1E_"$generation"G_09d_20Chr_15Mb.par;     done
 2672  for generation in {100,500,1000};do     sed -i "13s/\$generation 0 0 0 1.10 0 0/xx 0 0 0 1.90 0 0/g" ft_sim_10000Ne_20hapS_1E_"$generation"G_09d_20Chr_15Mb.par;     done
 2673  for generation in {100,500,1000};do     sed -i '13s/$generation 0 0 0 1.10 0 0/xx 0 0 0 1.90 0 0/g' ft_sim_10000Ne_20hapS_1E_"$generation"G_09d_20Chr_15Mb.par;     done
 2674  for generation in {100,500,1000};do ls ft_sim_10000Ne_20hapS_1E_"$generation"G_09d_20Chr_15Mb.par;     done
 2675  for generation in {100,500,1000};do     sed -i "13s/\$generation 0 0 0 1.10 0 0/xx 0 0 0 1.90 0 0/g" ft_sim_10000Ne_20hapS_1E_"$generation"G_09d_20Chr_15Mb.par;     done
 2676  for generation in {100,500,1000};do     sed -i "13s/\$generation/xx/g" ft_sim_10000Ne_20hapS_1E_"$generation"G_09d_20Chr_15Mb.par;     done
 2677  for generation in {100,500,1000};do     sed -i "13s/xx/$generation/g" ft_sim_10000Ne_20hapS_1E_"$generation"G_09d_20Chr_15Mb.par;     done
 2678  for generation in {100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.50 0 0/g" ft_sim_10000Ne_80hapS_1E_"$generation"G_05d_20Chr_15Mb.par;     done
 2679  for generation in {100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.90 0 0/g" ft_sim_10000Ne_80hapS_1E_"$generation"G_09d_20Chr_15Mb.par;     done
 2680  for generation in {100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.50 0 0/g" ft_sim_10000Ne_200hapS_1E_"$generation"G_05d_20Chr_15Mb.par;     done
 2681  for generation in {100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.90 0 0/g" ft_sim_10000Ne_200hapS_1E_"$generation"G_09d_20Chr_15Mb.par;     done
 2682  ls *.par | wc -l
 2683  cd /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb/
 2684  awk '{for(i=5;i<=NF;i++){j=i+1;j<=NF}{print $i$j}}' ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb_1_1.gen | head
 2685  ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb_1_1.gen | head
 2686  head ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb_1_1.gen
 2687  awk '{for(i=5;i<=NF;i++){j=i+1;j<=NF}{print $1}}' ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb_1_1.gen | head
 2688  awk 'BEGIN{OFS="\t"}{for(i=5;i<=NF;i++){j=i+1;j<=NF}{print $i$j}}' ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb_1_1.gen | head
 2689  awk 'BEGIN{OFS="\t"}{for(i=5;i<=NF;i++){j=i+1;j<=NF}{print $i$j;j++}}' ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb_1_1.gen | head
 2690  awk 'BEGIN{OFS="\t"}{for(i=5;i<=NF;i++){j=i+1;j<=NF}{print $i$j;j++}}' ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb_1_1.gen
 2691  awk '{for(i=5;i<=NF;i++){for(j=i+1;j<=NF){print $i$j;j++}}}' ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb_1_1.gen| head
 2692  awk 'BEGIN{OFS="\t"}{for(i=5;i<=NF;i++){for(j=i+1;j<=NF;j++){print $i$j;}}}' ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb_1_1.gen | head
 2693  awk 'BEGIN{OFS="\t"}{for(i=5;i<=NF;i++){for(j=i+1;j<=NF;j++){print $i$j;}}}' ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb_1_1.gen
 2694  awk '{for(i=5;i<=NF;i++){for(j=i+1;j<=NF;j++){print $i$j;}}}' ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb_1_1.gen| head
 2695  awk '{for(i=5;i<=NF;i++;j=i+1;j<=NF){print $i$j;}}}' ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb_1_1.gen| head
 2696  awk '{for(i=5;i<=NF;i++;j=i+1;j<=NF){print $i$j;}}' ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb_1_1.gen| head
 2697  awk '{for(i=5;i<=NF;i++;j=i+1;j<=NF;j++){print $i$j;}}' ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb_1_1.gen| head
 2698  awk '{for(i=5;i<=NF;j=i+1;i++){print $i$j;}}' ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb_1_1.gen| head
 2699  awk '{for(i=5;i<=NF;i++;j=6;j<=NF;j++){print $i$j;}}' ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb_1_1.gen| head
 2700  awk '{for(i=5;i<=NF;i++){print $i$3;}}' ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb_1_1.gen| head
 2701  awk '{for(i=5;i<=NF;i++){print $i$3;}}' ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb_1_1.gen
 2702  awk '{for(i=5;i<=NF;i++;j=i+1){print $i$j;}}' ft_sim_1000Ne_20dipS_1E_50G_1d_10000Chr_10Kb_1_1.gen| head
 2703  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/
 2704  cp /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/10000Ne 100000Ne
 2705  cp -r /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/10000Ne 100000Ne
 2706  cd 100000Ne/
 2707  ls . | less -N
 2708  ls \*_copy.par\
 2709  ls *_copy.par
 2710  for i in `ls *_copy.par`;do rename 500G 5000G ls $i;done
 2711  for i in `ls *_copy.par`;do rename 500G 5000G $i;done
 2712  for Ne in `ft_sim_10000Ne*1E*20Chr_15Mb.par`;do     sed -i "4s/10000/100000/" $Ne;     rename "10000Ne" "100000Ne" $Ne;     done
 2713  for Ne in `ls ft_sim_10000Ne*1E*20Chr_15Mb.par`;do     sed -i "4s/10000/100000/" $Ne;     rename "10000Ne" "100000Ne" $Ne;     done
 2714  cd ./10000N
 2715  cd ./10000Ne
 2716  cd ../10000Ne
 2717  ls *20hapS*
 2718  ll *20hapS*
 2719  for generation in {50,100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.50 0 0/g" ft_sim_10000Ne_20hapS_1E_"$generation"G_05d_20Chr_15Mb.par;     done
 2720  for generation in {50,100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.90 0 0/g" ft_sim_10000Ne_20hapS_1E_"$generation"G_09d_20Chr_15Mb.par;     done
 2721  for generation in {50,100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.50 0 0/g" ft_sim_10000Ne_80hapS_1E_"$generation"G_05d_20Chr_15Mb.par;     done
 2722  for generation in {50,100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.90 0 0/g" ft_sim_10000Ne_80hapS_1E_"$generation"G_09d_20Chr_15Mb.par;     done
 2723  for generation in {50,100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.50 0 0/g" ft_sim_10000Ne_200hapS_1E_"$generation"G_05d_20Chr_15Mb.par;     done
 2724  for generation in {50,100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.90 0 0/g" ft_sim_10000Ne_200hapS_1E_"$generation"G_09d_20Chr_15Mb.par;     done
 2725  cd ../100000Ne/
 2726  for generation in {50,100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.50 0 0/g" ft_sim_10000Ne_20hapS_1E_"$generation"G_05d_20Chr_15Mb.par;     done
 2727  for generation in {50,100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.90 0 0/g" ft_sim_10000Ne_20hapS_1E_"$generation"G_09d_20Chr_15Mb.par;     done
 2728  for generation in {50,100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.50 0 0/g" ft_sim_10000Ne_80hapS_1E_"$generation"G_05d_20Chr_15Mb.par;     done
 2729  for generation in {50,100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.90 0 0/g" ft_sim_10000Ne_80hapS_1E_"$generation"G_09d_20Chr_15Mb.par;     done
 2730  for generation in {50,100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.50 0 0/g" ft_sim_10000Ne_200hapS_1E_"$generation"G_05d_20Chr_15Mb.par;     done
 2731  for generation in {50,100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.90 0 0/g" ft_sim_10000Ne_200hapS_1E_"$generation"G_09d_20Chr_15Mb.par;     done
 2732  for generation in {50,100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.50 0 0/g" ft_sim_100000Ne_20hapS_1E_"$generation"G_05d_20Chr_15Mb.par;     done
 2733  for generation in {50,100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.90 0 0/g" ft_sim_100000Ne_20hapS_1E_"$generation"G_09d_20Chr_15Mb.par;     done
 2734  for generation in {50,100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.50 0 0/g" ft_sim_100000Ne_80hapS_1E_"$generation"G_05d_20Chr_15Mb.par;     done
 2735  for generation in {50,100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.90 0 0/g" ft_sim_100000Ne_80hapS_1E_"$generation"G_09d_20Chr_15Mb.par;     done
 2736  for generation in {50,100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.50 0 0/g" ft_sim_100000Ne_200hapS_1E_"$generation"G_05d_20Chr_15Mb.par;     done
 2737  for generation in {50,100,500,1000};do     sed -i "13s/50 0 0 0 1.10 0 0/$generation 0 0 0 1.90 0 0/g" ft_sim_100000Ne_200hapS_1E_"$generation"G_09d_20Chr_15Mb.par;     done
 2738  for sample in {80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/100 0 0 0 1.10 0 0/g' ft_sim_10000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par;     done
 2739  for sample in {80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/500 0 0 0 1.10 0 0/g' ft_sim_10000Ne_"$sample"hapS_1E_500G_01d_20Chr_15Mb.par;     done
 2740  for sample in {80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/1000 0 0 0 1.10 0 0/g' ft_sim_10000Ne_"$sample"hapS_1E_1000G_01d_20Chr_15Mb.par;     done
 2741  for sample in {80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/100 0 0 0 1.10 0 0/g' ft_sim_100000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par;     done
 2742  for sample in {80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/500 0 0 0 1.10 0 0/g' ft_sim_100000Ne_"$sample"hapS_1E_500G_01d_20Chr_15Mb.par;     done
 2743  for sample in {80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/1000 0 0 0 1.10 0 0/g' ft_sim_10000Ne_"$sample"hapS_1E_1000G_01d_20Chr_15Mb.par;     done
 2744  for sample in {80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/1000 0 0 0 1.10 0 0/g' ft_sim_100000Ne_"$sample"hapS_1E_1000G_01d_20Chr_15Mb.par;     done
 2745  for sample in {80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/100 0 0 0 1.10 0 0/g' ft_sim_100000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par;     done
 2746  for sample in {80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/500 0 0 0 1.10 0 0/g' ft_sim_100000Ne_"$sample"hapS_1E_500G_01d_20Chr_15Mb.par;     done
 2747  for sample in {80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/100 0 0 0 1.10 0 0/g' ft_sim_100000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par;     done
 2748  for sample in {80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/500 0 0 0 1.10 0 0/g' ft_sim_100000Ne_"$sample"hapS_1E_500G_01d_20Chr_15Mb.par;     done
 2749  for sample in {20,80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/100 0 0 0 1.10 0 0/g' ft_sim_10000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par;     done
 2750  for sample in {20,80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/100 0 0 0 1.10 0 0/g' ft_sim_100000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par;     done
 2751  for sample in {20,80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/500 0 0 0 1.10 0 0/g' ft_sim_100000Ne_"$sample"hapS_1E_500G_01d_20Chr_15Mb.par;     done
 2752  for sample in {20,80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/1000 0 0 0 1.10 0 0/g' ft_sim_100000Ne_"$sample"hapS_1E_1000G_01d_20Chr_15Mb.par;     done
 2753  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3
 2754  cd 10000Ne
 2755  for sample in {20,80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/100 0 0 0 1.10 0 0/g' ft_sim_10000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par;     done
 2756  for sample in {20,80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/500 0 0 0 1.10 0 0/g' ft_sim_10000Ne_"$sample"hapS_1E_500G_01d_20Chr_15Mb.par;     done
 2757  for sample in {20,80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/1000 0 0 0 1.10 0 0/g' ft_sim_10000Ne_"$sample"hapS_1E_1000G_01d_20Chr_15Mb.par;     done
 2758  cp -r 100000Ne 1000000Ne
 2759  cd ../100000Ne/
 2760  cp -r 100000Ne 1000000Ne
 2761  cd ..
 2762  cp -r 100000Ne 1000000Ne
 2763  cd 1000000Ne/
 2764  for Ne in `ls ft_sim_100000Ne*1E*20Chr_15Mb.par`;do     sed -i "4s/100000/1000000/" $Ne;     rename "100000Ne" "1000000Ne" $Ne;     done
 2765  for sample in {20,80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/100 0 0 0 1.10 0 0/g' ft_sim_1000000Ne_"$sample"hapS_1E_100G_01d_20Chr_15Mb.par;     done
 2766  for sample in {20,80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/500 0 0 0 1.10 0 0/g' ft_sim_1000000Ne_"$sample"hapS_1E_500G_01d_20Chr_15Mb.par;     done
 2767  for sample in {20,80,200};do     sed -i '13s/50 0 0 0 1.10 0 0/1000 0 0 0 1.10 0 0/g' ft_sim_1000000Ne_"$sample"hapS_1E_1000G_01d_20Chr_15Mb.par;     done
 2768  cd ../100000Ne/
 2769  for g in {50,100,500,1000};do     cp ft_sim_100000Ne_20hapS_1E_"$g"G_00d_20Chr_15Mb.par ft_sim_100000Ne_20hapS_1E_"$g"G_05i_20Chr_15Mb.par;     done
 2770  for g in {50,100,500,1000};do     cp ft_sim_100000Ne_80hapS_1E_"$g"G_00d_20Chr_15Mb.par ft_sim_100000Ne_80hapS_1E_"$g"G_05i_20Chr_15Mb.par;     done
 2771  for g in {50,100,500,1000};do     cp ft_sim_100000Ne_200hapS_1E_"$g"G_00d_20Chr_15Mb.par ft_sim_100000Ne_200hapS_1E_"$g"G_05i_20Chr_15Mb.par;     done
 2772  for generation in {50,100,500,1000};do     sed -i "13s/$generation 0 0 0 1.0 0 0/$generation 0 0 0 -1.50 0 0/g" ft_sim_1000000Ne_200hapS_1E_"$generation"G_05i_20Chr_15Mb.par;     done
 2773  # change history event in increasing pop
 2774  for generation in {50,100,500,1000};do     sed -i "13s/$generation 0 0 0 1.0 0 0/$generation 0 0 0 -1.50 0 0/g" ft_sim_100000Ne_200hapS_1E_"$generation"G_05i_20Chr_15Mb.par;     done
 2775  for generation in {50,100,500,1000};do     sed -i "13s/$generation 0 0 0 1.0 0 0/$generation 0 0 0 -1.50 0 0/g" ft_sim_100000Ne_80hapS_1E_"$generation"G_05i_20Chr_15Mb.par;     done
 2776  for generation in {50,100,500,1000};do     sed -i "13s/$generation 0 0 0 1.0 0 0/$generation 0 0 0 -1.50 0 0/g" ft_sim_100000Ne_20hapS_1E_"$generation"G_05i_20Chr_15Mb.par;     done
 2777  ls *.par | wc -l
 2778  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3
 2779  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 2780  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne
 2781  ls $par_folder/ft_sim_100000Ne*1E_*20Chr_15Mb.par | sort -V
 2782  ls $par_folder/ft_sim_100000Ne*1E_*20Chr_15Mb.par | sort -V | wc -l
 2783  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/
 2784  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/ft_sim_10K_100K_1MNe_20_80_200_200S_1E_01_05_09d_05i_20Chr_15Mb.sh
 2785  squeue -u yzliu
 2786  ls $par_folder/ft_sim_100000Ne*1E_*20Chr_15Mb.par | sort -V
 2787  ls $par_folder/ft_sim_100000Ne*1E_*20Chr_15Mb.par | sort
 2788  squeue -u yzliu
 2789  scancel 26709377
 2790  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/
 2791  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.sh
 2792  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne/ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb-
 2793  ls --block-size M 
 2794  ll --block-size M 
 2795  squeue -u yzliu
 2796  less -S ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb_1_1.gen
 2797  head ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb_1_1.gen
 2798  awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne/ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb-/ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb_1_1.gen | head
 2799  awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne/ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb-/ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb_1_1.gen > ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb_1_1.gen.new
 2800  geno_new=ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb_1_1.gen.new
 2801  sed '1d' $geno_new | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS NFR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' | sed '$d' > $geno_new.vcf
 2802  cd ..
 2803  ls
 2804  ls ./
 2805  ls ./*.gen
 2806  ls ./*/.gen
 2807  ls *.gen
 2808  find ./*.gen
 2809  find -print
 2810  find -print | grep '.gen'
 2811  gen_table=`find -print | grep '.gen'`
 2812  echo $gen_table
 2813  find -print | grep -e '15Mb-' -e '.gen'
 2814  find -print | grep "15Mb-" | grep '.gen'
 2815  find -print | grep "15Mb-" | grep '.gen$'
 2816  for gen_table in `find -print | grep "15Mb-" | grep '.gen$'`;do     gen_table_new=$gen_table.new;     gen_table_new_vcf=$gen_table_new.vcf;      awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' $gen_table > $gen_table_new;      sed '1d' $gen_table_new | awk 'BEGIN{OFS="\t"}{$2 = $2 OFS NFR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' |     sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' |     sed '$d' > $gen_table_new_vcf;     done
 2817  ll /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb
 2818  less -S /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne/ft_sim_100000Ne_20hapS_1E_100G_01d_20Chr_15Mb-/ft_sim_100000Ne_20hapS_1E_100G_01d_20Chr_15Mb_1_1.gen.new.vcf
 2819  head /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne/ft_sim_100000Ne_20hapS_1E_100G_01d_20Chr_15Mb-/ft_sim_100000Ne_20hapS_1E_100G_01d_20Chr_15Mb_1_1.gen.new.vcf
 2820  seq 1 40
 2821  i=seq 1 40
 2822  i=`seq 1 40`
 2823  echo G_1_$i
 2824  echo G_1_$i\n
 2825  echo "G_1_$i\n"
 2826  for i in `seq 1 40`;echo G_1_$i;done
 2827  for i in `seq 1 40`;do echo G_1_$i;done
 2828  for i in `seq 1 40`;do echo \\tG_1_$i\\t;done
 2829  for i in `seq 1 40`;do echo \\tG_1_$i;done
 2830  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3
 2831  for i in `seq 1 40`;do echo \\tG_1_$i | sed 's/\n//';done > diploid_40_sample_name.txt
 2832  head diploid_40_sample_name.txt
 2833  for i in `seq 1 40`;do echo \\tG_1_$i | sed 's/\n//';done
 2834  for i in `seq 1 40`;do echo \\tG_1_$i | sed 's/\n//g';done
 2835  for i in `seq 1 40`;do echo \\tG_1_$i | sed 's/\\n//g';done
 2836  for i in `seq 1 40`;do echo \\tG_1_$i;done > diploid_40_sample_name.txt
 2837  for i in `seq 1 40`;do echo \\tG_1_$i;done
 2838  for i in `seq 1 40`;do echo \\tG_1_$i;done > diploid_40_sample_name.txt
 2839  for i in `seq 1 100`;do echo \\tG_1_$i;done > diploid_100_sample_name.txt
 2840  squeue -u yzliu
 2841  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne
 2842  find -print | grep "15Mb-" | grep '.vcf$'
 2843  ## set a variable for vcf file to plink
 2844  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne
 2845  ## perform linkage pruning
 2846  for gen_vcf in `find -print | grep "15Mb-" | grep '.vcf$'`;do     plink --vcf $gen_vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 10 0.1 --out $gen_vcf.plink_ld01;     done
 2847  conda activate plink
 2848  plink
 2849  for gen_vcf in `find -print | grep "15Mb-" | grep '.vcf$'`;do     plink --vcf $gen_vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 10 0.1 --out $gen_vcf.plink_ld01;     done
 2850  head /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne/ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb-/ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb_1_1.gen.new.vcf
 2851  head /home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen
 2852  gen_table_new=/home/yzliu/DK_proj/steps/systematic_fsc_test2/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb/ft_sim_1000Ne_20dipS_1E_50G_1d_10Chr_1000Kb_1_1.new.gen
 2853  sed '1d' $gen_table_new | awk 'BEGIN{OFS="\t"}{$2=$2 OFS NFR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | head
 2854  sed '1d' $gen_table_new | awk 'BEGIN{OFS="\t"}{$2=$2 OFS "NFR";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | head
 2855  sed '1d' $gen_table_new | awk 'BEGIN{OFS="\t"}{$2=$2 OFS NFR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | head
 2856  sed '1d' $gen_table_new | awk 'BEGIN{OFS="\t"}{$2=$2 OFS NF;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | head
 2857  sed '1d' $gen_table_new | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | head
 2858  sed '1d' $gen_table_new | awk 'BEGIN{OFS="\t"}{$2=$2 OFS NFR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | head
 2859  sed '1d' $gen_table_new | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | head
 2860  for gen_table in `find -print | grep "15Mb-" | grep '.gen$'`;do     gen_table_new=$gen_table.new;     gen_table_new_vcf=$gen_table_new.vcf;      awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' $gen_table > $gen_table_new;      sed '1d' $gen_table_new | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' |     sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' |     sed '$d' > $gen_table_new_vcf;     done
 2861  for gen_vcf in `find -print | grep "15Mb-" | grep '.vcf$'`;do     plink --vcf $gen_vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 10 0.1 --out $gen_vcf.plink_ld01;     done
 2862  for gen_vcf in `find -print | grep "15Mb-" | grep '.vcf$'`;do     plink --vcf $gen_vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --extract $gen_vcf.plink_ld01.prune.in --out $gen_vcf.plink_ld01.pruned --keep-allele-order --recode vcf;     done
 2863  for gen_vcf in `find -print | grep "15Mb-" | grep '.vcf$'`;do     plink --vcf $gen_vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 10 0.05 --out $gen_vcf.plink_ld005;     done
 2864  conda bcftools
 2865  conda activate bcftools
 2866  query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1,"G"}'
 2867  vcf=/home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne/ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb-/ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb_1_1.gen.new.vcf.plink_ld01.pruned.vcf
 2868  bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1,"G"}'
 2869  bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1,"pop"}'
 2870  bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1,"pop"}' > pop_file
 2871  conda activate bioproject
 2872  /home/yzliu/bin/easySFS/easySFS.py -i $vcf -p pop_file -a -f --preview
 2873  cd dir=/home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne/ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb-
 2874  dir=/home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne/ft_sim_100000Ne_20hapS_1E_50G_09d_20Chr_15Mb-
 2875  cd $dir
 2876  /home/yzliu/bin/easySFS/easySFS.py -i $vcf -p pop_file -a -f --proj 20,68631
 2877  /home/yzliu/bin/easySFS/easySFS.py -i $vcf -p ../pop_file -a -f --proj 20,68631
 2878  /home/yzliu/bin/easySFS/easySFS.py -i $vcf -p ../pop_file -a -f --proj 20
 2879  squeue -u yzliu
 2880  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne
 2881  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 2882  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne
 2883  ls $par_folder/ft_sim_100000Ne*1E_*20Chr_15Mb.par | sort -V | head
 2884  conda activate bcftools
 2885  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
 2886  for folder in {10000Ne_5rep,};do     for size in {20,80,200};do         bcftools query -l `find ./$folder -print | grep "$size"hapS | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"` |         grep 'G_1' | awk -v var=$size '{split($0,a,"_G");print $1,"pop"var}' > ./$folder/pop"$size"_file;     done; done
 2887  cd ..
 2888  for folder in {10000Ne_5rep,};do     for size in {20,80,200};do         bcftools query -l `find ./$folder -print | grep "$size"hapS | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"` |         grep 'G_1' | awk -v var=$size '{split($0,a,"_G");print $1,"pop"var}' > ./$folder/pop"$size"_file;     done; done
 2889  for folder in {10000Ne_5rep,};do     for size in {20,80,200};do         bcftools query -l `find ./$folder -print | grep "$size"hapS | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"` |         grep 'G_1' | awk -v var=$size '{split($0,a,"_G");print $1,"pop"$var}' > ./$folder/pop"$size"_file;     done; done
 2890  for folder in {10000Ne_5rep,};do     for size in {20,80,200};do         bcftools query -l `find ./$folder -print | grep "$size"hapS | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"` |         grep 'G_1' | awk -v var=$size '{split($0,a,"_G");print $1,"pop"var}' > ./$folder/pop"$size"_file;     done; done
 2891  /home/yzliu/bin/easySFS/easySFS.py
 2892  conda activate bioproject 
 2893  /home/yzliu/bin/easySFS/easySFS.py
 2894  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-
 2895  ls ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_5.gen.new.vcf.plink_ld05.pruned.vcf
 2896  pwd ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_5.gen.new.vcf.plink_ld05.pruned.vcf
 2897  cd ..
 2898  pwd ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_5.gen.new.vcf.plink_ld05.pruned.vcf
 2899  cd ..
 2900  pwd ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_5.gen.new.vcf.plink_ld05.pruned.vcf
 2901  squeue -u yzliu
 2902  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
 2903  sfs=`find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep _MSFS.obs$ | sort -V`
 2904  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11 | tr -d $'\n';     echo -e "\t$i" > sfs_file.txt; done
 2905  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11 | tr -d $'\n' > sfs_file.txt;     echo -e "\t$
 2906  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11 | tr -d $'\n';     echo -e "\t$i"; done
 2907  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11 | tr -d $'\n' >> sfs_file.txt;     echo -e "\t$i" >> sfs_file.txt; done
 2908  cat sfs_file.txt | cut -d "/" -f 1,4 | sed 's/\.\///' > sfs_file.new.txt
 2909  cat sfs_file.txt | cut -d "/" -f 1,4 | sed -e 's/\.\///' -e 's/\.obs//' > sfs_file.new.txt
 2910  ls *.txt
 2911  cp sfs_file.new.txt .//home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint
 2912  cp sfs_file.new.txt ./home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint
 2913  cp sfs_file.new.txt /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint
 2914  squeue -u yzliu
 2915  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/
 2916  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 2917  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/10000Ne
 2918  $fsc -i $par -n 1 -q -s 0 -m --foldedSFS -c 8 -g -G -k 300000000
 2919  par=$par_folder/ft_sim_1000Ne_20dipS_1E_50G_1d_20Chr_15Mb.par
 2920  $fsc -i $par -n 5 -q -s 0 -m --foldedSFS -c 8 -g -G -k 300000000
 2921  par=$par_folder/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb.par
 2922  $fsc -i $par -n 5 -q -s 0 -m --foldedSFS -c 8 -g -G -k 300000000
 2923  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/
 2924  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb_5rep.sh
 2925  squeue -u yzliu
 2926  find /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep -print | grep "15Mb-" | grep '.gen$'
 2927  for rep in {1..5};do find /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep -print | grep "15Mb-" | grep '$rep.gen$'
 2928  for rep in {1..5};do find /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep -print | grep "15Mb-" | grep '$rep.gen$';done
 2929  for rep in {1..5};do find /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep -print | grep "15Mb-" | grep '_$rep.gen$';done
 2930  for rep in {1..5};do echo $rep;done
 2931  grep -h
 2932  grep --help
 2933  for rep in {1..5};do find /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep -print | grep "15Mb-" | grep "_$rep.gen$";done
 2934  for rep in {1..5};do     for gen_table in `find -print | grep "15Mb-" | grep "$rep.gen$"`;do         gen_table_new=$gen_table.new;         gen_table_new_vcf=$gen_table_new.vcf;          awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' $gen_table > $gen_table_new;          sed '1d' $gen_table_new | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' |         sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' |         sed '$d' > $gen_table_new_vcf;     done; done
 2935  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-
 2936  for rep in {1..5};do     for gen_table in `find -print | grep "15Mb-" | grep "$rep.gen$"`;do         gen_table_new=$gen_table.new;         gen_table_new_vcf=$gen_table_new.vcf;          awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' $gen_table > $gen_table_new;          sed '1d' $gen_table_new | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' |         sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' |         sed '$d' > $gen_table_new_vcf;     done; done
 2937  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
 2938  for rep in {1..5};do     for gen_table in `find -print | grep "15Mb-" | grep "$rep.gen$"`;do         gen_table_new=$gen_table.new;         gen_table_new_vcf=$gen_table_new.vcf;          awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' $gen_table > $gen_table_new;          sed '1d' $gen_table_new | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' |         sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' |         sed '$d' > $gen_table_new_vcf;     done; done
 2939  less -S /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_5.gen.new.vcf
 2940  conda activate plink
 2941  for rep in {1..5};do     for gen_vcf in `find -print | grep "15Mb-" | grep "$rep.gen.new.vcf$"`;do         plink --vcf $gen_vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 10 0.1 --out $gen_vcf.plink_ld01;     done; done
 2942  for rep in {1..5};do     for gen_vcf in `find -print | grep "15Mb-" | grep "$rep.gen.new.vcf$"`;do         plink --vcf $gen_vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --extract $gen_vcf.plink_ld01.prune.in --out $gen_vcf.plink_ld01.pruned --keep-allele-order --recode vcf;     done; done
 2943  easySFS=/home/yzliu/bin/easySFS/easySFS.py
 2944  for rep in {1..5};do     for vcf in `find -print | grep "15Mb-" | grep "$rep.gen.new.vcf.plink_ld01.pruned.vcf$"`;do          $easySFS -i $vcf -p pop_file -a -f --preview;     done; done
 2945  ## activate env to use python
 2946  conda activate bioproject
 2947  easySFS=/home/yzliu/bin/easySFS/easySFS.py
 2948  for rep in {1..5};do     for vcf in `find -print | grep "15Mb-" | grep "$rep.gen.new.vcf.plink_ld01.pruned.vcf$"`;do          $easySFS -i $vcf -p pop_file -a -f --preview;     done; done
 2949  find -print
 2950  for rep in {1..5};do     for vcf in `find -print | grep "15Mb-" | grep "$rep.gen.new.vcf.plink_ld01.pruned.vcf$"`;do echo "vcf_$rep" $easySFS -i $vcf -p pop_file -a -f --preview;     done; done
 2951  for rep in {1..5};do     for vcf in `find -print | grep "15Mb-" | grep "$rep.gen.new.vcf.plink_ld01.pruned.vcf$"`;do          echo "vcf_$rep";         $easySFS -i $vcf -p pop_file -a -f --preview;     done; done
 2952  for rep in {1..5};do     for vcf in `find -print | grep "15Mb-" | grep "$rep.gen.new.vcf.plink_ld01.pruned.vcf$"`;do          echo "------> VCF_$rep <------";         $easySFS -i $vcf -p pop_file -a -f --preview;     done; done
 2953  for rep in {1..5};do     for vcf in `find -print | grep "15Mb-" | grep "$rep.gen.new.vcf.plink_ld01.pruned.vcf$"`;do          echo "\n------> VCF_$rep <------";         $easySFS -i $vcf -p pop_file -a -f --preview;     done; done
 2954  echo "\\n"
 2955  echo "\n"
 2956  echo "/n"
 2957  echo -e "\n"
 2958  for rep in {1..5};do     for vcf in `find -print | grep "15Mb-" | grep "$rep.gen.new.vcf.plink_ld01.pruned.vcf$"`;do          echo -e "\n------> VCF_$rep <------";         $easySFS -i $vcf -p pop_file -a -f --preview;     done; done
 2959  for rep in {1..5};do     for vcf in `find -print | grep "15Mb-" | grep "$rep.gen.new.vcf.plink_ld01.pruned.vcf$"`;do          $easySFS -i $vcf -p pop_file -a -f --proj 20;     done; done
 2960  for rep in {1..5};do     for gen_vcf in `find -print | grep "15Mb-" | grep "$rep.gen.new.vcf$"`;do         plink --vcf $gen_vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 5 0.5 --out $gen_vcf.plink_ld05;     done; done
 2961  conda activate plink
 2962  for rep in {1..5};do     for gen_vcf in `find -print | grep "15Mb-" | grep "$rep.gen.new.vcf$"`;do         plink --vcf $gen_vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 5 0.5 --out $gen_vcf.plink_ld05;     done; done
 2963  for rep in {1..5};do     for gen_vcf in `find -print | grep "15Mb-" | grep "$rep.gen.new.vcf$"`;do         plink --vcf $gen_vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --extract $gen_vcf.plink_ld05.prune.in --out $gen_vcf.plink_ld05.pruned --keep-allele-order --recode vcf;     done; done
 2964  for rep in {1..5};do     for vcf in `find -print | grep "15Mb-" | grep "$rep.gen.new.vcf.plink_ld05.pruned.vcf$"`;do          $easySFS -i $vcf -p pop_file -a -f --proj 20;     done; done
 2965  conda activate bioproject
 2966  for rep in {1..5};do     for vcf in `find -print | grep "15Mb-" | grep "$rep.gen.new.vcf.plink_ld05.pruned.vcf$"`;do          $easySFS -i $vcf -p pop_file -a -f --proj 20;     done; done
 2967  for vcf in `find -print | grep "15Mb-" | grep "$1_1.gen.new.vcf.plink_ld05.pruned.vcf$"`;do     for size in {10,40,100};do         bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1,"pop$size"}' > pop"$size"_file;     done; doneoo
 2968  conda activate bcftools
 2969  ## 10 - 40 -100 diploid samples (workers) -> (20,80,200) genomes
 2970  for vcf in `find -print | grep "15Mb-" | grep "$1_1.gen.new.vcf.plink_ld05.pruned.vcf$"`;do     for size in {10,40,100};do         bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1,"pop$size"}' > pop"$size"_file;     done; done
 2971  for folder in {10000Ne,100000Ne,1000000Ne};do     for vcf in `find $folder -print | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"`;do         bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1,pop"$size"}' > "$folder"/pop"$size"_file;     done; 
 2972  cd ..
 2973  for folder in {10000Ne,100000Ne,1000000Ne};do     for vcf in `find $folder -print | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"`;do         bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1,pop"$size"}' > "$folder"/pop"$size"_file;     done; done
 2974  for folder in {10000Ne,100000Ne,1000000Ne};do     for vcf in `find $folder -print | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"`;do     echo $vcf;     done; done
 2975  find 100000Ne -print | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf
 2976  find ./100000Ne -print | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf
 2977  find ./100000Ne -print | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf"
 2978  find ./100000Ne -print | grep "15Mb-" 
 2979  find ./10000Ne_rep -print | grep "15Mb-" 
 2980  find ./10000Ne_5rep -print | grep "15Mb-" 
 2981  for folder in {10000Ne_5rep,100000Ne_5rep,1000000Ne_5rep};do     for vcf in `find ./$folder -print | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"`;do         bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1,pop"$size"}' > "$folder"/pop"$size"_file;     done; done
 2982  for folder in {10000Ne_5rep,100000Ne_5rep,1000000Ne_5rep};do     for vcf in `find ./$folder -print | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"`;do         bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1,pop"$size"}' > ./$folder/pop"$size"_file;     done; done
 2983  for folder in {10000Ne_5rep,100000Ne_5rep,1000000Ne_5rep};do     for size in {10,40,100};do     vcf=`find ./$folder -print | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"`;do
 2984      bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1,pop"$size"}' > ./$folder/pop"$size"_file
 2985      done
 2986  done
 2987  for folder in {10000Ne_5rep,100000Ne_5rep,1000000Ne_5rep};do     for size in {10,40,100};do         vcf=`find ./$folder -print | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"`;do
 2988          bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1,pop"$size"}' > ./$folder/pop"$size"_file
 2989      done
 2990  done
 2991      for size in {10,40,100};do         vcf=`find ./$folder -print | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"`;         bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1,pop"$size"}' > ./$folder/pop"$size"_file;     done
 2992  find ./$folder -print | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$
 2993  find ./$folder -print | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"
 2994  find ./$folder -print | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"
 2995  find 10000Ne_5rep -print | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"
 2996  for folder in {10000Ne_5rep,100000Ne_5rep,1000000Ne_5rep};do     for size in {10,40,100};do         vcf=find ./$folder -print | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$";         bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1,pop"$size"}' > ./$folder/pop"$size"_file;     done; done
 2997  for folder in {10000Ne_5rep};do     for size in {20,80,200};do         vcf=find ./$folder -print | grep "15Mb-" | grep "$size"hapS | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$";         bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1,pop"$size"}' > ./$folder/pop"$size"_file;     done; done
 2998  for folder in {10000Ne_5rep,};do     for size in {20,80,200};do         vcf=find ./$folder -print | grep "15Mb-" | grep "$size"hapS | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$";         bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1,pop"$size"}' > ./$folder/pop"$size"_file;     done; done
 2999  find 10000Ne_5rep -print | grep "15Mb-" | grep "$size"hapS | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"
 3000  find ./10000Ne_5rep -print | grep "15Mb-" | grep "$size"hapS | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"
 3001  find ./10000Ne_5rep -print | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"
 3002  for folder in {10000Ne_5rep,};do     for size in {20,80,200};do         vcf=find ./$folder -print | grep "$size"hapS | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$";         bcftools query -l $vcf | grep 'G_1' | awk '{split($0,a,"_G");print $1,pop"$size"}' > ./$folder/pop"$size"_file;     done; done
 3003  ls
 3004  grep Ne
 3005  grep 'Ne'
 3006  ls
 3007  grep diploid
 3008  grep "diploid"
 3009  ll
 3010  ll | grep diploid
 3011  for folder in {10000Ne_5rep,};do echo $folder;done
 3012  for folder in {10000Ne_5rep,};do vcf=find $folder echo $vcf;done
 3013  for folder in {10000Ne_5rep,};do vcf=find $folder -print echo $vcf;done
 3014  for folder in {10000Ne_5rep,};do vcf=`find $folder -print` echo $vcf;done
 3015  for folder in {10000Ne_5rep,};do vcf={find $folder -print} echo $vcf;done
 3016  for folder in {10000Ne_5rep,};do vcf=${find $folder -print} echo $vcf;done
 3017  for folder in {10000Ne_5rep,};do vcf={find ./$folder -print} echo $vcf;done
 3018  for folder in {10000Ne_5rep,};do vcf={find ./$folder -print} echo vcf;done
 3019  find ./10000Ne_5rep -print
 3020  for folder in {10000Ne_5rep,};do vcf='find ./$folder -print' echo vcf;done
 3021  for folder in {10000Ne_5rep,};do vcf='find ./$folder -print' echo $vcf;done
 3022  for folder in {10000Ne_5rep,};do vcf="find ./$folder -print" echo $vcf;done
 3023  for folder in {10000Ne_5rep,100000_5rep};do vcf="find ./$folder -print" echo $vcf;done
 3024  for folder in {10000Ne_5rep,100000_5rep};do vcf=find ./$folder -print echo $vcf;done
 3025  for folder in {10000Ne_5rep,100000_5rep};do vcf={find ./$folder -print} echo $vcf;done
 3026  for folder in {10000Ne_5rep,100000Ne_5rep};do vcf={find ./$folder -print} echo $vcf;done
 3027  for folder in {10000Ne_5rep,100000Ne_5rep};do vcf=(find ./$folder -print) echo $vcf;done
 3028  for folder in {10000Ne_5rep,100000Ne_5rep};do vcf=$(find ./$folder -print) echo $vcf;done
 3029  for folder in {10000Ne_5rep,100000Ne_5rep};do vcf=${find ./$folder -print} echo $vcf;done
 3030  for folder in {10000Ne_5rep,100000Ne_5rep,1000000Ne_5rep};do     for size in {10,40,100};do         echo `find ./$folder -print | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"`;     done; done
 3031  for folder in {10000Ne_5rep,};do     for size in {20,80,200};do         bcftools query -l `find ./$folder -print | grep "$size"hapS | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"` | grep 'G_1' | awk '{split($0,a,"_G");print $1,pop"$size"}' > ./$folder/pop"$size"_file;     done; done
 3032  for folder in {10000Ne_5rep,};do     for size in {20,80,200};do         bcftools query -l `find ./$folder -print | grep "$size"hapS | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"` |         grep 'G_1' | awk var=size '{split($0,a,"_G");print $1,pop"$size"}' > ./$folder/pop"$size"_file;     done; done
 3033  for folder in {10000Ne_5rep,};do     for size in {20,80,200};do         bcftools query -l `find ./$folder -print | grep "$size"hapS | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"` |         grep 'G_1' | awk -var=size '{split($0,a,"_G");print $1,pop"$size"}' > ./$folder/pop"$size"_file;     done; done
 3034  for folder in {10000Ne_5rep,};do     for size in {20,80,200};do         bcftools query -l `find ./$folder -print | grep "$size"hapS | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"` |         grep 'G_1' | awk -v var=size '{split($0,a,"_G");print $1,pop"$size"}' > ./$folder/pop"$size"_file;     done; done
 3035  for folder in {10000Ne_5rep,};do     for size in {20,80,200};do         bcftools query -l `find ./$folder -print | grep "$size"hapS | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"` |         grep 'G_1' | awk -v var=$size '{split($0,a,"_G");print $1,"pop$size"}' > ./$folder/pop"$size"_file;     done; done
 3036  for folder in {10000Ne_5rep,};do     for size in {20,80,200};do         bcftools query -l `find ./$folder -print | grep "$size"hapS | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"` |         grep 'G_1' | awk -v var=$size '{split($0,a,"_G");print $1,pop$size}' > ./$folder/pop"$size"_file;     done; done
 3037  for folder in {10000Ne_5rep,};do     for size in {20,80,200};do         bcftools query -l `find ./$folder -print | grep "$size"hapS | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"` |         grep 'G_1' | awk -v var=$size '{split($0,a,"_G");print $1,'pop$size'}' > ./$folder/pop"$size"_file;     done; done
 3038  for folder in {10000Ne_5rep,};do     for size in {20,80,200};do         bcftools query -l `find ./$folder -print | grep "$size"hapS | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"` |         grep 'G_1' | awk '{split($0,a,"_G");print $1,'pop$size'}' > ./$folder/pop"$size"_file;     done; done
 3039  for folder in {10000Ne_5rep,};do     for size in {20,80,200};do         bcftools query -l `find ./$folder -print | grep "$size"hapS | grep "15Mb-" | grep "1_1.gen.new.vcf.plink_ld05.pruned.vcf$"` |         grep 'G_1' | awk -v var=$size '{split($0,a,"_G");print $1,"pop"var}' > ./$folder/pop"$size"_file;     done; done
 3040   $easySFS
 3041  /home/yzliu/bin/easySFS/easySFS.py -h
 3042  cd ..
 3043  cd ./../..
 3044  find -print | grep "10000Ne" | grep "15Mb-"
 3045  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3
 3046  find -print | grep "10000Ne" | grep "15Mb-"
 3047  ls ./10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1.gen.new.vcf.plink_ld05.prune.out
 3048  ls ./10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1.gen.new.vcf.plink_ld05.prune.out | sed -e 's/^\(.*\)\/ft_sim_*.pruned.vcf/\1/'
 3049  ls ./10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1.gen.new.vcf.plink_ld05.prune.out | sed -e 's/\(.*\)\/ft_sim_*.pruned.vcf/\1/'
 3050  sed -e 's/\(.*\)\/ft_sim_*.pruned.vcf/\1/' ./10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1.gen.new.vcf.plink_ld05.prune.out
 3051  ls ./10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1.gen.new.vcf.plink_ld05.prune.out
 3052  ls ./10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1.gen.new.vcf.plink_ld05.prune.out | sed -e 's/\(.*\)Mb\-\/ft_sim_*.pruned.vcf/\1/'
 3053  ls ./10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1.gen.new.vcf.plink_ld05.prune.out | sed -e 's/\(.*\)Mb\-\/ft_sim_*.pruned.vcf/\/'
 3054  ls ./10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1.gen.new.vcf.plink_ld05.prune.out | sed -e 's/\(.*\)Mb-\/ft_sim_*.pruned.vcf/\1/'
 3055  ls ./10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1.gen.new.vcf.plink_ld05.prune.out | sed -e 's/\.\/\(.*\)\/ft_sim_*.pruned.vcf/\1/'
 3056  ls ./10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1.gen.new.vcf.plink_ld05.prune.out | sed -e 's/\.\/\(.*\)\/ft_sim_*.pruned.vcf*out/\1/'
 3057  stringZ=abcABC123ABCabc
 3058  echo ${stringZ/abc/xxx}
 3059  string=`ls ./10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1.gen.new.vcf.plink_ld05.prune.out`
 3060  echo $string
 3061  echo ${string//ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1.gen.new.vcf.plink_ld05.prune.out/}
 3062  echo ${string//ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1.gen.new.vcf.plink_ld05.prune.out//}
 3063  echo ${string/\/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1.gen.new.vcf.plink_ld05.prune.out//}
 3064  echo ${string/\/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1.gen.new.vcf.plink_ld05.prune.out/}
 3065  echo ${string/\/ft_sim_10000Ne_*.new.vcf.plink_ld05.prune.out/}
 3066  echo ${string/\/ft_sim_10000Ne_*.new.vcf.plink*.prune.out/}
 3067  echo ${string/\/ft_sim_10000Ne_*.new.vcf.plink*.prune.out//}
 3068  echo ${string//ft_sim_10000Ne_*.new.vcf.plink*.prune.out/}
 3069  echo ${string//ft_sim_10000Ne_*.new.vcf.plink*.prune.out//}
 3070  echo ${string//ft_sim_10000Ne_*.new.vcf.plink*.prune.out}
 3071  echo ${string/\/ft_sim_10000Ne_*.new.vcf.plink*.prune.out}
 3072  echo ${string/\/ft_sim_10000Ne_*.new.vcf.plink*.prune.out//}
 3073  echo ${string/\/ft_sim_10000Ne_*.new.vcf.plink*.prune.out/00/}
 3074  echo ${string/\/ft_sim_10000Ne_*.new.vcf.plink*.prune.out/00}
 3075  vcf_dir=`ls ./10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1.gen.new.vcf.plink_ld05.prune.out`
 3076  echo $vcf_dir
 3077  echo ${vcf_dir/*.vcf/}
 3078  echo ${vcf_dir/%ft_sim*.vcf/}
 3079  echo ${vcf_dir/\/%ft_sim*.vcf/}
 3080  echo ${vcf_dir/\/ft_sim*.vcf/}
 3081  echo ${vcf_dir/ft_sim*.vcf/}
 3082  echo ${vcf_dir/#ft_sim*.vcf/}
 3083  echo ${vcf_dir/%ft_sim*.vcf/}
 3084  less $vcf_dir
 3085  echo ${vcf_dir/.vcf/}
 3086  echo $vcf_dir
 3087  echo ${vcf_dir/%ft_sim/}
 3088  echo ${vcf_dir/ft_sim/}
 3089  echo ${vcf_dir/#ft_sim/}
 3090  echo $vcf_dir
 3091  $vcf_dir.split("/",2).join("/")
 3092  $vcf_dir.split("/",2)
 3093  $vcf_dir.split("\/",2)
 3094  var str = "Lorem Ipsum is simply& dummy text of the &printing and & typesetting industry."
 3095  str = "Lorem Ipsum is simply& dummy text of the &printing and & typesetting industry."
 3096  split -h
 3097  split --help
 3098  split("$vcf_dir","/",2)
 3099  split($vcf_dir,"/",2)
 3100  split($vcf_dir,"/")
 3101  split($vcf_dir,a,"/")
 3102  echo $vcf_dir
 3103  echo $vcf_dir | cut -d "/" -f 1,2
 3104  echo $vcf_dir | cut -d "/" -f 1,2,3
 3105  vcf_dir= `ls $vcf`
 3106  vcf_dir=`ls $vcf`
 3107  echo $vcf_dir | cut -d "/" -f 1,2,3
 3108  vcf_dir=`ls /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_5.gen.new.vcf.plink_ld05.pruned.vcf`
 3109  echo $vcf_dir
 3110  echo $vcf_dir | cut -d "/" -f 1,2,3
 3111  vcf_dir=DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_5.gen.new.vcf.plink_ld05.pruned.vcf
 3112  echo $vcf_dir | cut -d "/" -f 1,2,3
 3113  find -print | grep "10000Ne" | grep "15Mb-" 
 3114  vcf_dir=./10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_2.gen.new.vcf.plink_ld05.pruned.vcf
 3115  echo $vcf_dir | cut -d "/" -f 1,2,3
 3116  for rep in {1..5};do     for vcf in `find -print | grep "10000Ne" | grep "15Mb-" | grep "$rep.gen.new.vcf.plink_ld05.pruned.vcf$"`;do          vcf_dir=`ls $vcf`;         out_dir=`echo $vcf_dir | cut -d "/" -f 1,2,3`;         $easySFS -i $vcf -p pop_file -a -f --proj 20 -o $out_dir;     done; done
 3117  conda activate bioproject
 3118  for rep in {1..5};do     for vcf in `find -print | grep "10000Ne" | grep "15Mb-" | grep "$rep.gen.new.vcf.plink_ld05.pruned.vcf$"`;do          vcf_dir=`ls $vcf`;         out_dir=`echo $vcf_dir | cut -d "/" -f 1,2,3`;         $easySFS -i $vcf -p pop_file -a -f --proj 20 -o $out_dir;     done; done
 3119  cd 100000Ne_5rep/
 3120  cd ../10000Ne_5rep/
 3121  for rep in {1..5};do     for vcf in `find -print | grep "10000Ne" | grep "15Mb-" | grep "$rep.gen.new.vcf.plink_ld05.pruned.vcf$"`;do          vcf_dir=`ls $vcf`;         out_dir=`echo $vcf_dir | cut -d "/" -f 1,2,3`;         $easySFS -i $vcf -p pop_file -a -f --proj 20 -o $out_dir;     done; done
 3122  for rep in {1..5};do     for vcf in `find -print | grep "10000Ne" | grep "15Mb-" | grep "$rep.gen.new.vcf.plink_ld05.pruned.vcf$"`;do          vcf_dir=`ls $vcf`;         out_dir=`echo $vcf_dir | cut -d "/" -f 1,2`;         $easySFS -i $vcf -p pop_file -a -f --proj 20 -o $out_dir;     done; done
 3123  ll /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/fastsimcoal2
 3124  cat /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/fastsimcoal2/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_5_MSFS.obs
 3125  while read -r line;do echo $line;done < /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/fastsimcoal2/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_5_MSFS.obs
 3126  while IFS= read -r line;do echo $line;done < /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/fastsimcoal2/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_5_MSFS.obs
 3127  sfs=/home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/fastsimcoal2/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_5_MSFS.obs
 3128  awk 'NR==3' $sfs | cut -f 2-11
 3129  awk 'NR==3' $sfs | cut -d " " -f 2-11
 3130  for rep in {1..5};do     for sfs in `find -print | grep "10000Ne" | grep "15Mb-" | grep "$rep_MSFS.obs$"`;do          awk 'NR==3' $sfs | cut -d " " -f 2-11;     done; done
 3131  for rep in {1..5};do     for sfs in `find -print | grep "10000Ne_5rep" | grep "15Mb-" | grep "$rep_MSFS.obs$"`;do          awk 'NR==3' $sfs | cut -d " " -f 2-11;     done; done
 3132  for rep in {1..5};do     for sfs in `find . -print | grep "10000Ne" | grep "15Mb-" | grep "$rep_MSFS.obs$"`;do          awk 'NR==3' $sfs | cut -d " " -f 2-11;     done; done
 3133  find . -print | grep "10000Ne" | grep "15Mb-" | grep "$rep_MSFS.obs$"
 3134  find . -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep "$rep_MSFS.obs$"
 3135  find . -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep "_$rep_MSFS.obs$"
 3136  find . -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep "$rep"_MSFS.obs$
 3137  for rep in {1..5};do     for sfs in `find -print | grep "10000Ne_5rep" | grep "15Mb-" | grep fastsimcoal2 | grep "_$rep_MSFS.obs$"`;do          awk 'NR==3' $sfs | cut -d " " -f 2-11;     done; done
 3138  for rep in {1..5};do     for sfs in `find -print | grep "10000Ne_5rep" | grep "15Mb-" | grep fastsimcoal2 | grep "$rep_MSFS.obs$"`;do          awk 'NR==3' $sfs | cut -d " " -f 2-11;     done; done
 3139  for rep in {1..5};do     for sfs in `find -print | grep -e "10000Ne_5rep" -e "15Mb-" -e grep fastsimcoal2 -e grep "$rep_MSFS.obs$"`;do          awk 'NR==3' $sfs | cut -d " " -f 2-11;     done; done
 3140  for rep in {1..5};do     for sfs in `find -print | grep -e "10000Ne_5rep" -e "15Mb-" -e fastsimcoal2 -e "$rep_MSFS.obs$"`;do          awk 'NR==3' $sfs | cut -d " " -f 2-11;     done; done
 3141  for rep in {1..5};do     for sfs in `find -print | grep -e "10000Ne_5rep" -e "15Mb-" -e "fastsimcoal2" -e "$rep_MSFS.obs$"`;do          awk 'NR==3' $sfs | cut -d " " -f 2-11;     done; done
 3142  for rep in {1..5};do     for sfs in `find ./ -print | grep "10000Ne_5rep" | grep "15Mb-" | grep fastsimcoal2 | grep "$rep_MSFS.obs$"`;do          awk 'NR==3' $sfs | cut -d " " -f 2-11;     done; done
 3143  find ./ -print | grep "10000Ne_5rep" | grep "15Mb-" | grep fastsimcoal2 | grep "$rep_MSFS.obs$"
 3144  find ./ -print | grep "10000Ne_5rep" | grep "15Mb-" | grep fastsimcoal2
 3145  find ./ -print
 3146  find ./ -print | grep "10000Ne_5rep" | grep "15Mb-"
 3147  find ./ -print | grep "10000Ne_5rep"
 3148  find ./ -print | grep 10000Ne_5rep
 3149  find -print | grep 10000Ne_5rep
 3150  find -print
 3151  find ./ -print
 3152  for rep in {1..5};do     for sfs in `find ./ -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep "$rep_MSFS.obs$"`;do          awk 'NR==3' $sfs | cut -d " " -f 2-11;     done; done
 3153  for rep in {1..5};do     sfs=`find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep "_$rep_MSFS.obs$"`;     awk 'NR==3' $sfs | cut -d " " -f 2-11; done
 3154  for rep in {1..5};do     awk 'NR==3' `find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep "_$rep_MSFS.obs$"` | cut -d " " -f 2-11; done
 3155  for rep in {1..5};do     find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep "_$rep_MSFS.obs$" | awk 'NR==3' | cut -d " " -f 2-11;  done
 3156  find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2
 3157  ## output sfs from files
 3158  for rep in {1..5};do     sfs=`find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep "$rep_MSFS.obs$"`;     echo $sfs; done
 3159  for rep in {1..5};do     sfs=`find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep "$rep_MSFS.obs$"`     awk 'NR==3' $sfs | cut -d " " -f 2-11; done
 3160  for rep in {1..5};do     sfs=`find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep "$rep_MSFS.obs$"` done
 3161  for rep in {1..5};do     sfs=`find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep "$rep_MSFS.obs$"`;     echo -e "$sfs\n" done
 3162  sfs=`find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep _MSFS.obs$`
 3163  awk 'NR==3' $sfs | cut -d " " -f 2-11
 3164  echo $sfs
 3165  echo -e $sfs\n
 3166  echo -e "$sfs\n"
 3167  find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep _MSFS.obs$ | sort -V
 3168  sfs=`find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep _MSFS.obs$ | sort -V`
 3169  for i in $sfs;do     echo -e "$sfs\n";     awk 'NR==3' $i | cut -d " " -f 2-11; done
 3170  for i in $sfs;do     echo -e "$i";     awk 'NR==3' $i | cut -d " " -f 2-11; done
 3171  for i in $sfs;do     echo -e "$i\n";     awk 'NR==3' $i | cut -d " " -f 2-11; done
 3172  for i in $sfs;do     echo -e "\n";     awk 'NR==3' $i | cut -d " " -f 2-11;     echo -e "$i\n"; done
 3173  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11;     echo -e "$i\n"; done
 3174  sfs=`find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep _MSFS.obs$ | sort -V`
 3175  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11; echo -e "$i\n"; done
 3176  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11 | sed 's/\\n/\\t/g'; echo -e "$i\n"; done
 3177  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11 | sed 's/\n/\t/g'; echo -e "$i\n"; done
 3178  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11 | sed 's/\\n/\\t/g'; done
 3179  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11 | sed 's/\\n$/\\t/g'; done
 3180  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11; echo -e "$i\n"; done
 3181  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11; echo -e "$i\n"; done > sfs_file_name
 3182  cat sfs_file_name
 3183  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11; echo -e "$i\n"; done > sfs_file_name.txt
 3184  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11; echo -e "$i\n"; done >> sfs_file_name.1.txt
 3185  sed 1d sfs_file_name.1.txt
 3186  sed -d '1d' sfs_file_name.1.txt
 3187  sed -i '1d' sfs_file_name.1.txt
 3188  sed 's/\\n/\\t/g' sfs_file_name.1.txt
 3189  sed 's/\n/\t/g' sfs_file_name.1.txt
 3190  sed 's/\\n/\\t/g' sfs_file_name.1.txt
 3191  sed 's/\\s/\\t/g' sfs_file_name.1.txt
 3192  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11 | tr -d $'\n'; echo -e "$i\n"; done
 3193  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11 | tr -d $'\n'; echo -e "\t$i\n"; done
 3194  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11 | tr -d $'\n';     echo -e "\t$i\n" > sfs_file.txt; done
 3195  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11 | tr -d $'\n'; echo -e "\t$i\n"; done
 3196  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11 | tr -d $'\n'; echo -e "\t$i\n"; done > sfs_file.txt
 3197  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11 | tr -d $'\n'; echo -e "\t$i"; done > sfs_file.txt
 3198  history | grep split
 3199  cat sfs
 3200  cat sfs_file.txt 
 3201  sfs=`cat sfs_file.txt`
 3202  $sfs.split("/",3).join("/")
 3203  cat sfs_file.txt | cut -d "/" -f 1,3
 3204  cat sfs_file.txt | cut -d "/" -f 1,4
 3205  cat sfs_file.txt | cut -d "/" -f 1,4 | sed 's/\.\///' > sfs_file.new.txt
 3206  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11 | tr -d $'\n';     echo -e "\s$i"; done > sfs_file.txt
 3207  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11 | tr -d $'\n';     echo -e "\t$i"; done > sfs_file.txt
 3208  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11 | tr -d $'\n'; echo -e "\t$i"; done > sfs_file.txt
 3209  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11 | tr -d $'\n';     echo -e "\t$i"; done > sfs_file.txt
 3210  sfs=`find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep _MSFS.obs$ | sort -V`
 3211  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11 | tr -d $'\n';     echo -e "\t$i"; done > sfs_file.txt
 3212  cat sfs_file.txt | cut -d "/" -f 1,4 | sed 's/\.\///' > sfs_file.new.txt
 3213  cat sfs_file.new.txt
 3214  squeue -u yzliu
 3215  ls /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne
 3216  ll /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne
 3217  ll /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne | sort -n
 3218  ll /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne | sort -V
 3219  ll /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne | sort
 3220  ll /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne | sort -V
 3221  ls /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne | sort -V
 3222  ls /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne | sort -V | grep -v i_
 3223  ls /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne | sort -V | grep i_
 3224  ls /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne | sort -V | grep -v i_ > ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.list
 3225  ls /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne | sort -V | grep i_ >> ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.list
 3226  tail ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.li
 3227  tail ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.list
 3228  head ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.list
 3229  par_list=ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.list
 3230  par_list_new=ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.list
 3231  sed 's/\.par//g' $par_list > $par_list_new
 3232  par_list_new_5rep=ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.5rep.list
 3233  for par in `cat ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.list`;do     for rep in {1..5};do         touch "$par"_1_"$rep"_MSFS.obs;     done; done > $par_list_new_5rep
 3234  for par in `cat ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.list`;do     for rep in {1..5};do         echo "$par"_1_"$rep"_MSFS.obs;     done; done > $par_list_new_5rep
 3235  par_list_new_5rep_blueprint=ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.5rep_blueprint.list
 3236  for par in `cat ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.list`;do     for rep in {1..5};do         echo "$par"_1_"$rep"_MSFS.blueprint;     done; done > $par_list_new_5rep_blueprint
 3237  for par in `cat ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.list`;do     for rep in {1..5};do         echo "$par"_1_"$rep"_MSFS.blueprint >> $par_list_new_5rep_blueprint;     done; done
 3238  head $par_list_new
 3239  par_list=ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.list
 3240  par_list_new=ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.list
 3241  par_list_new_5rep_blueprint=ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.5rep_blueprint.list
 3242  sed 's/\.par//g' $par_list > $par_list_new
 3243  ls
 3244  cat sfs_file.txt
 3245  cat sfs_file.txt | touch cat_touch.txt
 3246   touch cat_touch.txt < cat sfs_file.txt
 3247   touch cat_touch.txt <& cat sfs_file.txt
 3248  cd /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint
 3249  ls
 3250  bp_file=ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.5rep_blueprint_5.list
 3251  bp_template=ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_0_MSFS.blueprint
 3252  for blueprint_content in `cat $bp_file`;do     echo $bp_template > $bp_file; done
 3253  echo $bp_template
 3254  echo $bp_template 
 3255  cat $bp_file
 3256  less -S ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.5rep_blueprint_5.list
 3257  cat $bp_file
 3258  cat $bp_template
 3259  bp_file_names=ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.5rep_blueprint_5.list
 3260  bp_template=ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_0_MSFS.blueprint
 3261  for bp_file in `cat $bp_file_names`;do     cat $bp_template > $bp_file; done
 3262  ls
 3263  head sfs_file.new.txt
 3264  for i in {1..5};do     awk 'FNR==$i {ptint}' sfs_file.new.txt; done
 3265  for i in {1..5};do     awk 'FNR=$i {ptint}' sfs_file.new.txt; done
 3266  for i in {1..5};do     awk 'FNR=$i {ptint $0}' sfs_file.new.txt; done
 3267  for i in {1..5};do     awk '{ptint $i}' sfs_file.new.txt; done
 3268  for i in {1..5};do     awk '{ptint $i}'; done
 3269  input="sfs_file.new.txt"
 3270  while IFS= read -r line; do   echo "$line"; done < "$input"
 3271  while IFS= read -r line; do   cut -d "\t" -f 1 "$line"; done < "$input"
 3272  input="sfs_file.new.txt"
 3273  while IFS= read -r line; do   cut -d "\t" -f 1 $line; done < $input
 3274  cut -d "\t" -f 1 sfs_file.new.txt
 3275  cut -f 1 sfs_file.new.txt
 3276  cut -d "\t" -f 2 sfs_file.new.txt
 3277  cut -f 2 sfs_file.new.txt
 3278  cut -d "\t" -f 2 sfs_file.new.txt
 3279  cut -d '\t' -f 2 sfs_file.new.txt
 3280  cut -d "\\t" -f 2 sfs_file.new.txt
 3281  while IFS= read -r line; do   cut -f 1 $line; done < $input
 3282  for i in {1..5};do     awk 'FNR==$i {ptint $1}' sfs_file.new.txt; done
 3283  for i in {1..5};do     awk -v var=$i 'FNR==var {ptint $1}' sfs_file.new.txt; done
 3284  for i in {1..5};do     awk -v var=$i 'FNR== {ptint $1}' sfs_file.new.txt; done
 3285  for i in {1..5};do     awk 'FNR== {ptint $1}' sfs_file.new.txt; done
 3286  awk 'FNR== {ptint $1}' sfs_file.new.txt
 3287  awk 'FNR==1 {ptint $1}' sfs_file.new.txt
 3288  awk -F ' ' 'FNR==1 {ptint $1}' sfs_file.new.txt
 3289  awk '{ptint $1}' sfs_file.new.txt
 3290  awk -F '\t' 'FNR==1 {ptint $1}' sfs_file.new.txt
 3291  awk -F "\t" 'FNR==1 {ptint $1}' sfs_file.new.txt
 3292  awk -F "\t" 'FNR==1 {ptint}' sfs_file.new.txt
 3293  awk 'BEGIN{FS="\t"} {print $1}' sfs_file.new.txt
 3294  for i in {1..5};do     awk -v var=$i 'FNR==var BEGIN{FS="\t"}{ptint $1}' sfs_file.new.txt; done
 3295  awk 'BEGIN{FS="\t"} {print $2}' sfs_file.new.txt
 3296  cut -d " " -f 2 sfs_file.new.txt
 3297  cut -d "\t" -f 2 sfs_file.new.txt
 3298  for i in {1..5};do     awk -v var=$i 'FNR==$var BEGIN{FS="\t"}{ptint $1}' sfs_file.new.txt; done
 3299  for i in {1..5};do     awk -v var=$i 'FNR==$var{ptint $1}' sfs_file.new.txt; done
 3300  for i in {1..5};do     awk -F "\t" -v var=$i 'FNR==$var{ptint $1}' sfs_file.new.txt; done
 3301  for i in {1..5};do     awk -F "\t" -v var=$i 'FNR==$var {ptint $1}' sfs_file.new.txt; done
 3302  for i in {1..5};do     awk -F "\t" -v var=$i 'FNR==var {ptint $1}' sfs_file.new.txt; done
 3303  for i in {1..5};do     awk -F "\t" -v var=$i 'FNR==$i {ptint $1}' sfs_file.new.txt; done
 3304  for i in {1..5};do     awk -F "\t" -v var=$i 'FNR=$i {ptint $1}' sfs_file.new.txt; done
 3305  for i in {1..5};do     awk -F "\t" -v var=$i 'FNR=i {ptint $1}' sfs_file.new.txt; done
 3306  for i in {1..5};do     awk -F "\t" -v var=$i 'NR==var {ptint $1}' sfs_file.new.txt; done
 3307  for i in {1..5};do     awk 'NR > 3 {ptint $1}' sfs_file.new.txt; done
 3308  for i in {1..5};do     awk -F "\t" 'NR > 3 {ptint $1}' sfs_file.new.txt; done
 3309  for i in {1..5};do echo $i;done
 3310  awk 'NR > 3 { print $1, $2 }' sfs_file.new.txt;
 3311  awk -F "\t" 'NR > 3 { print $1, $2 }' sfs_file.new.txt;
 3312  awk -F "\t" 'NR > 3 { print $1}' sfs_file.new.txt;
 3313  awk -F "\t" 'NR = 3 { print $1}' sfs_file.new.txt;
 3314  awk -F "\t" 'FNR = 3 { print $1}' sfs_file.new.txt;
 3315  awk -F "\t" 'FNR == 3 { print $1}' sfs_file.new.txt;
 3316  awk -F "\t" 'NR == 3 { print $1}' sfs_file.new.txt;
 3317  for i in {1..5};do     awk -F "\t" -v var=$i 'NR==var {ptint $1}' sfs_file.new.txt; done
 3318  for i in {1..5};do     awk -F "\t" -v var=i 'NR==var {ptint $1}' sfs_file.new.txt; done
 3319  for i in {1..5};do     awk -F "\t" -v var=$i 'NR==$var {ptint $1}' sfs_file.new.txt; done
 3320  for i in {3..5};do     awk -F "\t" -v var=$i 'NR==$var {ptint $1}' sfs_file.new.txt; done
 3321  for i in {3..5};do     awk -F "\t" 'NR==3 {ptint $1}' sfs_file.new.txt; done
 3322  for i in {3..5};do     awk -F "\t" 'NR==$i {ptint $1}' sfs_file.new.txt; done
 3323  for i in {3..5};do     awk -F "\t" -v var=$i 'FNR==var {ptint $1}' sfs_file.new.txt; done
 3324  for i in {3..5};do     awk -F " " -v var=$i 'FNR==var {ptint $1}' sfs_file.new1.txt; done
 3325  for i in {3..5};do     awk -F " " -v var=$i 'FNR==var {ptint $1}END' sfs_file.new1.txt; done
 3326  for i in {3..5};do     awk -F " " -v var=$i 'FNR==var END {ptint $1}' sfs_file.new1.txt; done
 3327  bashvar="2"
 3328  echo 'foo bar baz' | awk -v awkvar="$bashvar" '{print $awkvar}'
 3329  echo 'foo bar baz' | awk -v awkvar=2 '{print $awkvar}'
 3330  for i in {3..5};do     awk -F " " -v var="$i" 'FNR==var END {ptint $1}' sfs_file.new1.txt; done
 3331  for i in {3..5};do     awk -F " " -v var="$i" 'FNR==var {ptint $1}' sfs_file.new1.txt; done
 3332  for i in ' '; do   echo "foo bar" | awk -v i="$i" '{print $1"<"i">"$2}'; done
 3333  for i in {1..5}; do   echo "foo bar" | awk -v i="$i" '{print $1"<"i">"$2}'; done
 3334  for i in {3..5};do     awk -F " " -v var="$i" 'FNR==var {ptint $1}' sfs_file.new1.txt; done
 3335  for i in {1..5};do     awk -F " " -v var=$i 'FNR==var {ptint $1}' sfs_file.new.txt; done
 3336  awk -F "\t" 'NR = 3 { print $1}' sfs_file.new.txt
 3337  cd /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint
 3338  ls
 3339  for i in {1..5};do     awk -F " " -v var=$i 'FNR==var {ptint $1}' sfs_file.new.txt; done
 3340  for i in {1..5};do     awk -F " " -v var=$i 'FNR==var {ptint $1}' sfs_file.new1.txt; done
 3341  for i in {1..5};do     awk -v var=$i 'FNR==var {ptint $1}' sfs_file.new1.txt; done
 3342  for i in {1,5};do     awk -v var=$i 'FNR==var {ptint $1}' sfs_file.new1.txt; done
 3343  for i in 1 2;do     awk -v var=$i 'FNR==var {ptint $1}' sfs_file.new1.txt; done
 3344  for i in {2..5};do     awk -v var=$i 'FNR==var {ptint $1}' sfs_file.new1.txt; done
 3345  for i in {2..5};do     awk -v var=$i 'FNR==var {print $1}' sfs_file.new1.txt; done
 3346  for i in {2..5};do     awk -v var=$i 'FNR==var {print $1}' sfs_file.new.txt; done
 3347  for i in {2..5};do     awk -F "\t" -v var=$i 'FNR==var {print $1}' sfs_file.new.txt; done
 3348  for i in {2..5};do     awk -F " " -v var=$i 'FNR==var {print $1}' sfs_file.new.txt; done
 3349  for i in {2..5};do     awk -F " " -v var=$i 'FNR==$var {print $1}' sfs_file.new.txt; done
 3350  for i in {1..5};do     sfs=`awk -F " " -v var=$i 'FNR==var {print $1}' sfs_file.new.txt`;     sed -i "3s/AA/$sfs/" ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_"$i"_MSFS.blueprint; done
 3351  for i in {2..5};do     awk -F "\t" -v var=$i 'FNR==$var {print $1}' sfs_file.new.txt; done
 3352  head sfs_file.new.txt
 3353  for i in {2..5};do     awk -F "\t" -v var=$i 'FNR==var {print $1}' sfs_file.new.txt; done
 3354  for i in {2..5};do     awk -F "\t" -v var=$i 'FNR==var {print $2}' sfs_file.new.txt; done
 3355  for i in {4..5};do     sfs=`awk -F "\t" -v var=$i 'FNR==var {print $2}' sfs_file.new.txt`;     sed -i "3s/AA/$sfs/" ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_"$i"_MSFS.blueprint; done
 3356  for i in {1..3};do     sfs=`awk -F "\t" -v var=$i 'FNR==var {print $2}' sfs_file.new.txt`;     sed -i "3s/AA/$sfs/" ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_"$i"_MSFS.blueprint; done
 3357  for i in {4..5};do     sfs1=`awk -F "\t" -v var=$i 'FNR==var {print $2}' sfs_file.new.txt`;     sed -i -e "3s/AA/$sfs1/" -e "12s/AA/$sfs1/" -e "20s/AA/$sfs/" ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_"$i"_MSFS.blueprint     sfs2=`awk -F "\t" -v var=$i 'FNR==var {print $1}' sfs_file.new.txt`;     sed -i "7s/AA/$sfs2/" ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_"$i"_MSFS.blueprint; done
 3358  for i in {4..5};do     sfs1=`awk -F "\t" -v var=$i 'FNR==var {print $2}' sfs_file.new.txt`;     sed -i -e "3s/AA/$sfs1/" -e "12s/CC/$sfs1/" -e "20s/DD/$sfs/" ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_"$i"_MSFS.blueprint     sfs2=`awk -F "\t" -v var=$i 'FNR==var {print $1}' sfs_file.new.txt`;     sed -i "7s/BB/$sfs2/" ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_"$i"_MSFS.blueprint; done
 3359  head sfs_file.new.txt
 3360  for i in {4..5};do     sfs1=`awk -F "\t" -v var=$i 'FNR==var {print $2}' sfs_file.new.txt`;     sed -i -e "3s/AA/$sfs1/" -e "12s/CC/$sfs1/" -e "20s/DD/$sfs1/" ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_"$i"_MSFS.blueprint     sfs2=`awk -F "\t" -v var=$i 'FNR==var {print $1}' sfs_file.new.txt`;     sed -i "7s/BB/$sfs2/" ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_"$i"_MSFS.blueprint; done
 3361  gnodes
 3362  squeue -u yzliu
 3363  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 3364  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne
 3365  ls $par_folder/ft_sim_100000Ne*1E_*20Chr_15Mb.par | sort -V
 3366  ls $par_folder/ft_sim_100000Ne*1E_*05i*20Chr_15Mb.par | sort -V
 3367  ls $par_folder/ft_sim_100000Ne*1E_*05i*20Chr_15Mb.par | sort -V | wc -l
 3368  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/
 3369  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/ft_sim_10K_100K_1MNe_20_80_200_200S_1E_05i_20Chr_15Mb_5rep.sh
 3370  squeue -u yzliu
 3371  man
 3372  bash
 3373  bash -h
 3374  squeue -u yzliu
 3375  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i
 3376  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 3377  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne_50i/
 3378  ls $par_folder/ft_sim_100000Ne*1E_*05i*20Chr_1500Kb.par
 3379  par=`ls $par_folder/ft_sim_100000Ne*1E_*05i*20Chr_1500Kb.par`
 3380  $fsc -i $par -n 5 -q -s 0 -m --foldedSFS -c 8 -g -G -k 300000000
 3381  par=`ls $par_folder/ft_sim_100000Ne*1E_*05i*20Chr_100b.par`
 3382  $fsc -i $par -n 5 -q -s 0 -m --foldedSFS -c 8 -g -G -k 300000000
 3383  cd /home/yzliu/bin/stairway_plot_v2.1.2
 3384  java -cp stairway_plot_es Stairbuilder /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_1_1_MSFS.blueprint
 3385  bash /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_1_1_MSFS.blueprint.sh
 3386  java -cp stairway_plot_es Stairbuilder /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_1_1_MSFS.blueprint
 3387  bash /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_1_1_MSFS.blueprint.sh
 3388  java -cp stairway_plot_es Stairbuilder /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_1_1_MSFS.blueprint
 3389  bash /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_1_1_MSFS.blueprint.sh
 3390  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i
 3391  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 3392  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne_50i/
 3393  par=`ls $par_folder/ft_sim_100000Ne*1E_*05i*20Chr_15Kb.par`
 3394  $fsc -i $par -n 5 -q -s 0 -m --foldedSFS -c 8 -g -G -k 300000000
 3395  par=`ls $par_folder/ft_sim_100000Ne*1E_*05i*20Chr_15Kb.par`
 3396  $fsc -i $par -n 5 -q -s 0 -m --foldedSFS -c 8 -g -G -k 300000000
 3397  ls
 3398  rm -r *Kb
 3399  par=`ls $par_folder/ft_sim_100000Ne*1E_*05i*20Chr_5Kb.par`
 3400  $fsc -i $par -n 1 -q -s 0 -m --foldedSFS -c 8 -g -G -k 300000000
 3401  par=`ls $par_folder/ft_sim_100000Ne*1E_*05i*20Chr_1500Kb.par`
 3402  $fsc -i $par -n 1 -q -s 0 -m --foldedSFS -c 8 -g -G -k 300000000
 3403  par=`ls $par_folder/ft_sim_100000Ne*1E_*05i*20Chr_15Mb.par`
 3404  $fsc -i $par -n 1 -q -s 0 -m --foldedSFS -c 8 -g -G -k 300000000
 3405  echo $par
 3406  cd /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint
 3407  ls
 3408  head sfs_file.new1.txt
 3409  head sfs_file.new.txt
 3410  awk 'NR==3' $i | cut -d " " -f 2-81 | tr -d $'\n' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs
 3411  awk 'NR==3' $i | cut -d " " -f 2-81 /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs
 3412  awk 'NR==3' | cut -d " " -f 2-81 /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs
 3413  awk 'NR==3' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs | cut -d " " -f 2-81
 3414  awk 'NR==3' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs | cut -d " " -f 3-81
 3415  awk 'NR==3' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs | cut -d "\t" -f 3-81
 3416  awk 'NR==3' '{print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs | cut -d " " -f 3-81
 3417  awk 'NR==3{print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs | cut -d " " -f 3-81
 3418  awk 'NR==3{print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs | cut -d "\t" -f 3-81
 3419  awk 'NR==3{print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs | cut -d "\t" -f 2-81
 3420  awk 'NR==3' | cut -d "\t" -f 2-81 /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs
 3421  awk 'NR==3{print}' | cut -d "\t" -f 2-81 /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs
 3422  awk 'NR==3{print $0}' | cut -d "\t" -f 2-81 /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs
 3423  awk 'NR==3{print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs
 3424  awk 'NR==3{print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs | cut -f 2,3
 3425  awk 'NR==3{print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs | cut -f 2-81
 3426  awk 'NR==3{print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs | cut -f 2-41
 3427  awk 'NR==3{print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs | cut -f 2-42
 3428  awk 'NR==3{print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs | cut -f 2-41
 3429  awk 'NR==3{print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs | cut -d '\t' -f 2-41
 3430  awk 'NR==3{print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs | cut -d ' ' -f 2-41
 3431  awk 'NR==3{print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs | cut -d '\s+' -f 2-41
 3432  awk 'NR==3{print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs | cut -d '[\s+]' -f 2-41
 3433  awk 'NR==3{print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs | cut -d '\\s+' -f 2-41
 3434  awk 'NR==3{print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs | cut -d 's+' -f 2-41
 3435  awk 'NR==3{print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs | cut -f 2-41 | tr -d 's+'
 3436  awk 'NR==3{print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs | cut -f 2-41 | tr -d '\s+'
 3437  awk 'NR==3{print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_MAFpop0.obs | cut -f 2-41 | tr -d '\s+' > /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb.sfs
 3438  cat /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.5rep_blueprint_5.list
 3439  cat /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/sfs_file.new.txt
 3440  cat /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_0_MSFS.blueprint
 3441  cat /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.5rep_blueprint_5.list
 3442  cat /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.5rep_blueprint.list
 3443  find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep _MSFS.obs$ | sort -V
 3444  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne
 3445  find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep _MSFS.obs$ | sort -V
 3446  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/10000Ne
 3447  find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep _MSFS.obs$ | sort -V
 3448  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne
 3449  find -print | grep "100000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep _MSFS.obs$ | sort -V
 3450  cd ..
 3451  find -print | grep "100000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep _MSFS.obs$ | sort -V
 3452  find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep _MSFS.obs$ | sort -V
 3453  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/10000Ne
 3454  find -print
 3455  cd ..
 3456  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/10000Ne_5rep
 3457  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3
 3458  find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep _MSFS.obs$ | sort -V
 3459  cd /home/yzliu/bin/stairway_plot_v2.1.2
 3460  java -cp stairway_plot_es Stairbuilder /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_1MSFS.blueprint
 3461  bash /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_1MSFS.blueprint.sh
 3462  squeue -u yzliu
 3463  scancel 26742831_14
 3464  scancel 26742831_4,9
 3465  squeue -u yzliu
 3466  scancel 26742831_9
 3467  squeue -u yzliu
 3468  scancel 26742831_19
 3469  squeue -u yzliu
 3470  scancel 26742831_24,26742831_29
 3471  squeue -u yzliu
 3472  scancel 26742831_34,26742831_39,26742831_44,26742831_49,26742831_54,26742831_59
 3473  squeue -u yzliu
 3474  history 
 3475  squeue -u yzliu
 3476   cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
 3477  ls *.txt
 3478  cat sfs_file.new.txt
 3479  cat sfs_file.txt | cut -d "/" -f 1,4 | sed -e 's/\.\///' -e 's/\.obs//'
 3480  cat sfs_file.txt | cut -d "/" -f 1,4 | sed -e 's/\.\///' -e 's/obs/blueprint/'
 3481  cat sfs_file.txt | cut -d "/" -f 1,4 | sed -e 's/\.\///' -e 's/obs/blueprint/' > sfs_file.blueprint.txt
 3482  cat sfs_file.txt | cut -d "/" -f 1,4 | sed -e 's/\.\///' -e 's/obs/blueprint/' > /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/sfs_file.blueprint.txt
 3483  find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep _MSFS.obs$ | sort -V
 3484  cd 
 3485  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/
 3486  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne
 3487  ls *i_*Mb.par
 3488  cat ft_sim_100000Ne_200hapS_1E_1000G_05i_20Chr_15Mb.par
 3489  cat ft_sim_100000Ne_200hapS_1E_1000G_05i_20Chr_15Mb.par | less -N
 3490  pae_i=`ls *i_*Mb.par`
 3491  par_i=`ls *i_*Mb.par`
 3492   ft_sim_100000Ne_200hapS_1E_1000G_05i_20Chr_15Mb.par
 3493  cat --help
 3494  cat -n ft_sim_100000Ne_200hapS_1E_1000G_05i_20Chr_15Mb.par
 3495  par_i=`ls *i_*Mb.par`
 3496  echo $part_i
 3497  echo $par_i
 3498  for par_i in `ls *i_*Mb.par`;do     sed -i -e '8s/0/-0.0007/' -e '13s/1000 0 0 0 -1.50 0 0/1000 0 0 0 1.50 0 0/' $par_i; done
 3499  ls *i_*Mb.par | wc -l
 3500  cd ..
 3501  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/ft_sim_10K_100K_1MNe_20_80_200_200S_1E_05i_20Chr_15Mb_5rep.sh
 3502  squeue -u yzliu
 3503  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep
 3504  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 3505  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne
 3506  ls $par_folder/ft_sim_100000Ne*1E_*20Chr_15Mb.par | sort -V
 3507  ls $par_folder/ft_sim_100000Ne*1E_*20Chr_15Mb.par | sort -V | wc -l
 3508  ls $par_folder/ft_sim_100000Ne*1E_*20Chr_15Mb.par | sort -V | cat -n
 3509  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
 3510  ls *.txt
 3511  car sfs_file.new.txt
 3512  cat sfs_file.new.txt
 3513  find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep _MSFS.obs$ | sort -V
 3514  cat ./ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-/fastsimcoal2/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_1_MSFS.obs
 3515  tr --help
 3516  cat -n sfs_file.txt
 3517  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb-
 3518  ls *.list
 3519  ls *list
 3520  ls *listls
 3521  ls
 3522  ls *.list
 3523  cd ..
 3524  ls *.list
 3525  head ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.list
 3526  head ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.list
 3527  head ft_sim_10K_100K_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.new.5rep_blueprint.list
 3528  history
 3529  squeue -u yzliu
 3530  scancel 26928724
 3531  cd ../10000Ne
 3532  for par_i in `ls *500G*i_*Mb.par`;do     sed -i -e '8s/-0.0007/0.0013/' $par_i; done
 3533  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne
 3534  for par_i in `ls *500G*i_*Mb.par`;do     sed -i -e '8s/-0.0007/0.0013/' $par_i; done
 3535  for par_i in `ls *100G*i_*Mb.par`;do     sed -i -e '8s/-0.0007/0.0067/' $par_i; done
 3536  for par_i in `ls *100G*i_*Mb.par`;do     sed -i -e '8s/0.0067/-0.0067/' $par_i; done
 3537  for par_i in `ls *500G*i_*Mb.par`;do     sed -i -e '8s/0.0013/-0.0013/' $par_i; done
 3538  for par_i in `ls *50G*i_*Mb.par`;do     sed -i -e '8s/-0.0007/-0.0133/' $par_i; done
 3539  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/
 3540  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/ft_sim_10K_100K_1MNe_20_80_200_200S_1E_05i_20Chr_15Mb_5rep.sh
 3541  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/10000Ne
 3542  ls /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne/*i_*Mb.par
 3543  cp /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne/*i_*Mb.par .
 3544  par_i=`ls *i_*Mb.par`
 3545  ls *i_*Mb.par
 3546  for par_i in `ls *i_*Mb.par`;do     sed -i -e '4s/100000/10000/' $par_i; done
 3547  ls *i_*Mb.par
 3548  par_i=`ls *i_*Mb.par`
 3549  for par_i in `ls *i_*Mb.par`;do     sed -i '4s/100000/10000/' $par_i; done
 3550  for par_i in `ls *i_*Mb.par`;do     rename 100000Ne 10000Ne $par_i; done
 3551  cd ../1000000Ne/
 3552  cp /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne/*i_*Mb.par .
 3553  for par_i in `ls *i_*Mb.par`;do     sed -i '4s/100000/1000000/' $par_i; done
 3554  for par_i in `ls *i_*Mb.par`;do     rename 100000Ne 1000000Ne $par_i; done
 3555  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/1000000Ne_5rep
 3556  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 3557  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/1000000Ne
 3558  ls $par_folder/ft_sim_1000000Ne*1E_*20Chr_15Mb.par | sort -V
 3559  ls $par_folder/ft_sim_1000000Ne*1E_*20Chr_15Mb.par | sort -V | wc -l
 3560  cd ../100000Ne_5rep
 3561  ls $par_folder/ft_sim_100000Ne*1E_*20Chr_15Mb.par | sort -V | wc -l
 3562  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne
 3563  ls $par_folder/ft_sim_100000Ne*1E_*20Chr_15Mb.par | sort -V | wc -l
 3564  ls *.par | wc -l
 3565  ls $par_folder/*.par | wc -l
 3566  ls /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/1000000Ne/*.par | wc -l
 3567  ls /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/10000Ne/*.par | wc -l
 3568  ls /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/10000Ne/*.par
 3569  ls --help
 3570  ls /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/10000Ne/*.par | cat -n
 3571  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne
 3572  100000_par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne
 3573  par_folder_100000=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne
 3574  ls $par_folder/ft_sim_100000Ne*1E_*20Chr_15Mb.par | sort -V | wc -l
 3575  ls $par_folder/ft_sim_100000Ne*1E_*20Chr_15Mb.par | sort -V
 3576  ls $par_folder/ft_sim_100000Ne*1E_*20Chr_15Mb.par | sort -V | cat -n
 3577  par_folder_1000000=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/1000000Ne
 3578  ls $par_folder/ft_sim_1000000Ne*1E_*20Chr_15Mb.par | sort -V | cat -n
 3579  ls $par_folder_1000000Ne/ft_sim_1000000Ne*1E_*20Chr_15Mb.par | sort -V | cat -n
 3580  ls $par_folder_1000000/ft_sim_1000000Ne*1E_*20Chr_15Mb.par | sort -V | cat -n
 3581  ls $par_folder_100000/ft_sim_1000000Ne*1E_*20Chr_15Mb.par | sort -V | cat -n
 3582  ls $par_folder_100000/ft_sim_100000Ne*1E_*20Chr_15Mb.par | sort -V | cat -n
 3583  ls $par_folder_1000000/ft_sim_1000000Ne*1E_*20Chr_15Mb.par | sort -V | cat -n
 3584  par_folder_10000=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/10000Ne
 3585  ls $par_folder_10000/ft_sim_10000Ne*1E_*20Chr_15Mb.par | sort -V | cat -n
 3586  ls /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne/*00d_*Mb.par
 3587  ls /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne/*00d_*Mb.par | wc -l
 3588  cp /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne/*00d_*Mb.par /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/1000000Ne
 3589  ls /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/1000000Ne/*00d_*Mb.par | wc -l
 3590  ls /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/1000000Ne/*_*Mb.par | wc -l
 3591  cd ../1000000Ne
 3592  par_i=`ls *00d_*Mb.par`
 3593  ls *00d_*Mb.par
 3594  ls
 3595  pwd
 3596  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/1000000Ne
 3597  ls *00d_*Mb.par
 3598  par_i=`ls *00d_*Mb.par`
 3599  for par_i in `ls *i_*Mb.par`;do     rename 100000Ne 1000000Ne $par_i; done
 3600  for par_i in `ls *00d_*Mb.par`;do     rename 100000Ne 1000000Ne $par_i; done
 3601  ls *00d_*Mb.par | wc -l
 3602  ls *1000000Ne*00d_*Mb.par | wc -l
 3603  for par_i in `ls *00d_*Mb.par`;do     sed -i '4s/100000/1000000/' $par_i; done
 3604  ls *par | wc -l
 3605  ls *i_*Mb.par
 3606  for par_i in `ls *i_*Mb.par`;do     sed -i -e '8s/0/-0.0007/' -e '13s/1000 0 0 0 -1.50 0 0/1000 0 0 0 1.50 0 0/' $par_i; done
 3607  for par_i in `ls *i_*Mb.par`;do     sed -i -e '8s/-0.0007/0/' -e '13s/-1.50 0 0/1.50 0 0/' $par_i; done
 3608  cd ../10000Ne/
 3609  ls *i_*Mb.par | wc -l
 3610  for par_i in `ls *i_*Mb.par`;do     sed -i -e '13s/-1.50 0 0/1.50 0 0/' $par_i; done
 3611  ls *00d_*Mb.par | wc -l
 3612  ls *00d_*Mb.par
 3613  rm *00d_*Mb.par
 3614  ls *_*Mb.par | wc -l
 3615  cp /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne/*00d_*Mb.par /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/10000Ne
 3616  ls *_*Mb.par | wc -l
 3617  for par_i in `ls *00d_*Mb.par`;do     rename 100000Ne 10000Ne $par_i; done
 3618  for par_i in `ls *00d_*Mb.par`;do     sed -i -e '4s/100000/10000/' $par_i; done
 3619  squeue -u yzliu
 3620  pwd
 3621  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
 3622  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 3623  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/10000Ne
 3624  ls $par_folder/ft_sim_10000Ne*1E_*20Chr_15Mb.par | wc -l
 3625  cd ..
 3626  cd /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/10000Ne
 3627  cd ..
 3628  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/ft_sim_10KNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb_5rep.sh
 3629  scancel 26937607
 3630  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/ft_sim_10KNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb_5rep.sh
 3631  sbatch /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/ft_sim_1MNe_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb_5rep.sh
 3632  squeue -u yzliu
 3633  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
 3634  sfs=`find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep _MSFS.obs$ | sort -V`
 3635  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11 | tr -d $'\n' >> sfs_file.txt;     echo -e "\t$i\t$i" >> sfs_file_bp.txt; done
 3636  find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep _MSFS.obs$ | sort -V
 3637  for i in `find -print | grep "10000Ne" | grep "15Mb-" | grep fastsimcoal2 | grep _MSFS.obs$ | sort -V`;do     awk 'NR==3' $i | cut -d " " -f 2-11 | tr -d $'\n' >> sfs_file.txt;     echo -e "\t$i\t$i" >> sfs_file_bp.txt; done
 3638  for i in $sfs;do     awk 'NR==3' $i | cut -d " " -f 2-11 | tr -d $'\n' >> sfs_file_bp.txt;     echo -e "\t$i\t$i" >> sfs_file_bp.txt; done
 3639  cat sfs_file_bp.txt | cut -d "/"
 3640  cat sfs_file_bp.txt | cut -d "/" -f 1-
 3641  cat sfs_file_bp.txt | cut -d "/" -f 1
 3642  cat sfs_file_bp.txt | cut -d "/" -f 1,2
 3643  cat sfs_file_bp.txt | cut -d "/" -f 1,2,3
 3644  cat sfs_file_bp.txt | cut -d "/" -f 1,4
 3645  cat sfs_file_bp.txt | cut -d "/" -f 1,4,8
 3646  cat sfs_file_bp.txt | cut -d "/" -f 1,4,7
 3647  cat sfs_file_bp.txt | cut -d "/" -f 1,4,7 | sed -e 's/\.\///' -e 's/obs//1' -e 's/obs/blueprint/2'
 3648  cat sfs_file_bp.txt | cut -d "/" -f 1,4,7 | sed -e 's/\.\///g' -e 's/obs//1' -e 's/obs/blueprint/2'
 3649  cat sfs_file_bp.txt | cut -d "/" -f 1,4,7 | sed -e 's/\.\///' -e 's/.obs//1' -e 's/obs/blueprint/2'
 3650  cat sfs_file_bp.txt | cut -d "/" -f 1,4,7 | sed -e 's/\.\///g' -e 's/.obs//1' -e 's/obs/blueprint/2'
 3651  cat sfs_file_bp.txt | cut -d "/" -f 1,4,7 | sed -e 's/\.\///g' -e 's/\.obs//1' -e 's/\.obs/\.blueprint/2'
 3652  cat sfs_file_bp.txt | cut -d "/" -f 1,4,7 | sed -e 's/\.\///g' -e 's/\.obs//1' -e 's/\.obs/\.blueprint/1'
 3653  cat sfs_file_bp.txt | cut -d "/" -f 1,4,7 | sed -e 's/\.\///g' -e 's/\.obs//' -e 's/\.obs/\.blueprint/1'
 3654  cat sfs_file_bp.txt | cut -d "/" -f 1,4,7 | sed -e 's/\.\///g' -e 's/\.obs//0' -e 's/\.obs/\.blueprint/1'
 3655  cat sfs_file_bp.txt | cut -d "/" -f 1,4,7 | sed -e 's/\.\///g' -e 's/\.obs//' -e 's/\.obs/\.blueprint/2'
 3656  cat sfs_file_bp.txt | cut -d "/" -f 1,4,7 | sed -e 's/\.\///g' -e 's/\.obs//' -e 's/\.obs/\.blueprint/'
 3657  cat sfs_file_bp.txt | cut -d "/" -f 1,4,7 | sed -e 's/\.\///g' -e 's/.obs//' -e 's/obs/blueprint/1' > /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/sfs_file_bp.blueprint.txt
 3658  awk -F "\t" '{print $2}' sfs_file_bp.new.txt
 3659  cat sfs_file_bp.new.txt
 3660  cat /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/sfs_file_bp.new.txt
 3661  awk -F "\t" '{print $2}' sfs_file_bp.blueprint.txt
 3662  awk -F "\t" '{print $2}' /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/sfs_file_bp.blueprint.txt
 3663  awk -F "\t" '{print $3}' /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/sfs_file_bp.blueprint.txt
 3664  squeue -u yzliu
 3665  ls *15Mb
 3666  ls *15Mb$
 3667  ls *15Mb | wc -l
 3668  ls *15Mb$ | wc -l
 3669  ls *_15Mb$
 3670  ls ft*_15Mb
 3671  ls
 3672  ls ft_sim*_15Mb
 3673  ll ft_sim*_15Mb
 3674  ls ft_sim*_15Mb .
 3675  ls --help
 3676  ls -d ft_sim*_15Mb
 3677  ls -d ft_sim*_15Mb | wc -l
 3678  ls -d ft_sim*_15Mb | sort -V
 3679  ls *.gen
 3680  ls ft_sim*15Mb/*.gen
 3681  ls ft_sim*15Mb/*.gen | sort -V
 3682  ls ft_sim*15Mb/*.gen | grep -v _05i
 3683  ls ft_sim*15Mb/*.gen | grep -v _05i | wc -l
 3684  ls ft_sim*15Mb/*.gen | grep -v _05i | sort -V | wc -l
 3685  ls ft_sim*15Mb/*.gen | sort -V | grep -v _05i | wc -l
 3686  ls ft_sim*15Mb/*.gen | sort -V | grep -v _05i
 3687  ls ft_sim*15Mb/*.gen | sort -V | grep -v _05i | wc -l
 3688  ls ft_sim*15Mb/*.gen | sort -V | grep -v _05i > ft_sim_10000Ne_20Chr_15Mb.txt
 3689  ls ft_sim*15Mb/*.gen | sort -V | grep -v _05i > ft_sim_10000Ne_20Chr_15Mb.gen.txt
 3690  ls ft_sim*15Mb/*.gen | sort -V | grep _05i >> ft_sim_10000Ne_20Chr_15Mb.gen.txt
 3691  awk 'FR==1{print}' ft_sim_10000Ne_20Chr_15Mb.gen.txt
 3692  awk 'FR==1{print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt
 3693  awk 'NR==1{print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt
 3694  awk 'NR==0{print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt
 3695  awk 'NR==3{print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt
 3696  awk 'NR==NR{print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt
 3697  awk 'NR==NR-1{print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt
 3698  awk 'NR==44{print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt
 3699  awk 'NR<=3{print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt
 3700  for gen in {1..3};do     new_gen=`awk -v var=$i 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`;     awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$i 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` > ./$new_gen.new; done
 3701  for gen in {1..3};do     new_gen=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`;     awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$i 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` > ./$new_gen.new; done
 3702  for gen in {1..3};do     new_gen=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`;     awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` > ./$new_gen.new; done
 3703  for gen in {1..240};do     new_gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`     awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` > ./$new_gen_file.new; done
 3704  for gen in {241..300};do     new_gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`     awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` > ./$new_gen_file.new; done
 3705  for gen in {241..300};do     new_gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` echo $gen
 3706  for gen in {241..300};do     new_gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` echo $gen done
 3707  for gen in {241..300};do     new_gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` echo $gen; done
 3708  for gen in {241..300};do     new_gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` echo $new_gen_file; done
 3709  cat -n ft_sim_10000Ne_20Chr_15Mb.gen.txt
 3710  for gen in {241..300};do     new_gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` echo $new_gen_file; done
 3711  for gen in {1..10};do     new_gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` echo $new_gen_file; done
 3712  for gen in {1..10};do     new_gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`; echo $new_gen_file; done
 3713  for gen in {241..300};do     new_gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`; echo $new_gen_file; done
 3714  for gen in {241..300};do     new_gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`;     awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` > ./$new_gen_file.new; done
 3715  history | grep 'ft_sim_10000Ne_20hapS_1E_1000G_01d_20Chr_15Mb_1_5.gen.new.vcf'
 3716  ##example: for gen in {1..3};do
 3717  for gen in {1..3};do     gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`;     awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` |     sed '1d' | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' | sed '$d' > ./$gen_file.vcf;      done
 3718  conda env list
 3719  /home/yzliu/miniforge3/envs/plink
 3720  /home/yzliu/miniforge3/envs/plink -h
 3721  /home/yzliu/miniforge3/envs/plink/plink
 3722  /home/yzliu/miniforge3/envs/plink/plink -h
 3723  ls /home/yzliu/miniforge3/envs/plink
 3724  ls /home/yzliu/miniforge3/envs/plink/bin
 3725  ls /home/yzliu/miniforge3/envs/plink/bin/plink
 3726  ls /home/yzliu/miniforge3/envs/plink/bin/plink -h
 3727  /home/yzliu/miniforge3/envs/plink/bin/plink -h
 3728  for gen in {1..3};do     plink=/home/yzliu/miniforge3/envs/plink/bin/plink;     gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`;     awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` |     sed '1d' | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' | sed '$d' | $plink --vcf - --double-id --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 10 0.5 --out gen_file.vcf.final_ld05;      done
 3729  for gen in {1..3};do     plink=/home/yzliu/miniforge3/envs/plink/bin/plink;     gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`;     awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` |     sed '1d' | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' | sed '$d' | $plink --vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 10 0.5 --out gen_file.vcf.final_ld05;      done
 3730  ls ft_sim*gen.vcf
 3731  ls ft_sim*20Chr_15Mb/ft_sim*gen.vcf
 3732  for gen in {1..300};do     gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`;     awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` |     sed '1d' | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tG_1_1\tG_1_2\tG_1_3\tG_1_4\tG_1_5\tG_1_6\tG_1_7\tG_1_8\tG_1_9\tG_1_10' | sed '$d' > ./$gen_file.vcf;      done
 3733  ls ft_sim*20hapS*15Mb/*.gen | sort -V | grep -v _05i
 3734  ls ft_sim*20hapS*15Mb/*.gen | sort -V | grep -v _05i > ft_sim_10000Ne_20hapS_20Chr_15Mb.gen.txt
 3735  ls ft_sim*80hapS*15Mb/*.gen | sort -V | grep -v _05i > ft_sim_10000Ne_20hapS_200Chr_15Mb.gen.txt
 3736  ls ft_sim*20hapS*15Mb/*.gen | sort -V | grep -v _05i | wc -l
 3737  ls ft_sim*80hapS*15Mb/*.gen | sort -V | grep -v _05i | wc -l
 3738  ls ft_sim*200hapS*15Mb/*.gen | sort -V | grep -v _05i | wc -l
 3739  ls ft_sim*200hapS*15Mb/*.gen | sort -V | grep _05i | wc -l
 3740  ls ft_sim*200hapS*15Mb/*.gen | sort -V | grep -v _05i > ft_sim_10000Ne_200hapS_20Chr_15Mb.gen.txt
 3741  history | grep bcftools
 3742  for gen in {1..10};do     gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`;     sample_id=`cut --complement -f 1-4 $gen_file`;     awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` |     sed '1d' | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t$sample_id' | sed '$d' > ./$gen_file.vcf done
 3743  cut --complement -f 1-4 /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_200hapS_1E_500G_01d_20Chr_15Mb/ft_sim_10000Ne_200hapS_1E_500G_01d_20Chr_15Mb_1_5.gen
 3744  awk 'NFR==1 {print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_200hapS_1E_500G_01d_20Chr_15Mb/ft_sim_10000Ne_200hapS_1E_500G_01d_20Chr_15Mb_1_5.gen
 3745  awk 'NR==1 {print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_200hapS_1E_500G_01d_20Chr_15Mb/ft_sim_10000Ne_200hapS_1E_500G_01d_20Chr_15Mb_1_5.gen
 3746  awk 'NR==1 {print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_200hapS_1E_500G_01d_20Chr_15Mb/ft_sim_10000Ne_200hapS_1E_500G_01d_20Chr_15Mb_1_5.gen | cut --complement -f 1-4
 3747  awk 'NR==1 {print $0}' /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_200hapS_1E_500G_01d_20Chr_15Mb/ft_sim_10000Ne_200hapS_1E_500G_01d_20Chr_15Mb_1_5.gen | cut --complement -f 1-3
 3748  for gen in {1..10};do     gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`;     sample_id=`'NR==1 {print $0}' $gen_file awk | cut --complement -f 1-4`;     awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` |     sed '1d' | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t$sample_id' | sed '$d' > ./$gen_file.vcf done
 3749  for gen in {1..10};do     gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`;     sample_id=`awk 'NR==1 {print $0}' $gen_file awk | cut --complement -f 1-4`;     awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` |     sed '1d' | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t$sample_id' | sed '$d' > ./$gen_file.vcf done
 3750  for gen in {1..10};do     gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`;     sample_id=`awk 'NR==1 {print $0}' $gen_file | cut --complement -f 1-4`;     awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` |     sed '1d' | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t$sample_id' | sed '$d' > ./$gen_file.vcf done
 3751  for gen in {1..10};do     gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`;     sample_id=`awk 'NR==1 {print $0}' $gen_file | cut --complement -f 1-4`;     awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` |     sed '1d' | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t$sample_id' | sed '$d';done
 3752  for gen in {1..10};do     gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`;     sample_id=`awk 'NR==1 {print $0}' $gen_file | cut --complement -f 1-4`;echo $sample_id; done
 3753  for gen in {1..10};do     gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`;     sample_id=`awk 'NR==1 {print $0}' $gen_file | cut --complement -f 1-4`;     awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` |     sed '1d' | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t"$sample_id"' | sed '$d' > ./$gen_file.vcf done
 3754  for gen in {296..300};do     gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`;     sample_id=`awk 'NR==1 {print $0}' $gen_file | cut --complement -f 1-4`;     awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` |     sed '1d' | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t"$sample_id"' | sed '$d' > ./$gen_file.vcf done
 3755  for gen in {296..300};do     gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`;     sample_id=`awk 'NR==1 {print $0}' $gen_file | cut --complement -f 1-4`;     awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` |     sed '1d' | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t$sample_id' | sed '$d' > ./$gen_file.vcf done
 3756  for gen in {296..300};do     gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`;     sample_id=`awk 'NR==1 {print $0}' $gen_file | cut --complement -f 1-4`;     awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` |     sed '1d' | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | sed '1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t$sample_id' | sed '$d' > ./$gen_file.vcf done
 3757  for gen in {296..300};do     gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`;     sample_id=`awk 'NR==1 {print $0}' $gen_file | cut --complement -f 1-4`;     awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` |     sed '1d' | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | sed "1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t$sample_id" | sed '$d' > ./$gen_file.vcf done
 3758  for gen in {1..300};do     gen_file=`awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt`;     sample_id=`awk 'NR==1 {print $0}' $gen_file | cut --complement -f 1-4`;     awk 'FNR >1 { for (i = 5; i <= NF; i++) { if ($i == 0) { $i = "0/0"; } else if ($i == 1) { $i = "1/1"; } else {$i="0/1";}} } 1' `awk -v var=$gen 'NR==var {print $0}' ft_sim_10000Ne_20Chr_15Mb.gen.txt` |     sed '1d' | awk 'BEGIN{OFS="\t"}{$2=$2 OFS FNR;$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS ".";$4=$4 OFS "GT"}1' | sed "1i #CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t$sample_id" | sed '$d' > ./$gen_file.vcf done
 3759  ll /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_20hapS_1E_50G_00d_20Chr_15Mb
 3760  pwd
 3761  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_200hapS_1E_500G_05i_20Chr_15Mb
 3762  plink=/home/yzliu/miniforge3/envs/plink/bin/plink
 3763  vcf=/home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_200hapS_1E_500G_05i_20Chr_15Mb/ft_sim_10000Ne_200hapS_1E_500G_05i_20Chr_15Mb_1_5.gen.vcf
 3764  $plink --vcf $vcf --recode --double-id
 3765  less -S /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_200hapS_1E_500G_05i_20Chr_15Mb/plink.ped
 3766  less -S $vcf
 3767  $plink --vcf $vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 10 0.5 --out ft_sim_10000Ne_200hapS_1E_500G_05i_20Chr_15Mb/ft_sim_10000Ne_200hapS_1E_500G_05i_20Chr_15Mb_1_5.gen.final_ld05
 3768  $plink --vcf $vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 10 0.5 --out ft_sim_10000Ne_200hapS_1E_500G_05i_20Chr_15Mb_1_5.gen.final_ld05
 3769  ll /home/yzliu/DK_proj/steps/systematic_fsc_test2
 3770  ll /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3
 3771  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep_05i
 3772  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 3773  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne_50i/
 3774  ls $par_folder/ft_sim_100000Ne*1E_*05i*20Chr_5Kb.par
 3775  par=`ls $par_folder/ft_sim_100000Ne*1E_*05i*20Chr_5Kb.par`
 3776  $fsc -i $par -n 5 -q -s 0 -m --foldedSFS -c 8 -g -G -k 300000000
 3777  squeue -u yzliu
 3778  scancel 26883130
 3779  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test1
 3780  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 3781  cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/100000Ne_5rep
 3782  fsc=/home/yzliu/miniforge3/envs/fastsimcoal2/bin/fsc27093
 3783  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne
 3784  par_folder=/home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/100000Ne_50i/
 3785  ls $par_folder/ft_sim_100000Ne*1E_*20Chr_15Mb.new.par
 3786  par=`ls $par_folder/ft_sim_100000Ne*1E_*20Chr_15Mb.new.par`
 3787  $fsc -i $par -n 5 -q -s 0 -m --foldedSFS -c 8 -g -G -k 300000000
 3788  history
 3789  history | grep $python
 3790  history | grep "\$python"
 3791  history | grep "\$geno"
 3792  history | grep "geno"
 3793  ll /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep/ft_sim_10000Ne_200hapS_1E_500G_05d_20Chr_15Mb
 3794  ls /home/yzliu/DK_proj/scripts
 3795  ls /home/yzliu/DK_proj/scripts/*.sh
 3796  ls /home/yzliu/DK_proj/scripts/
 3797  ls /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3
 3798  history > /home/yzliu/DK_proj/scripts/fastsimcoal/para_test3/history_23_nov.sh
