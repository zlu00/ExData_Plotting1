setwd("~/Documents")

## Download the data
if (!file.exists("household_power_consumption.zip")){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, "household_power_consumption.zip", method = "curl")
    unzip("household_power_consumption.zip")
}

## Read the data (only read data from the dates 2007-02-01 and 2007-02-02)
data <- read.table("household_power_consumption.txt", sep=";", skip=66637, nrows=2880, na.strings="?")
names(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

## Construct the plot 
data$dateTime <- strptime(paste(data$Date, data$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
png("plot2.png", width=480, height=480)
plot(data$dateTime, data$Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
