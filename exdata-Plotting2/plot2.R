############################################
#                                          #
# Exploratory Data Analysis - Assignment 2 #
# by Francisco Marco-Serrano               #
#                                          #
############################################

# Read the data; file need to be in the working directory
NEI <- readRDS("summarySCC_PM25.rds")

# Calculate totals per year
require(data.table)
pm25 = as.data.table(NEI)
pm25 = pm25[ which(fips == 24510), sum(Emissions), by=year]

# Open PNG file
png(file="plot2.png", width = 480, height = 480)

# Draw the plot
plot(pm25$year, pm25$V1,
     type = "l",
     xlab = "",
     ylab = "PM2.5 Emissions (tons)",
     main = "Baltimore City, Maryland")

# Close PNG
dev.off()