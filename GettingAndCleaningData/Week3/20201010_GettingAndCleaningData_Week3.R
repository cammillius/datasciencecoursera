setwd("C:\\All-Files\\Work\\Projects\\Nabler Web Solutions Pvt. Ltd\\Badrinath Vankadari - Cam\\Desktop\\Personal\\Study&Learning\\Coursera\\DataScience\\GettingAndCleaningData\\Week3") 
getwd()

# Creating a data frame: 
set.seed(123) 
X <- data.frame("var1" = sample(1:5), "var2" = sample(6:10), "var3" = sample(11:15)) 
X <- X[sample(1:5), ]; X$var2[c(1, 3)] = NA 
X

# Get specific column values with column number:  
X[, 1] 

# Get specific column with column name: 
X[, "var1"] 

# Get specific rows and columns data: 
X[1:2, "var2"]

#Subset using logical statements 
# AND logical operator: 
X[(X$var1 <= 3 & X$var3 > 11),  ]  

# OR logical operator: 
X[(X$var1 <= 3 | X$var3 > 15),  ] 

# Dealing with missing values: Use which function to return only the needed rows 
X[which(X$var2 > 8), ]

# Sorting 
# Ascending: 
sort(X$var1)

# Descending order: 
sort(X$var1, decreasing = TRUE) 

