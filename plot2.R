#Read in text file
origin <- fread("household_power_consumption.txt", na.strings="?")

# Subset the data to the dates 2007-02-01 and 2007-02-02
data <- subset(origin, Date == "1/2/2007" | Date == "2/2/2007")

# Convert date and time to convert the Date and Time variables to Date/Time classes in R
#datetime <- paste(data$Date, data$Time, sep = " ")
library(dplyr)
data2 <- mutate(data, datetime = paste(Date, Time, sep = " "))

x <- as.POSIXct(strptime(data2$datetime,"%d/%m/%Y %H:%M:%S"))
data3 <- mutate(data2, x)

# Construct the line graph
plot(data3$x, as.numeric(data3$Global_active_power), xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")

# Copy 
dev.copy(png, width = 480, height = 480, file = "plot2.png")

# close the PNG device
dev.off()