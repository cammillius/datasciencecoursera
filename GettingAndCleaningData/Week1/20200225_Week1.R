# getwd() is used to get the current working directory. For example: 
getwd() 

# setwd() is used to assign / change the current working directory. In the below example, an 
# absolute path is set. 
setwd("C:\\All-Files\\Study&Learning\\Coursera\\DataScience\\GettingAndCleaningData\\Week1") 

# Below is an example of relative path set for the working directory: 
setwd("./Week1") 

# setwd("../") will move the working directory up by one heirarchy. For example: 
setwd("../")

# file.exists() checks if a folder / file is present in the working directory. For example: 
file.exists("20200225_Week1.R")

# dir.create() creates a folder. An example of file.exists and dir.create used together: 
if(!file.exists("Week1")) {
  dir.create("Week1")
} 

# download.file() downloads files from the internet. Usefule for tsv and csv file types. 
# If file already exists, it overwrites without asking. 

download.file("https://projects.iq.harvard.edu/files/hpca/files/main_conflict_table.xls", "data.xls") 

# OR 

fileURL <- "https://projects.iq.harvard.edu/files/hpca/files/main_conflict_table.xls" 
download.file(url = fileURL, destfile = paste("data", "-downloadedon", gsub(as.character(date()), pattern = ":", replacement = "-"), ".xls", sep = ""), method = "curl") # Method needs to be set as curl for https sites. 

# list.files() lists all files and sub-folders in a folder: 
list.files("C:\\All-Files\\Study&Learning\\Coursera\\DataScience\\GettingAndCleaningData\\Week1")

# Loading data from a local directory 

# read.table() can be used to read files from local directories. 

# As the files are loaded into the system's RAM, big files might cause issues. 

# Some important parameters: 

# file - file name with or without destination path 

# header - allow for the header row to be considered as header and not data 

# sep - seperator: for example, "," for CSV 

# row.names - allow for the header column to be considered as row names and not data 

# nrows - number of rows to read 

# quote - will read quoted values as unquoted in the data set. Useful if data contains ' or " 

# na.strings - used to identify non NA values as NA. For example "Not Available" 

# skip - number of rows from the 1st row to skip when reading the data 

# Default seperator for read.table is tab, hence it only reads tsv files by default. 

data <- read.table("data-csv.csv", sep = ",", header = TRUE) 
head(data)

# Reading Excel files 

library(readxl) 
data <- read_xls("data.xls")

# For xlsx file, use read_xlsx function 

# Reading XML files 

# Extracting XML is the basis for most web scraping 

# XML contains 2 components: Markup, which gives structure and Content which is the text 

# Use XML package to read XML files 

library(XML) 

# The XML code given cannot read from https, which requires RCurl library 
library(RCurl)

theurl <- "https://www.w3schools.com/xml/simple.xml" 

fileURL <- getURL(url = theurl) 

doc <- xmlTreeParse(fileURL, useInternalNodes = TRUE) 

# Rootnode is the wrapper element for the entire XML document 

rootNode <- xmlRoot(doc) 

# xmlName function returns the name / head tag of the rootNode 

xmlName(rootNode) 

# names gives the all the nested items of the root node 

names(rootNode) 

# We can access parts of the XML document as how we would, a list 

rootNode[[1]]

# We can get sub parts by sub-setting the list 

rootNode[[1]][[1]] 

# Programattically extract parts of the XML doc 
# The below code goes through all parts of the rootNode and xmlValue extracts the values. 

xmlSApply(rootNode, xmlValue)

# If you want to read specific components of the document, you need XPath. Need to learn specific syntax for this. 
# XPath 

# /node denotes the top level node 
# //node denotes the nodes at any level 
# node[@attr-name] denotes node with attribute names 
# node[@attr-name='bob'] denotes node with specific attribute name as 'bob' 

# Get the list of items and their prices 
# First, get the list of items 
xpathSApply(rootNode, "//name", xmlValue) 

# Get the list of prices 
xpathSApply(rootNode, "//price", xmlValue) 

# Sample of scraping team and scores data from ESPN: 

url <- "https://www.w3schools.com/xml/cd_catalog.xml" 

fileURL <- getURL(url = url) 

doc <- xmlTreeParse(fileURL, useInternalNodes = TRUE) 

