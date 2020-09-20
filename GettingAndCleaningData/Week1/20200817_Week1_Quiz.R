# Question 1
# The American Community Survey distributes downloadable data about United States communities. Download the 
# 2006 microdata survey about housing for the state of Idaho using download.file() from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# How many properties are worth $1,000,000 or more? 

setwd("C:/All-Files/Study&Learning/Coursera/DataScience/GettingAndCleaningData/Week1") 

library(dplyr) 

data <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv") 

milplus <- filter(data, VAL == 24) 

nrow(milplus)

# Answer: 53 

# Question 2: 
# Use the data you loaded from Question 1. Consider the variable FES in the code 
# book. Which of the "tidy data" principles does this variable violate? 

# Answer: Tidy data has one variable per column. 

# Question 3: 
# Download the Excel spreadsheet on Natural Gas Aquisition Program here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx 
# Read rows 18-23 and columns 7-15 into R and assign the result to a variable 
# called: dat 

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", "dataset.xlsx", method = "curl")

dat <- readxl::read_xlsx("dataset.xlsx", range = "NGAP Sample Data!G18:N23")  

# What is the value of:
# sum(dat$Zip*dat$Ext,na.rm=T) 

sum(dat$Zip*dat$Ext,na.rm=T)

# Answer: 36534720 

# Question 4: 
# Read the XML data on Baltimore restaurants from here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml 
# How many restaurants have zipcode 21231? 

library(XML) 

library(RCurl) 

theurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml" 

fileURL <- getURL(url = theurl) 

doc <- xmlTreeParse(fileURL, useInternalNodes = TRUE) 

rootNode <- xmlRoot(doc) 

zipcodes <- xpathSApply(rootNode, "//zipcode", xmlValue) 

zipcodes <- as.numeric(zipcodes)

length(zipcodes[zipcodes == 21231]) 

# Answer: 127 

# Question 5: 
# The American Community Survey distributes downloadable data about 
# United States communities. Download the 2006 microdata survey about housing for 
# the state of Idaho using download.file() from here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 
# using the fread() command load the data into an R object 
# DT 

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", "dataset2.csv", method = "curl") 

library(data.table)

DT <- fread(file = "dataset2.csv", sep = ",", header = TRUE)

View(DT)

sapply(split(DT$pwgtp15,DT$SEX),mean)

tapply(DT$pwgtp15,DT$SEX,mean)

mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)

DT[,mean(pwgtp15),by=SEX]

mean(DT$pwgtp15,by=DT$SEX)
??by
