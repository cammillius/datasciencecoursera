# c() is used to create a vector. For example, 
x <- c(0.5, 0.6) # Numeric vector 
x <- c(True, False) # Logical vector. True and false can also be written as T and F 
x <- c("a", "b", "c") # Character vector. 
x <- 1:20 # Integer vector. 
x <- c(1+4i, 3+8i) # Complext vector. 

#We can create a vector of certain length and type using: 
x <- vector("numeric", length=10) 

# Implicit coercion 
# If a vector contains multiple classes, coercion occurs and all values are changed to one class: 
y <- c(1.7, "a") # changes to character. 
y <- c(TRUE, 2) # changes to numeric. 
y <- c("a", TRUE) # changes to character. 

# Explicit Coercion 
# Objects can be explicitly changed classes using as. function: 
x <- 0:6 
class(x)
as.numeric(x)
as.logical(x)
as.character(x)
as.complex(x)
y <- as.integer(c(round(1.7, digits = 0), 3, 4))
class(y)

# If coercion does not work, NA values are returned. 
x <- c("a", "b", "c") 
as.numeric(x)

# Lists are vectors which can contain multiple classes of data 
x <- list(1, "a", TRUE, 1+4i) # Prints differently from vectors 
x
# Also, vector elements will have single brackets and lists will have double brackets. See output for example. 

# Matrices are vectors with dimension attributes 
# Create a matrix as follows: 
m <- matrix(nrow = 2, ncol = 3) 
dim(m)
attributes(m)

# Values in a matrix are entered from top-left by columns 
# Use the following to create matrix with user defined values: 
m <- matrix(1:6, nrow = 2, ncol = 3)

# Matrices can also be created with a combination of vector and dim 
m <- 1:10 
dim(m) <- c(2,5) 

# Matrix can also be created by combining columns and rows 
x <- 1:3 
y <- 10:12 
cbind(x,y) 
rbind(x,y) 

# Factors represent categorical data which are ordered or unordered. Like integers with labels. 
# Factors are treated specially by modelling functions like lm() and glm() 
# Using factors are better than integers as factors are self-describing. 
# For example, it is better to have values under "Male" and "Female" than 1 and 2 
x <- factor(c("yes", "yes", "no", "yes", "no")) 
table(x)
# The above codes will include the levels as part of output 

# The following function will remove class and give it as vector: 
unclass(x)

# Order of levels can be set using levels arg in factor. In the following code, the level is set to "yes no" instead of "no yes" that sets it alphabetically. 
x<-factor(c("yes", "yes", "no", "yes", "no"), levels = c("yes", "no"))

# Missing values are represnted as NA and NaN 
# is.na() is used to test if objects are NA values 
# is.nan() is used to test if objects are NaN values 
# NA values have class and hence can be integer, character, etc. 
# All NaN values are NA but not all NA are NaN 
x <- c(1, 2, NA, 10, 3) 
is.na(x)
is.nan(x)
x <- c(1, 2, NaN, 10, 3) 
is.na(x)
is.nan(x) 

# Data frames are used to store tabular data. 
# They are a special list where every element is of the same length. 
# Each element of list is a column and length is number of rows. 
# Data frames can store different classes in each column, which matrices cannot do. 
# Data frames have special attribute called row.names 
# Data frames can be created with read.table() or read.csv() or other similar functions. 
# Data frames can be changed to matrix using data.matrix(). Objects will be coerced to similar class. 
x <- data.frame(foo = 1:4, bar = c(T, T, F, F)) 
nrow(x)
ncol(x)

# R objects can have names useful for readable code and self-describing objects 
x <- 1:3
names(x) # Will return NULL value 
names(x) <- c("foo", "bar", "norf") 
names(x) # Names are given to the columns. If given additional names, they will not be taken. 

# Lists and Matrices can also have names: 
x <- list(a = 1, b = 2, c = 3)
m <- matrix(1:4, nrow = 2, ncol = 2) 
dimnames(m) <- list(c("a", "b"), c("c", "d")) 
# Note that the first vector in the list is attributed to row and the second to the columns. 

# Use read.table, read.csv, readLines, source, dget, load, unserialize for reading data into R  

# use write.table, writeLine, dump, dput, save, serialize for writing data in R 

# read.table has the following args: 
# file - name of file / connection 
# head - logical denoting if file contains header 
# sep - string denoting seperator / delimiter 
# colClasses - Character vector indicating class of each column 
# nrows - denotes number of rows in dataset 
# comment.char - character string indicating comment character 
# skip - number of lines to skip from beginning 
# stringsAsFactors - specify if strings should be considered as factors 

# read.table is the easiest way of reading a file. This will automatically skip lines beginning with # 
# Figure out the number of rows 
# Figure out class of the column, though highlighting these options at the start will make the process efficient 
# read.csv is similar except that the delimiter is a comma. 
data <- read.table("foo.txt") 

# Make sure that the size of the RAM is more than the size of the dataset. Else, you will not be able to process the file. 
# Specifying colClasses runs the read.table much faster. We can set colClasses = numeric if all columns are numeric. 
# The following code helps us easily identify classes: 
initial <- read.table("datatable.txt", nrows = 100) 
classes <- sapply(initial, class) # looping through all columns and using class function to get class. 
tabAll <- read.table("datatable.txt", colClasses = classes) 

# nrows helps with how much memory is used to process the data. 

# Calculating Memory: Imagine 1.5M rows and 120 columns of numeric data 
# 1.5M * 120 * 8 bytes / numeric  = 1440000000 bytes = 1440000000 / 2^20 bytes/MB = 1373.29 MB = 1.34 GB 

# Textual Formats: 
# Files can also be stored as text format. 
# dumping and dputing have textual format that is editable and recoverabe in case of curroptin 
# dput and dump stores metadata so that another user does not have to specify it 
# Textual formats work better with version control programs like git which can only track changes in text files 
# Corruption in text files have easier fixes. 
# Textual formats adhere to "Unix philosophy" 
# Textual formats are not space efficient 

y <- data.frame (a = 1, b = "string") # data frame ccreated. 
dput(y) # Gives the meta data and data of y data frame. 
dput(y, file = "y.R") # Writes y and its meta data into a R file 
new.y <- dget("y.R") # dget gets the file content (dataframe) and pushes it into a variable 

# new.y will have the information such as class, colnames, etc. passed into it.

# dget can be used only on one object but dump can be used on multiple objects 
x <- "foo" 
y <- data.frame (s = 1, b = "a") 
dump(c("x", "y"), file = "data.R") # values of x and y are pushed into data.R file
rm(x, y) # removing x & y from R environment 
source("data.R") # Brings back x & y to R environment 

