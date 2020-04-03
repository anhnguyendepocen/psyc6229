# solutions.R  Solutions to problem set 2

rm( list=ls() )

# load model observer code
source( 'model.R' )

# cross validation function
xval <- function( df, psyfn, init, nblocks=10, plotit=FALSE ) {
    # df      = data frame
    # psyfn   = psychometric function that will be fit to the data
    # init    = initial value of parameters for fitting
    # nblocks = number of training/validation blocks to divide data into
    # plotit  = flag whether to plot intermediate results (true/false)
    
    # divide the data into blocks; trial i belongs to block blocki(i)	
    ntrials <- nrow( df )
    blocki <- ( ( 0:(ntrials-1) ) %% nblocks ) + 1
    blocki <- sample( blocki, length(blocki) )
    
    # define negative log likelihood
    nll <- function( dfstar, p )
        -sum(log( dbinom( dfstar$response, 1, psyfn( dfstar$stim, p ) ) ))
    
    # step through cross validation blocks
    errv <- rep( NA, nblocks )
    for( b in 1:nblocks ) {
        
        # divide data into training and validation groups
        dft <- df[ blocki != b, ]
        dfv <- df[ blocki == b, ]

        # fit model to training data
        errfn <- function( p ) nll( dft, p )
        phat <- optim( init, errfn )$par
    
        # find error of fitted psychometric function on validation data
        errv[b] <- nll( dfv, phat )

        # optionally show intermediate results
        if( plotit ) {
            emp <- aggregate( response ~ stim, data=dft, mean )
            plot( emp$stim, emp$response, type='p', xlim=c(0,6), ylim=c(0,1) )
            curve( psyfn( x, phat ), col='red', add=TRUE )
            print( phat )
            Sys.sleep(0.1)
        }

    }

    # return mean validation error
    return( mean( errv ) )
    
}

# do cross validation test once
xval1 <- function( stimlev=1:5, nrep=20 ) {
    # stimlev = stimulus levels
    # nrep    = number of times each stimulus level is shown
    
    # get data from model observer
    ntrials <- rep( nrep, length(stimlev) )
    df <- subject( stimlev, ntrials )
    
    # do cross validation with normal cdf
    f1 <- function( x, p ) pnorm( x, p[1], p[2] )
    init1 <- c( 2, 1 )
    err1 <- xval( df, f1, init1 )
    
    # do cross validation with Weibull cdf
    f2 <- function( x, p ) pweibull( x, p[1], p[2] )
    init2 <- c( 2.5, 2 )
    err2 <- xval( df, f2, init2 )
    
    # choose model with lower cross validation error (1 = normal, 2 = Weibull)
    choice <- 1 + (err2<err1)
    return( choice )
    
}

# problem 1(a):  do cross-validation once
choice <- xval1()
if( choice==1 ) {
    cat( 'pnorm has lower cross validation error\n' )
} else {
    cat( 'pweibull has lower cross validation error\n' )
}

# problem 1(b):  do cross-validation many times
choice <- replicate( 1000, xval1(nrep=20) )  # or nrep=200
cat( 'probability of choosing pweibull:  ', mean( choice==2 ), '\n' )

# replicate() can take a long time to run.  you can use a variant that
# shows a progress bar and and time estimate as follows.
# 
# install.packages( 'pbapply' )  # run this once
library( pbapply )
choice <- pbreplicate( 1000, xval1(nrep=200) )


# conclusion:  We will need a lot of data in order to be able to reliably
#              choose between these two models (pnorm and pweibull).
