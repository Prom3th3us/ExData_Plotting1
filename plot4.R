file_name = "household_power_consumption.txt"

## Download the data files if it doesn't exist
if(!file.exists(file_name))
{
        url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        temp = tempfile()
        download.file(url, temp)
        unzip(temp, file_name)
        unlink(temp)
}

## read in data, subset for 2007-02-01 and 2007-02-02 and convert Time and Date to POSIXct and Date format
col_class = c(rep("character", 2), rep("numeric", 7))
data = read.table(file_name, sep = ";", header = T, na.strings = "?", colClasses = col_class)
data = subset(data, Date=="1/2/2007"| Date =="2/2/2007")
data$Time = as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")
data$Date = as.Date(data$Date, format = "%d/%m/%Y")

## Plot 4 to a png
png("plot4.png",width = 480, height = 480)

## Set up 4 plots in one graphic
par(mfrow = c(2,2))

## draw first plot
with(data, plot(Time, Global_active_power, type = "n", xlab = "", ylab = "Global Active Power"))
with(data, lines(Time, Global_active_power))

## draw second plot
with(data, plot(Time, Voltage, type = "n", xlab = "datetime", ylab = "Voltage"))
with(data, lines(Time, Voltage))

## draw third plot
with(data, plot(Time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
with(data, lines(Time, Sub_metering_1, col = "black"))
with(data, lines(Time, Sub_metering_2, col = "red"))
with(data, lines(Time, Sub_metering_3, col = "blue"))
legend("topright", lwd = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## draw fourth plot
with(data, plot(Time, Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power"))
with(data, lines(Time, Global_reactive_power))

## switch graphic device off
dev.off()