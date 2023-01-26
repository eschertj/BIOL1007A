#### ggplot 2
### 24 January 2023
### JWE 

library(ggplot2)
library(ggthemes)
library(patchwork)

#### Template for ggplot code
### ggplot(data=<DATA>, mapping = aes(x= xVar, y = yVar)) + 
### <GEOM FUNCTION> ##geom_boxplot()
### print(p1)

### Load in a built-in data set 
data(mpg)
d <- mpg
str(mpg)

library(dplyr)
glimpse(d)

### qplot: quick, plotting
qplot(x=d$hwy)

qplot(x=d$hwy, fill = "darkblue", color = "black")
# I function around the colors for it to properly recognize it 
qplot(x=d$hwy, fill = I("darkblue"), color = ("black"))

# scatterplot 
qplot(x=d$displ, y=d$hwy, geom = c("smooth", "point"))
# here geom is an argument, wihtout the heom there would be no curve or somoothness

# to plot a linear model
qplot(x=d$displ, y=d$hwy, geom = c("smooth", "point"), method="lm")

# boxplot
qplot(x=d$fl, y=d$cty, geom = "boxplot", fill = I("forestgreen"))

# bar plot
qplot(x= d$fl, geom ="bar", fill=I("forestgreen"))

### Create some data (specified counts)
x_trt <- c("control", "low", "high")
y_resp <- c(12, 2.5, 22.9)
qplot(x=x_trt, y=y_resp, geom="col", fill=I(c("forestgreen", "slategray", "goldenrod")))

#### ggplot uses data frames instead of vectors (like 1plot did)

p1 <- ggplot(data=d, mapping=aes(x=displ, y=cty, color=cyl))
p1
# if just run above it's a blank plot, we need to add a + sign at the end
# uses data frames without having to sopecify columns each time

p1 <- ggplot(data=d, mapping=aes(x=displ, y=cty, color=cyl)) + geom_point()
p1

# best practice to save the main plot as a variable and add plot arguments to it after

p1 + theme_base()
# changes the background of the plot

p1 + theme_bw()
# black and white grid lines underneath

p1 + theme_classic()
# different margins

p1 + theme_linedraw()

p1 + theme_dark()
# dark background dim

p1 + theme_minimal()
# no axis marks

p1 + theme_void()
# nothing but the points

p1 + theme_economist()
# econ type plot 

p1 + theme_bw(base_size = 30, base_family = "serif")
# how to change the font size and the font type 

p2 <- ggplot(data=d, aes(x=fl, fill=fl)) + geom_bar()
p2
## can add argument below that flips coordinates such that x-axis is now on y
p2 + coord_flip() + theme_classic(base_size = 15, base_family = "sans")

# Theme modifications 
p3 <- ggplot(data=d, aes(x=displ, y=cty)) + geom_point(size=4, shape=21, color="magenta", fill="black") + xlab("Count") + ylab("Fuel") + labs(title = "My title here", subtitle = "my subtitle goes here") # x= and y = for axis 
p3
# to change points must make sure the shape has color and fill (shape 21 allows you to change both)

# to get 1 to 10 for x-axis
p3 + xlim(1, 10) + ylim(0, 35)

ggplot(data=d, aes(x=class, y=hwy, fill=class)) + geom_boxplot() 

# to manually change the color of the boxplot 
library(viridis)
cols <- viridis(7)
# plasma, turbo, viridis are other options
ggplot(data=d, aes(x=class, y=hwy, fill=class)) + geom_boxplot() + scale_fill_manual(values=cols)


library(patchwork)
# patchwork puts graphs together in a nice way
p1 + p2 + p3
# puts them in same row

# puts on top of another /
p1 / p2 / p3

# to group them 
(p1 + p2) / p3

# patchwork creates mosaic graphs




