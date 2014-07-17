## QUESTION 1:
##

require(httr)

# Find OAuth settings for github: http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# Register an application at https://github.com/settings/applications
# Use http://localhost:1410 as the callback url
myapp <- oauth_app("github", "5870aa8d1b398ae65111",
                   "bd14d3ff7c15e2b4e2bb374e704cadcdff20b171")

# Get OAuth credentials
require(httpuv)
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
req # JSON file; still needs to be parsed, though

# OR...
# Read JSON file
require(jsonlite)

jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
subset(jsonData,name=="datasharing")["created_at"]


## QUESTION 2: Which of the following commands will select only the data for
## the probability weights pwgtp1 with ages less than 50?

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url,"acs.csv")

acs <- read.csv("acs.csv")

library(sqldf)
sqldf("select pwgtp from acs where AGEP < 50")


## QUESTION 4:
##

con = url("http://biostat.jhsph.edu/~jleek/contact.html") # set the connection
htmlCode = readLines(con)                                 # read the html code
close(con)                                                # close the connection

biolist <- c(10, 20, 30, 100)
nchar(htmlCode[biolist])


## QUESTION 5:
##

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(url,"wks.for")
mywidth <- c(10, -5, 4, 4, -5, 4, 4, -5, 4, 4, -5, 4, 4) # define the widths of the cols
wks <- read.fwf("wks.for", mywidth, skip = 4)
sum(wks[,4])
