
    require(ade4)
    require(cluster)
    require(grid)
    require(fpc)
    require(clusterSim)
    require(RColorBrewer)
	require(ggplot2)
	setwd("/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/03.Diversity/BetaDiversity/PCA/species")
	data = read.table("/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/03.Diversity/BetaDiversity/PCA/species/sample.s.relative.mat", head=T, na.strings=T,row.names=1,sep="\t")
	groups = read.table("/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/03.Diversity/BetaDiversity/PCA/group.list", head=F,na.strings=T,colClasses=c("character","character"))
	
    b <- matrix(0,nrow = nrow(data), ncol = ncol(data))
    for(i in 1:ncol(data)){
        b[,i] = data[ ,i]/sum(data[ ,i])
    }
    colnames(b) <- colnames(data)
    rownames(b) <- rownames(data)
    data <- t(b)

    length=length(unique(as.character(groups$V1)))
    times1=length%/%8
    res1=length%%8
    times2=length%/%5
    res2=length%%5
    col1=rep(1:8,times1)
    col=c(col1,1:res1)
    pich1=rep(c(15:18,20,7:14,0:6),times2)
    pich=c(pich1,15:(15+res2))

######################### PCA base on ade4 ###############################   		
    pca = dudi.pca(data[,1:ncol(data)], scannf=F, nf=5)
    PC1 = pca$li[,1]
    PC2 = pca$li[,2]
    PC12 = pca$li[,1:2]
    write.csv(pca$li,file="pca.csv")	
    ncol=ncol(groups)
    group1=c()
    group2=c() 
    for(i in 1:length(groups$V1)){
        Order=grep(paste0('^',rownames(pca$li)[i],'$'),groups$V1,perl=T)
        group1[i]=groups$V2[Order]
        if(ncol==3){
           group2[i]=groups$V3[Order]
        }
    }
    group1=factor(group1,levels=unique(group1))## edit by ye,to fix group order 2015-12-07
    group2=factor(group2,levels=unique(group2))## edit by ye,to fix group order 2015-12-07
    if(ncol==2){
        plotdata = data.frame(rownames(pca$li),PC1,PC2,group1)
        colnames(plotdata)=c("sample","PC1","PC2","group")
        point<-geom_point(aes(colour=group,shape=group),size=6)
    }else if(ncol==3){
        plotdata = data.frame(rownames(pca$li),PC1,PC2,group1,group2)
        colnames(plotdata)=c("sample","PC1","PC2","group1","group2")
        point<-geom_point(aes(colour=group1,shape=group2),size=6)
    }
    plotdata$sample = factor(plotdata$sample,levels=unique(plotdata$sample))## edit by ye,to fix samples order 2015-12-07
	plotdata$PC1=as.numeric(as.vector(plotdata$PC1))
	plotdata$PC2=as.numeric(as.vector(plotdata$PC2))
	pc1 <- round((pca$eig/sum(pca$eig))*100,2)[1]
    pc2 <- round((pca$eig/sum(pca$eig))*100,2)[2]

######################### PCA plot without cluster ############################
    plot<-ggplot(plotdata, aes(PC1, PC2)) +
        point+ 
        scale_shape_manual(values=pich)+
        scale_colour_manual(values=col)+
        labs(title="PCA Plot") + xlab(paste("PC1 ( ",pc1,"%"," )",sep="")) + ylab(paste("PC2 ( ",pc2,"%"," )",sep=""))+
        theme(text=element_text(family="Arial",size=18))+
                geom_vline(aes(x=0,y=0),linetype="dotted")+
                         geom_hline(aes(x=0,y=0),linetype="dotted")+
       	    theme(panel.background = element_rect(fill='white', colour='black'), panel.grid=element_blank(), axis.title = element_text(color='black',family="Arial",size=18),axis.ticks.length = unit(0.4,"lines"), axis.ticks = element_line(color='black'), axis.ticks.margin = unit(0.6,"lines"),axis.line = element_line(colour = "black"), axis.title.x=element_text(colour='black', size=18),axis.title.y=element_text(colour='black', size=18),axis.text=element_text(colour='black',size=18),legend.title=element_blank(),legend.text=element_text(family="Arial", size=18),legend.key=element_blank())+
            theme(plot.title = element_text(size=22,colour = "black",face = "bold"))

    cairo_pdf(filename="/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/03.Diversity/BetaDiversity/PCA/species/PCA.pdf",height=12,width=15)
    plot
dev.off()
	
