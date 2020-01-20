# datastruc1.R  data structures (atomic vectors, lists, data frames)

### atomic vector:  1D sequence of elements, all of the same type (numbers, strings, etc.)

# creating atomic vectors
x <- 10                  # make a vector with one element
x <- c( 1, 2, 3, 4, 5 )  # make a vector with several elements
print( x )               # show the vector in the console
?c                       # get help on the function c()
??combine                # look for functions that have 'combine' in their help text

x <- 1:10                # make a vector that is a sequence of numbers
x <- seq( 10, 20, 2 )
x <- seq( from=10, to=20, by=2 )
x <- seq( from=10, to=20, length.out=10 )
?seq

x <- rnorm( 5, mean=10, sd=2 )  # make a vector of normally distributed random numbers
x <- rnorm( 5 )                 # use default values for mean and sd

# other types of atomic vectors
x <- c( 'this', 'that', 'here', 'there' )  # character vector
x <- c( TRUE, FALSE, TRUE, FALSE )         # logical vector
typeof( x )                                # find the type of a vector

# getting elements of vectors
x <- rnorm( 10 )
x[1]                     # get an element of a vector
x[ c(1,3,5) ]            # get several elements of a vector
x[ 1:5 ]                 # get a range of elements of a vector (this is itself a vector)
x>0                      # get a vector indicating whether each element of x is greater than zero     
x[ x>0 ]                 # get a vector of the elements of x that are greater than zero

# setting elements of vectors
x[1] <- 10
x[ c(1,3,5) ] <- 10
x[ c(1,3,5) ] <- c(10,20,30)
x[ 1:5 ] <- 10
x[ x>0 ] <- 0

# applying functions to vectors
sum( x )                 # find the sum of all the elements in a vector
mean( x )                # find the mean of all the elements in a vector
sin( x )                 # find the sine of all the elements in a vector
is.atomic( x )           # see whether x is an atomic vector ( not the same as is.vector() )
length( x )              # find the number of elements in a vector

# special values
x <- Inf                 # infinity, e.g., 1/0
x <- -Inf                # negative infinity, e.g., -1/0
x <- NaN                 # not a number, e.g., 0/0
x <- NA                  # not available, e.g., missing data

# we can also give names to the elements of an atomic vector
x <- c( u=1, v=2, w=3 )
x
x['u']


### list:  1D sequence of elements, not necessarily all of the same type

# creating lists
x <- list( a=1, initials='rfm', scores=c(10,20,30) )  # make a list (note use of named elements)
str( x )  # show contents of x

# getting elements of lists
x[ 'a' ]  # less common
x$a       # more common
x$initials
x$scores
x$scores[2]

# subscripts to get elements of a list
x[[1]]
x[[3]][2]
# x[[1:2]]  # error; why?

# subscripts to get a sublist
x[1]
x[1:2]

# setting elements of lists
x$a <- 2
x$initials <- 'jfk'

# applying functions to lists
is.list( x )             # see whether x is a list
length( x )              # get the number of elements in x
names( x )               # get a vector of the names of the elements of x

# note:  lists are vectors, but not atomic vectors
x <- list( a=1, b=2 )
is.vector( x )
is.atomic( x )
# although we usually call the atomic vectors that we examined in the first section
# "vectors" for short, sometimes it's important to know that, strictly speaking,
# a vector can be an atomic vector or a list


### data frame:  a list of equal-length vectors

# creating data frames
df <- data.frame( trial=1:5,
                  signal=c('a','b','b','a','b'), 
                  response=c('a','b','a','a','a'),
                  rt=c(0.11,0.21,0.12,0.21,0.21) )  # make a data frame (note use of named elements)

# getting parts of data frames
df$trial
df$signal
df$response[1:3]

# applying functions to data frames
is.list( df )            # see whether x is a list
is.data.frame( df )      # see whether x is a data frame
names( df )              # get a vector of the names of the columns of df
length( df )             # get number of columns in x
ncol( df )               # get number of columns in x
nrow( df )               # get number of rows in x
