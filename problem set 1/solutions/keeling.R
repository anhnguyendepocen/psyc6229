# keeling.R

rm( list=ls() )

# (a) read the data

df <- read.table( 'keeling.txt', sep=',', header=TRUE )

# (b) plot the CO2 concentration over time

# plot keeling curve
plot( df$date_float, df$co2_fill, type='l', xlab='time', ylab='CO2 concentration (ppm)', main='Keeling curve' )


# (c) plot average CO2 concentration by year

# one way of doing this is to manually find the concentration for each year

# get average concentration in available years
yearvec <- unique( df$year )
co2vec <- rep( NA, length(yearvec) )
for( i in 1:length(yearvec) )
    co2vec[i] <- mean( df$co2_fill[ df$year==yearvec[i] ] )

# plot it
plot( yearvec, co2vec, type='p', col='red',
      xlab='year', ylab='CO2 concentration (ppm)', main='CO2 by year' )

# but R has specialized functions available that make many common data processing operations
# like this much easier.  here we'll use the aggregate() function.

dfy <- aggregate( co2_fill ~ year, data=df, mean )
plot( dfy$year, dfy$co2_fill, type='p', col='red',
      xlab='year', ylab='CO2 concentration (ppm)', main='CO2 by year' )

# (d) plot average CO2 concentration by month

dfm <- aggregate( co2_fill ~ month, data=df, mean )
plot( dfm$month, dfm$co2_fill, type='o', col='red',
      xlab='month', ylab='CO2 concentration (ppm)', main='CO2 by month' )

