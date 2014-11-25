# Read the data; file need to be in the working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Extract SCC codes related to motor vehicles, which are onroad type
pattern = "(Onroad)"
coal.index = grep(pattern, SCC[,2]) 
CoalSCC = SCC[coal.index, ]      

# to get the list of SCC codes for motor vehicles sources
CoalSCC = as.vector(SCC[coal.index, 1])

# Calculate totals per year
require(data.table)
pm25 = as.data.table(NEI)
pm25 = pm25[ (pm25$SCC %in% CoalSCC) & (fips == "24510"|fips == "06037"), sum(Emissions), by=list(fips, year)]

# Rename V1 (total emissions)
setnames(pm25, "V1", "emissions")

# Variable year as factor
pm25$year = as.factor(pm25$year)

# Draw the plot
require(ggplot2)

compare = ggplot(pm25, aes(x = year, y = emissions)) +
          geom_bar(stat="identity") +
          ggtitle("Baltimore, Maryland\nMotor Vehicle related Emissions") +
          theme(plot.title = element_text(lineheight=.8, face="bold")) +
          xlab ("") +
          ylab ("PM2.5 Emissions (tons)")

print(compare)

# Export to PNG file as a single graph
ggsave(baltimore, filename="plot5.png", width=4, height=4, dpi=100)

