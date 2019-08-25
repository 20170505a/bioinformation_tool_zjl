## README
# 0. Set working directory 
rm(list=ls())
temp_path <- file.path("D:","FIGURE","PCA")
dir.create(temp_path,recursive = TRUE)
# dir.create() function need to add recursive = TRUE when create multi-level directory

setwd(temp_path)
getwd()


# 1. Generation test dataset
test_dataset <- matrix(nrow=100, ncol=10)

data.matrix <- test_dataset
colnames(data.matrix) <- c(
  paste("wt",1:5,sep=""),
  paste("ko",1:5,sep=""))
rownames(data.matrix) <- paste("gene", 1:100, sep="")
for (i in 1:100){
  wt.values <- rpois(5, lambda = sample(x=10:1000, size=1))
  ko.values <- rpois(5, lambda = sample(x=10:1000, size=1))
  
  data.matrix[i,] <- c(wt.values, ko.values)
}

head(data.matrix)

# 2. Calculate PCA
pca <- prcomp(t(data.matrix),scale=TRUE)
plot(pca)
pca.var <- pca$sdev^2
pca.var.per <- round(pca.var/sum(pca.var)*100,1)

# 3. Calcualte loading scores

loading_score <- pca$rotation[,1]
# prcomp() calcuate results inclding loading score, namely, rotation term

gene_scores <- abs(loading_score)
# Some numbers in loading _score is negative
# Use abs() function transform them into positive

gene_score_ranked <- sort(gene_scores, decreasing = TRUE)
# Sort all loading score after abs()


top_10_genes <- names(gene_score_ranked[1:10])
top_10_genes
# Obtain top10 genes in loading score

pca$rotation[top_10_genes,1]
# Examine top10 gene of loading score

# 3. Plot each component  for Scree plot

barplot(pca.var.per, 
        main="Scree Plot", 
        xlab="Principal Component", 
        ylab="Percent Variation")

# 4. ggplot2 foir PCA image
pca.data <- data.frame(Sample=rownames(pca$x),
                       X=pca$x[,1],
                       Y=pca$x[,2])
# one column with the sample ids
# Tow columns for the X and Y coordinates for each sample
pca.data

library(ggplot2)
ggplot(data=pca.data, aes(x=X, y=Y, label=Sample))+
  geom_text() +
  xlab(paste("PC1 - ", pca.var.per[1], "%", sep=""))+
  ylab(paste("PC2 - ", pca.var.per[2], "%", sep=""))+
  theme_bw()+
  ggtitle("My PCA Graph")

# 5. Save reulst
ggsave("PCA.pdf",
       device = "pdf",
       dpi = 300,
       limitsize = FALSE
       )





