dt <- fread(some_csv)

# how to sort data.table by dates
dt[order(time_column)]

# great crossTable wit package Rz
library(Rz)
tab <- crossTable(test$target_event, dt$col1)
summary(tab)

# how to make Cross Table? By SAS library(gmodels) like a table function
library(gmodels)
CrossTable(dt$target_event, dt$col1)

# perfect package for grouping data with selected attribute
library(zoo)
obj <- zoo(dt$feature, dt$target_event) # obj is "zoo" class

# how to select date in some period of time?
dt[as.Date(time) > "2015-09-24" & as.Date(time) < "2015-10-15", ]

# select first 10 row by each unique variable in column (by date)
best <- do.call(rbind, lapply(split(dt, dt$time), head, 10))
# or
best <- ddply(dt, .(time), function(x) head(x, 10))

# how to greatly describe data.table with all columns?
library(Hmisc)
describe(dt)

# do table with percentage
prop.table(table(dt$col1, dt$target))*100

# find row index where all rows in data.table are NA
rm.rows <- which(apply(all, 1, function(x) { all(is.na(x)) } ))

# how to change all names in data.table - without 'count_'
name <- gsub("count_", "", names(dt))
setNames(dt, names(dt), name)

# remove multiple columns by grep
remove = c("col1|col2|col3")
dt <- dt[, !grep(remove, names(test.cat), value=T), with = F]

# how extract values from function into list - [[]] is important !!!
feat <- list()
for (i in 1:ncol(dt)) {feat[[i]] <- fun(dt[[i]], dt$target_event)}
# or using lapply
feat <- lapply(seq(dt), function(x) fun(dt[[x]], dt$target_event))

# how to assign names from data.table into list 
names(feat.list) <- names(dt) 

# how to rename multiple variables into one variable in one column of data.table
name <- c("name1", "name2", "name3")
dt <- dt[ col1  %in% name, col1 := "hot authors"]

# multiple plot for every column finding correlation
pairs(dt)

# how many numeric columns is in the data.table?
# numric is num and int
counts = sum(unlist(dt[, lapply(.SD, is.numeric)]))

# remove attributes with more than 95% NA values
clean.dt <- dt[, unlist(lapply(dt, function(x) !sum(is.na(x)) >
                               0.95*(nrow(dt)))), with=F]

# chisq.test for every column (must NA omit each column for test)
features <- lapply(dt, function(x) as.numeric(na.omit(x)))
chi <- sapply(features, function(x) chisq.test(x))

# how to find differences in string names of two vectors?
diff  <- setdiff(names(vector1), names(vector2))

# extract columns as vector from data.table
dt[['column_name']]
# or
name <- names(dt)
dt[[name[1]]]

# how to find NA values and replace it with 'NULL'?
na <- all[, lapply(.SD, is.na)] # true false in NA for every row in all data.table
invisible(lapply(seq(na), function(x) all[na[[x]], names(all)[x] := 'NULL']))

# how to replace all NA in data.table to specific value?
dt[is.na(dt)] <- 'null'
dt[is.na(dt)] <- 0

# how to replace NA in existing column to string "Others"
dt[is.na(column), column := "Others"]

# discretize every column in data.table by 5 equal parts !!! 
dt <- dt[, lapply( .SD, function(x) cut2(x, g =5)), ]

# find differencies in two vectors (for example strings)
setdiff(vector1, vector2)

# removing every column that contains NA values
df_NA_free <- dt[, colSums(is.na(df)) == 0]

# convert all columns into factor
dt <- dt[, lapply( .SD, as.factor), ]

# how many 5 variables have each column in data frame?
colSums(df == 5)

# find all negative values in data.table - boolean
dt[, lapply(dt, function(x) x < 0)]

# how many negative values are in data.table columns?
dt.num[, colSums(dt.num < 0, na.rm = T)]

# where is negative values in data.table columns?
dt.num[, colSums(dt.num < 0, na.rm = T) > 0]

# Unique values per column
dt[, lapply(.SD, function(x) length(unique(x)))]

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
