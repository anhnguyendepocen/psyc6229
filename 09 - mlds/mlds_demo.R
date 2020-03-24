# mlds_demo.R

rm( list=ls() )

# install.packages( 'MLDS' )  # run this once to install the MLDS package

library( MLDS )  # load the MLDS package

ll.mlds <- function( p, d ) {
    
    # transform parameters
    psi <- c(0, plogis(p[-length(p)]), 1)
    sig <- exp(p[length(p)])
    
    # get stimuli and responses from data frame
    stim <- as.matrix(d[, -1])
    resp <- d[, 1]
    
    # calculate stimulus differences according to current parameters
    del <- matrix(psi[stim], ncol = 4) %*% c(1, -1, -1, 1)
    del <- del / sig

    # calculate log likelihood of responses
    ll <- -sum(pnorm(del[resp == 1], log.p = TRUE))
          -sum(pnorm(del[resp == 0], lower.tail = FALSE, log.p = TRUE))
    
}


# make initial estimates of parameters (nonlinearly transformed)
p <- c(qlogis(seq(0.1, 0.9, 0.1)), log(0.2))

# find parameters that maximize likelihood
res <- optim(p, ll.mlds, d = kk3, method = "BFGS")

# nonlinearly transform estimated parameters
psi <- res$par[ -length(res$par) ]
psi <- c( 0, plogis( psi ) )

# plot parameter estimates
plot( psi )
