#### Vectors, Matricies, Data Frames, and Lists
# 17 January 2023 
## JWE

## Vectors (Continued) 
# Properties

# Coercion 


# All atomic vectors are of the same data type
# If you use c() to assemble different types, R coerces them 
# logical -> integer -> double -> character
# predict what data type it gets coerced into must know what types are already in the vector, it'll convert to the base data type 

a <- c(2, 2.2)
# 2 is an integer and 2.0 is a double therefore it'll be coerced into a double 
a

b <- c("purple", "green")
# these are both characters in a character string 
typeof(b)

d <- c(a,b)
print(d)
# the former doubles will be inserted with quote marks such that are characters, a list is required to retain the data type
typeof(d)

# comparison operators yield a logical result 
# let's overwrite a into some random uniform numbers 
a <- runif(10)
print(a)

a > 0.5 #conditional statement 

# can run operations on conditional statements
# How many elements in the vector are >0.5
sum (a > 0,5)
# reads through the logical T/F and sums up the number of trues 

mean (a >0.5)
# yields a proportion of what vectors are greater than 0.5, looks at how many trues and creates representation of that value versus total

### Vectorization
# Add a constant to a vector and it applies the value to all elements of the vector 

z <- c(10, 20, 30)
print(z)

z + 1
# adds one to each element in the vector without specifying indicies 

# what happens when vectors are added together 
y <- c(1, 2, 3)

z + y
# this goes element by element and sums everything up as an operation on the vector 
# done for easy statistical analysis this way 

z^2
# returns everything in z squared 

### Recycling, done for vectors of unequal lengths 
# what if vector lengths are not equal? 

z
x <- c(1,2)
z+x
# it will add as many elements as can, once reaches the end of shorter vector it restarts to the beginning to add first value and keeps going (recycling)
# the shorter vector is always recycled 
# essentially what's done for vectorization (uses one vector over again)
# warning is issued but a calculation is still made 

## simulating data: runif and rnorm()

runif(5)
runif(n=5)
# same functionality 

runif(n=5, min=5, max=10)
# n is the sample size here
# randomly generated but can be set with a seed

set.seed(123) # set. seed can have any numbers in the () 
# done to reproduce random numbers you generated
# sets the random number generator and is reproducbible 
runif(n=5, min=5, max=10)
# can be random in a specific way that's reproducible 
hist(runif(n=5, min=5, max=10))
# no peaks, flat, per definition of histogram 


## rnorm: random normal values with a mean 0 and sd 1 (default)
rnorm(6) 
# 6 is 6 random numbers with a mean of 0 and sd of 1 (standard dev)

#to set it 
randomNormalNumbers <- rnorm(100)
mean(randomNormalNumbers)
# hist function shows the distribution of anything 

sd(randomNormalNumbers)
hist(randomNormalNumbers)

rnorm(n=100, mean=100, sd=30)
hist(rnorm(n=100, mean=100, sd=30))
# to set the mean and sd to see a non-std dev
# good for data simulation

##### Matrix 
## 2 dimensional with rows and columns 
# homogenous (only one type of data is allowed in the matrix, usually filled with numerics [integers and doubles])
# a matrix can be a combination of vectors 

# a matrix is an atomic vector organized into rows and columns 
my_vec <- 1:12
# making a variable, my_vec
# colon generates an automatic sequence (between 1 and 12)

# can arrange this into rows and columns via the matrix function
m <- matrix(data = my_vec, nrow = 4)
m

# to specify number of columns rather than row, vector goes downward to fill in the column first 
m <- matrix(data = my_vec, ncol = 4)
m

# still one vector, fills in across
m <- matrix(data = my_vec, ncol =3, byrow=TRUE)
m

# default is byrow = false, byrow=true means fill in values across rather than as columns
# byrow= TRUE is a logical function argument 

#### Lists
# are like atomic vectors BUT each element can hold different data types and different sizes 

mylist <- list(1:10, matrix(1:8, nrow = 4, byrow = TRUE), letters[1:3], pi)
mylist
class(mylist)
str(mylist)
# see that each element retains its data type

## Subsetting Lists
# subsetting a list with just one pair of square brackets gives you a single item but not the elements 
mylist[4]
# what if we want to use the element?
mylist[4] -3
# this won't work because this list is still in its compartment via [ ], can't use anything

# [ ] gives you only elements in the slot which is always type list 
# get the value within the lsit via double brackets 

# to grab the object itself, use [[]]
mylist[[4]]
# result looks like a vector no more [[1]] and [1] pi, just [1] pi

mylist[[4]] -3 
# can now do arithmetic since its accessing that object within the list 

# if we just want the matrix we would need to do mylist[[2]]
mylist[[2]]
mylist[2]

# can't work with a list just elements inside the list 

## Two-Dimensional Subsetting
mylist[[2]][4,1]
# call the list first, double brackets to extract element from 2nd copartment, inside 2nd compartment is a vector therefore use [row, column] bracket to retrieve matrix item


# to obtain multiple compartments of list 
mylist[c(1,2)]

# to obtain multiple elements within the list 
c(mylist[[1]], mylist[[2]])

# for example:
letters
pi

### Name list items when they're created 
mylist2 <- list(Tester = FALSE, littleM = matrix(1:9, nrow=3))
mylist2
# each compartment of the lsit has its own name as represented by $

