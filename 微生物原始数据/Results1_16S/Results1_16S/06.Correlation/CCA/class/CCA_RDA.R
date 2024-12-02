
    library(vegan)
    library(ggplot2)
    library(grid)
	community<-read.table("/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/05.Correlation/CCA/class/sample.c.relative.mat", head=T,na.strings=T, row.names=1,sep="\t")
    envdata<-read.table("/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/env_cor", header=TRUE,na.strings=T,row.names=1,sep="\t")
    groups = read.table("/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/05.Correlation/CCA/all.mf", head=F,na.strings=T,colClasses=c("character","character"))
    community$taxonomy=NULL
    community<-t(community)
       
    length=length(unique(as.character(groups$V1)))
    times1=length%/%8
    res1=length%%8
    times2=length%/%5
    res2=length%%5
    col1=rep(1:8,times1)
    col=c(col1,1:res1)
    pich1=rep(c(15:18,20,7:14,0:6),times2)
    pich=c(pich1,15:(15+res2))
  
	
#DCA
    dca=decorana(veg = community)
    dca1=max(dca$rproj[,1])
    dca2=max(dca$rproj[,2])
    dca3=max(dca$rproj[,3])
    dca4=max(dca$rproj[,4])
    AL=data.frame(
    DCA1=c(dca1),
    DCA2=c(dca2),
    DCA3=c(dca3),
    DCA4=c(dca4))
    rownames(AL)=c("Axislength")        
    write.csv(AL,file="/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/05.Correlation/CCA/class/dca.csv")
        

#CCA    
    cca<-cca(community,envdata,scale=T)
    ccascore=scores(cca)
    write.csv(ccascore$sites,file="/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/05.Correlation/CCA/class/cca.sample.csv")
    write.csv(cca$CCA$biplot,file="/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/05.Correlation/CCA/class/cca.env.csv")
    write.csv(ccascore$species,file="/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/05.Correlation/CCA/class/cca.sp.csv")
          
    CCAE =cca$CCA$biplot[,1:2]
    CCASP=ccascore$species[,1:2]
   	CCAS1 = ccascore$sites[,1]
	CCAS2 = ccascore$sites[,2]
    CCAE = as.data.frame(CCAE)
    CCASP = as.data.frame(CCASP)
	
    ncol=ncol(groups)
    group1=c()
    group2=c() 
    for(i in 1:length(groups$V1)){
        TEEE=paste("^",rownames(ccascore$sites)[i],"$",sep="")
        Order=grep(TEEE,groups$V1)
        group1[i]=groups$V2[Order]
        if(ncol==3){
           group2[i]=groups$V3[Order]
           }
        }
    if(ncol ==2){
	    plotdata = data.frame(rownames(ccascore$sites),CCAS1,CCAS2,group1)
	    colnames(plotdata)=c("sample","CCAS1","CCAS2","group")
        point<-geom_point(aes(colour=group,shape=group),size=6)
    }else if (ncol ==3){
        plotdata = data.frame(rownames(ccascore$sites),CCAS1,CCAS2,group1,group2)
        colnames(plotdata)=c("sample","CCAS1","CCAS2","group1","group2")
        point<-geom_point(aes(colour=group1,shape=group2),size=6)
    }  
	plotdata$sample = factor(plotdata$sample,levels=unique(plotdata$sample))
        plotdata$group = factor(plotdata$group,levels=unique(plotdata$group))
	plotdata$CCAS1=as.numeric(as.vector(plotdata$CCAS1))
	plotdata$CCAS2=as.numeric(as.vector(plotdata$CCAS2))
    pc1 =round(cca$CCA$eig[1]/sum(cca$CCA$eig)*100,2)
    pc2 =round(cca$CCA$eig[2]/sum(cca$CCA$eig)*100,2)
    

