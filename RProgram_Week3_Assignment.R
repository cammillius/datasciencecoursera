## Put comments here that give an overall description of what your
## functions do
## These functions will take an input matrix, calculate its inverse
## and give it as the returned value which will also be cached. 
## If the calculated value is cached, it will not calculate the 
## inverse and only return the cached inverse of the matrix. 
## Write a short comment describing this function 
## The first function, makeCacheMatrix creates a special "matrix", 
## which is really a list containing a function to 
## set the values of the matrix 
## get the values of the matrix 
## set the values of the inverse matrix 
## get the values of the inverse matrix 
makeCacheMatrix <- function(x = matrix()) {
  m <- NULL 
  set <- function(y) {
    x <<- y 
    m <<- NULL
  }
  get <- function() x 
  setinverse <- function(solve) m <<- solve 
  getinverse <- function() m 
  list(set = set, get = get, 
       setinverse = setinverse, 
       getinverse = getinverse)
}


## Write a short comment describing this function
## The following function calculates the inverse of the 
## special "matrix" created with the above function. 
## However, it first checks to see if the inverse has 
## already been calculated. If so, it gets the inverse 
## from the cache and skips the computation. Otherwise, 
## it calculates the inverse of the matrix and sets the 
## value of the inverse in the cache via the setsolve function.
cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  m <- x$getinverse()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data, ...)
  x$setinverse(m)
  m
}

makeVector <- function(x = numeric()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setmean <- function(mean) m <<- mean
  getmean <- function() m
  list(set = set, get = get,
       setmean = setmean,
       getmean = getmean)
}

cachemean <- function(x, ...) {
  m <- x$getmean()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- mean(data, ...)
  x$setmean(m)
  m
}
