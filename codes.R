dt <- fread(some_csv)

# removing every column that contains NA values
df_NA_free <- dt[, colSums(is.na(df)) == 0]

# how many 5 variables have each column in data frame?
colSums(df == 5)

# automatic discretization with package 'infotheo'
library(infotheo)
data(USArrests)
# this code automatic discretize every column by 10 equal values
nbins = 10
ew.data <- discretize(USArrests,"equalwidth", nbins)
# number of bins by square root
nbins<- sqrt(NROW(USArrests))
ew.data <- discretize(USArrests,"equalwidth", nbins)
# for equal frequency for each bin (not very useful)
ef.data <- discretize(USArrests,"equalfreq", nbins)
# global bins for every column (good for similar values in columns)
gew.data <- discretize(USArrests,"globalequalwidth", nbins)

# how to make histogram for every column in the data set
library(reshape2)
library(ggplot2)
dt <- fread(..some csv)
# doing rbind for every column
# data frame must be cleaned by id values and repetitive column
transform_data <- melt(dt)
ggplot(transform_data, aes(x = value)) +
    facet_wrap(~ variable,scales = "free_x") + 
    geom_histogram()
