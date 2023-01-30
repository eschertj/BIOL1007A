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

# pivot_wider
# best for making occupancy matrix 
# an occupancy matrix is having an individual and 0 or 1 if present at site 
glimpse(fish_encounters)
view(fish_encounters)

fish_encounters %>% 
  pivot_wider(names_from = station, # which columns you want to turn into multiple columns
              values_from = seen) # which column contains the values for the new column cells
# shows NA if fish wasn't seen there but 1 if was 

fish_encounters %>% 
  pivot_wider(names_from = station, 
              values_from = seen,
              values_fill = 0)
# values_fill() allows any NA to be replaced with 0 

#### Dryad: resource that makes research data freely reusable, citable, and discoverable 
# datadryad.org/search/

# read.table() after loading csv
dryadData <- read.table(file = "Data/veysey-babbitt_data_amphibians.csv", header = TRUE, sep = ",")
#can hit tab after starting to type name of file and it will auto fill
# comma seperated since is a CSV file
glimpse(dryadData)
head(dryadData)
table(dryadData$species) # allows you to see different groups of character columns
summary(dryadData$mean.hydro)

# weekly assignment is going to dryad, finding a data set that interests you, and reproducing a ggplot graph

dryadData$species <-factor(dryadData$species, labels=c("Spotted Salamander", "Wood Frog")) #creating labels to use for plot
str(dryadData$species)
p <- ggplot(data=dryadData,
            aes(x=interaction(wetland,y=count.total.adults)) +
  geom_boxplot()