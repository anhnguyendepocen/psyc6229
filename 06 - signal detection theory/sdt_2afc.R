# sdt_2afc.R  Simulation of a signal detection model of a 2afc task

# clear workspace
rm( list=ls() )

# set model observer parameters
mu1 <- 0
mu2 <- 3
sigma <- 2
criterion <- 0

# calculate d' from observer parameters
dprimecalc <- (mu2 - mu1)/sigma

# set experiment parameters
ntrials <- 10000

# initialize data frame
init <- rep(NA, ntrials)
trials <- data.frame(signal = init, response = init, dvar = init)

# run trials
for (t in 1:ntrials) {
    
    # choose a signal order
    trials$signal[t] <- 1 + (runif(1) < 0.5)
    
    # get the decision variable
    if (trials$signal[t] == 1) {
        d1 <- rnorm( 1, mean=mu1, sd=sigma )
        d2 <- rnorm( 1, mean=mu2, sd=sigma )
    } else {
        d1 <- rnorm( 1, mean=mu2, sd=sigma )
        d2 <- rnorm( 1, mean=mu1, sd=sigma )
    }
    trials$dvar[t] <- d1 - d2;
    
    # make a response
    trials$response[t] <- 1 + (trials$dvar[t] > criterion)
    
}

# find the hit rate and false alarm rate
hit <- mean(trials$response[trials$signal == 2] == 2)
fa  <- mean(trials$response[trials$signal == 1] == 2)

# calculate d' from data
dprimehat <- ( qnorm(hit) - qnorm(fa) ) / sqrt(2)

# compare true and empirical d'
cat("dprimecalc =", dprimecalc, "\n")
cat("dprimehat  =", dprimehat, "\n\n")
