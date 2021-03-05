# CSCI 4360/6360
## Tool Talk #1: Using the R Language for Linear Models using 'lm'
# January 26, Tuesday
# Authors: Zachary, Nawa, Sameen

#### Part 1 ############################################################################################### 

# Variables and data types

boolean <- TRUE
numeric <- 1
string <- 'hello'
vector <- c('list', 'of', 'values')
dataframe <- data.frame(numeric, string)

# Conditionals

condition <- TRUE
condition2 <- TRUE

if(condition) {
  # True expression
} else if(condition2) {
  # First not true, second true
} else {
  # if and else if fail before coming here
}

# Loops

## For loops

range <- 1:10
for(i in range) {
  print(i)
}

for(i in range) {
  if(i == 3) {
    next
  }
  print(i)
}

## While loops

while(TRUE) {
  # Do something
  temp <- sample(1:10, 1)
  if(temp == 1) {
    break
  } else {
    print("[While loop] Temp does not equal 1!")
  }
}

## Repeat loops

repeat {
  # Do something
  temp <- sample(1:10, 1)
  if(temp == 1) {
    break
  } else {
    print("[Repeat loop] Temp does not equal 1!")
  }
}

# Functions

printFunction <- function(arg1) {
  print(arg1)
  return(arg1)
}

hello <- printFunction("hello")
hello


funcWithDefaultArg <- function(arg1, arg2 = TRUE) {
  if(arg2) {
    print(arg1)
  } 
}
funcWithDefaultArg('hello')
funcWithDefaultArg('goodbye?', arg2 = FALSE)

# Installing and Importing libraries and other functions

## If you've never installed it before, install.package first
install.packages('dplyr')

## Then import the package into the script
library(dplyr)


############################# Part 1 Ends ###################################################################

################################### Part 2 ##################################################################

setwd("C:/Users/np63571/Downloads") # Setting directory ( Ctrl+Shift+H)

###########################Reading file#######################################

#install.packages("dplyr")
#install.packages(readxl)
library(dplyr)
library(readxl)

df <- read.csv("swissData.csv", header = T) 
write.csv(df, "df1.csv")
######################################################################
# if xlsx                                                           #
#
#read_xlsx("File_name.xlsx", sheet = "sheet_name")                  #
#
# if text
#
#read.table("file_name", sep = "\t")
#####################################################################
str(df)
summary(df)

## Edit data##

edit(df)
View(df)

##############view head and tail fo the data
head(df)
tail(df)


#for help
?rep
help(rep)

##################################################################
## Indexing data frames

df[1, c(1,3)] #Extract data from row 1, columns 1 and 3

df[, 2] # second column

df[2, ] # second row

df["forest"] # Forest column

df[2:10, 3] # from second to tenth row within 3rd colum.

# $dollar sign

df$sppRichness  # column of sppRichness



df$water <- as.factor(df$water)

# Adding column

df$interaction <- df$elevation*df$forest
df["new_col"] <- df$interaction
# can use cbind to combine data from different dataframes

# Droping column
df1 <- subset(df, select= -c(interaction, new_col))
df <-select(df, -c(interaction,new_col))

head(df)

##  techniques from dplyr 

summarise(df, avg= mean(forest), SD= sd(forest), max(forest), min(forest))  #creating summary data

## Group Cases

count(df, water)
df %>% 
  group_by(water) %>% 
  summarise(avg = mean(forest)) %>% 
  ungroup()

df %>% 
  group_by(water) %>% 
  summarise_all(.funs= funs(mean="mean", sd = "sd")) %>% 
  ungroup()


## filter

filter(df, forest >70)



############################### Part 2 Ends #################################################################

################################## Part 3 ##################################################################
## Linear Models

## Reading the dataset named as swissData.csv
# Set the working directory to where the .csv file is

mydata <- read.csv("swissData.csv")
View(mydata) 
# A simple linear model with an intercept and a slope would have the form :
#        y = b0 + b1*x1
    
# Let's say I want to see what effect does 'elevation' have on species richness ('sppRichness') 

model1 <- lm(sppRichness~elevation, data = mydata)

summary(model1)


coefficients(model1)

# Getting the coefficents and storing them in separate variables

b0 = coefficients(model1)[1]
b0

b1 = coefficients(model1)[2]
b1

## Making a simple R plot
plot(sppRichness~elevation, data = mydata,
     xlab = "Elevation (ft)", ylab = "Species Richness (#)",
     main = "Linear Model 1")
abline(model1, lty = 1, lwd = 2)

## If you want to make a fancy plot
install.packages("ggplot2")
library(ggplot2)


