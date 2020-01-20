# datastruc2.R  more data structures (matrices, arrays)

### matrix:  2D grid of elements, all of the same type (numbers, strings, etc.)

# creating matrices
x <- 1:12
m <- matrix( x, ncol=4 )  # make a 3 x 4 matrix of numbers 1 to 12 (filled in column-wise)

# non-numeric matrices
m <- matrix( c('abc','def','ghi','jkl'), nrow=2 )  # character matrix
m <- matrix( c(TRUE,FALSE,TRUE,FALSE), nrow=2 )    # logical matrix
typeof( m )                                        # find the mode of a matrix

# getting parts of matrices
m <- matrix( rnorm(50), nrow=10 )
m[2,1]                   # get an element of m
m[2,2:4]                 # get several elements of m
m[2,]                    # get a row of m
m[,2]                    # get a column of m
m[ m>0 ]                 # get a vector of the elements of m that are greater than zero

# applying functions to matrices
sum( m )                 # find the sum of all the elements in a matrix
sin( m )                 # find the sine of all the elements in a matrix
dim( m )                 # find the dimension of a matrix
length( m )              # find the number of elements in a matrix
as.vector( m )           # convert a matrix to a vector
is.matrix( m )           # see whether m is a matrix

# combining matrices
x <- matrix( rnorm(9), nrow=3 )
y <- matrix( rnorm(9), nrow=3 )
z <- rbind( x, y )       # combine matrices vertically (appending rows)
z <- cbind( x, y )       # combine matrices horizontally (appending columns)

# compare x and y
a <- 1:4
b <- 11:14
x <- cbind( a, b )
y <- rbind( a, b )


### array:  n-dimensional block of elements, all of the same type (numbers, strings, etc.)

# creating arrays
x <- rnorm( 24 )
a <- array( data=x, dim=c(2,3,4) )  # make a 2 x 3 x 4 array of random numbers
