# 1. Set working directory 
rm(list=ls())
temp_path <- file.path("D:","heatmap_temp_for_rna_seq")
dir.create(temp_path)
setwd(temp_path)
getwd()

# 2. Load raw data
# This raw data was generated randomly
raw_data <- read.delim("https://raw.githubusercontent.com/20170505a/raw_data/master/heatmap_raw_data.csv",header=T,sep=",")
head(raw_data)
str(raw_data)

# 3. Transform raw data(data.frame) into matrix
raw_data_matrix <- as.matrix(raw_data[-1])
rownames(raw_data_matrix) <- raw_data[1]

# 4. pheatmap package
# first R packages: pheatmap
library(pheatmap)
pheatmap(raw_data_matrix,
         border=NA,border_color=NA,
         color = colorRampPalette(c("blue","white","red"))(100),
         cellwidth = 36,cellheight = 8,
         cluster_rows = T,cluster_cols = F,
         cutree_rows = 4,
         fontsize = 8, 
         scale="row",
         show_rownames=T,filename = "pheatmap_R_package_heatmap.pdf")



# 