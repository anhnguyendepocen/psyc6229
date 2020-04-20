# solution.R  Solution for problem set 3

rm(list = ls())

# load model observer function sim()
source("sim.R")

# define a function to measure a psychometric function for a model observer
runobserver <- function( obs, sig1 = 10, sig2list = 5:15, ntrials = 100 ) {

	# initialize
	nhigher <- rep(NaN, length(sig2list))
	phigher <- rep(NaN, length(sig2list))
	
	# step through signal levels
	for (i in 1:length(sig2list)) {

    # run trials
    response = replicate( ntrials, obs(sig1,sig2list[i]) )

		# count responses
		nhigher[i] <- sum(response == 2)
		phigher[i] <- nhigher[i]/ntrials

	}

	# fit a normal cdf
	psefn <- function(x, mu, sigma) pnorm(x, mu, sigma)
	obj <- function(p) -sum(log(dbinom(nhigher, ntrials, psefn(sig2list, p[1], p[2]))))
	pinit <- c(8, 2)
	phat <- optim(pinit, obj)$par

	# show data and fit
	plot(sig2list, phigher, xlab='signal 2', ylab='proportion "higher"')
	curve(psefn(x, phat[1], phat[2]), from = min(sig2list), to = max(sig2list), col = "green",  add = TRUE)
		
	# return fit parameters
	return( phat )

}

# fit pse for disparity
par( mfrow=c(1,3) )
obs_disparity <- function( stim1, stim2 ) sim( depth1=c(stim1,NA), depth2=c(stim2,NA) )
pse_disparity <- runobserver( obs_disparity )
cat(sprintf("disparity:  mu = %5.2f, sigma = %.2f\n", pse_disparity[1], pse_disparity[2]))
# note that we're reporting the fitted sigma here.  the actual standard deviation of the
# cue's decision variable is smaller by sqrt(2).

# fit pse for touch
obs_touch <- function( stim1, stim2 ) sim( depth1=c(NA,stim1), depth2=c(NA,stim2) )
pse_touch <- runobserver( obs_touch )
cat(sprintf("touch:      mu = %5.2f, sigma = %.2f\n", pse_touch[1], pse_touch[2]))

# find prediction for sigma in combined cue condition
sigma_predict <- sqrt( 1/ ( ( 1/pse_disparity[2]^2 ) + (1/pse_touch[2]^2) ) )
cat(sprintf('prediction for sigma in combined condition:  %.2f\n',sigma_predict))

# fit pse for combined cues
obs_combined <- function( stim1, stim2 ) sim( depth1=c(stim1,stim1), depth2=c(stim2,stim2) )
pse_combined <- runobserver( obs_combined )
cat(sprintf("combined:   mu = %5.2f, sigma = %.2f\n", pse_combined[1], pse_combined[2]))

# answer:  the combined sigma is much larger than the predicted combined sigma, so the observer
# is not combining the cues optimally.
