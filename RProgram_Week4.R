# str Function 
# It compactly displays the internal structure of an R object 
# A diagnostic function and an alternative to R 'summary' 
# It is especially well suited to compactly display the (abbreviated) contents of (possibly nested) lists. 
# Take a quick look at the data to find data issues and other things. 
# Rough one line per basic object 
str(str)
# Output: function (object, ...)  
str(lm)
# Output: 
# function (formula, data, subset, weights, na.action, method = "qr", 
# model = TRUE, x = FALSE, y = FALSE, qr = TRUE, singular.ok = TRUE, 
# contrasts = NULL, offset, ...)  
str(ls)
# Output: 
# function (name, pos = -1L, envir = as.environment(pos), all.names = FALSE, 
# pattern, sorted = TRUE)
x <- rnorm(100, 2, 4) # Creates numerical vector of 100 elements with mean of 2 and sd of 4 
summary(x) 
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -4.2031 -0.3648  2.1715  2.3056  4.6555 12.2337 
str(x)
# Output:  num [1:100] 3.39 3 3.93 -2.94 -2.8 ... 
f <- gl(40, 10) # Generates a factor with 40 levels and 10 replications 
str(f) 
# Output:  Factor w/ 40 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ... 
summary(f)
# Output: 
#  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 
# 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 
# 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 
# 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 10 
library(datasets)
head(airquality)
# Output: 
#   Ozone Solar.R Wind Temp Month Day
# 1    41     190  7.4   67     5   1
# 2    36     118  8.0   72     5   2
# 3    12     149 12.6   74     5   3
# 4    18     313 11.5   62     5   4
# 5    NA      NA 14.3   56     5   5
# 6    28      NA 14.9   66     5   6 

str(airquality)
# Output: 
# 'data.frame':	153 obs. of  6 variables:
# $ Ozone  : int  41 36 12 18 NA 28 23 19 8 NA ...
# $ Solar.R: int  190 118 149 313 NA NA 299 99 19 194 ...
# $ Wind   : num  7.4 8 12.6 11.5 14.3 14.9 8.6 13.8 20.1 8.6 ...
# $ Temp   : int  67 72 74 62 56 66 65 59 61 69 ...
# $ Month  : int  5 5 5 5 5 5 5 5 5 5 ...
# $ Day    : int  1 2 3 4 5 6 7 8 9 10 ... 

m <- matrix(rnorm(100), 10, 10) 
str(m)
# Output: num [1:10, 1:10] 0.206 -0.39 1.177 0.983 -1.991 ... 
# Shows that it is a matrix of 10x10 and gives some values of 1st column 

s <- split(airquality, airquality$Month)
s1 <- s$`5`

# The above code splits the dataset into a list of smaller subsets by month and
# str gives structure of each of the subsets. 

# Simulation 

# Generate Random Numbers: Used to generate distributions 
# rnorm: generate random normal values with a given mean and standard deviation 
# dnorm: evaluate the Normal probability density (with a given mean & SD) at a point (or vector of points) 
# pnorm: evaluate the cumulative distribution function for a Normal distribution 
# rpois: generate random Poisson values with a given rate 

# Probability distribution functions usually have four functions associated with them. 
# The functions are prefixed with a 
# d for density 
# r for random number generation 
# p for cumulative ditribution 
# q for quantile function 

# Working with normal distribution requires these 4 functions: 
# dnorm(x, mean = 0, sd = 1, log = FALSE) # Option to evaluate the log of the value 
# pnorm(x, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE) # making lower.tail = FALSE evaluates upper tail (right value). 
# qnorm(x, mean = 0, sd = 1, lower.tail = TRUE, log.p = FALSE) 
# rnorm(x, mean = 0, sd = 1) 
# if Φ is the cumulative distribution for a standard Normal distribution, then pnorm(q) = Φ(q) 
# and qnorm(p) = Φ to the power -1 of p 

x <- rnorm(10) # mean = 0 & sd = 1 automatically taken 
x <- rnorm(10, 20, 2) # mean and sd are given explicitely 
summary(x) 

# set.seed() fixes the random number generation so that the same numbers are generated. 
# This helps with reproducibility. This is important when running simulations. 
set.seed(1) # Fixes the random number generation 
rnorm(5) # Random numbers set generated 
rnorm(5) # New random numbers generated 

set.seed(1)
rnorm(5) # Earlier list of random numbers generated 

# Generating Poisson data 
rpois(10, 1) 
# Output: [1] 0 0 1 1 2 1 1 4 1 2 
rpois(10, 2)
# Output: [1] 4 1 2 0 1 1 0 1 4 1 
rpois(10, 20) 
# Output: [1] 24 23 20 11 22 24 16 17 18 17 

# Cumulative Distribution with Poisson: 
ppois(2, 2) # Pr(x <= 2) # What is the probability that a Poisson random variable is less than or equal to 2  
# Output: [1] 0.6766764
ppois(4, 2) # Pr(x <= 2) # What is the probability that a Poisson random variable is less than or equal to 4  
# Output: [1] 0.947347
ppois(6, 2) # Pr(x <= 2) # What is the probability that a Poisson random variable is less than or equal to 6 
# Output: [1] 0.9954662 

# Simulation in R 
# Simulating a Linear Model 
# Generating Random Numbers from a Linear Model 
# Example of a linear model to be generated: 
# y = β₀ + β₁x + ε
# Where ε ~ N(0.2²). Assume x ~ N(1.0²), β₀ = 0.5 and  β₁ = 2 
set.seed(20) 
x <- rnorm(100)
e <- rnorm(100, 0, 2) 
y <- 0.5 + 2 * x + e 
summary(y) 
# Output: 
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -6.4084 -1.5402  0.6789  0.6893  2.9303  6.5052 
plot(x, y) 