ggplot(mydata, aes(x=elevation, y=sppRichness))+
  geom_point(size = 3, color = "gray64")+
  stat_smooth(method="lm", formula=y~x, size=1, se=FALSE, color = "blue")+
  xlab("Elevation (ft)")+
  ylab("Species Richness (#)")+
  scale_x_continuous(breaks = seq(0,3000, 500))+
  theme_bw(base_size = 20)+
  ggtitle("Linear Model 1")




### Now I want to see the effect of forest cover on species richness

model2 <- lm(sppRichness~forest, mydata)
summary(model2)

ggplot(mydata, aes(x=forest, y=sppRichness))+
  geom_point(size = 3, color = "gray64")+
  stat_smooth(method="lm", formula=y~x, size=1, se=FALSE, color = "red")+
  xlab("Forest Cover (%)")+
  ylab("Species Richness (#)")+
  theme_bw(base_size = 20)+
  ggtitle("Linear Model 2")


### Lets make some more models


# This model takes on the form
#        y = b0 + b1*x1 + b2*x2
## It becomes multiple linear regression now

model3 <- lm(sppRichness ~ elevation + forest, mydata)
summary(model3)
# RMSE = 5.118 and R2 = 0.7756

install.packages("scatterplot3d")
library(scatterplot3d)

attach(mydata)
my3Dplot <- scatterplot3d(elevation, forest, sppRichness, pch = 16,
                        main = "Linear Model 3 - 3D Scatterplot")
my3Dplot$plane3d(model3, col="blue")
detach(mydata)


## Make a spinning 3D Scatter plot
install.packages("predict3d")
library(predict3d)

predict3d(model3, radius = 20)


### Now we want to add some more explanatory variables to the model to improve the fit statistics

# This model takes on the form
#        y = b0 + b1*x1 + b2*x2 + b3*x3

model4 <- lm(sppRichness ~ elevation + forest + water, data = mydata)
summary(model4)



## In this final model, 'water' is a categorical variable
# 'sppRichness', 'elevation', 'forest' are all continuous variables

## Plotting this model requires four dimensions (Not possible here)
# A different way to plot this would be something like...

# These values are taken from the model4 summary results
b0 <- coefficients(model4)[1]
b1 <- coefficients(model4)[2]
b2 <- coefficients(model4)[3]
b3 <- coefficients(model4)[4]

## Declaring water as a dummy variable; 1 if water is available, 0 if water is not available
water_yes <- 1
water_no <- 0

## Creating a series of points for making a nice plot
elev_min <- min(mydata$elevation)
elev_max <- max(mydata$elevation)

avg_forest <- mean(mydata$forest)
## We are only using the mean forest cover (%) which is 34.74532 for the plot

elev <- seq(elev_min, elev_max, 1)


water_yay <- b0 + b1 * elev  + b2 * avg_forest + b3 * water_yes
water_nay <- b0 + b1 * elev  + b2 * avg_forest + b3 * water_no

water_yes_line <- data.frame(elev, water_yay)
water_no_line <- data.frame(elev, water_nay)


ggplot(mydata, aes(x=elevation, y=sppRichness))+
  geom_point(size = 3, color = "gray64")+
  geom_line(data=water_yes_line, mapping = aes(x=elev, y=water_yay, color = "Y0"), size = 1)+
  geom_line(data=water_no_line, mapping = aes(x=elev, y=water_nay, color = "Y1"), size = 1)+
  xlab("Elevation (ft)")+
  ylab("Species Richness (#)")+
  scale_x_continuous(breaks = seq(0,3000, 500))+
  theme_bw(base_size = 20)+
  ggtitle("Linear Model 4") + 
  scale_colour_manual(name = "Water",
                      values = c('Y0' = "green",
                                 'Y1' = "red"),
                      breaks=c("Y0",
                               "Y1"),
                      labels=c("Yes","No"))


#### Model Comparisons using Akaike Information Criterion

# AIC = n * log(RSS/n) + 2K

# n = number of observations
# RSS = Residual sum-of-squares
# K = number of model parameters

model1_AIC <- AIC(model1)
model2_AIC <- AIC(model2)
model3_AIC <- AIC(model3)
model4_AIC <- AIC(model4)

AIC <- c(model1_AIC, model2_AIC, model3_AIC, model4_AIC)
delta <- AIC - min(AIC)


model_table <- data.frame(AIC, delta)
rownames(model_table) <- c("Model-1", "Model-2", "Model-3", "Model-4" )
model_table <- model_table[order(model_table$AIC),]
round(model_table, digits = 2)

## In this final data frame, the best model is at the top and the worst is at the bottom.
# Hence, model4 is the best and model2 is the worst.

########################################### Part 3 Ends ####################################################


