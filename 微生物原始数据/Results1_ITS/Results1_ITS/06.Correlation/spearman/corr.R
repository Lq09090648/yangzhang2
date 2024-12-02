library(psych);
alpha = read.table("/Mega/bioinfo/sci/Project/Mic/ITS/C10117100230/Project/project1/output/05.Correlation/spearman/sample.g.relative35.tab.order_sample", head=T,sep='\t',row.names=1);
env =  read.table("/Mega/bioinfo/sci/Project/Mic/ITS/C10117100230/Project/project1/env_cor.order_sample", head=T,sep='\t',row.names=1);
res=corr.test(env,alpha,method="spearman");
write.table(res$r,"correlation.xls",sep="\t",quote=F,col.names=NA);
write.table(res$p,"pvalue.xls",sep="\t",quote=F,col.names=NA);

library(pheatmap);
#pdf("correlation.pdf",height=ceiling(13),width=ceiling(12.6129032258065));
#pheatmap(res$r,display_numbers = matrix(ifelse(res$p <= 0.05, "*", ""), nrow(res$p)), cluster_rows=F, cluster_col=F, fontsize=10 , filename="correlation.pdf");
pheatmap(res$r,display_numbers = matrix(ifelse(res$p <= 0.01, "**", ifelse(res$p <= 0.05 ,"*"," ")), nrow(res$p)), cluster_rows=F, fontsize_number=20,cluster_col=F, fontsize=10 , filename="correlation.pdf");

