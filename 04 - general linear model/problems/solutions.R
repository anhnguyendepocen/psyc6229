# solutions.R  Solutions to problems on the general linear model

rm( list=ls() )

# read the data
load( 'keeling.Rdata' )

# plot the data
plot( df$date_float, df$co2_fill, type='l', xlab='date', ylab='CO2 (ppm)' )

# fit a linear model
m1 <- lm( co2_fill ~ date_float + 1, data=df )

# plot the linear fit
abline( a=m1$coefficients[1], b=m1$coefficients[2], col='red' )

# fit a quadratic model
df$date_float2 <- df$date_float^2
m2 <- lm( co2_fill ~ date_float + date_float2 + 1, data=df )

# plot the quadratic fit
lines( df$date_float, predict( m2 ), col='blue' )

# fit a quadratic and sinusoidal model
m3 <- nls( co2_fill ~ b1 + b2 * date_float + b3 * date_float^2
           + b4 * sin( 2*pi*date_float - b5 ),
           start = c( b1 = unname( m2$coefficients[1] ),
                      b2 = unname( m2$coefficients[2] ),
                      b3 = unname( m2$coefficients[3] ),
                      b4 = 10, b5 = 0),
           data = df )
lines( df$date_float, predict( m3 ), col='green' )
