# functions_plots.R  functions and plots

### functions

# create a function to calculate sine in degrees
sind <- function(theta)
	sin((pi/180) * theta)

sind(0)
sind(90)

# create a function to calculate sine in degrees (default) or radians
sinv <- function(theta, deg = TRUE) {
	if (deg) 
		return(sin((pi/180) * theta))
	else
		return(sin(theta))
}

sinv(90)
sinv(pi/2, deg = FALSE)
sinv(deg = FALSE, theta = pi/2)  # order of arguments doesn't matter if we use argument names

# create a function to calculate sine and cosine
sincos <- function(theta)
	list(sine = sin(theta), cosine = cos(theta))

v <- sincos(0)
v$sine
v$cosine
str(v)

# create a function that uses a variable in the workspace
r <- rnorm(100)
sumsquare <- function(x)
	sum((r - x)^2)

sumsquare(0)
sumsquare(1)

# change the value of r and call sumsquare again
r <- rnorm(100)
sumsquare(0)
sumsquare(1)


### plots

# make some data
u <- seq( 0, 2*pi, by=0.1 )
v <- sin( u )
v <- v + rnorm( length(v), sd=0.1 )

# basic plot
plot( u, v )

# plot with some options
plot( u, v, type='o', pch=2, lwd=2, col='red', xlab='x', ylab='sin(x)', main='a sinusoid',
	xlim=c(-0.1,2*pi+0.1), ylim=c(-1.2,1.2) )
# type = points (p), lines (l), both (b), overlay (o), etc.
# pch  = point character (circle, square, etc.), a code 1-25
# lwd  = line width
# col  = colour (red, green, blue, etc.)
# xlab = x label
# ylab = y label
# main = title
# xlim = limits of x axis
# ylim = limits of y axis

# add to an existing plot
z <- sin(u)
lines( u, z, col='blue' )               # add lines connecting points
abline( h=0 )                           # add a straight line
curve( sin(2*x), col='green', add=TRUE )  # plot a function

# histogram
r <- rnorm( 1000, mean=10, sd=3 )
hist(r)

# histogram with probability units on y-axis
r <- rnorm( 1000, mean=10, sd=3 )
hist(r, probability=TRUE, ylim=c(0,0.15))
curve( dnorm(x,mean=10,sd=3), col='red', add=TRUE )           # add to existing plot
points( 0:20, dnorm( 0:20, mean=10, sd=3 ), col='blue' )      # add to existing plot
