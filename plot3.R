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
plot(data3$x, as.numeric(data3$Sub_metering_1), xlab = "", ylab = "Energy sub metering", type = "n")
points(x, as.numeric(data3$Sub_metering_1), col = "black", type = "l")
points(x, as.numeric(data3$Sub_metering_2), col = "red", type = "l")
points(x, as.numeric(data3$Sub_metering_3), col = "blue", type = "l")

legend("topright",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       x.intersp=1.4,cex=0.8,lwd=2, col=c("black","red","blue"), lty=c(2,2,2))

# Copy 
dev.copy(png, width = 480, height = 480, file = "plot3.png")

# close the PNG device
dev.off()