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

install.packages("XPath")

# /node denotes the top level node 
# //node denotes the nodes at any level 
# node[@attr-name] denotes node with attribute names 
# node[@attr-name='bob'] denotes node with specific attribute name as 'bob' 
