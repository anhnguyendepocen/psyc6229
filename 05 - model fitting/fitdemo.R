# fitdemo.R  Illustrate how to fit a function to behavioural data

rm( list=ls() )

# 1.  fit a psychometric function using optim()

# make up some behavioural data for a discrimination task
df <- data.frame( stimlev=seq( 0.1, 1.0, by=0.1 ),                  # stimulus levels
                  ntrials=rep( 20, times=10 ),                      # number of trials at each stimulus level
                  nhigher=c( 1, 0, 4, 5, 8, 10, 12, 14, 19, 20 ) )  # number of trials where the observer responded "higher"
df$phigher <- df$nhigher / df$ntrials                               # 'nhigher' expressed as a proportion

# choose the form of the psychometric function
psyfn <- function( x, mu, sigma )
    pnorm( x, mu, sigma )

# define a maximum likelihood objective function
obj <- function( p )
	-sum(log( dbinom( df$nhigher, df$ntrials, psyfn( df$stimlev, p[1], p[2] ) ) ))

# alternatively, define a sum-of-squares objective function
# obj <- function( p )
#     sum( ( df$phigher - psyfn( df$stimlev, p[1], p[2] ) )^2 )

# find the parameters that minimize the objective function
pinit <- c( 0.5, 0.2 )             # initial guess
phat <- optim( pinit, obj )$par    # find the parameters of the best fit

# plot data and fitted PSE function
plot( df$stimlev, df$phigher, col='red', ylim=c(-0.1,1.1), xlab='stimulus level', ylab='proportion judged higher', main='PSE function' )
curve( psyfn( x, phat[1], phat[2] ), from=0, to=1, col='green', add=TRUE )
print( phat )

# 2.  fit a psychometric function using nls()

# fit a normal cumulative distribution function to the data (least-squares)
m <- nls( phigher ~ pnorm( stimlev, mean=pse, sd=jnd ), start=c( pse=0.5, jnd=0.5 ), data=df )
phat <- coef( m )

# plot data and fitted PSE function
plot( df$stimlev, df$phigher, col='red', ylim=c(-0.1,1.1), xlab='stimulus level', ylab='proportion judged higher', main='PSE function' )
curve( pnorm( x, mean=phat[1], sd=phat[2] ), from=0, to=1, col='green', add=TRUE )
print( phat )
