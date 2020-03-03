# find_sigma.R  Show how to estimate the standard deviation of a decision variable
#               from behavioural responses

rm( list=ls() )

# set decision variable properties
mu1 <- 10;                            # mean for signal 1
mu2 <- seq( 6, 14, length.out=10 )    # mean for signal 2 (several stimulus magnitudes)
sigma <- 2                            # standard deviation for both signals

# initialize data frame
ntrials <- 10000;
init <- rep( NaN, ntrials )
df <- data.frame( stim1=init, stim2=init, response=init )

# run trials
for( t in 1:ntrials ) {
    
    # choose stimuli
    df$stim1[t] <- mu1
    df$stim2[t] <- sample( mu2, 1 )
    
    # get decision variables
    d1 <- rnorm( 1, mean=df$stim1[t], sd=sigma )
    d2 <- rnorm( 1, mean=df$stim2[t], sd=sigma )
    
    # make response
    df$response[t] <- as.numeric(d2>d1)
    
}

# plot response as a function of stimulus level
psy <- aggregate( response ~ stim2, data=df, mean )
plot( psy$stim2, psy$response, col='red', ylim=c(0,1), xlab='stimulus level', ylab='probability "higher"' )

# choose form of psychometric function
psyfn <- function( x, p ) pnorm( x, p[1], p[2] )

# fit psychometric function
errfn <- function( p ) -sum(log( dbinom( df$response, 1, psyfn(df$stim2,p) ) ))
phat <- optim( c(8,1), errfn )$par
sigmahat <- phat[2] / sqrt(2)

# plot psychometric function
curve( psyfn( x, phat ), col='green', add=T )

# show true and estimated standard deviation of the decision variable
print( sigma )
print( sigmahat )
