dt <- fread(some_csv)

# removing every column that contains NA values
df_NA_free <- dt[, colSums(is.na(df)) == 0]