#CCA plot	
	plot_CCA1<-ggplot(plotdata, aes(CCAS1, CCAS2)) +
	    geom_text(aes(label=sample),size=4,hjust=0.5,vjust=-1,position = "jitter")+ 
	    point+ 
        scale_shape_manual(values=pich)+
        scale_colour_manual(values=col)+
	    labs(title="CCA Plot") + 
		xlab(paste("CCA1 ( ",pc1,"%"," )",sep="")) + 
		ylab(paste("CCA2 ( ",pc2,"%"," )",sep=""))+
	    theme(panel.background = element_rect(fill='white', colour='black')) +
        geom_segment(data = CCAE,x=0,y=0, aes(x=0,y=0,xend = CCAE[,1], yend = CCAE[,2]),
		    colour="purple",size=1,arrow=arrow(angle=25, length=unit(0.25, "cm")))+
        geom_text(data=CCAE, aes(x=CCAE[,1], y=CCAE[,2], label=rownames(CCAE)), family="Arial", size=6, colour="purple",
		    hjust = (1 - 2 * sign(CCAE[ ,1])) / 3,angle = (180/pi) * atan(CCAE[ ,2]/CCAE[ ,1]))+
        theme(text=element_text(family="Arial",size=5))+
        geom_vline(aes(x=0,y=0),linetype="dotted")+
        geom_hline(aes(x=0,y=0),linetype="dotted")+
       	theme(panel.background = element_rect(fill='white', colour='black'), panel.grid=element_blank(), 
		    axis.title = element_text(color='black',family="Arial",size=18),axis.ticks.length = unit(0.4,"lines"), 
			axis.ticks = element_line(color='black'), axis.ticks.margin = unit(0.6,"lines"),axis.line = element_line(colour = "black"), 
			axis.title.x=element_text(colour='black', size=18),axis.title.y=element_text(colour='black', size=18),axis.text=element_text(colour='black',size=18),
			legend.title=element_blank(),legend.text=element_text(family="Arial", size=18),legend.key=element_blank())+
        theme(plot.title = element_text(size=22,colour = "black",face = "bold"))        
    cairo_pdf("/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/05.Correlation/CCA/class/CCA_sample_env.pdf",height=12,width=15)
    plot_CCA1
    png(filename="/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/05.Correlation/CCA/class/CCA_sample_env.png",res=600,height=5400,width=7200,type="cairo")
    plot_CCA1
    dev.off()	

    
	plot_CCA2<-ggplot(plotdata, aes(CCAS1, CCAS2)) +
        point+ 
        scale_shape_manual(values=pich)+
        scale_colour_manual(values=col)+
	    labs(title="CCA Plot") + xlab(paste("CCA1 ( ",pc1,"%"," )",sep="")) + ylab(paste("CCA2 ( ",pc2,"%"," )",sep=""))+
        theme(panel.background = element_rect(fill='white', colour='black')) +
        geom_segment(data = CCAE,x=0,y=0, aes(x=0,y=0,xend = CCAE[,1], yend = CCAE[,2]),
            colour="purple",size=1,arrow=arrow(angle=25, length=unit(0.25, "cm")))+
        geom_text(data=CCAE, aes(x=CCAE[,1], y=CCAE[,2], label=rownames(CCAE)), family="Arial", size=6, colour="purple",
		    hjust = (1 - 2 * sign(CCAE[ ,1])) / 3,angle = (180/pi) * atan(CCAE[ ,2]/CCAE[ ,1]))+
        theme(text=element_text(family="Arial",size=5))+geom_vline(aes(x=0,y=0),linetype="dotted")+
            geom_hline(aes(x=0,y=0),linetype="dotted")+theme(plot.title = element_text(size=22,colour = "black",face = "bold"))+
       	theme(panel.background = element_rect(fill='white', colour='black'), panel.grid=element_blank(), 
		    axis.title = element_text(color='black',family="Arial",size=18),axis.ticks.length = unit(0.4,"lines"), 
			axis.ticks = element_line(color='black'), axis.ticks.margin = unit(0.6,"lines"),axis.line = element_line(colour = "black"), 
			axis.title.x=element_text(colour='black', size=18),axis.title.y=element_text(colour='black', size=18),axis.text=element_text(colour='black',size=18),
			legend.title=element_blank(),legend.text=element_text(family="Arial", size=18),legend.key=element_blank())
        cairo_pdf("/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/05.Correlation/CCA/class/CCA_sample_env2.pdf",height=12,width=15)
        plot_CCA2
        png(filename="/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/05.Correlation/CCA/class/CCA_sample_env2.png",res=600,height=5400,width=7200,type="cairo")
        plot_CCA2
        dev.off()  
    
    
