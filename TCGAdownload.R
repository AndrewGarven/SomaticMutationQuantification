library("TCGAbiolinks")

TCGADownload <- function(project, dataCategory, experimentalStratergy, WorkflowType, dataType) {
  # INPUT
  # project = string of TCGA project type (ex. 'TCGA-BLCA')
  # dataCategory = string of TCGA data.category (ex. 'Transcriptome Profiling')
  # expreimentalStratergy = string of TCGA experimental.stratergy (ex. 'RNA-Seq')
  # WorkflowType = string of TCGA workflow.type (ex 'STAR - Counts')
  # dataType = string of TCGA data.type (ex. 'Gene Expression Quantification')
  
  # OUTPUT
  # large data object containing both expression and clinical information
  
  # search using GDC API for given parameters
  TCGAquery = GDCquery(
    project = project,
    data.category = dataCategory,
    experimental.strategy = experimentalStratergy,
    workflow.type = WorkflowType,
    data.type = dataType)
  
  # download data elucidated in search query 
  GDCdownload(query = TCGAquery)
  
  # prepare downloaded data into R object
  data <- GDCprepare(query = TCGAquery, save = FALSE)
  
  return(data)
}