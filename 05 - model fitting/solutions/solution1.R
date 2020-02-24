# solution1.R  Find cross-validation error for fits to the Keeling curve

# define cross-validation function
xval <- function( f, x, y, pinit, nblocks=10 ) {

	# divide the data into blocks; trial i belongs to block blocki(i)
    n <- length( x )
    blocki <- ( ( 0:(n-1) ) %% nblocks ) + 1
	blocki <- sample( blocki, n, replace=FALSE )
    
	# initialize training and validation error
	errt <- rep( NaN, times=nblocks )
	errv <- rep( NaN, times=nblocks )

	# step through cross validation blocks
	for( b in 1:nblocks ) {
	
		# get the training data
		it <- blocki != b
		xt <- x[ it ]
		yt <- y[ it ]

		# get the validation data
		iv <- blocki == b
		xv <- x[ iv ]
		yv <- y[ iv ]

		# fit model to the training data
		df <- data.frame( x=x, y=y )
        m <- nls( y ~ f( x, p ), df, pinit )
        phat <- coef( m )

		# find mean squared prediction error on training trials
        yhatt <- f( xt, phat )
		errt[b] <- mean( (yt-yhatt)^2 )
		
		# find mean squared prediction error on validation trials
		yhatv <- f( xv, phat )
		errv[b] <- mean( (yv-yhatv)^2 )

		# plot results
		plot( xt, yt, pch='.', col='black' )
		lines( xt, yhatt, col='red' )
		Sys.sleep( 0.1 )
		
	}
    
	# return average training and validation error
	return( list( errt=mean( errt ), errv=mean( errv ) ) )

}

# read the data
load( 'keeling.Rdata' )
x <- df$date_float
y <- df$co2_fill

# fit linear model
f1 <- function( x, p ) p[1] * x + p[2]
xval1 <- xval( f1, x, y, pinit=list( p=c(1,0) ) )
print( xval1 )

# fit quadratic model
f2 <- function( x, p ) p[1] * x^2 + p[2] * x + p[3]
xval2 <- xval( f2, x, y, pinit=list( p=c(0,1,0) ) )
print( xval2 )

# fit quadratic-sinusoidal model
f3 <- function( x, p ) p[1] * x^2 + p[2] * x + p[3] + p[4]*sin( 2*pi*x + p[5] )
xval3 <- xval( f3, x, y, pinit=list( p=c(0,1,0,1,0) ) )
print( xval3 )

# as we might expect from seeing the fits, the quadratic-sinusoidal model has
# the lowest cross-validation error
