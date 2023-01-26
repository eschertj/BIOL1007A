### Entering the tidyverse (dplyr)
# 23 January 2023
# JWE

## Tidyverse is a collection of packages that share philosophy, grammar (or how the code is structured), and data structures
# they use slightly different coding than what we do, supposed to be more intuitive and quicker 

## Operators: symbols that tell R to perform different operations (between variables, functions, etc)

## Arithmetic operators: + - * / ^ ~
## Assignment operator: <- 
## Logical operators: ! & | (or)
## Relational operators: == , != , > , < , >= , <= 

## Miscellaneous operators: %>% (forward pipe operator) %in% (matching operator)

# only need to install packages once 

library(tidyverse) #use this function to laod in packages not in base R

## dplyr is a newer package that provides a set of tools for manipulating data sets, names the functions for what you want to do, written to be fast, individual functions that correspond to common operations

##### The core verbs 
## filter()
## arrange()
## select()
## summarize() and group_by()
## mutate()


## built in data set
data(starwars)
class(starwars)

## Tibble: modern take on data frames 
# keeps great aspects of data frames and drops frustrating ones (change variable names)
# changes the input type 

# glimpse() is a built in function of dplyr that is better than str() of a large data set
# much cleaner 

### NAs 
anyNA(starwars) #is.na #complete.case
starwarsClean <- starwars[complete.cases(starwars[,1:10]),]
glimpse(starwarsClean)
anyNA(starwarsClean[,1:10])

## filter(): picks and subsets observations (ROWS) by their values 

filter(starwarsClean, gender == "masculine" & height < 180)
filter(starwarsClean, gender == "masculine", height < 180 & height > 100) # multiple conditions for the same variable 

## %in% operator is a matching operator that's similar to the == operator but you can compare vectors of different lengths which you can't do with ==

# sequence of letters 

a <- LETTERS[1:10]
length(a)

b <- LETTERS[4:10]
length(b)

## output of the %in% operator depends on what the first vector is 
a %in% b
b %in% a

# use %in% to subset 
eyes <- filter(starwars, eye_color %in% c("blue", "brown"))
view(eyes)


### arrange reoders rows, similar to the sort function
arrange(starwarsClean, by=height)
# defualt is ascending order
# can use a helper function desc() 
arrange(starwarsClean, by=desc(height))

arrange(starwarsClean, height, desc(mass))
# second variable used to break ties from the first variable 

sw <- arrange(starwars, by=height)
tail(sw) ## missing values are at the end 

#### select(): chooses variables (COLUMNS) by their names 
select(starwarsClean, 1:11)
select(starwarsClean, name:species)
select(starwarsClean, -(films:starships))
starwarsClean[,1:11]
## all of the above lines do the same thing

### Rearrange columns via select()
select(starwarsClean, name, gender, species, everything())
## everything() is a helper function that's useful if you have a couple variables you want to move to the beginning 

# contains() helper function 
select(starwarsClean, contains("color"))
# subsetted everything with the word color in it
# others include ends_with() , starts_with() , num_range() -> all of these help you select column names that you want to subset 

# select can also rename columns 
select(starwarsClean, haircolor = hair_color) #returns only renamed column
rename(starwarsClean, haircolor = hair_color) #returns only whole data frame

starwarsClean

#### mutate(): creates new variable using functions of existing variables 
# let's create a new column that is hight divided by mass 
mutate(starwarsClean, ratio = height/mass)

starwars_lbs <- mutate(starwarsClean, mass_lbs = mass*2.2)
starwars_lbs
starwars_lbs <- select(starwars_lbs, 1:3, mass_lbs, everything())
starwars_lbs
glimpse(starwars_lbs)
#brought mass in lbs to the front using select()

# want.a new data frame with only our new mutated function therefore use transmute()
transmute(starwarsClean, mass_lbs=mass*2.2) 
#only returns mutated columns 
transmute(starwarsClean, mass, mass_lbs=mass*2.2, height)

starwars_lbs <- mutate(starwarsClean, mass_lbs=mass*2.2, .after=mass)
starwars_lbs # must use . before argument so it recognizes it as an argument and not another name 
glimpse(starwars_lbs)

#### group by and summarize functions 
# group_by() and summarize() are better if used togehter but can be used seperately
summarize(starwarsClean, meanHeight = mean(height))
summarize(starwarsClean, meanHeight = mean(height, na.rm=T))
# above do the same thing, bottom requries na.rm
# throws NA if any NAs are in df = need to use na.rm

summarize(starwarsClean, meanHeeight=mean(height), TotalNumber = n())
# best to use group_by for maximum usefulness 
starwarsGenders <- group_by(starwars, gender)
head(starwarsGenders)

summarize(starwarsGenders, meanHeight=mean(height, na.rm=T), TotalNumber=n())
# to compare different subgroups within a column via group_by 
# head() lets you see the first 6 rows

### Piping -> taking the output of one function and using it as the input of the next function
# Piping %>% is used ti emohasize a sequence of actions 
# allows you to pass an intermdiate result onto the next function 
# avoid if you need to manipulate more than one object/variable at a time, or if you have meaningful intermediate variables 
# formatting: should have a space before the pipe %>% followed by a new line 
# start with the variables you want to conduct code on
 starwarsClean %>% 
   group_by(gender) %>%
   summarize(meanHeight=mean(height, na.rm=TRUE), TotalNumber = n())

 ## more complex coding: 
 ## case_when() is useful for multiple if/ifelse statements 
 starwarsClean %>%
   mutate(sp = case_when
          (species == "Human" ~ "Human",
            TRUE ~ "Non-Human"))
# syaing a condition, ~ says what to put in that column if it's true and the other ~ for what to put in the column is not true 
 # uses confition and puts "Human" if True in sp column, puts "non-Human" if it's FALSE and not human    