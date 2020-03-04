# model.R  A model observer

subject <- function( stimlev, ntrials ) {

  # check arguments  
  if( length(stimlev) != length(ntrials ) )
    stop( 'arguments stimlev and trials must have same length' )

  # find proportion correct at each stimulus level
  pcorrect <- pweibull( stimlev, 2.5, 3 )
  
  # initialize data frame
  ntotal <- sum( ntrials )
  init <- rep( NA, ntotal )
  df <- data.frame( stim=init, response=init )
  
  # run trials
  for( i in 1:length(stimlev) ) {
    u <- 1 + sum( ntrials[0:(i-1) ] )
    v <- sum( ntrials[1:i] )
    df$stim[u:v] <- stimlev[i]
    df$response[u:v] <- rbinom( ntrials[i], 1, pcorrect[i] )
  }

  # randomize order of trials
  # df <- df[ sample(1:ntotal,ntotal), ]

  return( df )
  
}
