BiocManager::install("BSgenome.Hsapiens.UCSC.hg38")
install.packages('mutSignatures')
install.packages('dplyr')

library('BSgenome.Hsapiens.UCSC.hg38')
library('mutSignatures')
library('readr')
library('dplyr')

hg38 <- BSgenome.Hsapiens.UCSC.hg38

#isolate just single nucleotide polymorphisms
BLCA <- filterSNV(dataSet = mutationData,  seq_colNames = c("Reference_Allele", "Allele"))

BLCA <- attachMutType(mutData = BLCA,                      
                   ref_colName = "Reference_Allele",             
                   var_colName = "Allele",             
                   context_colName = "CONTEXT")

BLCA.counts <- countMutTypes(mutTable = BLCA,
                             mutType_colName = "mutType",
                             sample_colName = "Tumor_Sample_UUID")

num.sign <- 4

BLCA.params <- 
  mutSignatures::setMutClusterParams( 
    num_processesToExtract = num.sign,    
    num_totIterations = 100,             
    num_parallelCores = 16)

BLCA.analysis <- 
  decipherMutationalProcesses(input = BLCA.counts,
                              params = BLCA.params)

BLCA.sig <- BLCA.analysis$Results$signatures

# Retrieve exposures (results)
BLCA.exp <- BLCA.analysis$Results$exposures

# Plot signature 1 (standard barplot, you can pass extra args such as ylim)
msigPlot(BLCA.sig, signature = 1, ylim = c(0, 0.10))

# signature ggplot
msigPlot(BLCA.exp, main = "BLCA samples")

# signatures to data.frame
xprt <- coerceObj(x = BLCA.sig, to = "data.frame")

mutSignatures::getCosmicSignatures()