# demo.R  Illustrate how to use model subject in model.R

# get subject function
source( 'model.R' )

# choose stimulus levels and number of trials at each level
stimlev <- c(  1,  2,  3 , 4 , 5 )
ntrials <- c( 10, 20, 30, 20, 10 )

# get a simulated experiment
df <- subject( stimlev, ntrials )

# plot results
psy <- aggregate( response ~ stim, data=df, mean )
plot( psy$stim, psy$response, type='o', col='red',
      xlab='stimulus level', ylab='proportion correct',
      xlim=c(0,6), ylim=c(0,1) )
