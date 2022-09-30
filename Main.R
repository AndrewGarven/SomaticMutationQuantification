source("TCGAdownload.R")

rnaData <- TCGADownload('TCGA-BLCA', 'Transcriptome Profiling', 'RNA-Seq', 'STAR - Counts', 'Gene Expression Quantification')
mutationData <- TCGADownload('TCGA-BLCA', 'Simple Nucleotide Variation', 'WXS', 'Aliquot Ensemble Somatic Variant Merging and Masking', 'Masked Somatic Mutation')

mutationData <- as.data.frame(mutationData)

rna <- as.data.frame(SummarizedExperiment::assay(rnaData))
clinical <- data.frame(rnaData@colData)

ARID1A <- mutationData[mutationData$Hugo_Symbol == 'ARID1A',]