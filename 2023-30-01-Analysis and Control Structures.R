##### Simple Data Analysis and More Complex Control Statements 
#### 30 January 2023
#### JWE 

dryadData <- read.table(file="Data/veysey-babbitt_data_amphibians.csv", header = TRUE, sep=",")
dryadData
# read.table() loads the CSV in
# file= is the file pathway to this CSV

## setup libraries
library(tidyverse)
library(ggthemes)

## Analyses 
## Experimental Designs 
## For experimental design you typically have an independent and a dependent variable
## X-axis is typically where independent variable goes (aka Explanatary Variable)
## Y-axis id the dependent (response) variable 
## Continuous versus discrete variables 
## continuous variables are a range of numbers (height, weight, temperature) 
## discrete (categorical) variables are groups or categories that can be "binned" (species, treatment groups, site)

glimpse(dryadData)

### Basic linear regression analysis (2 continuous variables)
## IS there a relationship between the mean pool hydroperiod and the number of breeding frogs caught?
## mean pool hydroperiod is how long a temporary pond had water before dried up and number of breeding frogs is total number of adult frogs 
# typically put y variable ~ x-variable inside () of lm()
regModel <- lm(count.total.adults ~ mean.hydro, data=dryadData)
print(regModel)
summary(regModel) #better than glimpse
# estimate gives the slope esitmate of the relationship and here the p-value is very significant, can usually ignore the intercepts since if looking for relation between 2 variables can ignore if the intercept is zero 
hist(regModel$residuals)
# historgram of residuals shows id regression was way to go

# R^2 value explains how much avriance in X explains the variance in Y
summary(regModel)$"r.squared"
summary(regModel)[["r.squared"]]
View(summary(regModel))
# the View function must be capitalized so make sure to have it like this 

library(ggplot2)
library(tidyverse)
library(ggthemes)
regPlot <- ggplot(data = dryadData, aes(x=mean.hydro, y=count.total.adults)) + 
  geom_point()
# geom_point for a scatterplot
regPlot
regPlot <- ggplot(data = dryadData, aes(x=mean.hydro, y=count.total.adults+1)) + 
  geom_point(size=2) + stat_smooth(method="lm", se = 0.93)
regPlot + theme_few()
# use stat_smooth to plot the regression plot under the scatterplot

### Basic ANOVA 
## Was there a statistically significant difference in the number of adults among wetlands? 
ANOmodel <- aov(count.total.adults ~ wetland, data=dryadData)
summary(ANOmodel)
glimpse(dryadData)

## need to tell R it's not a list of number but rather groups, therefore way to solve this is to factor the wetland data 
ANOmodel <- aov(count.total.adults ~ factor(wetland), data=dryadData)
# must always ensure the y-variable you give to R here is categorical, the factor function makes it categorical
summary(ANOmodel)

dryadData %>%
  group_by(wetland) %>%
  summarize(avgHydro = mean(count.total.adults, na.rm=TRUE), N =n())
# na.rm=T skips the NAs when calculating the mean

### Boxplot 
# don't conduct the ANOVA but go hand in hand with visualizing the results 
# for the boxplot, must ensure that it knows that it's factored, done with plot or in data

dryadData$wetland
class(dryadData$wetland)
dryadData$wetland <- factor(dryadData$wetland)
class(dryadData$wetland)

ANOplot <- ggplot(data=dryadData, mapping=aes(x=wetland, y=count.total.adults)) + geom_boxplot()
ANOplot

# fill or color, to break it up between sepcies, fill deals with the color between the boxplot but the fill lets it be different between the species to break up boxplots by species, later with the fill of a color palette gives the colors of those groups
ANOplot2 <- ggplot(data=dryadData, mapping=aes(x=wetland, y=count.total.adults, fill=species)) + geom_boxplot() + scale_fill_grey()
ANOplot2
# mapping() fills in the aesthetics, argument name of the ggplot fcn that can be run with or without the ggplot() fcn, lets the color or fill to be different between groups or setting up the arguments for aesthetic looks


ggsave(file="SpeciesBoxPlots.pdf", plot=ANOplot2, device="pdf")
# lets you save it as a pdf, but may be difficult for getting exact size or Zoom that you want for resizing 

## Logistic Regression
# Data frame 
xVar <- sort(rgamma(n=200, shape=5, scale=5))
# rgamma() is in same family as rnorm()
# gamma probabilities - continuous variables that are always positive and have a skewed distribution
# 200 gamma values, shape & scale are parameters for distributions 
xVar
hist(xVar)
# rgamma() has a tail at the end

yVar <- sample(rep(c(1,0), each=100), prob=seq_len(200))
# seq_len(200) gives it a sequence of 1 to 200, same as doing 1:200 just a different fucntion
yVar

logRegData <- data.frame(xVar, yVar)
glimpse(logRegData)

## Logistic Regression Analysis
# glm() specifies the type of regression that you want, important for stats next semester 
logRegModel <- glm(yVar ~ xVar, data=logRegData, family=binomial(link=logit))
summary(logRegModel)
# now visualize this via a ggplot

logRegPlot <- ggplot(data=logRegData, aes(x=xVar, y=yVar)) + geom_point() + stat_smooth(method="glm", method.args=list(family=binomial))
print(logRegPlot)
# mess with the stat_smooth when dealing with different types of regression, binomial tells R if it's a logistic regression because it's wither 0 or 1 

