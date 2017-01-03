## file: plot1.R
## author: Raul Hermosa
## date: Jan 3, 2017
## description: load and plot1.png generation

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

# Filtering data according to dates 2007-02-01 and 2007-02-02
ini <- strptime("2007-02-01", "%Y-%m-%d")
end <- strptime("2007-02-02", "%Y-%m-%d")
data$Date <- strptime(as.character(data$Date), "%d/%m/%Y")

data_sub <- subset(data, Date == ini | Date == end)

# 480 x480 is default
png("plot1.png")

hist(data_sub$Global_active_power, main = "Global Active Power",
                col = "red", 
                xlab = "Global Active Power (kilowatts)",
                xlim = range(0:6),
                xaxt = "n")
axis(side = 1, at = seq(0,6,2))
dev.off()