mylist2$Tester
# if someting auto fills and its correct then hit tab to fill
# $ is used for named slots, accesses named elements 
# allows you to focus in on a list compartment 

mylist2$littleM[2,3]
# include [row, coumn] locator to specify exact matrix value 
# extracrs second row, 3rd column of little m

mylist2$littleM[2,]
# do comma and then leave blank since R WILL KNOW that we want all elements after the first thing specified [2nd row, all columns]
mylist2$littleM[2]
# give it just number with no commas, it'll take the element into the matrix 
# gives the second element 

##### We can use unlist to string lists back to vectors 
unRolled <- unlist(mylist2)
unRolled
# note how false got converted to zero via tester, via the binary system 

# All outputs of linear regression are in lists 

# head() is a function that lets you see first 6 rows
data(iris)
head(iris)
# use plot() to visualize relation
plot(Sepal.Length ~ Petal.Length, data = iris)
# run this and we get a basic plot
# with formulas in plot it's always y-variable ~ x-variable 
# we can do a linear regression to see if was statistically significant 
# make a variable called model 
# estimate is whatever the predicted slope is for the relationship between petal and stepal length
model <- lm(Sepal.Length ~ Petal.Length, data = iris)
# lm() is for linear model
results <- summary(model)
# summary makes it simialr to Excel demonstration
results
# results gives p value 

# for linear regression testing relation of petal length and sepal length, we don't care about the intercept we care about the p value [Pr(>|t|)]

str(results)
# gives us everything 

results$coefficients
# zooms in

coefficients <- unlist(results$coefficients) # won't work because this is now a matrix
# to confirm is matrix do:
class(results$coefficients)
# answer is matrix and array, can't unlist a non-list
coefficients
p <- coefficients[2, 4]
p

##### Data Frames 
# equal-lengthed vectors, each of which is a column (pretty much like a list but not really)
# different types of data put together in different columns 

varA <- 1:12
varA
varB <- rep(c("Cpn", "LowN", "HighN"), each=4)
varB
# repeats each character 4 times 
# this results in a character string 

varC <- runif(12)
# data frames must be equal lengths, doensn't automatically throw in NA therefore will be error 

dFrame <- data.frame(varA, varB, varC, stringsAsFactors = FALSE)
# previously all character strings in a data frame were made as factors (grouped), FALSE ensures this doesn't happen
print(dFrame)
str(dFrame)
#structure spelled out isn't a function! 

### add another row
# need a list for different types of data unlike a vector 
newData <- list(varA=13, varB= "HighN", varC = 0.668)
newData
# this list retains the different data types, can confirm the different data types via str() but visually is fine since no quotes 

# function to add a new row is rbind()
dFrame <- rbind(dFrame, newData)
dFrame

## why can't we use c?
newData2 <- c(14, "HighN", 0.668)
dFrame <- rbind(dFrame, newData2)
dFrame
# all character types now, verified via structure function
str(dFrame)
# chr next to all variables = covnerted to lowest data structure

## Add a column
newVar <- runif(14)
newVar

# use cbind() function to add column 
dFrame <- cbind(dFrame, newVar)
head(dFrame)

# dim() function checks to see how many rows and columns you have 


### Data Frames versus Matricies
zMat <- matrix(data=1:30, ncol=3, byrow=TRUE)
zMat
zDFrame <- as.data.frame(zMat)
# as() functions coerece something into being a different structure
zDFrame
# named V because it's currently unnamed 
str(zDFrame)
zMat[3,3]
zDFrame[3,3]

# All rows but just 3rd column
zMat[,3]. 
zDFrame[,3]. 
zDFrame$V3. 
zDFrame["V3"]
# the " " also work but $ is better 

# 3rd row of matrix and data frame
zMat[3,]. 
zDFrame[3,].  

# matrix is a vector therefore its 3rd element is a single element, a data frame is a list therefore its 3rd element is the entire 3rd column
zMat[3]
zDFrame[3]


##### To eliminate NAs from Data Structures

# complete.cases() function can accomplish this 
zD <- c(NA, rnorm(10), NA, rnorm(3))
zD
complete.cases(zD)
#gives a logical output, TRUE when present

# many data sets already have NAs wouldn't neccesarily wanna create one with them tho
# rnorm is normal number generator 

# To Clean Out NAs
zD[complete.cases(zD)]
# This function puts are T/F vector and removes all the NAs to form a compelte vector 
which(!complete.cases(zD))
# The ! is done to find the NAs because the compelte cases gives what is NOT the NAs, this ! lets us find which is not a compelte case (an NA)

# Matrix
m <- matrix(1:20, nrow=5)
m
m[1,1] <- NA
# [ ] lets us specify a slot with the assignment operator <- 
m
# The first slot we specifed is now NA
m[5, 4] <- NA
m
complete.cases(m)
# gives the whole row which is different tha is NA, this gives T/F on if whole row is complete

# To subset only rows that are complete use m[complete.cases(m),] 
# comma at end gives all columns but only rows with compelte cases 

m[complete.cases(m),]

## get complete cases for only certain rows 
m[complete.cases(m[,c(1:2)]),]
# without the last comma it'll just return the vector, adding it returns a matrix, it looks at matrix and focuses on first 2 columns and end with comma to get all columns that meet that condition, 
# we're giving it a subset matrix that's within the condition of the first 2 columns, we didn't specify column 4 since it contains an NA
# helpful for analysis data in just 2 columns but you want to tell the complete story

