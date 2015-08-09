#Read in text file
origin <- fread("household_power_consumption.txt", na.strings="?")

# Subset the data to the dates 2007-02-01 and 2007-02-02
data <- subset(origin, Date == "1/2/2007" | Date == "2/2/2007")

# Construct the histogram
hist(as.numeric(data$Global_active_power), freq = TRUE, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# Copy 
dev.copy(png, width = 480, height = 480, file = "plot1.png")

# close the PNG device
dev.off()