#### LEcture 8: Loading in Data
### 26 January 2023
#### JWE

### write.table() #lets you specify if any data are notes
## read.csv #doesn't let you specify notes and can throw errors

# These functions read in a data set to R
# read.table(file = "path/to/data.csv", header = TRUE, sep = ",")
# sep is the sepration index, if is CSV can just put comma in quotes

## read.csv(file="data.csv", header=TRUE)

## Create a dataset via the write() functions 
## write.table(x=varName, file="outputfileName.csv", header=TRUE, sep = ",")

### Use RDS objects when only working in R
## saveRDS(my_data, file="fileName.RDS")
## readRDS("fileName.RDS")
# saving uses a variable you created in R and makes it as its own R object
# add .RDS for best practice on file name 
# p <- readRDS("fileName.RDS") 
# makes p the RDS
# helpful with large data sets


## Long versus wide data formats
# long have more rows than columns and wide has more columns than rows
# wide format = contains values that don't repeat in the ID column
# long format = contains values that DO repeat in the ID column, same individual multiple times

library(tidyverse)
head(billboard)
b1 <- billboard %>%
  pivot_longer(
    cols = starts_with("wk"), # specifies which columns you want to make longer 
    names_to = "Week", # what we want new columns of names to be which will contain the header names
    values_to = "Rank", # specifies the column name of where we want the values to be 
    values_drop_na = TRUE # removes any rows where the value = NA
  )
view(b1) # R markdown does not like view, takeout before knitting 
