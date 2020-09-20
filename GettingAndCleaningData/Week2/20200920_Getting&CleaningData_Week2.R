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

# HDF5 is used for storing large datasets 

# Supports storing a range of data types 
