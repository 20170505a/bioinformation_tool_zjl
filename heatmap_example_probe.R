## This scriptes is used for generating from microarray downloaded from GEO datases
## This scriptes is split into two parts, first is use to download data and translate them into expression profile
## The second part is used to create heatmap

# set working directory 
rm(list=ls())
temp_path <- file.path("D:","heatmap_temp_for_microarray")
dir.create(temp_path)
setwd(temp_path)
getwd()

# Load corresponding R packages:
library(GEOquery)

# Obtain expression profiles:
eSet <- getGEO('GSE55298', destdir=".", 
               AnnotGPL = F,
               getGPL = F)
raw_profile_data <- eSet[[1]]
exprSet = exprs(raw_profile_data)
