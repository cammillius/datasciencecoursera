if(!require(dplyr)){ 
  
  install.packages("dplyr") 
  
  library(dplyr)
} 
setwd("C:/All-Files/Study&Learning/Coursera/DataScience")
rankall <- function(outcome, num = "best") { 
  
  # Read outcome data 
  
  data <- read.table("week4assignment-outcome-of-care-measures.csv", header = TRUE, sep = ",", na.strings = "NA", stringsAsFactors = FALSE) 
  
  # Taking subset of data with only the hospital name, state and the required mortality rate columns 
  
  data <- data[, c(which(colnames(data) == "Hospital.Name"), 
                   which(colnames(data) == "State"), 
                   which(colnames(data) == "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"), 
                   which(colnames(data) == "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"), 
                   which(colnames(data) == "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"))] 
  
  # Renaming the complex column names with simple ones. 
  
  colnames(data) <- c("hospital.name", "State", "heart.attack", "heart.failure", "pneumonia") 
  
  # Replacing all "Not Available" values with NA 
  
  data[data == "Not Available"] <- NA 
  
  # Converting all the value columns to numeric 
  
  data$heart.attack <- as.numeric(data$heart.attack) 
  data$heart.failure <- as.numeric(data$heart.failure) 
  data$pneumonia <- as.numeric(data$pneumonia) 
  
  # Create the states and outcomes list 
  
  statelist <- unique(data$State) 
  outcomelist <- c("heart attack", "heart failure", "pneumonia") 
  
  # Check that state and outcome are valid 

  if(state %in% statelist == FALSE) { 
    stop("invalid state") 
  } else if(outcome %in% outcomelist == FALSE) {
    stop("invalid outcome") 
    
    # If the state and outcome are valid, continue with the program 
    
  } else { 

    # Choose the outcome column to take, subset to the required columns and remove NAs 

    if(outcome == "heart attack") { 
      
      outcomecol <- "heart.attack" 
      finaldata <- data[, c(1, 2, 3)] 
      finaldata <- finaldata[complete.cases(finaldata$heart.attack), ] 
      finaldata$rank <- NA
      
    } else if(outcome == "heart failure") { 
      
      outcomecol <- "heart.failure" 
      finaldata <- data[, c(1, 2, 4)]
      finaldata <- finaldata[complete.cases(finaldata$heart.failure), ] 
      finaldata$rank <- NA
      
    } else { 
      
      outcomecol <- "pneumonia" 
      finaldata <- data[, c(1, 2, 5)]
      finaldata <- finaldata[complete.cases(finaldata$pneumonia), ] 
      finaldata$rank <- NA
      
    } 
    
    # Changing best, worst and number function inputs to proper format 
    
    if(num == "best") {
      num <- 1 
    } else if(num == "worst") {
      num <- nrow(finaldata) 
    } else if(class(num == "numeric") == TRUE) {
      num <- num 
    } 
    

    
    # Split the data set by state  
    
    splitbystate <- split(finaldata, finaldata$State) 

    ans <- lapply(splitbystate, function(x) { 
      
      x <- x[order(x[, 3], x[, 1]), ] 
      x$rank <- 1:nrow(x) 
      return(x)
    }) 

    View(ans)
    
    rankbystate <- data.frame()
    
    
    
    for (eachstate in statelist) { 
      
      
      
    }
    ans <- bind_rows(ans)
    
    ans <- subset(ans, ans$rank == num) 
    ans <- ans[, c(1, 2)]
  } 
  
} 

tail(rankall("pneumonia", "worst"), 3)
