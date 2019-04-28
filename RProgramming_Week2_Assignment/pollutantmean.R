# This assignment involves reading multiple files, extracting required values and doing
# operations to give results 

# Assignment Part 1

pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  setwd(directory) 
  total = 0
  observations = 0 
  
  for (i in id)
  {
 
    if (i < 10) { 
      data <- read.csv(paste("0","0", as.character(i), ".csv", sep=""),  
                       header = T, 
                       na.strings=c("NA","NaN", " "))
    }
    
    else if (i>=10 & i<100) { 
      data <- read.csv(paste("0", as.character(i), ".csv", sep=""),  ## for example, if 'id' = 17, we get 017.csv
                       header = T, 
                       na.strings=c("NA","NaN", " ") 
      )
    }
    
    
    
    else       { 
      data <- read.csv(paste(as.character(i), ".csv", sep=""),     ## Normal
                       header = T, 
                       na.strings=c("NA","NaN", " ") 
      )
    }
    
    data = na.omit(data)    
    observations = observations + nrow(data)
    if (pollutant == "sulfate") {total = total + sum(data$sulfate)}
    else {total = total + sum(data$nitrate)}
    
  }
 
  setwd("..")
 
  return (total/observations)
  
}

# Assignment Part 2 

complete <- function(directory, id = 1:332) {
  
  dataframe = NULL 
  setwd(directory) 
  
  for (i in id)
  {

    if (i <10) { 
      data <- read.csv(paste("0","0", as.character(i), ".csv", sep=""),  ## for example, if 'id' =7, we get 007.csv
                       header = T, 
                       na.strings=c("NA","NaN", " "))
    }
    
    else if (i>=10 & i<100) { 
      data <- read.csv(paste("0", as.character(i), ".csv", sep=""),  ## for example, if 'id' = 17, we get 017.csv
                       header = T, 
                       na.strings=c("NA","NaN", " ") 
      )
    }
    
    else       { 
      data <- read.csv(paste(as.character(i), ".csv", sep=""),     ## Normal
                       header = T, 
                       na.strings=c("NA","NaN", " ") 
      )
    }
    
 
    data = na.omit(data) 

    data = as.matrix(data)
    dataframe = rbind(dataframe, c(i,nrow(data))) 
    
  }
  
  setwd("..")  
  dataframe = data.frame(dataframe)  
  names(dataframe) = c('id', 'nobs') 
  return (dataframe) 
} 

# Assignment Part 3 

corr <- function(directory, threshold = 0) {
  setwd(directory) 
  
  correlationVector = NULL 
  
  for (i in 1:332)
  {
    
    
    if (i <10) { 
      data <- read.csv(
        paste("0","0", as.character(i), ".csv", sep=""),  ## for example, if 'id' =7, we get 007.csv
        header = T, 
        na.strings=c("NA","NaN", " ")
        
      )
    }
    
    else if (i>=10 & i<100) { 
      data <- read.csv(
        paste("0", as.character(i), ".csv", sep=""),  ## for example, if 'id' = 17, we get 017.csv
        header = T, 
        na.strings=c("NA","NaN", " ") 
        
      )
    }
    
    
    
    else       { 
      data <- read.csv(
        paste(as.character(i), ".csv", sep=""),     ## Normal
        header = T, 
        na.strings=c("NA","NaN", " ") 
        
      )
    }
    
    data = na.omit(data) 
    
    if (nrow(data) > threshold) {
      correlationVector = c(correlationVector, cor(data[,2], data[,3]))
    }
    
    
  }
  
  
  
  setwd("..") 
  return (correlationVector)
} 

# Quiz Questions: 

pollutantmean("specdata", "sulfate", 1:10) 

pollutantmean("specdata", "nitrate", 70:72) 

pollutantmean("specdata", "sulfate", 34) 

pollutantmean("specdata", "nitrate")

cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs) 

cc <- complete("specdata", 54)
print(cc$nobs)

set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])

cr <- corr("specdata")                
cr <- sort(cr)                
set.seed(868)                
out <- round(cr[sample(length(cr), 5)], 4)
print(out)

cr <- corr("specdata", 129)                
cr <- sort(cr)                
n <- length(cr)                
set.seed(197)                
out <- c(n, round(cr[sample(n, 5)], 4))
print(out) 

cr <- corr("specdata", 2000)                
n <- length(cr)                
cr <- corr("specdata", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4))) 
