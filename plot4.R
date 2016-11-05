# Create directory for file to be downloaded into and set working directory
mainDir <- "~/data/"
subDir <- "powerdata"
if (file.exists(subDir)){
  setwd(file.path(mainDir, subDir))
} else {
  dir.create(file.path(mainDir, subDir))
  setwd(file.path(mainDir, subDir)) }

# Download File
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,"household_data_consumption.zip","curl")

# Unzip File
unzip("~/data/powerdata/household_data_consumption.zip", exdir = "~/data/powerdata/data")
setwd("~/data/powerdata/data/")

# Read in file and create a subset for dates 2007-02-01 and 2007-02-02 
file <- "household_power_consumption.txt"
data <- read.table(file, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
subdata <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

# Create plot titled "Global Active Power"
datetime <- strptime(paste(subdata$Date, subdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
global_active_power <- as.numeric(subdata$Global_active_power)
voltage <- as.numeric(subdata$Voltage)
global_reactive_power <- (subdata$Global_reactive_power)
sub_metering_1 <- as.numeric(subdata$Sub_metering_1)
sub_metering_2 <- as.numeric(subdata$Sub_metering_2)
sub_metering_3 <- as.numeric(subdata$Sub_metering_3)

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

plot(datetime, global_active_power, type="l", xlab = "", ylab = "Global active power")

plot(datetime, voltage, type="l", xlab = "datetime", ylab = "Voltage")

plot(datetime, sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(datetime, sub_metering_2, type="l",col="red")
lines(datetime, sub_metering_3, type="l",col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="n")

plot(datetime, global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()