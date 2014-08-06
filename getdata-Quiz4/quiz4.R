## Quiz 4
##
## Script supporting quiz 4 answers

##############
# Question 1 #
##############

# read data
if (file.exists('idaho.csv') == FALSE) {
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    download.file(url, "idaho.csv")
}

household.data <- read.csv("idaho.csv")

# split names
splitnames <- strsplit(names(household.data), "wgtp")
splitnames[123]


##############
# Question 2 #
##############

# read data
if (file.exists('gdp.csv') == FALSE) {
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
    download.file(url, "gdp.csv")
}

gdp <- read.csv("gdp.csv", skip = 5, header = FALSE, nrows = 190)

# clean data
gdp <- gdp[, c(1, 2, 4, 5)]
names(gdp) <- c("id", "gdprank", "country", "gdp")

# remove commas (more than 1, so use gsub)
gdp.vector <- gsub(",", "", gdp$gdp)

# calculate mean
mean(as.numeric(gdp.vector))


##############
# Question 3 #
##############

countryNames <- gdp$country
united <- gdp[grep("^United", countryNames),]
nrow(united)


##############
# Question 4 #
##############

# read data
if (file.exists('edu.csv') == FALSE) {
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
    download.file(url, "edu.csv")
}

edu <- read.csv("edu.csv")

# merge both data frames using the country id
merged.data <- merge(gdp, edu, by.x = "id", by.y = "CountryCode")

# detect countries with fiscal year end info, for June
specialnotes <- merged.data$Special.Notes
specialnotes <- merged.data[grep("Fiscal year end: June", specialnotes), ]

nrow(specialnotes)


##############
# Question 5 #
##############

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 

library(lubridate)
sampleTimesYear = year(sampleTimes)
sampleTimesWeekday = wday(sampleTimes)
xt = xtabs( ~ sampleTimesYear + sampleTimesWeekday, sampleTimes)
xt