# An example where x is binary: 
set.seed(10) 
x <- rbinom(100, 1, 0.5) # Binomial distribution where n = 1 & p = 0.5 
e <- rnorm(100, 0, 2) 
y <- 0.5 + 2 * x + e 
summary(y) 
# Output: 
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -3.4936 -0.1409  1.5767  1.4322  2.8397  6.9410  
plot(x, y) # x is binary (0 or 1) but y has varying values 

# Simulating From Poisson Distribution to calculate count instead of continuous variables where 
# Y ~ Poisson(μ) 
# log μ = β₀ + β₁x # Here, β₀ is the intercept and β₁ is the slope and x is predictor 
# β₀ = 0.5 and β₁ = 0.3 We need to use rpois function for this requirement 
set.seed(1) 
x <- rnorm(100) 
log.mu <- 0.5 + 0.3 * x # Gives log of the linear predictor 
y <- rpois(100, exp(log.mu)) # Exponentiation of log required to get the mean for the Poisson variables 
summary(y) 
# Output: 
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.00    1.00    1.00    1.55    2.00    6.00 
plot(x, y)
# Linearly, As x increases, y also increases but all values are counts 

# Random Sampling 
# The sample function draws randomly from a specified set of (scalar) objects allowing you to 
# sample from arbitrary distributions 
set.seed(1) 
sample(1:10, 4) 
# Output: [1] 3 4 5 7 
sample(1:10, 4) # Will give different numbers from earlier sample 
# Output: [1] 3 9 8 5 
sample(letters, 5) 
# Output: [1] "q" "b" "e" "x" "p" 
sample(1:10) # Since number of values required is not given, it just gives a random order of all the values 
# [1]  4  7 10  6  9  2  8  3  1  5 
sample(1:10) # Gives a different order of values from last sample 
# [1]  2  3  4  1  9  5 10  8  6  7 
sample(1:10, replace = TRUE) # Repeats values multiple times 
# Output: [1] 2 9 7 8 2 8 5 9 7 8 

# Summary 
# Drawing samples from specific probability distributions can be done with r* functions like rnorm 
# Standard distributions are built in: Normal, Poisson, Binomial, Exponential, Gamma, etc 
# The sample function can be used to draw random samples from arbitrary vectors 
# Setting the random number generator seed via set.seed is critical for reproducibility 

# Profiler 
# Profiler helps to optimize the code 
# Profiling is a systematic way to examine how much is spent in different parts of a program 
# Useful in trying to optimize your code 
# Often code runs fine once, but we need to check what happens when it is looped a 1,000 times 
# Measure the optimization requirement rather than guessing  
# Getting biggest impact on speeding up code depends on knowing where the code spends most of the time 
# This cannot be done without performance analysis  or profiling 
# Do not optimize code without finishing the goal of the code 

# system.time() 
# Takes an arbitrary R expression as input (can be wrapped in curly braces) and returns the amount 
# of time taken to evaluate the expression 
# Computes the time (in seconds) needed to execute an expression 
# If there's an error, gives time until error occured 
# Returns an object of class proc_time 
 # User time: Time charged to the CPU(s) for this expression 
 # Elapsed time: The "wall clock" or real world time that we see 
# Usually the user time and elapsed time would be the same 
# Elapsed time might be higher than user time if the CPU waits before executing tasks 
# Elapsed time might be smaller than user time if the CPU works using multiple cores / processors 
# such as Multi-Threaded BLAS libraries (vecLib / Accelerate, ATLAS, ACML, MKL) or Parallel processing via the parallel package 

# Example where elapsed time >  user time 
system.time(readLines("https://www.jhsph.edu"))

# Example where user time > elapsed time 
hilbert <- function(n) {
  i <- 1:n 
  1 / outer(i-1, i, "+")
} 
x <- hilbert(1000) 
system.time(svd(x))
# The above output didn't come out as expected 

# How to check time for long codes and functions: Wrap them in curly braces 
system.time({
  n <- 1000 
  r <- numeric(n) 
  for (i  in 1:n) {
    x <- rnorm(n) 
    r[i] <- mean(x)
  }
}) 

# Using system.time() allows you to test certain functions or code blocks to see if they are taking excessing amounts of time 
# Assumes you already know where the problem is and can call system.time() on it 
# What if you don't know where to start? 

# Using Rprof() 
# This functions starts the R Profiler. R must be compiled with Profiler support which is the usual case. 
# The summaryRprof() function summarizes the output from the Rprof() function which is by default not readable. 
# DO NOT use system.time() and Rprof() together. 
# Rprof() keeps track of the function call stack at regularly sampled intervals and tabulates how much time is spent in each function 
# Default sampling interval is 0.02 seconds 
# NOTE: If your code runs very quickly, the profiler is not useful, in which case, it is not required 


# lm(y ~ x) 
sample.interval = 10000 # Don't understand this code 

# summaryRprof() function tabulates the R profiler output and calculates how much time is spent in which function 
# There are two methods for normalizing the data 
# "by.total" divides the time spent in each function by the total run time 
# "by.self" does the above but first subtracts out time spent in functions above in the call stack. 
# Meaning, in a function if the top level function calls helper functions and most of the work is done by these helper functions, 
# then, it is possible that most time is spent by these smaller functions and it would be prudent to look at the optimization 
# within these helper functions 
# C or Fortran code is not profiled 
