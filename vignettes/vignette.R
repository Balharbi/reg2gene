## ----global_options, include=FALSE---------------------------------------

library(knitr)
library(reg2gene)
library(InteractionSet)
library(GenomicRanges)
library(rmarkdown)

opts_chunk$set(warning = FALSE,
               message= FALSE,
               fig.align='center',
               fig.path='Figures', 
               dev='png',
               fig.show='hold', 
               cache=FALSE)



## ----fig2, fig.height = 5, fig.width = 3, fig.align = "center",echo=FALSE----
#knitr::include_graphics("https://github.com/BIMSBbioinfo/reg2gene/blob/master/vignettes/Figures/QuantificationDataIntegrationSimplified.png")

knitr::include_graphics("/data/akalin/Projects/AAkalin_reg2gene/reg2gene/vignettes/Figures/QuantificationDataIntegrationSimplified.png")

## ------------------------------------------------------------------------

# toy bigwig files
test.bw <- system.file("extdata", "test.bw",package = "reg2gene")
test2.bw <- system.file("extdata", "test2.bw",package = "reg2gene")

# toy GRanges object
regTSS_toy <- GRanges(c(rep("chr1",2),"chr2",rep("chr1",3)),
                      IRanges(c(1,7,9,15,1,15),c(4,8,14,20,4,20)),
                                            c(rep("+",3),rep("-",3)))
regTSS_toy$reg <-  regTSS_toy[c(1,1,3,5,5,5)]
regTSS_toy$name2 <- regTSS_toy$name <- paste0("TEST_Reg",
                                        c(1,1,3,5,5,5))
                                        
# run quntification f()                                        
 bwToGeneExp(exons = regTSS_toy,target = c(test.bw,test2.bw))



## ------------------------------------------------------------------------

# toy bigwig files
test.bw <- system.file("extdata", "test.bw",package = "reg2gene")
test2.bw <- system.file("extdata", "test2.bw",package = "reg2gene")

# toy GRanges object
regTSS_toy <- GRanges(c(rep("chr1",4),rep("chr2",2)),
                      IRanges(c(1,7,9,15,1,15),c(4,8,14,20,4,20)),
                                            c(rep("+",3),rep("-",3)))
regTSS_toy$reg <-  regTSS_toy[c(1,1,3:6)]
regTSS_toy$name2 <- regTSS_toy$name <- paste0("TEST_Reg",
                                        c(1,1,3:length(regTSS_toy)))
# run quantification of enhance activity
regActivity(windows = regTSS_toy,target = c(test.bw,test2.bw))   


## ------------------------------------------------------------------------

# create toy GRanges objects for gene expression (regTSS_toy) and enhancer 
# activity (regReg_toy) with scores stored in bw columns

regTSS_toy <- GRReg1_toy
  regTSS_toy$bw1 <- rep(1,length(GRReg1_toy))
  regTSS_toy$bw2 <- rep(2,length(GRReg1_toy))
  regTSS_toy$bw3 <- rep(3,length(GRReg1_toy))
regReg_toy <- GRReg2_toy
   regReg_toy$bw1 <- rep(3,length(regReg_toy))
   regReg_toy$bw2 <- rep(4,length(regReg_toy))

# combine these object into per gene GRangesList
   
regActivityAroundTSS(regActivity = regReg_toy,geneExpression = regTSS_toy, 
                     upstream=1,downstream=1)



## ---- echo=FALSE---------------------------------------------------------

