#First we will discuss my previous work
#Wilder, Feldman, and Singh (2009)
#and
#Wilder, Feldman, and Singh (2016)

#refer to pdf during this time
#important points:
#The Shape Skeleton is a "stick figure" for a shape
#My work uses a Bayesian estimation of the shape skeleton
#Bayesian estimation is a way to estimate a value that is 
#different from what might be the usual way we have learned from
#intro stats courses

#in these ways we find the maximum likelihood estimate of a parameter/value

#for example

randomData <- rnorm(100,mean=0,sd=1)
randomData

randomData <- rnorm(100000,mean=0,sd=1)
mean(randomData)

#the maximum likelihood estimate of the mean of the distribution from 
#which we have obtained our data is the sample mean

#we can see this by looking at how likely our data is, 
#given a distribution with the sample mean as the mean

#dnorm is how we look up a the probability of some x, given a certain mean and sd
#remember the command by saying we want the density of a normal distribution

plot(dnorm(seq(-3,3,by=0.1)))


#to find out how likely a set of data was to be randomly sampled
#from a given distribution, we take that data and input it into
#dnorm
randomData <- rnorm(10,mean=0,sd=1)
dnorm(randomData,0,1)

#this gives us the probability of sampling each element from 
#our given distrubition, here a normal with mean 0 and SD 1

#to find the probability of the entire dataset, we take the product
prod(dnorm(randomData,0,1))

#what we mean when we say that the mean of a dataset is the 
#maximum likelihood estimator for that data is to say
#that the normal distribution from which the sample was 
#most likely to have been sampled, is the normal distribution
#whose mean equals the sample mean

#concretely,
prod(dnorm(randomData,mean(randomData),1))
#has a higher value than when the mean was set to 0


#this is a long way a describing the likelihood, or
#how likely the data is given a set of parameters, and for a 
#normal distribution, that is the normal probability density function

#as a picky point, a likelihood function is when we do not know
#the parameters of the distribution, but have data.
#we search through the parameter space and find the set of parameters
#that maximizes the likelihood of the data
#it is provable, that for the normal distribution, the mean
#is the maximum likelihood estimate of the mu parameter, 
#and the standard deviation is the maximum likelihood estimator
#for the parameter sigma

#its not always clear why this is distinct from
#the likelihood of the data given a set of parameters
#this is because often we are using a normal distribution
#but the likelihood function is sort of like saying
#I have my first data point from my sample, what is the 
#most likely mean that would generate this datapoint
#(this happens to be a distribution where the mean
#is equal to that data point). You iterate over all 
#data points, and take the average, which happens to be the sample mean



#To bring us back to Bayesian estimation, we now no longer 
#just make use of the likelihood

#in Bayesian estimation we also use the prior probability
#(simply referred to as the prior)

#intuitively, think of randomly sampling a person from the entire world
#what is the probability of sampling someone whose citizenship is Canadian?
#its actually about 0.48%
#Now if we were sampling from people in Canada, we would expect that
#the probability of sampling someone whose citizenship is Canadian to 
#be quite a bit higher (maybe something like 75%)
# this knowledge is taking into account the prior probability, 
#sometimes also called the base rate

#in notation, the likelhood is often written something like
#p( data | model )

#the prior is p( model )

#Bayes rules combines both of these
#and gives the posterior probability

#p( model | data ) 


#the posterior is proprtional to the product of the likelihood and the prior
#p( model | data) ~= p( data | model ) p(model)

#Bayes Rule also has a normalization factor, which is why it is only
#proprtional to
#that normalization is to divide by p(data)



#so to bring this back to Wilder, Feldman, Singh (2009)
#the shape skeleton is the MAP skeleton, which 
#stands for the Maximum a posteriori skeleton. 
#Often when we are estimating something, there is more than just 
#a single value, an in fact we have an entire other distrubtion
#we call this the posterior distribution
#in my case I simply chose the maximum values from this 
#multi-dimensional space, hence
#Maximum a posteriori



#now Wilder, Feldman, and Singh (2009) demonstrated that
#human shape classification can be explained by the 
#properties of the MAP skeleton


#in Wilder, Feldman and Singh (2016) we investigated
#if the shape skeleton had an influence on the detection
#of shapes, or if perhaps, the skeleton only influences
#visual processing after the whole shape is detected

#In this work, we generated a measure of complexity 
#of a contour (below I call this the surprisal)
#we also have a measure of complexity of the skeleton
#which is the prior probability of the skeleton
#p(skeleton)
#and a measure of complexity related to how well 
# a skeleton fits a shape (the likelihood)
# p(shape | skeleton)


#my goal was to see how well a participant's ability
#to detect a shape in noise was related to these three
#values


#Are you familiar with CSV files?

#load CSV file
mydata <- read.csv("big_data_nat.csv")

#ignore this for now!
mydata$Responses <- mydata$Correct+rnorm(nrow(mydata),mean=0,sd=0.25)
mydata$Responses2 <- (mydata$Prior+rnorm(nrow(mydata),mean=0,sd=2000))/1000


#what is my data about - Wilder et al 2016
summary(mydata)
nrow(mydata)



#handling missing data or NaN
library('functional')
my_data<-mydata[apply(mydata, 1, Compose(is.finite, all)),]
summary(my_data)
#notice how there are fewer rows of data now
nrow(mydata)
#this example is not to suggest that you always do this, just to be aware of missing data
# or NaN data, and that it could affect your results

plot(my_data$Prior, my_data$Responses)