titles <- xpathSApply(doc, "//TITLE", xmlValue)

prices <- xpathSApply(doc, "//PRICE", xmlValue)

titles

prices

# Below code extracts values from a list using class: 
# The code will not work. 

scores <- xpathSApply(doc, "//li[@class='score']", xmlValue) 

# Reading JSON 
# Short for JavaScript Object Notation 
install.packages('jsonlite')

library(jsonlite)

jsonData  <- fromJSON("https://api.github.com/users/jtleek/repos")

# To get the names in the dataframe from JSON file: 
names(jsonData) 

# Get the names under "owner" variable: 
names(jsonData$owner) 

# Drilldown further into the "login" variable: 
jsonData$owner$login 

# Write data into a JSON file: 
myjson <- toJSON(iris, pretty = TRUE) 

# Use cat command to print out the content of the JSON neatly: 
cat(myjson) 

# Convert JSON into normal dataframe: 
iris2 <- fromJSON(myjson) 

head(iris2) 

# The data.table package: 
# data.table inherits all functions that apply to data.frame 
# Package is much faster as it is written in C. For example, subsetting, group, updating, etc. 
# Create data tables just like data frames: 
library(data.table) 

DF <- data.frame(x = rnorm(9), y = rep(c("a", "b", "c"), each = 3), z = rnorm(9)) 

head(DF, 3) 

DT <- data.table(x = rnorm(9), y = rep(c("a", "b", "c"), each = 3), z = rnorm(9)) 

head(DT, 3) 

# See all the tables in memory with name of table, number of rows, columns, names, size, etc.: 
tables()

# Subsetting rows: 
DT[2, ] 

DT[DT$y == "a"] 

# Note that subsetting by only a vector automatically applies to rows. 
# The code below subsets rows 2 and 3. 
DT[c(2, 3)] 

# To subset by columns, start with a ','. 
DT[, c(2, 3)] 

# Calculate values for variables with expressions. Use list to define multiplee functions. 
DT[, list(mean(x), sum(x))] 

DT[, table(y)] 

# Add new columns in tables. In frames, the function would create a copy which would be problematic 
# if the the size of the table is big. data.table does not create a copy of the table and is faster. 
DT[, w := z^2] 

# After passing the values of an exisiting table into a new table, when the old table is changed, 
# it automatically changes tthe new table. In data.frame, the old and new tables are not connected. 
DT2 <- DT 

DT[, y := 2] 

head(DT, n = 3) 

head(DT2, n = 3) 

# Multiple functions can be performed in tables to reach the intended values. 
# Here m is log2( x + z) + 5. 
# 2 functions in the code are seperated by the semicolon. 
DT[, m := {tmp <- (x + z); log2(tmp + 5)}] 

# Do plyr like operations: 
DT[, a := x > 0] 

# In the below code, b's value will be the mean of x+w value for all the rows where a is false and 
# the mean for where a is true. 

DT[, b := mean(x + w), by = a] 

# data.table package has special variables that can be used to run codes faster. 
# For example, ".N" syntax helps count very fast compared to using the $ sign. 
set.seed(123) 

DT <- data.table(x = sample(letters[1:3], 1E5, TRUE)) 

DT[, .N, by = x] 

# data.table has keys which are the unique identifiers for the table. 
# Below is a fast way of using keys to subset data by a filter on colums x by value a: 
DT <- data.table(x = rep(c("a", "b", "c"), each = 100), y = rnorm(300)) 

setkey(DT, x) 

DT["a"]

# We can also use keys for joins which is faster than frames: 
DT1 <- data.table(x = c("a", "a", "b", "dt1"), y = 1:4) 

DT2 <- data.table(x = c("a", "b", "dt2"), z = 5:7) 

setkey(DT1, x) 

setkey(DT2, x) 

merge(DT1, DT2) 

# Reading a table is faster compared to reading a data frame: 
big_df <- data.frame(x = rnorm(1E6), y = rnorm(1E6)) 

file <- tempfile() 

write.table(big_df, file = file, row.names = FALSE, col.names = TRUE, sep = "\t", quote = FALSE) 

system.time(fread(file)) 

system.time(read.table(file, header = TRUE, sep = "\t")) 

# New improvements include melt and cast functions. 

# Continue with Swirl "Getting and Cleaning Data" section 

