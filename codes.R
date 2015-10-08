dt <- fread(some_csv)

# removing every column that contains NA values
df_NA_free <- dt[, colSums(is.na(df)) == 0]

# how many 5 variables have each column in data frame?
colSums(df == 5)