###############################
#STEP 1.  Getting random and predefined .8 correlation
 
 require(GenomicRanges)
 require(doMC)
 require(glmnet)
 require(foreach)
 require(stringr)
 require(qvalue)
 
 ####################################
 # create example
 
 x <- c(2.000346,2.166255,0.7372374,0.9380581,2.423209, 
      2.599857,4.216959,2.589133,1.848172,3.039659)
 y <- c(2.866875,2.817145,2.1434456,2.9039771,3.819091,5.009990,
      5.048476,2.884551,2.780067,4.053136)
 corrM <- rbind(x,y)
 
 # define Granges object
  gr0 <- GRanges(seqnames=rep("chr1",2),IRanges(1:2,3:4))
    
    GeneInfo <- as.data.frame(matrix(rep(c("gene","regulatory"),each=3),
                ncol = 3,byrow = TRUE),stringsAsFactors=FALSE)

        colnames(GeneInfo) <- c("featureType","name","name2")

       mcols(gr0) <- DataFrame(cbind(GeneInfo,corrM))
 
 
       gr0
       
    

## ---- echo=FALSE---------------------------------------------------------

###############################
#STEP 1.  Getting random and predefined .8 correlation
 
 require(GenomicRanges)
 require(doMC)
 require(glmnet)
 require(foreach)
 require(stringr)
 require(qvalue)
 
 ####################################
 # create example
 
 x <- c(2.000346,2.166255,0.7372374,0.9380581,2.423209, 
      2.599857,4.216959,2.589133,1.848172,3.039659)
 y <- c(2.866875,2.817145,2.1434456,2.9039771,3.819091,5.009990,
      5.048476,2.884551,2.780067,4.053136)
 corrM <- rbind(x,y)
 
 # define Granges object
  gr0 <- GRanges(seqnames=rep("chr1",2),IRanges(1:2,3:4))
    
    GeneInfo <- as.data.frame(matrix(rep(c("gene","regulatory"),each=3),
                ncol = 3,byrow = TRUE),stringsAsFactors=FALSE)

        colnames(GeneInfo) <- c("featureType","name","name2")

       mcols(gr0) <- DataFrame(cbind(GeneInfo,corrM))
 
    print("associateReg2Gene(input=gr0,cores = 1,B=100,method=\"spearman\")")
    associateReg2Gene(input = gr0,cores = 1,B=100)     
   

## ---- echo=FALSE---------------------------------------------------------

require(GenomicRanges)
require(InteractionSet)

gr2 <- gr <- GRanges(seqnames=rep("chr1",3),IRanges(1:3,3:5))
   x <- 1:5
   y <- 2:6
   z <- 10:14
   a <- rep(0,length(x))
   
   
   GeneInfo <- as.data.frame(matrix(c(rep("gene",3),rep("regulatory",6)),
               ncol = 3,byrow = TRUE),stringsAsFactors=FALSE)
               colnames(GeneInfo) <- c("featureType","name","name2")
 
 mcols(gr) <- DataFrame(cbind(GeneInfo,rbind(x,y,z)))
 mcols(gr2) <- DataFrame(cbind(GeneInfo,rbind(x,y,a)))
 
 # create associateReg2Gene output objects, GInteractions will all 
 # output results
 
 AssocObject <- reg2gene::associateReg2Gene(gr)
 AssocObject2 <- reg2gene::associateReg2Gene(gr2)
 
 # input for meta-analysis is list of such objects
 
 interactions <- list(AssocObject,AssocObject2)
 names(interactions) <- c("H3K4me1","H327ac")
 
 # Run voteInteractions

 
 voteInteractions( interactions, 
                  cutoff.stat="pval",
                  cutoff.val=0.05,
                  vote.threshold=0.5)
                  

## ----fig3, fig.height = 5, fig.width = 5, fig.align = "center",echo=FALSE----
#knitr::include_graphics("https://github.com/BIMSBbioinfo/reg2gene/master/vignettes/Figures/VOTING.png")

knitr::include_graphics("/data/akalin/Projects/AAkalin_reg2gene/reg2gene/vignettes/Figures/VOTING.png")


## ---- echo=FALSE---------------------------------------------------------
# creating datasets

require(GenomicRanges)
require(InteractionSet)

