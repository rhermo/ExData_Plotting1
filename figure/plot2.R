## file: plot2.R
## author: Raul Hermosa
## date: Jan 3, 2017
## description: load and plot2.png generation

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

# 480 x480 is default
png("plot2.png")

plot(data_sub$Date, data_sub$Global_active_power, 
                main = "Global Active Power (kilowatts)",
                ylab = "Global Active Power (kilowatts)",
                xlab = "",
                type = "l")
dev.off()
