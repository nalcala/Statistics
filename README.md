# Statistics
Repository with scripts for statistical analyses

## 1. Rejection Sampling with continuous uni- and multivariate distributions
The file ***rejection_samp.R*** contains the function *rej_samp* that performs rejection sampling **to obtain samples from a target probability distribution** <img src="https://rawgit.com/nalcala/Statistics/svgs/svgs/ffcbbb391bc04da2d07f7aef493d3e2a.svg?invert_in_darkmode" align=middle width=30.4986pt height=24.56553pt/> **given samples from an *unknown probability distribution*** <img src="https://rawgit.com/nalcala/Statistics/svgs/svgs/7997339883ac20f551e7f35efff0a2b9.svg?invert_in_darkmode" align=middle width=31.88493pt height=24.56553pt/>.

### Usage
Function *rej_samp* takes 6 arguments:
- A vector or matrix *S* containing sampled values; if the distribution is multivariate, rows correspond to the different statistical units
- An acceptance rate *M* (default is 50)
- A target distribution function *g* (default is dunif)
- An optional vector containing parameters for *g*, *gparams* (default is NULL)
- An optional boolean value *plot* indicating if plots of the distributions are required (default is TRUE)
- An optional cumulative distribution function *pg* (default is NULL); this is required if plot=T in order to truncate the target distribution within the possible range given S

## Algorithm
- Compute an approximation <img src="https://rawgit.com/nalcala/Statistics/svgs/svgs/1be415bedf77d1dc80452b7e1a1146b7.svg?invert_in_darkmode" align=middle width=31.91496pt height=30.55107pt/> of the unknown <img src="https://rawgit.com/nalcala/Statistics/svgs/svgs/7997339883ac20f551e7f35efff0a2b9.svg?invert_in_darkmode" align=middle width=31.88493pt height=24.56553pt/> for all <img src="https://rawgit.com/nalcala/Statistics/svgs/svgs/84b486d65e13978df1d1b6c83dcf8a5f.svg?invert_in_darkmode" align=middle width=151.243125pt height=24.56553pt/> using kernel density estimation function *kde* from R package *ks* on matrix *S*
- Simulate <img src="https://rawgit.com/nalcala/Statistics/svgs/svgs/55a049b8f161ae7cfeb0197d75aff967.svg?invert_in_darkmode" align=middle width=9.83004pt height=14.10255pt/> random variables <img src="https://rawgit.com/nalcala/Statistics/svgs/svgs/194516c014804d683d1ab5a74f8c5647.svg?invert_in_darkmode" align=middle width=14.008665pt height=14.10255pt/> uniformly distributed between 0 and 1, where <img src="https://rawgit.com/nalcala/Statistics/svgs/svgs/55a049b8f161ae7cfeb0197d75aff967.svg?invert_in_darkmode" align=middle width=9.83004pt height=14.10255pt/> is the number of samples in *S*
- For <img src="https://rawgit.com/nalcala/Statistics/svgs/svgs/5059c0687b56e424dbd5e2100470ae5c.svg?invert_in_darkmode" align=middle width=60.09795pt height=24.56553pt/>, accept sample <img src="https://rawgit.com/nalcala/Statistics/svgs/svgs/d28140eda2d12e24b434e011b930fa23.svg?invert_in_darkmode" align=middle width=14.67576pt height=22.38192pt/> if <img src="https://rawgit.com/nalcala/Statistics/svgs/svgs/c0fda936eacea9cf0047928a8572707c.svg?invert_in_darkmode" align=middle width=83.71308pt height=33.14091pt/>


## Output
Function *rej_samp* returns a list with 2 elements:
- a vector or matrix containing the retained elements of *S*
- a boolean vector of size the number of rows in *S* indicating whether the statistical unit is retained

### Examples
#### Univariate example
To obtain samples From a uniform distribution given a uniform distribution, you can use the following command:
```
S = rexp(100000)
Sunif = rej_samp(S,M=10,g=dunif,plot=TRUE,pg=punif)
```
We obtain the following plot based on 10244 retained samples:
![Rejection sampling example](Example_exp2unif.png?raw=true "1D rejection sampling example")

#### Bivariate example
To obtain samples From a bivariate uniform distribution given a bivariate normal distribution with parameters, you can use the following command:
```
S2d = mvrnorm(100000,c(-1,1),matrix(c(1,0,0,1),ncol=2))
Sunif2d = rej_samp(S2d,M=50,g=mvdunif,plot=TRUE,pg=pnorm)
```

We obtain the following plot based on 3890 retained samples:
![Rejection sampling example](Example_mvnorm2mvunif.png?raw=true "2D rejection sampling example")