### Contingency Tables (chi-squared analysis, where both variables are categorical)
# wrangle the data so 2 groups as columns and 2 groups as rows for dryadData
# start with dplyr wrangling 
# Are there differences in countes of males and females between species? 

countData <- dryadData %>%
  group_by(species) %>%
  summarize(Males = sum(No.males, na.rm=TRUE), Females = sum(No.females, na.rm=TRUE)) %>%
  select(-species) %>%
  as.matrix() # ERRORR !
countData

row.names(countData) = c("SS", "WF") # to rename
countData

## chi-squared 
testResults<- chisq.test(countData)$residuals
testResults
## get residuals

### mosaic plot (base R)
mosaicplot(x=countData, col=c("goldenrod", "grey"), shade=FALSE)

## bar plot of these counts, no have means or variance therefore bar plot better than box plot

# long format, practical way of using pivot_longer() function

countDataLong <- countData %>%
  as_tibble() %>% # doesn't like it as a matrix therefore convert to a tibble
  mutate(Species = c(rownames(countData))) %>% # mutate it so we have the species names 
  pivot_longer(cols = Males:Females, names_to = "Sex", values_to = "Count")

### Plot bar graph 
ggplot(data = countDataLong, mapping = aes(x=Species, y=Count, fill = Sex)) + geom_bar(stat = "identity", position = "dodge") + scale_fill_manual(values=c("darkslategrey", "midnightblue"))
# position = "dodge" plots the bars next to each other rather than stacking on top of another 

################################################

## Control structure is the structure of code
# when we code functions that's control structure because we're specifying the structure
# useful to know and helpful for other coding languages 

# if statements and if/else statements and for loops 

# if statements 
###### if (relational condition) {expression 1, can be creating a new variable or printing out something}

### if (condition) {expression 1} else {expression 2}
# if condition is met do expression 1 but if not then do expression 2 

# if (condition 1) {expression 1} else 
# if (condition 2) {expression 2} else {expression 3}
## if any final unspecified elses it captures the rest of the unspecified conditions 
# the 1st else must appear on the same line as the expression (but the 2nd if statement can start on a new line)

# if statements are used for single values (not vectors)
z <- signif(runif(1), digits=2)
# gives one random uniform numver rounded to 2nd digit
# z > 0.5

### use {} or not 
if (z > 0.8) {cat(z, "is a large number", "\n")} else 
  if (z < 0.2) {cat(z, "is a small number", "\n")} else
    {cat(z, "is a number of typical size", "\n")
    cat("z^2 =", z^2, "\n")
    y <- c(z, TRUE, "dog")}
y
# cat() strings together functions and \n ends with a line break
# must run each line one by one don't run last line or error

##### if/else fills vectors 

#ifelse(condition, yes, no)

#### insect population where females lay on average 10.2 eggs, follows the Poisson distribution (discrete probability distribution showing the likely number of times an event will occur)
# probability that's between 0 and 1 
# 35% chance of parasitism where no eggs are laid, so let's make a distribution for 1,000 individuals 

tester <- runif(1000) 
tester
eggs <- ifelse(tester > 0.35, rpois(n=1000, lambda=10.2), 0)
hist(eggs)

##### vector of p values from a simulation and we want to create a vector to highlight the significant ones for plotting 
pVals <- runif(1000)
z <- ifelse(pVals <- 0.025, "lowerTail", "nonSig")
z
z[pVals >= 0.975] <- "upperTail" ## check for help
table(z)


###### for loops
### workhorse function for doing repetitive tasks
## universal in all computer languages
## have vectorization in R which no occur for other languages therefore for loops are controversial in R
## are very slow for certain operations 
## part of the family of apply functions

#### Anatomy of for loop
## for(variable in a sequence){ # starts for loop, 
# contents are the body of the for loop
#} #ends on its own line
# var is a counter variable that holds the current value of the loop (i, j, k)
## sequence is an integer vector usually that defines the starting and endpoints of the loop

for(i in 1:5){
  cat("stuck in a loop", i, "\n")
  cat(3+2, "\n")
  cat(3+i, "\n")
}
print(i)
# unlike functions takes place in global environment can setup a varibale to be filled and it will be filled automatically and can recognize all the previous variables etc. 
# cat function is like the print statement but 

## often we want the sequence to be dependent on the length of another variable 

my_dogs <- c("chow", "akita", "malamute", "husky", "samoyed")
length(my_dogs)
for(i in 1:length(my_dogs)) {
  cat("i=", i, "my_dogs[i]=", my_dogs[i], "\n")
}
# for each iteration it prints out a different element of the vector depending on what number it's on

### use double for loops 
m <- matrix(round(runif(20), digits=2), nrow=5)
m
# run a for loop to chnage the values in the matrix
for (i in 1:nrow(m)) {
  m[i,] <- m[i,] + i #take whatever value is there and overwrite the counter
}
m #adds 1 to all values in row 1 and 2 to row 2 values etc. 

## loop over columns 
m <- matrix(round(runif(20), digits=2), nrow=5) # for columns use j and for rows use i
for(j in 1:ncol(m)){
  m[,j] <- m[,j] + j
}
m # iteration addition now applied to columns rather than rows 

###### loop over rows and columns 

m <- matrix(round(runif(20), digits=2), nrow=5)

for(i in 1:nrow(m)){
  for(j in 1:ncol(m)){
    m[i,j] <- m[i,j] + i + j
  }
}
print(m) # adds index value to current value of [i,j] location 