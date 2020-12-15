## ASSET Example Use ##

library(ASSET)

## Data for h.traits example ##
data(ex_trait, package="ASSET")
# Display the data, and case/control overlap matrices
data
N00
N11
N10


## Data for h.types example ##
data(ex_types, package="ASSET")
# Display the first 10 rows of the data
data[1:10, ]

##Forest plot for meta-analysis of heterogenerous traits or types ##

# Use the example data
data(ex_trait, package="ASSET")
data
# Define the input arguments to h.traits
snps <- as.vector(data[, "SNP"])
traits.lab <- paste("Trait_", 1:6, sep="")
beta.hat <- as.matrix(data[, paste(traits.lab, ".Beta", sep="")])
sigma.hat <- as.matrix(data[, paste(traits.lab, ".SE", sep="")])

cor <- list(N11=N11, N00=N00, N10=N10)
ncase <- diag(N11)
ncntl <- diag(N00)
# Now let us call h.traits on these summary data.
res <- h.traits(snps, traits.lab, beta.hat, sigma.hat, ncase=ncase,
                ncntl=ncntl, cor=cor, cor.numr=FALSE, search=NULL,
                side=2, meta=TRUE, zmax.args=NULL)
h.forestPlot(res, "SNP_1", digits=3)


## Summary results from subset-search. ##

# Use the example data
data(ex_trait, package="ASSET")
# Define the input arguments to h.traits
snps <- as.vector(data[, "SNP"])
traits.lab <- paste("Trait_", 1:6, sep="")
beta.hat <- as.matrix(data[, paste(traits.lab, ".Beta", sep="")])
sigma.hat <- as.matrix(data[, paste(traits.lab, ".SE", sep="")])
cor <- list(N11=N11, N00=N00, N10=N10)
ncase <- diag(N11)
ncntl <- diag(N00)
# Now let us call h.traits on these summary data.
res <- h.traits(snps, traits.lab, beta.hat, sigma.hat, ncase=ncase,
                ncntl=ncntl, cor=cor, cor.numr=FALSE, search=NULL,
                side=2, meta=TRUE, zmax.args=NULL)
h.summary(res)



## Heterogeneous traits or studies ##

# Use the example data
data(ex_trait, package="ASSET")
# Display the data, and case/control overlap matrices
data
N00
N11
N10
# Define the input arguments to h.traits
snps <- as.vector(data[, "SNP"])
traits.lab <- paste("Trait_", 1:6, sep="")
beta.hat <- as.matrix(data[, paste(traits.lab, ".Beta", sep="")])
sigma.hat <- as.matrix(data[, paste(traits.lab, ".SE", sep="")])
cor <- list(N11=N11, N00=N00, N10=N10)
ncase <- diag(N11)
ncntl <- diag(N00)
# Now let us call h.traits on these summary data.
res <- h.traits(snps, traits.lab, beta.hat, sigma.hat, ncase=ncase,
                ncntl=ncntl, cor=cor, cor.numr=FALSE, search=NULL,
                side=2, meta=TRUE, zmax.args=NULL)
h.summary(res)


## Heterogeneous Subtype analysis ##
# Use the example data
data(ex_types, package="ASSET")
# Display the first 10 rows of the data and a table of the subtypes
data[1:10, ]
table(data[, "TYPE"])
# Define the input arguments to h.types.
snps <- paste("SNP_", 1:3, sep="")
adj.vars <- c("CENTER_1", "CENTER_2", "CENTER_3")
types <- paste("SUBTYPE_", 1:5, sep="")
# SUBTYPE_0 will denote the controls
res <- h.types(data, "TYPE", snps, adj.vars, types, "SUBTYPE_0", subset=NULL,
               method="case-control", side=2, logit=FALSE, test.type="Score",
               zmax.args=NULL, pval.args=NULL)
h.summary(res)


# NOTE EVERYTHING UNDER IS CALLED INTERNALLY BY H.TYPE OR H.TRAITS 
# SO IT NEED NOT BE CALLED #


## Discrete Local Maxima approximate p-value. ##

# A function to define the correlations between a subset and its neighbors
# Returned values should not exceed the value of 1
cor.def <- function(subset, neighbors, k, ncase, ncntl) {
  n <- ncol(neighbors)
  mat <- matrix(subset, nrow=k, ncol=n, byrow=FALSE)
  cor <- (mat + neighbors)*(1:k)/(k^2)
  cor <- colSums(cor)
  cor <- cor/max(cor)
  dim(cor) <- c(n, 1)
  cor
}
# Subset definition
sub.def <- function(logicalVec, args) {
  # Only allow the cummulative subsets:
  # TRUE FALSE FALSE FALSE ...
  # TRUE TRUE FALSE FALSE ...
  # TRUE TRUE TRUE FALSE ...
  # etc
  sum <- sum(logicalVec)
  ret <- all(logicalVec[1:sum])
  ret
}
k <- 5
t.vec <- 1:k
z.sub <- rep(1, k)
p.dlm(t.vec, z.sub, 1, 2, cor.def=cor.def, sub.def=sub.def,
      cor.args=list(ncase=rep(1000, k), ncntl=rep(1000,k)))



## Z-score Maximization ##

set.seed(123)
# Define the function to calculate the z-scores
16 z.max
meta.def <- function(logicalVec, SNP.list, arg.beta, arg.sigma) {
  # Get the snps and subset to use
  beta <- as.matrix(arg.beta[SNP.list, logicalVec])
  se <- as.matrix(arg.sigma[SNP.list, logicalVec])
  test <- (beta/se)^2
  ret <- apply(test, 1, max)
  list(z=ret)
}
# Define the function to determine which subsets to consider
sub.def <- function(logicalVec, args) {
  # Only allow the cummulative subsets:
  # TRUE FALSE FALSE FALSE ...
  # TRUE TRUE FALSE FALSE ...
  # TRUE TRUE TRUE FALSE ...
  # etc
  sum <- sum(logicalVec)
  ret <- all(logicalVec[1:sum])
  ret
}
# Assume there are 10 subtypes and 3 SNPs
k <- 10
snp.vars <- 1:3
# Generate some data
nsnp <- length(snp.vars)
beta <- matrix(-0.5 + runif(k*nsnp), nrow=nsnp)
sigma <- matrix(runif(k*nsnp)^2, nrow=nsnp)
meta.args <- list(arg.beta=beta, arg.sigma=sigma)
z.max(k, snp.vars, 2, meta.def, meta.args, sub.def=sub.def)

