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

# Display with the 2 x 2 panel graphics
par(mfrow = c(2, 2))

# Construct the 2X2 line graphs
plot(data3$x, as.numeric(data3$Global_active_power), xlab = "", ylab = "Global Active Power", type = "l")

plot(data3$x, as.numeric(data3$Voltage), xlab = "", ylab = "Voltage", type = "l")

plot(data3$x, as.numeric(data3$Sub_metering_1), xlab = "", ylab = "Energy sub metering", type = "n")
points(x, as.numeric(data3$Sub_metering_1), col = "black", type = "l")
points(x, as.numeric(data3$Sub_metering_2), col = "red", type = "l")
points(x, as.numeric(data3$Sub_metering_3), col = "blue", type = "l")

legend("topright",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       x.intersp=0.1,cex=0.3,lwd=2, col=c("black","red","blue"), lty=c(2,2,2))

plot(data3$x, as.numeric(data3$Global_reactive_power), xlab = "", ylab = "Global_reactive_power", type = "l")
# Copy 
dev.copy(png, width = 480, height = 480, file = "plot4.png")

# close the PNG device
dev.off()