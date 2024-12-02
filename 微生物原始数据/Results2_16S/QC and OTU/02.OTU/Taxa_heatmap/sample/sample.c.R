library(pheatmap)
        x<-read.table("/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/02.OTU/Taxa_heatmap/sample/sample.c.txt",sep="\t",header=T,row.names=1)
        tax<-read.table("p-c.list",sep="\t",header=F)
        annotation_row = data.frame(Phylum=factor(tax$V2))
        rownames(annotation_row) = tax$V1
        pheatmap(x,scale="row",annotation_row = annotation_row,filename="/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/02.OTU/Taxa_heatmap/sample/sample.c.pdf",,height=ceiling(24),width=ceiling(24.1290322580645),fontsize=20)
        dev.off()