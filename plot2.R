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
global_active_power <- as.numeric(subSetData$Global_active_power)
png("plot2.png", width=480, height=480)
plot(datetime, global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()