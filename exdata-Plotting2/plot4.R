# Read the data; file need to be in the working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Extract SCC codes related to coal combustion
# First filter for combustion technology
pattern = "([Cc]omb)"
coal.index = grep(pattern, SCC[,7]) 
CoalSCC = SCC[coal.index, ]      

# Second refine for coal as fuel
pattern = "([Cc]oal)"
coal.index = grep(pattern, CoalSCC[,9])

# to get the list of SCC codes for coal combustion-related sources
CoalSCC = as.vector(SCC[coal.index, 1])

# Calculate totals per year
require(data.table)
pm25 = as.data.table(NEI)
pm25 = pm25[ pm25$SCC %in% CoalSCC, sum(Emissions), by=list(type, year)]

# Rename V1 (total emissions)
setnames(pm25, "V1", "emissions")

# Variable type as a factor and year as date
pm25$type = as.factor(pm25$type)
pm25$year = as.factor(pm25$year)

# Draw the plot
require(ggplot2)

# First one shows total
usa1 = ggplot(pm25, aes(x = year, y = emissions)) +
       geom_bar(stat="identity") +
       ggtitle("USA Carbon Combustion related Emissions") +
       theme(plot.title = element_text(lineheight=.8, face="bold")) +
       xlab ("") +
       ylab ("PM2.5 Emissions (tons)")

# Second one show per source    
usa2 = ggplot(pm25, aes(x = year, y = emissions)) +
       geom_bar(stat="identity") +
       facet_wrap(~type, scales = "free_y", ncol=2) +
       ggtitle("USA Carbon Combustion related\nEmissions per Source") +
       theme(plot.title = element_text(lineheight=.8, face="bold")) +
       xlab ("") +
       ylab ("PM2.5 Emissions (tons)")

# Export to PNG file as a single graph
require(gridExtra)
png(filename="plot4.png", width=480, height=480)
grid.arrange(usa1, usa2, nrow=2, ncol=1)
dev.off()

ggsave(baltimore, filename="plot4.png", width=4, height=4, dpi=100)