#Permutation test       
    envfit=envfit(cca,envdata,permu=2000)  
    r=as.matrix(envfit$vectors$r) 
    p=as.matrix(envfit$vectors$pvals)
    colnames(r)="r2" 
    colnames(p)="Pr(>r)" 
    env=cbind(envfit$vectors$arrows,r,p) 
    write.csv(as.data.frame(env),file="/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/05.Correlation/CCA/class/ccaenvfit.csv")

		
#RDA		
    rda<-rda(community,envdata,scale=T)
    rdascore<-scores(rda)
    write.csv(rdascore$sites,file="/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/05.Correlation/CCA/class/rda.sample.csv")
    write.csv(rda$CCA$biplot,file="/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/05.Correlation/CCA/class/rda.env.csv")
    write.csv(rdascore$species,file="/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/05.Correlation/CCA/class/rda.sp.csv")
    RDAE =rda$CCA$biplot[,1:2]
    RDASP=rdascore$species[,1:2]
    RDAS1 = rdascore$sites[,1]
    RDAS2 = rdascore$sites[,2]
    RDAE = as.data.frame(RDAE)
    RDASP = as.data.frame(RDASP)

    if(ncol ==2){
        plotdata = data.frame(rownames(rdascore$sites),RDAS1,RDAS2,group1)
        colnames(plotdata)=c("sample","RDAS1","RDAS2","group")
    }else if (ncol ==3){
        plotdata = data.frame(rownames(rdascore$sites),RDAS1,RDAS2,group1,group2)
        colnames(plotdata)=c("sample","RDAS1","RDAS2","group1","group2")
    }

    plotdata$sample = factor(plotdata$sample,levels=unique(plotdata$sample))
    plotdata$group = factor(plotdata$group,levels=unique(plotdata$group))
    plotdata$RDAS1=as.numeric(as.vector(plotdata$RDAS1))
    plotdata$RDAS2=as.numeric(as.vector(plotdata$RDAS2))
    pc1 =round(rda$CCA$eig[1]/sum(rda$CCA$eig)*100,2)
	pc2 =round(rda$CCA$eig[2]/sum(rda$CCA$eig)*100,2)

		
