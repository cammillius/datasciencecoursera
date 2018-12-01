# Control Structures in R 
# Control structures allows for control of flow of program depending on runtime conditions  
# if, else - testing a condition 
# for - execute a loop a fixed number of times 
# repeat - execute an infinite loop 
# break - break / stop execution of a loop 
# next - skip an iteration of a loop 
# return - exit a function 
# Most control structures are not used in interactive sessions, but in functions or expressions 

# If, else, else if 
x = 4
if (x > 3) {
  y <- "greater than 3"
} else {
  y <- "smaller than 3"
}
y

# The else is not necessary if not required 

# For loop 

for (i in 1:10) {
    print(i) 
}

x <- c("a", "b", "c", "d") 

for (i in 1:4) {
  print(x[i])
}

for (i in seq_along(x)) {
  print(x[i])
} 

for (letter in x) {
  print(letter)
}

for (i in 1:4) print(x[i]) 

# Nested for loops: 
x <- matrix(1:6, 2, 3) 
for(i in seq_len(nrow(x))) {
  for(j in seq_len(ncol(x))) {
    print(x[i, j])
  }
}

# While loops: 
count <- 0 
while(count < 10) {
  print(count) 
  count <- count + 1
}
# While loops can easily result in infinite loops 

# More than one condition 
z <- 5 
while(z >= 3 & z <= 10) { # Conditions are evaluated left to right 
  print(z) 
  coin <- rbinom(1, 1, 0.5) 
  
  if(coin == 1) { # random walk 
    z <- z + 1
  } else {
    z <- z - 1
  }
}

# Repeat loop creates an infinite loop and needs Break to stop 

# Next is used to skip an iteration 
for(i in 1:100) {
  if(i <= 20) {
    # Skip the first 20 iterations 
    next 
  }
  print(i)
}

# return signals that a function should exit and return a given value 

# Function for adding 2 numbers 
add2 <- function(x, y) {
  x + y
}
add2(2, 4)

#Function for finding numbers above 10 
above10 <- function(x) {
  y <- x > 10 
  print(x[y])
}
above10(c(12, 13, 9)) 

# Function for finding numbers above a given number 
abovethenumber <- function(x, y = 10) {
  z <- x > y 
  print(x[z])
}
# In the above function, if the comparison value is not provided, the function will compare against 10 by default 
abovethenumber(c(10, 20, 30, 40, 50), 20) 

colmean <- function(mat, remNA = TRUE) {
  colnum <- ncol(mat) # Find number of columns 
  matmean <- numeric(colnum) # Create a numeric vector equal to number of columns 
  for(i in 1:colnum) {
    matmean[i] <- mean(mat[, i], na.rm = remNA) # Loop through each column and get mean. If NAs are found, remove them. 
  }
  matmean
}
colmean(airquality)

# Functions are created using function() directive and are stored as objects with class function. 
# Functions are "first class objects" and can be nested in other functions as well as passed as args 
# Functions are named arguments and can have default values. 
# Formal arguments are the args included in function definition 
# formals() function returns list of formal arguments of a function 
# Not every function call in R uses all formal args 
# Function args can be missing and / or have default values or could be NULL 
# R functions can be matched positionally or by name. Though, moving the order of args is not recommended. 
# Args have to be passed when executing from command line or if the list of args is large and only a few are not custom. 
# Args are matched exact, partial and not finding them, positional. 
# Functions follow lazy evaluations of args, which are processed only if / when needed. 

# Binding Values to Symbol 
# When more than 1 function is available, how does R know which to apply? 
# R uses the following rules: 
# 1. Search the global environment for a symbol name matching the one requested. 
# 2. Search the namespaces of each of the packages on the search list. 
# The search list can be found using the search() function 
# The global env is searched first, followed by base package 
# The order of the packages in the search list matters 
# Users can configure which packages get loaded on startup so you cannot assume that there will be a set list of packages available. 
# When a user loads a package with library(), the name space of that package gets put in poisition 2 of the search list by default and everything else gets shifted down the list. 
# R has seperate namespaces for functions and non-functions, so its possible to have an object named c and a function named c. 

# Scoping Rules 
# R is different from S also due to the scoping rules 
# Scoping rules determine how a value is associated with a free variable in a function 
# R uses lexical scoping or static scoping. An alternative to this is dynamic scoping. 
# Similar to scoping rules, R uses the search list to bind a value to a symbol. 
# Lexical scoping simplifies statistical computations. 

# In the following function, z is not defined 
f <- function (x, y) {
  x^2 + y / z
}
f(9, 10) 

# In R, for lexical scoping, the values of free variables are searched for in the env in which the function was defined. 
# An env is is a collection of symbol (x, lm, etc. ) and value pairs. 
# Every env has a parent env. One env can have multiple children env 
# An empty env does not have a parent env. 
# A function + An Env = A Closure / A Function Closure 

# If a value of a symbol is not found in an env which has the function, the search continues in parent env. 
# The search continues into the sequence of parent environments until the top level env is reached (global env / workspace / namespace of package). 
# The search continues from top-level env till we hit an empty env. 
# Only after reaching an empty env, an error is thrown. 

