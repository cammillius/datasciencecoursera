if(!require(dplyr)){ 
  
  install.packages("dplyr") 
  
  library(dplyr)
} 

best <- function(state, outcome) { 
  
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
    
    # Subset data based on state 
    
    statesubset <- subset(data, State == state) 
    
    # Arrange the hospitals to get the first hospital in alphabetical order if there is a tie 
    
    statesubset <- statesubset %>% arrange(statesubset$hospital.name) 
    
    # Choose the outcome column to take, subset to the required columns and remove NAs 

    if(outcome == "heart attack") { 
      
      outcomecol <- "heart.attack" 
      finaldata <- statesubset[, c(1, 2, 3)] 
      finaldata <- finaldata[complete.cases(finaldata$heart.attack), ] 
      
    } else if(outcome == "heart failure") { 
      
      outcomecol <- "heart.failure" 
      finaldata <- statesubset[, c(1, 2, 4)]
      finaldata <- finaldata[complete.cases(finaldata$heart.failure), ] 
      
    } else { 
      
      outcomecol <- "pneumonia" 
      finaldata <- statesubset[, c(1, 2, 5)]
      finaldata <- finaldata[complete.cases(finaldata$pneumonia), ] 
      
    } 
    
    # Find the lowest outcome value and pass the row number into a variable 
    
    lowest <- match(min(finaldata[, outcomecol]), finaldata[, outcomecol]) 
    
    # Output the name of the hospital with the lowest outcome value 
    
    finaldata[lowest, 1] 
    
  } 
  
} 