plot(my_data$Prior, my_data$Responses2)


#What is regression?
#Correlation looks at the strength of a relationship between two variables, how are they related?
#Regression describes this relationship in the form of a line

# y = mx + b

#in our data, y is an observation, in this case whether the observer was correct or incorrect. This is commonly referred to as a dependent variable. Regression makes it clear why this is the case. The value of y (our observation) depends upon x, m, and b
#x is the independent variable. It is something we manipulate in our experiment.
#m is the slope of the best fitting line, and b is the intercept

myFirstLM <- lm(Correct ~ Surprisal, data=my_data)
summary(myFirstLM)
#hmmm, to bad! It doesn't seem that this had a significant effect...


#lets try something else
mySecondLM <- lm(Correct ~ Prior, data=my_data)
summary(mySecondLM)
#Yay! This seems to have had a large effect!


plot(my_data$Prior,my_data$Correct)
abline(0.8144,-0.00002706)

library(car)
scatterplot(Responses2 ~ Prior, data = my_data)

scatterplot(Correct ~ Prior, data = my_data)


#compare to anova
myAnova <- aov(Correct~Prior, data = my_data)
summary(myAnova)
#the linear model is much like ANOVA, if the predictor is continuous the general rule is to use regression, and if categorical use ANOVA (but there may be exceptions)


#do any of our other independent variables have an effect on behavior?
myThirdLM <- lm(Correct ~ Likelihood, data=my_data)
summary(myThirdLM)



#In linear regression, we often have multiple variables, and we would like to see how they affect the dependent variable together. This is called multivariate regression, or a general linear model

#instead of y = mx + b we now have multiple ms and xs
# y = m_1 x_1 + m_2 x_2 + m_3 x_3 + b

#Do not get confused! This is not a polynomial! The x_1, x_2 and x_3 are independent variables, they are not like x and x^2 and x^3...

#instead they represent different dimensions

#data is no longer just in the x y plane, it is in a multidimensional plane, like x,y,z
#or in our notation, x_1, x_2, x_3, y space

#we can have any number of dimensions, but keep in mind, the more dimensions we have, the more data we must collect 



#lets make a general linear model, using the three independent variables we used before
#lets think about what this would be in space
#as these are all linear functions with no exponents, the result is a line in four dimensions
#so if we look at any cross section it will look like a line in x,y space


myMultivarLM1 <- lm(Correct ~ Likelihood + Prior + Surprisal, data=my_data)
summary(myMultivarLM1)

#we see a similar result
#only the skeleton prior (complexity) and the intercept have an effect
#the significance is lower. This is because we have more factors accounting for the variance in the data


#notice the notation I used in the previous example. 
# + looks only at the combination of the factors, with no interaction
# what is an interaction?....

# if we wish to incorporate an interaction we need to use * instead of +
myMultivarLM2 <- lm(Correct ~ Likelihood * Prior * Surprisal, data=my_data)
summary(myMultivarLM2)

#notice the main effect is now smaller, but there is an interaction with Surprisal!
#also note that all possible interactions are considered, even the interaction between all three variables together



#we don't need to do that
#perhaps we have an a priori reason to think that one variable will not interact
myMultivarLM <- lm(Correct ~ Likelihood * Prior + Surprisal, data=my_data)
summary(myMultivarLM)

myMultivarLM <- lm(Correct ~ Likelihood + Prior * Surprisal, data=my_data)
summary(myMultivarLM)

myMultivarLM <- lm(Correct ~ Likelihood + Prior + Surprisal + Likelihood:Prior:Surprisal, data=my_data)
summary(myMultivarLM)

myMultivarLM <- lm(Correct ~ Likelihood:Prior + Likelihood:Prior:Surprisal, data=my_data)
summary(myMultivarLM)

#we have a lot of models!!! 
#how do we pick between models?

anova(myFirstLM,myMultivarLM2)

anova(mySecondLM,myMultivarLM2)

anova(mySecondLM,myMultivarLM1)


step(myMultivarLM2)

myMultivarLM <- lm(Correct ~ Prior * Surprisal, data=my_data)
summary(myMultivarLM)

anova(mySecondLM,myMultivarLM)
#step was right!


#what if our sample is non-representative
# or what if we want to look into individual differences?

#then we use a mixed effects model. This looks at variables, like which subject, as a random variable

#the Knoblauch and Maloney gives a good example
#an observer may be much better than others, at seeing a low contrast Gabor.
#but they still may have the same shape of contrast sensitivity function as the others

#in my example some observers might be good at detecting these shapes,
#but the influence of the skeleton complexity might still be the same
#(or it might not!)

library(lme4)

myMixedEffects <- lmer(Correct ~ Prior + (1 | Subject),data=my_data)
summary(myMixedEffects)

anova(myMixedEffects,mySecondLM)
#notice this table looks different than what we had before


myMixedEffects2 <- lmer(Correct ~ Prior * Surprisal * Likelihood + (1 | Subject),data=my_data)
summary(myMixedEffects2)



library('psyphy')
mylogit = glm(Correct~Prior*Likelihood*Surprisal,data = my_data,family=binomial(mafc.logit()))
summary(mylogit)
step(mylogit)

mylogit2 = glm(Correct~Prior*Surprisal,data = my_data,family=binomial(mafc.logit()))
summary(mylogit2)
anova(myMultivarLM,mylogit2)


mylogit3 = glmer(Correct~Prior*Surprisal*Likelihood+ (1 | Subject),data = my_data,family=binomial(mafc.logit()))