####prerequisite#####
install.packages(c("matrixStats", "Hmisc", "splines", "foreach", "doParallel", "reshape", "fastcluster", "dynamicTreeCut", "survival") )
source("http://bioconductor.org/biocLite.R") 
install.packages("WGCNA")
install.packages("flashClust")


#To enable multithreading type
#export  ALLOW_WGCNA_THREADS=<number_of_processors>
#in your linux bash shell


WORKING_DIR="./"
VSD_DATA_FILE="vsd_data.txt"
##Load R Libraries and Set working directory path" ###
library(WGCNA)
library(cluster)
require("flashClust")
options(stringsAsFactors = FALSE)
allowWGCNAThreads()
setwd(WORKING_DIR)



#1. Prepare data for WGCNA
#Read in the VSD (Variance Stabalize data) data set
expressed_genes_dataF = read.table(VSD_DATA_FILE, header=TRUE,row.names=1)


#Remove gene information and transpose the expression data
dataExpr=as.data.frame(t( expressed_genes_dataF))


#2. Cleaning and Preprocessing####################################################
#Checking for too may missing values
gsg = goodSamplesGenes(dataExpr, verbose = 3);
gsg$allOK

#if the last statment is "TRUE" go to next step or else run foloowing code
if (!gsg$allOK)
{
  # Optionally, print the gene and sample names that were removed:
  if (sum(!gsg$goodGenes)>0)
    printFlush(paste("Removing genes:", paste(names(dataExpr)[!gsg$goodGenes], collapse = ", ")));
  if (sum(!gsg$goodSamples)>0)
    printFlush(paste("Removing samples:", paste(rownames(dataExpr)[!gsg$goodSamples], collapse = ", ")));
  # Remove the offending genes and samples from the data:
  dataExpr = dataExpr[gsg$goodSamples, gsg$goodGenes]
}


#3.Step-by-dtep network construction and module detection
#3.1 Soft-thresholding power
NETWORKTYPE<-"signed"
RSQUARED_CUTOFF<-0.9

# Choose a set of soft-thresholding powers
powers = c(c(1:10), seq(from = 12, to=30, by=2))
# Call the network topology analysis function
#sft = pickSoftThreshold(dataExpr, powerVector = powers, verbose = 5)
sft=pickSoftThreshold(dataExpr,powerVector=powers, networkType=NETWORKTYPE)
# Plot the results:
sizeGrWindow(9, 5)
par(mfrow = c(1,2));
cex1 = 0.9;
# Scale-free topology fit index as a function of the soft-thresholding power
plot(sft$fitIndices[,1], -sign(sft$fitIndices[,3])*sft$fitIndices[,2],xlab="Soft Threshold (power)",ylab="Scale Free Topology Model Fit,signed R^2",type="n",main = paste("Scale independence"));
text(sft$fitIndices[,1], -sign(sft$fitIndices[,3])*sft$fitIndices[,2],labels=powers,cex=cex1,col="red");
# this line corresponds to using an R^2 cut-off of h
abline(h=RSQUARED_CUTOFF,col="red")
# Mean connectivity as a function of the soft-thresholding power
plot(sft$fitIndices[,1], sft$fitIndices[,5],
     xlab="Soft Threshold (power)",ylab="Mean Connectivity", type="n",
     main = paste("Mean connectivity"))
text(sft$fitIndices[,1], sft$fitIndices[,5], labels=powers, cex=cex1,col="red")

#Set the Soft Power
softPower = 20;

#3.2 Co-expression similarity and adjacency

#Following setps will take a place here
#Topology overlap Matrix
#Clustering using TOM


#Calculate adjacencies
adjacencyP = adjacency(dataExpr, power = softPower, type=NETWORKTYPE);

#Topological Overlap Matrix (TOM)
TOM = TOMsimilarity(adjacencyP, TOMType=NETWORKTYPE, verbose=1);
dissTOM = 1-TOM

#Clustering using TOM
# Call the hierarchical clustering function
geneTree = flashClust(as.dist(dissTOM), method = "average");

