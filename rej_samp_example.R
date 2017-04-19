#################################
# Example of rejection sampling #
#################################

source("rejection_samp.R")

#### Univariate ####
# From exponential to uniform
S = rexp(100000)
Sunif = rej_samp(S,M=10,g=dunif,plot=TRUE,pg=punif)

# From normal to uniform
S2 = rnorm(100000,1,1)
Sunif2 = rej_samp(S2,M=10,g=dunif,plot=TRUE,pg=punif)

# From uniform to normal
S3= runif(100000,-2,2)
Snorm = rej_samp(S3,M=10,g=dnorm,gparams=c(-1,1),plot=TRUE,pg=pnorm)


#### Bivariate ####
# from normal to uniform
mvdunif <- function(a){ dunif(a[,1])*dunif(a[,2]) } #bivariate uniform distribution over [0,1]^2

S4= MASS::mvrnorm(100000,c(-1,1),matrix(c(1,0,0,1),ncol=2))
Sunif2d = rej_samp(S4,M=50,g=mvdunif,plot=TRUE,pg=pnorm)

