# Statistics
Repository with scripts for statistical analyses

## 1. Rejection Sampling with continuous uni- and multivariate distributions
The file ***rejection_samp.R*** contains the function *rej_samp* that performs rejection sampling **to obtain samples from a target probability distribution** $g(x)$ **given samples from an *unknown probability distribution*** $f(x)$.

### Usage
Function *rej_samp* takes 6 arguments:
- A vector or matrix *S* containing sampled values; if the distribution is multivariate, rows correspond to the different statistical units
- An acceptance rate *M* (default is 50)
- A target distribution function *g* (default is dunif)
- An optional vector containing parameters for *g*, *gparams* (default is NULL)
- An optional boolean value *plot* indicating if plots of the distributions are required (default is TRUE)
- An optional cumulative distribution function *pg* (default is NULL); this is required if plot=T in order to truncate the target distribution within the possible range given S

## Algorithm
- Compute an approximation $\tilde{f}(x)$ of the unknown $f(x)$ for all $x \in [\min(S),\max(S)]$ using kernel density estimation function *kde* from R package *ks* on matrix *S*
- Simulate $n$ random variables $u_i$ uniformly distributed between 0 and 1, where $n$ is the number of samples in *S*
- For $i \in [1,n]$, accept sample $S_i$ if $u_i < \frac{g(S_i)}{M \tilde{f}(S_i)}$


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