gr2 <- gr <- GRanges(seqnames=rep("chr1",3),IRanges(1:3,3:5))
   x <- 1:5
   y <- 2:6
   z <- 10:14
   a <- rep(0,length(x))
   
   
   GeneInfo <- as.data.frame(matrix(c(rep("gene",3),rep("regulatory",6)),
               ncol = 3,byrow = TRUE),stringsAsFactors=FALSE)
               colnames(GeneInfo) <- c("featureType","name","name2")
 
 mcols(gr) <- DataFrame(cbind(GeneInfo,rbind(x,y,z)))
 mcols(gr2) <- DataFrame(cbind(GeneInfo,rbind(x,y,a)))
 
 # create associateReg2Gene output objects, GInteractions will all 
 # output results
 
 AssocObject <- reg2gene::associateReg2Gene(gr)
 AssocObject2 <- reg2gene::associateReg2Gene(gr2)
 
 # input for meta-analysis is list of such objects
 
 interactions <- list(AssocObject,AssocObject2)
 names(interactions) <- c("Roadmap","Blueprint")
 

 
 # Run metaA
 metaInteractions( interactions=interactions)
 

## ---- fig.height = 10, fig.width = 10, fig.align = "center",echo=FALSE----
#knitr::include_graphics("https://github.com/BIMSBbioinfo/reg2gene/blob/master/vignettes/Figures/Meta-Analysis_Simplified.png")


knitr::include_graphics("/data/akalin/Projects/AAkalin_reg2gene/reg2gene/vignettes/Figures/Meta-Analysis_Simplified.png")

## ----fig5, fig.height = 5, fig.width = 3, fig.align = "center",echo=FALSE----
#knitr::include_graphics("https://github.com/BIMSBbioinfo/reg2gene/blob/master/vignettes/Figures/BenchSimpleE.png")

knitr::include_graphics("/data/akalin/Projects/AAkalin_reg2gene/reg2gene/vignettes/Figures/BenchSimpleE.png")


## ------------------------------------------------------------------------

   interactions <- GInteractions(GRReg1_toy,GRReg1_toy$reg)[2]
   benchInteractions <- GInteractions(GRReg2_toy,GRReg2_toy$reg)
   
   # removing confusing meta-data
   mcols(interactions) <- NULL
   
benchmarkInteractions(interactions = interactions,
              benchInteractions = benchInteractions, 
              preFilter = T,
              binary=TRUE) 

## ----fig6, fig.height = 5, fig.width = 5, fig.align = "center",echo=FALSE----
#knitr::include_graphics("https://github.com/BIMSBbioinfo/reg2gene/master/vignettes/Figures/benchmarkF.png")

knitr::include_graphics("/data/akalin/Projects/AAkalin_reg2gene/reg2gene/vignettes/Figures/benchmarkF.png")


## ---- echo=FALSE---------------------------------------------------------
interactionsBench <- GInteractions(GRReg1_toy,GRReg1_toy$reg)

Bench <- interactionsBench$anchor1.Bench1Exp
Filter <- interactionsBench$anchor1.Filter1Exp
      mcols(interactionsBench) <- NULL

   interactionsBench$Pval <- seq(0, 1, length.out = length(GRReg1_toy))
   interactionsBench$Bench <- Bench
   interactionsBench$Filter <- Filter
  
  interactionsBench


## ---- echo=FALSE---------------------------------------------------------
interactionsBench <- GInteractions(GRReg1_toy,GRReg1_toy$reg)

Bench <- interactionsBench$anchor1.Bench1Exp
Filter <- interactionsBench$anchor1.Filter1Exp
      mcols(interactionsBench) <- NULL

   interactionsBench$Pval <- seq(0, 1, length.out = length(GRReg1_toy))
   interactionsBench$Bench <- Bench
   interactionsBench$Filter <- Filter

confusionMatrix(interactionsBench,
                thresholdID = "Pval",
                thresholdValue = 0.05,
                benchCol = "Bench",
                prefilterCol = "Filter",
                statistics = "ConfusionMatrix")

## ------------------------------------------------------------------------

