#Loop Functions# 

# lapply: Loop over a list and evaluate a function on each element. 
# sapply: Same as lapply but try to simplify the result. 
# apply: Apply a function over the margins of an array. 
# tapply: Apply a function over the subsets of a vector. 
# mapply: Multivariate version of lapply. 
# split: Splits objects into sub-pieces and is mostly used with lapply. 

# lapply returns a list irrespective of the class of the input. 
# If the input is not a list, it will be coerced into one. 

x <- list(a = 1:5, b = rnorm(10))
lapply(x, mean)

x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
lapply(x, mean)

x <- 1:4 
lapply (x, runif) 

x <- 1:4 
lapply (x, runif, min = 1, max = 10) 

# apply functions make heavy use of anonymous functions or functions created on the fly. 

x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
x
lapply(x, function(elt) elt[, 1])

# sapply: 
# sapply will try to simplify the results of lapply, if possible. 
# If the result is a list where every element is of length 1, a vector is returned. 
# If the result is a list where every element is a vector of same length (> 1), a matrix is returned. 
# If it cannot figure things out, it returns a list. 

x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
lapply(x, mean) # Gives back a list. 
sapply(x, mean) # Gives back a vector. 
mean(x) # Will get a warning message. 

# apply: 
# apply is used to evaluate a function (often an anonymous one) over the margins of an array. 
# It is mostly used to apply a function to the rows or columns of a matrix. 
# It can be used in general arrays, e.g. taking the average of an array of matrices. 
# It is not really faster than writing a loop, but it works in one line! 

x <- matrix(rnorm(200), 20, 10) 
apply(x, 2, mean) # Gives mean of all 10 columns. Preserves columns and collapses rows. 
apply(x, 1, sum) # Gives sum of all 20 rows. Preserves rows and collapses columns. 

# Some easy shortcuts for calculating matrix sums and means. These are faster when using large matrices: 

rowSums = apply(x, 1, sum)
rowMeans = apply(x, 1, mean) 
colSums = apply(x, 2, sum) 
colMeans = apply(x, 2, mean) 

# Use apply to calculate the 25th and 75th %s of quantiles for rows: 
x < matrix(rnorm(200), 20, 10)
apply(x, 1, quantile, probs = c(0.25, 0.75))

# Average matrix in an array. 
a <- array(rnorm(2 * 2 * 10), c(2, 2, 10))
apply(a, c(1, 2), mean) 
rowMeans(a, dims = 2) 
