##### Programming in R
##### 12 January 2023 
##### JWE 

# let's start with the basics

## Assignment operator: used to assign new values to a variable 

x <- 5
print(x)
x


y = 4 #legal but not used in function arguments 
print(y)
y = y + 1.1
y <- y + 1.1

## Variable: used to store information (a container)

z <- 3 #single letter variables 
plantHeight <- 10 #camel case format 
plant_height <- 3.3 #snake case format #a preferred method
plant.height <- 4.2 
. <- 5.5 #reserve for temporary variable 

square <- function(x = NULL){
  x <- x^2
  print(x)
  
}

z<-103
square(x=3)
square(x=z)

### or there are built in fucntions 
sum(109, 3, 10) ## look at package info by using ?sum on console or going into help panel


#### Atomic Vectors
# one dimensional (a single row)
# fundamental data structure

### Types
# character strings (words, typically within quotes)
# integers (whole numbers)
# double (anything with a decimal, real numbers)
# both integers and doubles are numeric 
# could be logical (true or false)
# could be factors (categorizes and puts your variable into different groups)

# c function (combines different elements and puts them as one variable)
z <- c(3.2, 5, 5, 6)
print(z) # prints and provides info on variable
class(z) #returns class of variable
typeof(z) #returns type of variable 
is.numeric(z) #returns True or false

# c() always "flattens" to a vector 
z <- c(c(3,4), c(5,6))

c(3, 2, "dog", TRUE, 4.2) #converts to lowest denomination which would be characters

# use c to create a vector or string things together 

# character vectors, doesn't have to be single words since reads whatever between () 
z <- c("perch", "bass", "trout")
print(z)
z <- c("This is only 'one' character string", "a second", "a third")
print(z)
typeof(z)
is.character(z) # usually returns true or false, tests whether it is a certain data type
# as. fucntion coerces data types
?is.character

# logical (Boolean), no quotes, all caps: TRUE and/or FALSE
z<-c(TRUE, FALSE, T, F)
z <- as.character(z).  # you could think of it as converting data types
is.logical(z)

# Length, how long the vector is (useful for long data series)
length(z)
dim(z) # NULL since only has one dimension

## Names
z <- runif(5) #gives random amount of unifrm numebers depending on how many specified
names(z)

# add names 
names(z) <- c("chow", "pug", "beagle", "greyhound", "akita") #allows us to assign names
print(z) #names get corresponded to previous random uniform values
names(z)
names(z) <- NULL #lets us reset the values 


## NA
## stands for missing data
z <- c(3.2, 3.5, NA)
typeof(z)
mean(z)
anyNA(z) #checks for any NA, returns a logical (T/F)
is.na(z) #shows the particular one that's NA
which(is.na(z)) #gives the specfic index of where the NA is

# Subsetting vectors -> giving a set of conditions for what we want from that vector 
# vectors are indexed depending on order
z <- c(3.1, 9.2, 1.3, 0.4, 7.5)
print(z)
z[4] # only returns the 4th element of the vector, use square brackets to subset by vector 
z[c(4,5)] # combines two indicies into one element such that can return two numbers back, won't work with 2 numbers in square bracket 
z[-c(2,3)] #gives me everything except the 2nd and 3rd index, minus sign excludes somenthing generally
z[-1] #excludes all but one
z==7.5 #hones in on 7.5 via double equal marks, a logical condition is an exact match via logical condition
z[z==7.5] # only gets back the one that equals 7.5
z[z<7.5] # returns all elements less than 7.5
#use logical statements within square brackets to subset by conditions 

which(z<7.5) #this will give the indicie locations 
z[which(z<7.5)] # only subsets indicies 1, 3, 4 --> z in front gives the exact value rather than indices because refers to variable itself 

#creating logical vectors 
z<7.5 

#subsetting characters (named elements)
names(z) <- c("a", "b", "c", "d", "e")
print(z)
z[c("a", "d")] #subsets just a and d

## subset function 
# sometimes is helpful if the indicies are all over the place and don't know where to start
# first argument is where tou wanna start 
susbet(x=z, subset= z>1.5)
  
# randomly smaple
# sample function lets you choose something random
story_vec <- c("A", "Frog", "Jumped", "Here")
sample(story_vec) #sample shuffles order

# randomly select 3 elements from vector 
sample(story_vec, size=3) 

story_vec <- c(story_vec[1], "Green", story_vec[2:4]) #takes first one, adds new one, then runs rest of story vec
story_vec[2] <- "Blue"
story_vec

# vector function
vec <- vector(mode="numeric", length=5)
vec #creates an empty vector

## rep and seq function, rep means repeat, will repeat is 100 times
z <- rep(x=0, times = 100) #repeat zero 100 times 
print(z)
z <- rep(x = 1:4, times=3) #giving it a sequence and asking to repeat 3 times
print(z)
z <- rep (x=1:4, each = 3) # repeats that element that amount of times 
print(z) #repeats each element 3 times without sequence syntax

z <- seq(from = 2, to = 4)
print(z)
#can give it a start and a finish value 
seq(from = 2, to =4, by =0.3) #lets your sequence go by that increment 
seq(from=1, to=length(z))
# length(z) here is 3

z <- runif(5) #runif makes 5 random number between 0 and 1
print(z)
seq(from=1, to=length(z)) #seq is now 1-5 due to the runif commit 
