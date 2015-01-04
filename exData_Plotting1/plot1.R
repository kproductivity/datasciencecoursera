####################################################
## Script for Exploratory Analysis - Assignment 1 ##
## PLOT 1                                         ##
## by Francisco Marco-Serrano (@kproductivity)    ##
####################################################

# Read data
# Data file has to be located on the working directory
path = "./household_power_consumption.txt"

# Read first 5 rows and detect column classes
power.data5 = read.table(path, header=TRUE, sep=";", nrows=5)
classes <- sapply(power.data5, class)

# Import data
power.data = read.table(path, header=TRUE, sep=";", na.strings="?", colClasses=classes)

# Subset
date1 = as.Date("2007-02-01", format = "%Y-%m-%d")
date2 = as.Date("2007-02-02", format = "%Y-%m-%d")

power.data$Date = as.Date(power.data$Date, format = '%d/%m/%Y')

power.data = subset(power.data, Date >= date1 & Date <= date2)

# Draw the histogram (show it in the screen device)
hist(power.data$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     cex.main = 0.9,
     cex.axis = 0.7)

# Copy to PNG
dev.copy(png, file = "plot1.png")
dev.off()

