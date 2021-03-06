getwd()
# setwd("D:/Study&Learning/Coursera/DataScience")
outcome <- read.csv("week4assignment-outcome-of-care-measures.csv", header = TRUE, colClasses = "character") 
View(outcome)
head(outcome)
ncol(outcome)
nrow(outcome)
names(outcome)
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[, 11])
colnames(outcome[11])
state <- "state"
best <- function(state, outcome) { 
  # Read outcome data 
  data <- read.csv("week4assignment-outcome-of-care-measures.csv", header = TRUE, colClasses = "character") 
  # Check that state and outcome are valid 
  statelist <- data$State 
  outcomelist <- c("heart attack", "heart failure", "pneumonia") 
  
  if((state %in% statelist && outcome %in% outcomelist) == TRUE) {
    print("State and Outcome Found. Continue with program") 

    statesubset <- subset(data, State == state) 
    
    View(statesubset)
    
    print("Created subset based on State Code") 
    
    if(outcome == "heart attack") { # Heart Attack Mortality COlumn - 11 
      lowest <- match(min(statesubset$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack), statesubset$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack) 
      statesubset[lowest, 2]
    } 
    
    else if(outcome == "heart failure") { # Heart Failure Mortality column - 17 
      lowest <- match(min(statesubset$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure), statesubset$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure) 
      statesubset[lowest, 2]
    } 
    
    else if(outcome == "pneumonia") { # Pneumonia Mortality column - 23 
      lowest <- match(min(statesubset$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia), statesubset$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia) 
      statesubset[lowest, 2]
    }
  } 
}

best("AL", "heart attack")
match(min(statesubset$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure), statesubset$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
