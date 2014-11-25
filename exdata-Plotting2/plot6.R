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

# Variable year and fips as factor
pm25$year = as.factor(pm25$year)
pm25$fips = as.factor(pm25$fips)

# Draw the plot
require(ggplot2)
require(scales)

compare = ggplot(pm25, aes(x = year, y = emissions, group = fips, shape = fips)) +
          geom_line() +
          geom_point() +
          ggtitle("Motor Vehicle related Emissions: Baltimore City vs LA County") +
          theme(plot.title = element_text(lineheight=.8, face="bold")) +
          xlab ("") +
          scale_y_continuous(trans=log2_trans()) +
          ylab ("log PM2.5 Emissions (tons)") +
          scale_shape_discrete(name="county",
                        breaks=c("06037", "24510"),
                        labels=c("LA County", "Baltimore City"))

print(compare)

# Export to PNG file as a single graph
ggsave(compare, filename="plot6.png", width=8, height=4, dpi=100)

