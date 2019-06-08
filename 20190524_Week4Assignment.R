library(dplyr)
getwd()
# setwd("D:/Study&Learning/Coursera/DataScience") 
 setwd("C:/All-Files/Study&Learning/Coursera/DataScience") 

outcome <- read.table("week4assignment-outcome-of-care-measures.csv", header = TRUE, sep = ",", na.strings = "Not Available", stringsAsFactors = FALSE) 

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
  data <- read.table("week4assignment-outcome-of-care-measures.csv", header = TRUE, sep = ",", na.strings = "NA", stringsAsFactors = FALSE) 
  data[is.na(data)] <- 0
  data[data == "Not Available"] <- 0
  
  data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <- as.numeric(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
  data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure = as.numeric(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
  data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia = as.numeric(data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
  View(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
  
  # Check that state and outcome are valid 
  statelist <- data$State 
  outcomelist <- c("heart attack", "heart failure", "pneumonia") 
  
  if((state %in% statelist && outcome %in% outcomelist) == TRUE) {
    print("State and Outcome Found. Continue with program") 

    statesubset <- subset(data, State == state) 
    statesubset <- statesubset %>% arrange(statesubset$Hospital.Name)
    View(statesubset)
    
    print("Created subset based on State Code") 
    
    coltotake <- if(outcome == "heart attack") { # Heart Attack Mortality COlumn - 11 
      "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack" 
    } 
    
    else if(outcome == "heart failure") { # Heart Failure Mortality column - 17 
      "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure" 
    } 
    
    else { # Pneumonia Mortality column - 23 
      "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
    } 
    
    print(coltotake)
    lowest <- match(min(statesubset[, coltotake]), statesubset[, coltotake]) 
    statesubset[lowest, 2]

  } 
} 

best("AL", "pneumonia")
best("TX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack") 
best("NY", "hert attack")

dataTX <- subset(data, data$State == "TX")
class(dataTX$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
dataTX$heart_failure_new = as.numeric(dataTX$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
summary(dataTX$heart_failure_new)
paste("coltotake =", coltotake) 
lowest <- match(min(statesubset[, coltotake]), statesubset[, coltotake]) 
statesubset[lowest, 2]

data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <- data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack[!is.na(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)]
View(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