#RDA plot        
    plot_RDA1<-ggplot(plotdata, aes(RDAS1, RDAS2)) +
        geom_text(aes(label=sample),size=4,hjust=0.5,vjust=-1,position = "jitter")+ 
        point+ 
        scale_shape_manual(values=pich)+
        scale_colour_manual(values=col)+
	    labs(title="RDA Plot") + xlab(paste("RDA1 ( ",pc1,"%"," )",sep="")) + ylab(paste("RDA2 ( ",pc2,"%"," )",sep=""))+
        theme(panel.background = element_rect(fill='white', colour='black')) +
        geom_segment(data = RDAE,x=0,y=0, aes(x=0,y=0,xend = RDAE[,1], yend = RDAE[,2]),
            colour="purple",size=1,arrow=arrow(angle=25, length=unit(0.25, "cm")))+
        geom_text(data=RDAE, aes(x=RDAE[,1], y=RDAE[,2], label=rownames(RDAE)), size=6, colour="purple",
		    hjust = (1 - 2 * sign(RDAE[ ,1])) / 3,angle = (180/pi) * atan(RDAE[ ,2]/RDAE[ ,1]))+
        theme(text=element_text(family="Arial",size=5))+
        geom_vline(aes(x=0,y=0),linetype="dotted")+
        geom_hline(aes(x=0,y=0),linetype="dotted")+
       	theme(panel.background = element_rect(fill='white', colour='black'), panel.grid=element_blank(), 
		    axis.title = element_text(color='black',family="Arial",size=18),axis.ticks.length = unit(0.4,"lines"), 
			axis.ticks = element_line(color='black'), axis.ticks.margin = unit(0.6,"lines"),axis.line = element_line(colour = "black"), 
			axis.title.x=element_text(colour='black', size=18),axis.title.y=element_text(colour='black', size=18),
			axis.text=element_text(colour='black',size=18),legend.title=element_blank(),legend.text=element_text(family="Arial", size=18),legend.key=element_blank())+
        theme(plot.title = element_text(size=22,colour = "black",face = "bold"))        
    cairo_pdf("/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/05.Correlation/CCA/class/RDA_sample_env.pdf",height=12,width=15)
    plot_RDA1
    png(filename="/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/05.Correlation/CCA/class/RDA_sample_env.png",res=600,height=5400,width=7200,type="cairo")
    plot_RDA1
    dev.off() 


    plot_RDA2<-ggplot(plotdata, aes(RDAS1, RDAS2)) +
        point+ 
        scale_shape_manual(values=pich)+
        scale_colour_manual(values=col)+
	    labs(title="RDA Plot") + xlab(paste("RDA1 ( ",pc1,"%"," )",sep="")) + 
		ylab(paste("RDA2 ( ",pc2,"%"," )",sep=""))+
        theme(panel.background = element_rect(fill='white', colour='black')) +
        geom_segment(data = RDAE,x=0,y=0, aes(x=0,y=0,xend = RDAE[,1], yend = RDAE[,2]),
            colour="purple",size=1,arrow=arrow(angle=25, length=unit(0.25, "cm")))+
        geom_text(data=RDAE, aes(x=RDAE[,1], y=RDAE[,2], label=rownames(RDAE)), size=6, colour="purple",
		    hjust = (1 - 2 * sign(RDAE[ ,1])) / 3,angle = (180/pi) * atan(RDAE[ ,2]/RDAE[ ,1]))+
        theme(text=element_text(family="Arial",size=5))+
        geom_vline(aes(x=0,y=0),linetype="dotted")+
        geom_hline(aes(x=0,y=0),linetype="dotted")+
       	theme(panel.background = element_rect(fill='white', colour='black'), panel.grid=element_blank(),
		    axis.title = element_text(color='black',family="Arial",size=18),axis.ticks.length = unit(0.4,"lines"),
			axis.ticks = element_line(color='black'), axis.ticks.margin = unit(0.6,"lines"),axis.line = element_line(colour = "black"), 
			axis.title.x=element_text(colour='black', size=18),axis.title.y=element_text(colour='black', size=18),axis.text=element_text(colour='black',size=18),
			legend.title=element_blank(),legend.text=element_text(family="Arial", size=18),legend.key=element_blank())+
        theme(plot.title = element_text(size=22,colour = "black",face = "bold"))        
    cairo_pdf("/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/05.Correlation/CCA/class/RDA_sample_env2.pdf",height=12,width=15)
    plot_RDA2
    png(filename="/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/05.Correlation/CCA/class/RDA_sample_env2.png",res=600,height=5400,width=7200,type="cairo")
    plot_RDA2
    dev.off()         
 

#Permutation test 
    envfit=envfit(rda,envdata,permu=2000)
    r=as.matrix(envfit$vectors$r)
    p=as.matrix(envfit$vectors$pvals)
    colnames(r)="r2"
    colnames(p)="Pr(>r)"
    env=cbind(envfit$vectors$arrows,r,p)
    write.csv(as.data.frame(env),file="/Mega/bioinfo/sci/Project/Mic/16sRNA/C10117100230/Project/project1/output/05.Correlation/CCA/class/rdaenvfit.csv")  
