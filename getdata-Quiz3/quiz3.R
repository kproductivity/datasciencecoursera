## QUIZ 3
##
## Supporting code for answering Quiz 3.


##############
# Question 1 #
##############

# read data
if (file.exists('idaho.csv') == FALSE) { # if file does not exist
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    download.file(url, "idaho.csv")      # download from source
}

household.data <- read.csv("idaho.csv")

# identify households with more than 10 acres which sold more than $10K agricultural products
agricultureLogical <- household.data[which(household.data$ACR == 3 &
                                           household.data$AGS == 6), ]
  
# show first 3 results
row.names(agricultureLogical)[1:3]


##############
# Question 2 #
##############

# read data
if (file.exists('image.jpg') == FALSE) {        # if file does not exist
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
    download.file(url, "image.jpeg", mode="wb") # download from source
}

require('jpeg')
picture <- readJPEG("image.jpeg", native=TRUE)

# quantiles 30 and 80
quantile(picture, c(0.30, 0.80))


##############
# Question 3 #
##############

# read data
if (file.exists('gdp.csv') == FALSE) {
    url.gdp <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
    download.file(url.gdp, "gdp.csv")
}
if (file.exists('edu.csv') == FALSE) {
    url.edu <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
    download.file(url.edu, "edu.csv")
}

gdp.data <- read.csv("gdp.csv", skip = 5, header = FALSE, nrows = 190)
edu.data <- read.csv("edu.csv")

# clean data
gdp.data <- gdp.data[, c(1, 2, 4, 5)]
names(gdp.data) <- c("id", "gdprank", "country", "gdp")

# merge both data frames using the country id
merged.data <- merge(gdp.data, edu.data, by.x = "id", by.y = "CountryCode")
nrow(merged.data) #show how many of the ids matched

# sort in descending order by gdprank
merged.data <- merged.data[order(merged.data$gdprank, decreasing = TRUE), ]
merged.data$country[13]


##############
# Question 4 #
##############

aggregate(gdprank ~ Income.Group, merged.data, mean)


##############
# Question 5 #
##############

# divide data frame in 5 equal groups, each one with 38 countries
group.labels <- c("high rank", "mid-high", "mid-mid", "mid-low", "low rank")
group.data <- cut(merged.data$gdprank, 5, group.labels)

# create a cross-tab indicating frequencies between group.data and income.group
xt <- xtabs(~ merged.data$Income.Group + group.data, merged.data)
xt

