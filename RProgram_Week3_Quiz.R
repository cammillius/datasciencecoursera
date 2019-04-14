# Q1 
# Take a look at the 'iris' dataset that comes with R. The data can be loaded with the code:
library(datasets)
data(iris)
# A description of the dataset can be found by running 
?iris
# There will be an object called 'iris' in your workspace. In this dataset, what is the mean of 'Sepal.Length' for the species virginica? Please round your answer to the nearest whole number.
# (Only enter the numeric result and nothing else.) 
# Answer: 
tapply(iris$Sepal.Length, iris$Species, mean)
# OR
sapply(split(iris$Sepal.Length, iris$Species), mean) 

# Q2 
# Continuing with the 'iris' dataset from the previous Question, what R code returns a vector of the means of the variables 'Sepal.Length', 'Sepal.Width', 'Petal.Length', and 'Petal.Width'? 
# Answer: 
apply(iris[, 1:4], 2, mean) 

# Q3 
# Load the 'mtcars' dataset in R with the following code 
library(datasets)
data(mtcars) 
# There will be an object names 'mtcars' in your workspace. You can find some information about the dataset by running 
?mtcars 
# How can one calculate the average miles per gallon (mpg) by number of cylinders in the car (cyl)? Select all that apply. 
# Answer: 
tapply(mtcars$mpg, mtcars$cyl, mean) # (OR)
with(mtcars, tapply(mpg, cyl, mean))
sapply(split(mtcars$mpg, mtcars$cyl), mean)
# Q4 
# Continuing with the 'mtcars' dataset from the previous Question, what is the absolute difference between the average horsepower of 4-cylinder cars and the average horsepower of 8-cylinder cars? 
# Answer: 
s <- tapply(mtcars$hp, mtcars$cyl, mean)
s[3] - s[1]
# 126.5779 

# Q5 
# If you run 
debug(ls) 
# what happens when you next call the 'ls' function? 
ls(5)
sapply(split(mtcars$mpg, mtcars$cyl), mean)
