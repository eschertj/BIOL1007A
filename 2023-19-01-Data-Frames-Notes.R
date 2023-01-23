####### Finishing up matricies and data frames 
# 19 January 2023
# JWE


m <- matrix(data = 1:12, nrow=3)

# subsetting based on elements 
m[1:2. ]. 
# colon can be used as a sequence statement to narrow down the specific rows or columns 
print(m)
m[, 2:4]. 

# subset with logical (conditional) statements 
# select all columns for which totals are > 15

colSums(m) >15
m[,colSums(m)>15]

## rowSums() now
## select rows that sum up to 22 (want an exact amount)
m[rowSums(m)==22, ]

m[rowSums(m)!=22,]

## Logical Operators: == , != , > , <

# subsetting the vector changes the data type
z <- m[1,]
print(z)
str(z)
# an argument can be used to keep it as a matrix

z2 <- m[1, , drop=FALSE]
# the extra argument beyond row, columns, is drop=FALSE (which keeps the data structure as its structure)
str(z2)
class(z2)
class(z)

# simulate new matrix
m2 <- matrix(data = runif(9), nrow=3)
m2
# make sure to subset with both indicies 
m2[6]

m2[3,2]

## use assignment operator to Substitute values 
m2[m2 > 0.6] <- NA
m2


data <- iris
head(data)
tail(data)

data[3,2] # numbered indicies still work 

dataSub <- data[,c("species", "Petal.Length")]


## Sort a data frame by values 
orderedIris <- iris[order(iris$Petal.Length),]
# order function tells us to sort the rows by Petal Length, that's why it's in the row indicie
# gives each element an order number
head(orderedIris)
# how to sort and order like you would in Excel 

######### Functions in R

# everything in R is a function pretty much 
sum(3,2)
3+2
# sum is a function and the plus sign is also a function
# to see the code for a function, run it and in the console you'll see what it's doing 

## User defined functions 


functionName <- function(argX=defaultX, argY=defaultY){x <- 1}
# the { } starts the body of a function where you can insert lines of R code and notes and local variables
# if you create a varaible within a function it is only visible to R within the function 
# argX <- c("IDK")
  # to save to a variable 
# the function() in the parentheses is anything you want to adjust 
# return(z)
# when we print somthing the function shows us what is in that variable 
# you can use print within a fucntion but that can create problems therefore we want the return function, to get things out from the function 



myFunc <- function(a=3, b=4){
  z <- a + b
  return (z)
}
myFunc()
z <- myFunc()
z
# run with open parentheses, it runs the default
# functions allow you to change the initial argument to whatever 
# functions are powerful by allowing you to change values and run eveything
myFunc(a=100, b=3.4)
myFunc

myFuncBad <- function(a=3){
  z <- a + b
  return(z)
}
myFuncBad # doesn't work 

# the or symbol is | and if statements have {} too

### Multiple Return statements
####################################################
# best way to create a function is to annotate it via hashtags 
# say function name 
# Function Name: HardyWeinberg 
# input: all allele freqeuncy p (0,1)
# output: p and the frequencies of 3 genotypes AA AB BB
#--------------------------------------------------

HardyWeinberg <- function(p = runif(1)){
  if(p > 1.0 | p < 0){
    return("Function failure: p must be between 0 and 1")
  }
  q <- 1 - p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
  vecOut <- signif(c(p=p, AA=fAA, AB=fAB, BB=fBB), digits=3)
  return(vecOut)
}
#########################################################

HardyWeinberg()
freqs <- HardyWeinberg()
freqs
HardyWeinberg(p=3)

# if statements need a condition statement first and then have squigly brackets after 

## ## Create a more complex default value 
##########################################
# FUNCTION: fitlinear2
# fits a simple regression line
# Input: numeric list (p) of predictor (x) and response (y) the 2 different elements
# outputs: slope and p-value 

fitlinear2 <- function(p=NULL){
  if(is.null(p)){
    p <- list(x=runif(20), y=runif(20))
  }
  myMod <- lm(p$x~p$y)
  myOut <- c(slope= summary(myMod)$coefficients[2,1],
             pValue = summary(myMod
)$coefficients[2,4])
  plot(x=p$x, y=p$y) # quick plot to check output
  return(myOut)
}
fitlinear2() #simulates p for us when p=NULL
myPars <- lit(x=1:10, y=runif(10))
fitlinear2(p=myPars)
# allows you to run 2 values or if NULL it will create 2 values for you

## to troubleshoot, check your code line-by-line it's probably just a small syntax error, usually 


# running the individual variables for the function puts it into global memory and allows it to be runned
# we want to save the output of a function


str(iris)
typeof(iris)
class(iris)
