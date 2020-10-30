# script para plotar output samtools depth: https://www.biostars.org/p/245652/
# Fernanda T 14-05-2020

# diretorio e lista de amostras
library(reshape)
library(lattice, pos=10)
setwd("~/paleomix/batch001/ChrA1depth")
barcodeTable<-read.csv("../sampleIDTable.txt")

# loop por cada amostra - especificar no loop o numero de amostras
for (i in 1:57) {
  input<-paste0("batch001.felCat9-masked.realigned.",barcodeTable$AccessionID[[i]],".bam.ChrA1depth")
  title<-paste0("Depth ",barcodeTable$ClientAccessionID[[i]]," - felCat9 ChrA1")
  output<-paste0("ChrA1depth_felCat9_",barcodeTable$ClientAccessionID[[i]],".png")

  print("Working on read...")
  depth<-read.table(input, header=FALSE, na.strings="NA", dec=".", strip.white=TRUE)
  depth<-rename(depth,c(V1="chr", V2="pos", V3="dep"))

  print("Plotting...")
  png(filename=output, width=1700, height=500)
  print(xyplot(dep ~ pos | dep>20 , type="p", pch=16, cex=0.1, auto.key=list(border=TRUE), par.settings=simpleTheme(pch=16), scales=list(x=list(relation='free'), y=list(relation='free')), data=depth, groups=depth$chr, main=title))
  dev.off()
}

