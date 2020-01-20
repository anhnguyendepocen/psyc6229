# basics.R  programming in R:  the basics


### a few useful functions

help.start()                   # open help homepage

getwd()                        # get working directory
setwd( '/Users/rfm/Desktop' )  # set working directory


### variable assignment

# R uses the <- symbol for variable assignment
x <- 1

# R sometimes can also use the = symbol for variable assignment, but this is not recommended
x = 1

ls()                           # list all variables
rm( x )                        # remove variable x
rm( list=ls() )                # remove all variables


### saving and loading variables

x <- 1
y <- 2
save( x, y, file='datafile.Rdata' )  # save variables

rm( list=ls() )
load( 'datafile.Rdata' )             # load variables

unlink( 'datafile.Rdata' )           # delete a file


### if-else

# check whether a random number is negative
r <- rnorm( 1 )
if ( r < 0 ) 
  print("result is negative")

# encode the sign of a number
r <- rnorm( 1 )
if ( r < 0 ) {
  x <- -1
} else {
  x <- 1
}
cat( "the number", r, "has sign", x, "\n" )

# encode the sign of a number and allow for zero
r <- rnorm( 1 )
if ( r < 0 ) {
  x <- -1
} else if ( r == 0 ) {
  x <- 0
} else {
  x <- 1
}
cat( "the number", r, "has sign", x, "\n" )


### for loops

# print numbers 1 to 10
for ( i in 1:10 )
	print( i )

# print some function of numbers 1 to 10 (note set braces that enclose multiple lines of code)
for ( i in 1:10 ) {
	j <- 2 * i^3
	print( j )
}

# print the squares of a sequence of numbers
for ( k in c( 2, 3, 5, 9, 14, 25, 30, 40 ) )
	print( k^2 )


### while loops

# get a normally distributed random number between -2 and 2
r <- rnorm( 1 )
while ( r < (-2)  || r > 2 )
	r <- rnorm( 1 )
print( r )

# logical operators:  and = &&, or = ||, not = !, and can use parentheses ()

# find the first number in the fibonacci sequence that is greater than 100	
i <- 1
j <- 1
k <- -1
while ( k < 100 ) {
	k <- i + j
	print( k )
	i <- j
	j <- k
}


### repeat loop

# find the highest number in the fibonacci sequence that is less than 100	
i <- 1
j <- 1
k <- -1
repeat {
	k <- i + j
	if ( k >= 100 ) 
		break
	print( k )
	i <- j
	j <- k
}
