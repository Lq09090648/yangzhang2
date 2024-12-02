library(pheatmap)
        x<-read.table("/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/02.OTU/Taxa_heatmap/group/group.p.txt",sep="\t",header=T,row.names=1)
        tax<-read.table("p-p.list",sep="\t",header=F)
        annotation_row = data.frame(Phylum=factor(tax$V2))
        rownames(annotation_row) = tax$V1
        pheatmap(x,scale="row",annotation_row = annotation_row,filename="/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/02.OTU/Taxa_heatmap/group/group.p.pdf",,height=ceiling(24),width=ceiling(18.7096774193548),fontsize=20)
        dev.off()