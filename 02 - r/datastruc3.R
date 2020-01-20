# datastruc3.R  properties and attributes

rm( list=ls() )

# make an atomic vector
x <- c( 1, 2, 3 )

# vectors (atomic vectors and lists) have three basic properties
typeof( x )
length( x )
attributes( x )

# convenience functions based on the three basic properties
is.atomic( x )
is.double( x )

# can add arbitrary attributes
attr( x, 'subject' ) <- 'rfm'
attr( x, 'date' ) <- '01/03/2018'
attributes( x )  # a named list
attributes( x )$subject

# three special attributes:  'names', 'dim', 'class'
# - use special three functions to access them, instead of attr()

# special attribute 1:  names

# usually set names when creating the vector
x = c( u=1, v=2, w=3 )
x[ 'u' ]
attributes( x )
names( x )

# we can understand how this is implemented by setting the attribute manually
x <- c( 1, 2, 3 )
attr( x, 'names' ) <- c( 'u', 'v', 'w' )  # illustrative, but not really ok
names( x ) <- c( 'u', 'v', 'w' )          # correct way of setting names
attributes( x )
names( x )
x[ 'u' ]


# special attribute 2:  dimension

# a matrix is just an atomic vector with a "dim" property that specifies
# the number of rows and columns
x <- 1:10      # atomic vector
is.atomic( x )
is.matrix( x )
dim( x )
dim( x ) <- c( 2, 5 )    # alternative to using matrix()
x
attributes( x )
is.atomic( x )
is.matrix( x )
dim( x )
nrow( x )
ncol( x )

# can also add attributes to name the rows and columns of a matrix
rownames( x ) <- c( 'a', 'b' )
colnames( x ) <- c( 'p', 'q', 'r', 's', 't' )
x
x[ 'a', 'q' ]
attributes( x )
attributes( x )$dimnames
attributes( x )$dimnames[[1]]

# special attribute 3:  class (important in object oriented programming)
class( x )

# a list is a vector, so its attributes can be used and modified
# in the same way
y <- list( a='1', b=2L, c=TRUE, d=3.1415 )

# three basic properties
typeof( y )
length( y )
attributes( y )

# convenience function based on information given by typeof()
is.list( y )

# we don't usually do this, but we can use dim() to make a 2D list
dim( y ) <- c( 2, 2 )
y
