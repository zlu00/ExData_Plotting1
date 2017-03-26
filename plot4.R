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
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
## Upper left plot
plot(data$dateTime, data$Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power")
## Upper right plot
plot(data$dateTime, data$Voltage, type="l", col="black", xlab="datetime", ylab="Voltage")
## Lower left plot
plot(data$dateTime, data$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
lines(data$dateTime, data$Sub_metering_2, type="l", col="red")
lines(data$dateTime, data$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)
## Lower right plot
plot(data$dateTime, data$Global_reactive_power, type="l", col="black", xlab="datetime", ylab="Global_reactive_power")
dev.off()