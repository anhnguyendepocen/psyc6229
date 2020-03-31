# sim.R

# model observer
sim <- function( depth1=c( NA, NA ), depth2=c( NA, NA ) ) {
	
  # get depths from disparity and touch
  depthD1 <- depth1[1]
  depthT1 <- depth1[2]
  depthD2 <- depth2[1]
  depthT2 <- depth2[2]
  
	# set cue standard deviations in centimeters
	sigmaD = 1;
	sigmaT = 3;
	
	# set cue weights
	wD = 0.25
	wT = 0.75

	# get cue samples
	if( !is.na(depthD1) )  xD1 <- rnorm( 1, depthD1, sigmaD )
	if( !is.na(depthT1) )  xT1 <- rnorm( 1, depthT1, sigmaT )
	if( !is.na(depthD2) )  xD2 <- rnorm( 1, depthD2 ,sigmaD )
	if( !is.na(depthT2) )  xT2 <- rnorm( 1, depthT2, sigmaT )
	
	# get combined cue for stimulus 1
	if( !is.na(depthD1) & !is.na(depthT1) ) {
		x1 <- wD*xD1 + wT*xT1
	} else if( !is.na(depthD1) ) {
		x1 <- xD1
	} else if( !is.na(depthT1) ) {
		x1 <- xT1
	} else
		stop('both depthD1 and depthT1 are NaN')
		
	# get combined cue for stimulus B
	if( !is.na(depthD2) & !is.na(depthT2) ) {
		x2 <- wD*xD2 + wT*xT2
	} else if( !is.na(depthD2) ) {
		x2 <- xD2
	} else if( !is.na(depthT2) ) {
		x2 <- xT2
	} else
		stop('both depthD2 and depthT2 are NaN')
	
	# make response
	return( ifelse( x1>=x2, 1, 2 ) )
		
}