# Plot the resulting clustering tree (dendrogram)
sizeGrWindow(12,9)
plot(geneTree, xlab="", sub="", main = "Gene clustering on TOM-based dissimilarity",
     labels = FALSE, hang = 0.04);

# We like large modules, so we set the minimum module size relatively high:
MIN_MODULE_SIZE=30
DEEP_SPLIT=1

# Module identification using dynamic tree cut:
dynamicMods = cutreeDynamic(dendro = geneTree, distM = dissTOM,
                            deepSplit = DEEP_SPLIT, pamRespectsDendro = FALSE,
                            minClusterSize = MIN_MODULE_SIZE);

# Convert numeric lables into colors
dynamicColors = labels2colors(dynamicMods)

# Plot the dendrogram and colors underneath
sizeGrWindow(8,6)
plotDendroAndColors(geneTree, dynamicColors, "Dynamic Tree Cut",
                    dendroLabels = FALSE, hang = 0.03,
                    addGuide = TRUE, guideHang = 0.05,
                    main = "Gene dendrogram and module colors")

#Merging of modules whose expression profiles are very similar
# Calculate eigengenes
MEList = moduleEigengenes(dataExpr, colors = dynamicColors)
MEs = MEList$eigengenes
# Calculate dissimilarity of module eigengenes
MEDiss = 1-cor(MEs);
# Cluster module eigengenes
METree = flashClust(as.dist(MEDiss), method = "average");
# Plot the result
sizeGrWindow(7, 6)
plot(METree, main = "Clustering of module eigengenes",xlab = "", sub = "")

#We choose default tree height cut of 0.1
MEDISSTHRES = 0.1
# Plot the cut line into the dendrogram
abline(h=MEDISSTHRES, col = "red")
# Call an automatic merging function
merge = mergeCloseModules(dataExpr, dynamicColors, cutHeight = MEDISSTHRES, verbose = 3)
# The merged module colors
mergedColors = merge$colors;
# Eigengenes of the new merged modules:
mergedMEs = merge$newMEs;
sizeGrWindow(12, 9)
plotDendroAndColors(geneTree, cbind(dynamicColors, mergedColors),
                    c("Dynamic Tree Cut", "Merged dynamic"),
                    dendroLabels = FALSE, hang = 0.03,
                    addGuide = TRUE, guideHang = 0.05)

# Rename to moduleColors
moduleColors = mergedColors
# Construct numerical labels corresponding to the colors
colorOrder = c("grey", standardColors(50));
moduleLabels = match(moduleColors, colorOrder)-1;
MEs = mergedMEs;

###########################
#eigengene Expression
############################

final_modules <-unique(mergedColors)
Names<-colnames(expressed_genes_dataF)



pdf( "Heatmaps_Eigengene_Expr_plots.pdf", width=6, height=3)

for (module in final_modules){
  
  which.module<-module
  
  #sizeGrWindow(12,15);
  ME=MEs[, paste("ME",which.module, sep="")]
  par(mfrow=c(2,1), mar=c(0.3, 5.5, 3, 2))
  
  plotMat(t(scale(dataExpr[,mergedColors==which.module ]) ),
          nrgcols=30,rlabels=F,rcols=which.module,
          main="", cex.main=1, clabels=Names)
  par(mar=c(1, 4.2, 1, 0.7))
  barplot(ME, col=which.module, main=which.module, cex.main=0.5, cex.lab =0.8,
          ylab="eigengene expression",xlab="array sample")
  
  
}
dev.off()

#######################
#Write eigengene expression to a file
#######################

eigengene_expression_values = data.frame(MEs, row.names = Names)

write.table(eigengene_expression_values, file = "eigengene_expression_values.txt", sep = "\t")

intModules =c(final_modules)

#######################
#Write module to a file
#######################

for (module in intModules)
{
  
  fileName = paste("ModuleIDs-", module, ".txt", sep="");
  module_genes = t(dataExpr[moduleColors==module])
  module_genes_df<-as.data.frame(module_genes)
  module_genes_df['id']<-rownames(module_genes_df)
  write.table(module_genes_df, file = fileName,
              row.names = TRUE, col.names = TRUE, sep="\t")
  
  
  
}


save.image(file="Final.RData")
savehistory(file="Final.Rhistory")