enhancers <- GRanges(rep("chr16",6),
                      IRanges(c(53112601,55531601,53777201,
                                53778801,54084001,53946467),
                              c(53114200,55533250, 53778800, 
                                53780400, 54084400 ,53947933)))

genes <- GRanges(rep("chr16",6),
                     IRanges(c(53737874, 54964773, 54320676,
                               53737874, 54964773, 54320676),
                             c(53737874, 54964773, 54320676,
                               53737874, 54964773, 54320676)))

GenomeInteractions <- GInteractions(enhancers,genes)

GenomeInteractions$name2 <- c("FTO","IRX5","IRX3")

GenomeInteractions$pval <- c(0.20857403, 0.72856090, 0.03586015,
                             0.32663439, 0.32534945, 0.03994488)

GenomeInteractions$color <- c("red","blue","grey")
 

 plotInteractions(interactions = GenomeInteractions,
                  statistics ="pval",
                  coloring = "color")


## ------------------------------------------------------------------------
 plotInteractions(interactions = GenomeInteractions,
                        selectGene="FTO")
                  

## ------------------------------------------------------------------------
                   
  plotInteractions(interactions = GenomeInteractions,
               selectRegulatoryRegion = "chr16:53112601-53114200")

## ------------------------------------------------------------------------
                   
 benchInteractions = list(GenomeInteractions[1:3])

  plotInteractions(interactions = GenomeInteractions,
                         coloring = "color",
                         statistics = "pval",
                         benchInteractions = benchInteractions)

## ----echo=FALSE----------------------------------------------------------

# creating toy example
# 1. windows of interest
   windows <- GRanges(c("chr1:1-2", # 1. overlap prom
                                 "chr2:1-2",  # 2. overlap enh
                                 "chr3:1-2", # 3. overlap tss +/- 1,000,000
                                 "chr4:1-2")) # 4. do not overlap tss +/- 1Mb
    
     annotationsEnh <- GRanges(c("chr1:1-2",
                                 "chr2:1-2",
                                 "chr3:100000-100002",
                                 "chr4:10000001-10000002"))
    
     annotationsGenes <- GRanges(c("chr1:1-2",
                                   "chr2:100000-100002",
                                   "chr3:99999-100002",
                                   "chr4:10000001-10000002"))
    
     seqlengths(annotationsEnh) <- seqlengths(annotationsGenes) <- rep(10000002,
                                                                       4)
  # example of interactions
         interactions = GInteractions(annotationsEnh,annotationsGenes,
                                 name=c("gen1","gen2","gen3","gen4"))
     
  # example of geneAnnotations   
     geneAnnotations=second(interactions)
     mcols(geneAnnotations) <- mcols(interactions) 
 
     print("windows of interest")
     windows
      print("toy example of interactions object")
     interactions
      print("toy example of geneAnnotations object")
     geneAnnotations
     
     

## ------------------------------------------------------------------------
     
  # run annotation function: 
 reg2gene(windows=windows,
          interactions=interactions, 
          geneAnnotations = geneAnnotations)
 
 # which regions are not identified
 
 reg2gene(windows=windows,
          interactions=interactions, 
          geneAnnotations = geneAnnotations,
          identified=FALSE)
 
 # if interactions are not available, assign interactions based solely on the 
 # proximity to promoters
 reg2gene(windows = windows,
                 interactions=NULL,
                 geneAnnotations = geneAnnotations)
  

## ----fig4, fig.height = 5, fig.width = 5, fig.align = "center",echo=FALSE----
#knitr::include_graphics("https://github.com/BIMSBbioinfo/reg2gene/master/vignettes/Figures/annotatExample.png")

knitr::include_graphics("/data/akalin/Projects/AAkalin_reg2gene/reg2gene/vignettes/Figures/annotatExample.png")


## ------------------------------------------------------------------------
 
 reg2gene(windows,
          geneAnnotations=geneAnnotations,
          interactions,
          identified=F)


  


## ---- echo=FALSE---------------------------------------------------------
sessionInfo()


