####################################################
## Script for Exploratory Analysis - Assignment 1 ##
## PLOT 3                                         ##
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

# Open PNG file
png(file="plot3.png", width = 480, height = 480)

# Draw plot, first variable
plot(power.data$datetime, power.data$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     cex.lab = 1,
     cex.axis = 1)

# Add second variable
points(power.data$datetime, power.data$Sub_metering_2,
       type = "l",
       col = "red")

# Add third variable
points(power.data$datetime, power.data$Sub_metering_3,
       type = "l",
       col = "blue")

# Add legend
legend("topright", cex = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lwd = 2)

# Close the PNG file
dev.off()

