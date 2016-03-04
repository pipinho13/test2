####more info http://rstudio-pubs-static.s3.amazonaws.com/1001_3177e85f5e4840be840c84452780db52.html

set.seed(123)
tau_1_true <- 0.25
x <- y <- rep(0,1000)
for( i in 1:1000 ) {
  if( runif(1) < tau_1_true ) {
    x[i] <- rnorm(1, mean=1)
    y[i] <- "heads"
  } else {
    x[i] <- rnorm(1, mean=7)
    y[i] <- "tails"
  }
}

densityplot( ~x, 
             par.settings = list(
               plot.symbol = list(
                 col=as.factor(y)
                 )
               )
             )

##Apply the Algorithm             
## set the initial guesses for the distribution parameters
mu_1 <- 0
mu_2 <- 1

## as well as the latent variable parameters
tau_1 <- 0.5
tau_2 <- 0.5

for( i in 1:10 ) {

  ## Given the observed data, as well as the distribution parameters,
  ## what are the latent variables?

  T_1 <- tau_1 * dnorm( x, mu_1 )
  T_2 <- tau_2 * dnorm( x, mu_2 )

  P_1 <- T_1 / (T_1 + T_2)
  P_2 <- T_2 / (T_1 + T_2) ## note: P_2 = 1 - P_1

  tau_1 <- mean(P_1)
  tau_2 <- mean(P_2)

  ## Given the observed data, as well as the latent variables,
  ## what are the population parameters?

  mu_1 <- sum( P_1 * x ) / sum(P_1)
  mu_2 <- sum( P_2 * x ) / sum(P_2)

  ## print the current estimates

  print( c(mu_1, mu_2, mean(P_1)) )

}


###Alternatieve way by using mixtools

install.packages("mixtools")
library("mixtools")
myEM <- normalmixEM( x, mu = c(0,1), sigma=c(1,1), sd.constr=c(1,1) )

myEM$mu ## the distribution means
## [1] 0.9866 7.0059
myEM$lambda ## the mixing probabilities
## [1] 0.2435 0.7565



####Another example with normal distributions with closer means each other
###First way

###Our estimates converge very quickly! And, it turns out, they are quite accurate in this case. 
###What if the two distributions aren't so similar? Let's have one distribution with mean 1, 
###and the other with mean 4. We'll increase the number of iterations as well.


set.seed(123)
tau_true <- 0.25
x <- y <- rep(0,1000)
for( i in 1:1000 ) {
  if( runif(1) < tau_true ) {
    x[i] <- rnorm(1, mean=1)
    y[i] <- "heads"
  } else {
    x[i] <- rnorm(1, mean=4)
    y[i] <- "tails"
  }
}

densityplot( ~x, par.settings = list( plot.symbol=list( col=as.factor(y) ) ) )


mu_1 <- 0
mu_2 <- 1

tau_1 <- 0.5
tau_2 <- 0.5

for( i in 1:30 ) {

  ## Given the observed data, as well as the distribution parameters,
  ## what are the latent variables?

  T_1 <- tau_1 * dnorm( x, mu_1 )
  T_2 <- tau_2 * dnorm( x, mu_2 )

  P_1 <- T_1 / (T_1 + T_2)
  P_2 <- T_2 / (T_1 + T_2) ## note: P_2 = 1 - P_1

  tau_1 <- mean(P_1)
  tau_2 <- mean(P_2)

  ## Given the observed data, as well as the latent variables,
  ## what are the population parameters?

  mu_1 <- sum( P_1 * x ) / sum(P_1)
  mu_2 <- sum( P_2 * x ) / sum(P_2)

  ## print the current estimates

  print( c(mu_1, mu_2, mean(P_1)) )

}


###Second way using R package

myEM <- normalmixEM( x, mu = c(0,1), sigma=c(1,1), sd.constr=c(1,1) )
## number of iterations= 21 
myEM$mu ## the means of the two distributions
## [1] 0.8974 3.9991
myEM$lambda ## the mixing probabilities
## [1] 0.2344 0.7656
