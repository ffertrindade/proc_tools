# script para plotar resumos gerados pelo getStats.sh
# Fernanda T 14-05-2020

# diretorio e lista de amostras
library(lattice, pos=10)
setwd("C:/Users/ffert/OneDrive - PUCRS - BR/Doutorado/analises/map_stats/")
chromosomeSummary<-read.csv("batch001_paleomix_cromosomeSummary.csv")
readsSummary<-read.csv("batch001_paleomix_readsSummary.csv")

# plot num pares de reads inicial para cada amostra
png(filename="numReadPairs.png", width=500, height=900)
print(xyplot(seq_reads_pairs ~ reorder(sample,seq_reads_pairs), scales=list(x=list(rot=45), y=list(tick.number=20)), pch=16, data=readsSummary, main="Number of read pairs", xlab="Samples", ylab="Number of read pairs"))
dev.off()

# plot num pares de reads inicial e colapsadas para cada amostra
samples<-paste(readsSummary$sample,readsSummary$sample)
png(filename="numReadPairsCollap.png", width=500, height=900)
barplot(counts, col=c("darkblue","red"), names=reorder(sample, seq_reads_pairs), cex.names=0.75)

xyplot(seq_reads_pairs ~ reorder(sample,seq_reads_pairs), scales=list(x=list(rot=45), y=list(tick.number=20)), pch=16, data=readsSummary)
xyplot(seq_collapsed ~ reorder(sample,seq_reads_pairs), scales=list(x=list(rot=45), y=list(tick.number=20)), pch=16, data=readsSummary, main="Number of read pairs total and collapsed", xlab="Samples", ylab="Number of read pairs")
