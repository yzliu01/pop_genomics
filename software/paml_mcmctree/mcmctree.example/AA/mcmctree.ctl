          seed = -1
       seqfile = AA_Chi23.phy
      treefile = ../Chi23.tree
       outfile = out_usedata2
 
       seqtype = 2
 
         ndata = 1
       usedata = 2    * 0: no data; 1:seq like; 2:normal approximation
         clock = 2    * 1: global clock; 2: independent rates; 3: correlated rates
       RootAge = '<10'  * constraint on root age, used if no fossil for root.
         model = 3
                   * models for codons:
                       * 0:one, 1:b, 2:2 or more dN/dS ratios for branches
                   * models for AAs or codon-translated AAs:
                       * 0:poisson, 1:proportional, 2:Empirical, 3:Empirical+F
                       * 6:FromCodon, 7:AAClasses, 8:REVaa_0, 9:REVaa(nr=189)

    aaRatefile = mtREV24.dat  * only used for aa seqs with model=empirical(_F)
                   * dayhoff.dat, jones.dat, wag.dat, mtmam.dat, or your own
  
         alpha = 0.5
         ncatG = 5
     cleandata = 0    * remove sites with ambiguity data (1:yes, 0:no)?

       BDparas = 1 1 0   * birth, death, sampling
   kappa_gamma = 6 2      * gamma prior for kappa
   alpha_gamma = 1 1      * gamma prior for alpha

   rgene_gamma = 1 20     * gamma prior for rate for genes
  sigma2_gamma = 1 4.5    * gamma prior for sigma^2     (for clock=2 or 3)

      finetune = 1: 0.057  0.25  0.008  0.12 0.3  * times, rates, mixing, paras, RateParas

         print = 1
        burnin = 50000
      sampfreq = 50
       nsample = 10000

*** Note: Make your window wider (100 columns) when running this program.
