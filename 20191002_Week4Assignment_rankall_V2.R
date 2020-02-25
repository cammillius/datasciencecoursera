if(!require(dplyr)){ 
  
  install.packages("dplyr") 
  
  library(dplyr)
} 

rankall <- function(outcome, num = "best") { 
  
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
  
  # Getting outcome from input 
  
  

  
  
      outcomecol <- "heart.attack" 
      finaldata <- neededdata[, c(1, 2, 3)] 
      finaldata <- finaldata[complete.cases(finaldata$heart.attack), ] 
      finaldata <- dplyr::arrange(finaldata, )
      finaldata$rank <- NA
      
groupeddata <- finaldata %>% 
  group_by(State) %>%
  mutate(rank=1:nrow)

states <- unique(finaldata$State)
finaldata2 <- data.frame()
for(i in 1:length(states)){
  temp <- finaldata[finaldata$State==states[i],]
  temp$rank <- 1:nrow(temp)
  finaldata2<-rbind(finaldata2, temp)
}
View(finaldata2)
lowest <- match(min(finaldata2[, "rank"]), finaldata2[, "rank"]) 

finaldata2[lowest, 1]



rankall <- function(rank, issue){
  
}



View(groupeddata)      
View(unsplitdata)
splitdata <- split(finaldata, finaldata$State) 
unsplitdata <- do.call(rbind, splitdata) 


library(dplyr)
?group_by
unlist(lapply(splitdata, function(d) d[["hospital name"]]))

    # Changing best, worst and number function inputs to proper format 
    
    if(num == "best") {
      num <- 1 
    } else if(num == "worst") {
      num <- nrow(finaldata) 
    } else if(class(num == "numeric") == TRUE) {
      num <- num 
    } 
    

    
    # Split the data set by state 
    
    for( eachstate in statelist) {
      subset
    }
  
    splitbystate <- split(finaldata, finaldata$State) 

    ans <- lapply(splitbystate, function(x) { 
      
      x <- x[order(x[, 3], x[, 1]), ] 
      x$rank <- 1:nrow(x) 
      return(x)
    }) 

    ans <- as.data.frame(ans)
    ans[[AK]]
    rankbystate <- data.frame()
    
    
    
    for (eachstate in statelist) { 
      
      
      
    }
    ans <- bind_rows(ans)
    
    ans <- subset(ans, ans$rank == num) 
    ans <- ans[, c(1, 2)]
  } 
  
} 

tail(rankall("pneumonia", "worst"), 3)
