## This script of R is used to create heatmap for high-throughput qPCR data 
# set working directory 
rm(list=ls())
temp_path <- file.path("D:","heatmap_temp_for_qPCR")
dir.create(temp_path)
setwd(temp_path)
getwd()

