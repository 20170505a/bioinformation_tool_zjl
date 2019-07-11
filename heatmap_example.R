
# set working directory 
rm(list=ls())
setwd("C:\Users\20161111\Desktop")

# Load corresponding R packages:
library(GEOquery)

# Obtain expression profiles:
eSet <- getGEO('GSE55298', destdir=".", 
               AnnotGPL = F,
               getGPL = F)
raw_profile_data <- eSet[[1]]
exprSet = exprs(raw_profile_data)
