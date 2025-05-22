# https://joey711.github.io/phyloseq/install.html
conda/mamba activate R

# slow
conda install -c conda-forge r-rcpparmadillo r-igraph gsl hdf5 openssl libxml2

# faster
mamba install -c conda-forge r-rcpparmadillo r-igraph gsl hdf5 openssl libxml2
mamba install -c bioconda -c conda-forge r-ade4 r-latticeExtra r-geometry r-rcdd r-rncl r-adegraphics r-phylobase r-adegenet r-gaston r-polysat r-adegraphics r-adephylo 
mamba install -c bioconda -c conda-forge r-rhdf5filters r-rhdf5 r-biomformat
#r-phyloseq


source("https://raw.githubusercontent.com/joey711/phyloseq/master/inst/scripts/installer.R",
       local = TRUE)


mamba install -c conda-forge gdal proj expat geos udunits2
mamba install -c conda-forge r-terra


## then in R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

# Explicitly set Bioconductor version for R 4.4
BiocManager::install(version = "3.20")  

# Now install phyloseq
BiocManager::install("phyloseq",force = TRUE)

