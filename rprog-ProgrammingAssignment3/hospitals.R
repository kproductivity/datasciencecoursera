# Opens file; it must be in the working directory
# colClasses coerces the data to be read as a certain type
outcome <- read.csv("outcome-of-care-measures.csv", colClasses="character")

############
## Part 1 ##
############

# Shows beginning of the file
head(outcome)

# Shows number of columns and rows
ncol(outcome)
nrow(outcome)

# Extracts values from variable 11 (30-day death rates from hearth attack)
# transforming it into a numeric variable
outcome[, 11] <- as.numeric(outcome[, 11])

# Obtains the histogram
hist(outcome[, 11])
