####################################################
## Script for Exploratory Analysis - Assignment 1 ##
## PLOT 2                                         ##
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

# Create new variable Date+Time
power.data$datetime = strptime(paste(power.data$Date, power.data$Time),
                               format = '%d/%m/%Y %H:%M:%S') 

# Subset
date1 = strptime("2007-02-01 00:00:00", format = "%Y-%m-%d %H:%M:%S")
date2 = strptime("2007-02-02 23:59:59", format = "%Y-%m-%d %H:%M:%S")

power.data = subset(power.data, datetime >= date1 & datetime <= date2)


# Draw the plot (show it in the screen device)
plot(power.data$datetime, power.data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     cex.lab = 0.7,
     cex.axis = 0.7)

# Copy to PNG
dev.copy(png, file = "plot2.png")
dev.off()

