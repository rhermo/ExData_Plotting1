## file: plot4.R
## author: Raul Hermosa
## date: Jan 3, 2017
## description: load and plot4.png generation

fileURL <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "power.zip", mode="wb")

#Initial calculation of size in memory
#  Size ~ 2,075,259 rows x 9 variables  x 8 bytes /1024 ~ 146MB
size <- 2075259 * 9 * 8 / 2^20
print("Aprox Size: "); print(size); print(" MB")
if (size > 4096){
        stop ("not enough RAM memory")
}

doc <- unzip("power.zip")
data <- read.csv(doc, sep=";", header = TRUE, na.strings = "?")

# generating a variable with date + time
data$Date <- paste(as.character(data$Date), sep= " ", as.character(data$Time))
data$Date <- strptime(data$Date, "%d/%m/%Y %H:%M:%S")
# filterin days
# Filtering data according to dates 2007-02-01 and 2007-02-02
ini <- strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S")
end <- strptime("2007-02-02 23:59:59", "%Y-%m-%d %H:%M:%S")
data_sub <- subset(data, Date >= ini & Date <= end)

# Generating graphic
# 480 x480 is default
png("plot4.png")

# 2x2 multi graphs
par(mfrow=c(2,2))
# global active power plot
plot(data_sub$Date, data_sub$Global_active_power, 
     ylab = "Global Active Power",
     xlab = "",
     type = "l")

# voltage plot
plot(data_sub$Date, data_sub$Voltage,
     ylab = "Voltage",
     xlab = "",
     type = "l",
     sub = "datetime")

#submetering values
with (data_sub, {
        plot(Date, Sub_metering_1, type = "l", col ="black", ylab = "Energy sub metering", xlab = "")
        lines(Date, Sub_metering_2, type = "l", col = "red")
        lines(Date, Sub_metering_3, type = "l", col = "blue")
})

legend("topright", col = c("black", "red", "blue"),
       lty = c(1,1,1), lwd = c(2.5, 2,5, 2.5),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")

#global reactive power
plot(data_sub$Date, data_sub$Global_reactive_power,
     ylab = "Global_reactive_power",
     xlab = "",
     type = "l",
     sub = "datetime")

dev.off()


