## rejection sampling
rej_samp <- function(S,M=50,g=dunif,gparams=NULL,plot=TRUE,pg=NULL){
  dim = ncol(S)
  if(is.null(dim)) dim = 1
  fx = ks::kde(S)
  if(dim==1) fxi = fx$estimate[sapply(S, function(xi) which.min(abs(fx$eval.points-xi)) )]
  else  fxi = fx$estimate[sapply(1:dim, function(i) sapply(S[,i], function(xi) which.min(abs(fx$eval.points[[i]]-xi)) ))]
  u = runif(length(S)/dim)
  gS = do.call(g, c(list(S),as.list(gparams)))
  retain = (u < (gS/M/fxi) )&(gS>0)
  
  if(dim==1) gx = ks::kde(S[retain])#,H = bandwidth)
  else gx = ks::kde(S[retain,])
  if(plot){
    if(dim==1){
      xsteps = seq(min(S),max(S),(max(S)-min(S))/100 )
      pdf(paste("Rejection_sampling",format(Sys.time(), "%d%b%Y_%R:%S"),".pdf",sep=""),h=5,w=5)
      par(family="Times",las=1)
      plot( fx$eval.points,fx$estimate ,type="l",xlim=c(min(S),max(S)),ylim=c(0,max(c(fx$estimate,gx$estimate))), xlab="Value of the random variable",ylab="Density",col=1)
      lines(gx$eval.points,gx$estimate,col=2)
      lines(xsteps, do.call(g, c(list(xsteps),as.list(gparams)))/(do.call(pg, as.list(c(max(S),gparams))) - do.call(pg, as.list(c(min(S),gparams)))) ,lty=2,col=2)
      legend("topright",legend = c("Before rejection sampling","After rejection sampling","Target distribution") ,col=c(1,2,2), lty=c(1,1,2),cex = 0.5)
      dev.off()  
    }else{
      if(dim==2){
        xsteps = seq(min(S),max(S),(max(S)-min(S))/100 )
        pdf(paste("Rejection_sampling",format(Sys.time(), "%d%b%Y_%R:%S"),".pdf",sep=""),h=3.5,w=3.5*3)
        par(family="Times",las=1,mfrow=c(1,3))
        image(fx$eval.points[[1]],fx$eval.points[[2]],fx$estimate ,xlim=c(min(S[,1]),max(S[,1])),ylim=c(min(S[,2]),max(S[,2])), xlab="Value of the 1st random variable",ylab="Value of the 2nd random variable",main="Before rejection sampling",col=gray.colors(12,start = 1,end=0.2))
        image(gx$eval.points[[1]],gx$eval.points[[2]],gx$estimate ,xlim=c(min(S[,1]),max(S[,1])),ylim=c(min(S[,2]),max(S[,2])), xlab="Value of the 1st random variable",ylab="Value of the 2nd random variable",main="After rejection sampling",col=gray.colors(12,start = 1,end=0.2))
        image(xsteps,xsteps,matrix(do.call(g, c(list(cbind(xsteps, rep(xsteps,each=length(xsteps)))),as.list(gparams))),ncol=length(xsteps) ),xlim=c(min(S[,1]),max(S[,1])),ylim=c(min(S[,2]),max(S[,2])), xlab="Value of the 1st random variable",ylab="Value of the 2nd random variable" ,main="Target distribution",col=gray.colors(12,start = 1,end=0.2))
        dev.off()  
      } 
    }
  }
  
  return(list(S[retain],retain) )
}  


