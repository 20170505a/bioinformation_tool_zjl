library(dplyr)

# RAW DATA
raw_data <- read.delim("volcano.txt")
raw_data <- raw_data[,-5]
cutoff <- 1
names(raw_data)[2] <- c("log2FC")
raw_data$threshold[raw_data$log2FC > 1 & raw_data$padj < 0.05] <- "up"
raw_data$threshold[raw_data$log2FC < -1 & raw_data$padj < 0.05] <- "down"
raw_data$threshold[is.na(raw_data$threshold)] <- "non"
raw_data$log10pvalue <- -log10(raw_data$padj)

# Modify boder
raw_data$log10pvalue[raw_data$log10pvalue>300] <- 288
raw_data$log2FC[raw_data$log2FC > 5] <- 4.5
raw_data$log2FC[raw_data$log2FC < -5] <- -4.5

## Volcano #1 ---- ggscatter()
library(ggpubr)
library(ggthemes)
pdf("ggscatter_volcano.pdf")
p1 <- ggscatter(raw_data,x="log2FC",y= "log10pvalue",
          color= "threshold",
          palette = c("green","gray","red"),
          size=1)+
  theme_base()+
  geom_hline(yintercept = 1,linetype="dashed")+
  geom_vline(xintercept = c(-1,1),linetype="dashed")
print(p1)
dev.off()


## Volcano $1---Add label
library(ggrepel)
raw_data_order <- raw_data[order(raw_data$log10pvalue),]
raw_data_order$sig <- ""
up_gene <- head(raw_data_order$id[which(raw_data_order$threshold=="up")],10)
down_gene <- head(raw_data_order$id[which(raw_data_order$threshold=="down")],10)
raw_data_label_gene <- c(as.vector(up_gene),as.vector(down_gene))
raw_data_order$sig[match(raw_data_label_gene,raw_data_order$id)] <- raw_data_label_gene

p <- ggplot(raw_data_order,aes(x=log2FC,y=log10pvalue,color=threshold ))+
  geom_point()+
  scale_color_manual(values=c("#DC143C","#00008B","#808080"))+
  geom_text_repel(
    data = raw_data_order,
    aes(label = sig),
    size = 3,
    segment.color = "black", show.legend = FALSE )+
  theme_bw()+
  ylab('-log10 (p-adj)') +
  xlab('log2 (FoldChange)')+ 
  geom_vline(xintercept=c(-1,1),lty=3,col="black",lwd=0.5) +
  geom_hline(yintercept = -log10(0.05),lty=3,col="black",lwd=0.5)
ggsave("ggplot2_volcano_2.pdf",p)





