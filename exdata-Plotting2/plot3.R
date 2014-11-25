# Read the data; file need to be in the working directory
NEI <- readRDS("summarySCC_PM25.rds")

# Calculate totals per year
require(data.table)
pm25 = as.data.table(NEI)
pm25 = pm25[ which(fips == 24510), sum(Emissions), by=list(type, year)]

# Rename V1 (total emissions)
setnames(pm25, "V1", "emissions")

# Variable type as a factor and year as date
pm25$type = as.factor(pm25$type)
pm25$year = as.factor(pm25$year)

# Draw the plot
require(ggplot2)

v1999 = pm25[ which(pm25$year == "1999"), ]
v1999 = v1999[order(v1999$type), ]

baltimore = ggplot(pm25, aes(x = year, y = emissions)) +
            geom_bar(stat="identity") +
            facet_wrap(~type, scales = "free_y", ncol=2) +
            ggtitle("Baltimore City, Maryland\nEmissions per Source") +
            theme(plot.title = element_text(lineheight=.8, face="bold")) +
            xlab ("Dotted line shows 1999 levels") +
            ylab ("PM2.5 Emissions (tons)") +
            geom_hline(data = v1999, aes(yintercept=v1999$emissions),
                       colour="#990000", linetype="dashed")  # 1999 base line
            

print(baltimore)

# Export to PNG file
ggsave(baltimore, filename="plot3.png", width=4, height=4, dpi=100)

