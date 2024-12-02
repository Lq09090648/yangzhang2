beta=read.table("Beta_sort.txt",head=F)
        opar=par(no.readonly=T)
        par(mar=c(5,5,4,1))
        a = unique(beta$V1);
        group = factor(beta$V1,levels = a);
        num=length(levels(factor(beta$V1)))
        pdf(file = paste("bray_curtis",".pdf",sep=""),width=8,height=7)
        boxplot(beta$V2~group,col=rainbow(num),boxwex=0.5,ylim=c(min(beta$V2)*0.7,max(beta$V2)*1.3),las=1,ylab="bray_curtis",xlab="Group",cex.lab=1.2)
        dev.off()
        par=opar
fit = aov(beta$V2~beta$V1)
            tuk = TukeyHSD(fit)
            write.table(tuk$`beta$V1`,file=paste("bray_curtis","_TukeyHSD.txt",sep=""),sep="	",quot=F,col.names=NA)
library(agricolae)
            wilcox=kruskal(beta$V2,beta$V1,group=F)
            write.table(wilcox$comparison,file=paste("bray_curtis","_wilcox.txt",sep=""),sep="	",quot=F,col.names=NA)
