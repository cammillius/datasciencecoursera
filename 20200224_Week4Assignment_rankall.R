if(!require(dplyr)){ 
  
  install.packages("dplyr") 
  
  library(dplyr)
} 

rankall <- function(outcome, num = "best") { 
  
  outcome <- "heart failure" 
  
  num <- "best" 
  
  # Read outcome data 
  
  data <- read.table("week4assignment-outcome-of-care-measures.csv", header = TRUE, sep = ",", na.strings = "NA", stringsAsFactors = FALSE) 
  
  # Taking subset of data with only the hospital name, state and the required mortality rate columns 
  
  neededdata <- data[, c(which(colnames(data) == "Hospital.Name"), 
                   which(colnames(data) == "State"), 
                   which(colnames(data) == "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"), 
                   which(colnames(data) == "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"), 
                   which(colnames(data) == "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"))] 
  
  # Renaming the complex column names with simple ones. 
  
  colnames(neededdata) <- c("hospital.name", "State", "heart.attack", "heart.failure", "pneumonia") 

  # Replacing all "Not Available" values with NA 
  
  neededdata[neededdata == "Not Available"] <- NA 
  
  # Converting all the value columns to numeric 
  
  neededdata$heart.attack <- as.numeric(neededdata$heart.attack) 
  neededdata$heart.failure <- as.numeric(neededdata$heart.failure) 
  neededdata$pneumonia <- as.numeric(neededdata$pneumonia) 
  
  # Create the states and outcomes list 
  
  statelist <- unique(neededdata$State) 
  outcomelist <- c("heart attack", "heart failure", "pneumonia") 
  
  # Getting outcome from input and choosing the final data subset 
  
  finaldata <- if(outcome == "heart attack") 
  {
    neededdata[, c(1, 2, 3)]
  } else if(outcome == "heart failure") 
  {
    neededdata[, c(1, 2, 4)]
  } else if(outcome == "pneumonia") 
    {
    neededdata[, c(1, 2, 5)]
  } else {
    stop("invalid outcome")
  }
  
  # Dropping NAs 
  
  finaldata <- finaldata[complete.cases(finaldata[, 3]), ] 

  # Creating final dataset with rank by state, considering mortality rate and hospital name 

  rankbystatedata <- data.frame() 
  
  for(i in 1:length(statelist)){ 
    
    statewisedata <- finaldata[finaldata$State==statelist[i],] 
    
    statewisedata <- arrange(statewisedata, statewisedata$heart.failure, statewisedata$hospital.name) 
    
    statewisedata$rank <- 1:nrow(statewisedata)
    
    rankbystatedata<-rbind(rankbystatedata, statewisedata) 
    
  } 
  
  # Arranging by state 
  
  rankbystatedata <- arrange(rankbystatedata, rankbystatedata$State) 
  
  # Defining value of num and getting the resultant output 
  
  result1 <- data.frame() 
  result2 <- data.frame() 
  result3 <- data.frame()

  if(num == "best") {
    result1 <- subset(rankbystatedata, rankbystatedata$rank == 1) 
    result1 <- result1[, 1:2] 
    result1 
    View(result1) 
  } else if(num != "best" && class(num) == "numeric") {
    result2 <- subset(rankbystatedata, rankbystatedata$rank == num) 
    result2 <- result2[, 1:2] 
    View(result2) 
  } else if(num == "worst") { 
    for(i in 1:length(statelist)) {
      maxrank <- nrow(rankbystatedata[rankbystatedata$State==statelist[i], ] ) 
      temp <- rankbystatedata[rankbystatedata$State==statelist[i],]
      # worsthospital <- temp[temp$rank==max(temp$rank),] 
      worsthospital <- temp[temp$rank == maxrank, 1:2] 
      
      #worsthospital <- rankbystatedata[rankbystatedata$State==statelist[i] && rankbystatedata$rank == maxrank, ] 
      result3 <- rbind(result3, worsthospital) 
      
    } 
    View(result3)
  } 
} 
