setwd("C:/All-Files/Study&Learning/Coursera/DataScience/GettingAndCleaningData/Week2") 
getwd() 
install.packages("RMySQL") 
library(RMySQL) 

# dbConnect command helps connect with the database 
ucscDb <- dbConnect(MySQL(), user = "genome", 
                    host = "genome-mysql.soe.ucsc.edu") 

# dbGetQuery will help run mysql commands. After running query, alwaysdisconnect. 
result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb);
result

# Connecting to one database and getting tables 
hg19 <- dbConnect(MySQL(), user = "genome", 
                  db = "hg19", 
                  host = "genome-mysql.soe.ucsc.edu") 
allTables <- dbListTables(hg19) 

# Find the number of tables in the database 
length(allTables) 

# Names of the first 5 tables 
allTables[1:10] 

# Get all the fields in a particular table 
dbListFields(hg19, "affyU133Plus2") 

# Count of all the records  
dbGetQuery(hg19, "select count(*) from affyU133Plus2") 

# Read from a table into R 
affyData <- dbReadTable(hg19, "affyU133Plus2") 
head(affyData) 

# Select subset from mySQL 
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3") 
affyMis <- fetch(query); quantile(affyMis$misMatches) 

# Bring in a very small subset of 10 rows from table 
affyMisSmall <- fetch(query, n = 10); dbClearResult(query); 
dim(affyMisSmall) 

# Don't forget to close the connection 

# HDF5 
# HDF5 is used for storing large datasets 
# Supports storing a range of data types 
# Heirarchical data format 
# groups containing zero or more data sets and meta data 
# Have a group header with group name and attributes 
# Have a group symbol table with a list of objects in group 
# datasets multidimensional array of data elements with metadata 
# Have a header with name, datatype, dataspace and storage layout 
# Have a data array with the data 

# Install R HDF5 Package 
# Below codes are outdated 
# source("http://bioconductor.org/biocLite.R") 
# biocLite("rdhf5") 

install.packages("BiocManager")
BiocManager::install("rhdf5")

library(rhdf5) 
created <- h5createFile("example.h5") 

# Create groups 
created <- h5createGroup("example.h5", "foo") 
created <- h5createGroup("example.h5", "baa") 
created <- h5createGroup("example.h5", "foo/foobaa") 
h5ls("example.h5") 

# Write to groups 
A <- matrix(1:10, nrow = 5, ncol = 2) 
h5write(A, "example.h5", "foo/A") 
B <- array(seq(0.1, 2.0, by = 0.1), dim = c(5, 2, 2)) 
attr(B, "scale") <- "liter" 
h5write(B, "example.h5", "foo/foobaa/B") 
h5ls("example.h5") 

# Write a data set directly 
df <- data.frame(1L:5L, seq(0, 1, length.out = 5), 
                 c("ab", "cde", "fghi", "a", "s"), 
                 stringsAsFactors = FALSE) 
h5write(df, "example.h5", "df") 
h5ls("example.h5") 

# Reading data from specific datasets and sub-datasets 
readA <- h5read("example.h5", "foo/A") 
readB <- h5read("example.h5", "foo/foobaa/B") 
readdf <- h5read("example.h5", "df") 
readA

# Writing and reading chunks 
h5write(c(12, 13, 14), "example.h5", "foo/A", index = list(1:3, 1)) 
h5read("example.h5", "foo/A") 

# Reading data from web 

# Webscraping 
# Webscraping is programmatically extracting data from the HTML code of websites 
# Getting data off webpages using readLines() 
con <- url("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en") 
htmlCode <- readLines(con) 
close(con) 
htmlCode 

# Parsing through XML 
library(XML) 
library(RCurl) 
theurl <- "https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en" 
fileURL <- getURL(url = theurl) 
html <- htmlTreeParse(fileURL, useInternalNodes = T) 
xpathSApply(html, "//title", xmlValue) 

# code below not working 
# xpathSApply(html, "//td[@id = 'col-citedby']", xmlValue) 

# Using httr package 
library(httr) 
html2 <- GET(theurl) 
content2 <- content(html2, as = "text") 
parsedHTML <- htmlParse(content2, asText = TRUE) 
xpathSApply(parsedHTML, "//title", xmlValue) 

# Accessing websites with passwords will show 401 
pg1 <- GET("http://httpbin.org/basic-auth/user/passwd") 
pg1 

# Using httr to authenticate with credentials 
pg2 <- GET("http://httpbin.org/basic-auth/user/passwd", 
           authenticate("user", "passwd")) 
pg2 
names(pg2) 

# Use handles to use one time authentication 
google <- handle("https://www.google.com") 
pg1 <- GET(handle = google, path = "/") 
pg2 <- GET(handle = google, path = "search")

# Getting data from APIs 
