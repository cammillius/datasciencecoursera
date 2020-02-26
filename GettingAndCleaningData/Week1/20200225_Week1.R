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

