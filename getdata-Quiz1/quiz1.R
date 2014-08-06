## QUIZ 1

## QUESTION 1: The American Community Survey distributes downloadable data about
## United States communities. Download the 2006 microdata survey about housing
## for the state of Idaho using download.file() from here:

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

if (file.exists('idaho.csv') == FALSE) {   # if file doesn't exist
    download.file(url, "idaho.csv")        # download and store in file
}

housing <- read.csv("idaho.csv") # retrieve in a data frame

## How many housing units in this survey were worth more than $1,000,000?
## From codebook, variable VAL (Property value) = 24

nrow(subset(housing, housing$VAL == 24))


## QUESTION 3: Download the Excel spreadsheet on Natural Gas Aquisition Program.

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"

## Need mode=wb because xls is a binary file
if (file.exists('gas.xlsx') == FALSE) {                            # if file doesn't exist
    download.file(url, "gas.xlsx", mode = "wb", method = "auto")   # download and store in file
}

## Read rows 18-23 and columns 7-15 into R and assign the result to a variable

## Sys.setenv(JAVA_HOME='C:\\Program Files (x86)\\Java\\jre7') # for Win 32-bit version
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre7') # for Win 64-bit version

require(xlsx)
rowIndex <- 18:23
colIndex <- 7:15
dat <- read.xlsx("gas.xlsx", sheetIndex = 1, rowIndex = rowIndex, colIndex = colIndex)

## Can use XLConnect instead...
require(XLConnect)
dat <- readWorksheetFromFile("gas.xlsx", sheet = 1,
                             startRow = 18, endRow = 23,
                             startCol = 7, endCol = 15)

## Result
sum(dat$Zip*dat$Ext,na.rm=T)


## QUESTION 4: Download the XMl file of restaurants from Baltimore.

# Need to remove s from https because xmlTreeParse cannot handle https.
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
  
library(XML)

doc <- xmlTreeParse(url, useInternal = TRUE) # Parse the file
rootNode <- xmlRoot(doc)                     # Create the object
xmlName(rootNode)                            # Top node/root
names(rootNode)                              # Child nodes of root
names(rootNode[[1]][[1]])                    # Show fields
names(rootNode[['row']][[1]])                # Ditto
rootNode[[1]][[1]][['zipcode']]              # Extract zipcode of first row

zipcode <- xpathSApply(rootNode, "//zipcode", xmlValue)
sum(zipcode == "21231")


## QUESTION 5: Download the 2006 microdata survey about housing for the state of Idaho.

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"

if (file.exists('idaho.csv') == FALSE) {   # if file doesn't exist
    download.file(url, "idaho.csv")        # download and store in file
}

require(data.table)
DT <- fread("idaho.csv")

## Use system.time()
DT[,mean(pwgtp15), by = SEX]
rowMeans(DT)[DT$SEX == 1];rowMeans(DT)[DT$SEX == 2]
sapply(split(DT$pwgtp15,DT$SEX),mean)
tapply(DT$pwgtp15, DT$SEX, mean)
mean(DT[DT$SEX == 1,]$pwgtp15);mean(DT[DT$SEX == 2,]$pwgtp15)
mean(DT$pwgtp15, by = DT$SEX)
