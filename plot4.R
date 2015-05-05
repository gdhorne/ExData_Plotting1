# plot4.R
#

# Obtain the source data for subsequent analysis
if (!file.exists("household_power_consumption.zip")) {
  print("Fetching data from source...")
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip", "curl", T)
  unzip("household_power_consumption.zip")
}

library(data.table)

# Select only February 1, 2007 and February 2, 2007
startDate <- "1/2/2007"
endDate <- "2/2/2007"
dataset <- fread("household_power_consumption.txt", header = T, sep=";", colClasses = c("character"), na.strings="?", stringsAsFactors=F)[Date == startDate  | Date == endDate]

# Plot the graphs as a PNG file in a 2-by-2 layout
png(filename = "./plot4.png", width = 480, height = 480, bg = "white")
par(mfrow = c(2, 2))
with(dataset, plot(as.numeric(Global_active_power), type = "l", axes=F, ylab = "Global Active Power", xlab = ""))
axis(1, at=c(1, nrow(dataset)/2, nrow(dataset)), labels=c("Thu", "Fri", "Sat"))
axis(2)
box(which = "plot", lty = "solid")
with(dataset, plot(as.numeric(Voltage), type = "l", axes=F, ylab = "Voltage", xlab = "datetime"))
axis(1, at=c(1, nrow(dataset)/2, nrow(dataset)), labels=c("Thu", "Fri", "Sat"))
axis(2)
box(which = "plot", lty = "solid")
with(dataset, plot(as.numeric(Sub_metering_1), type = "l", axes=F, ylab = "Energy sub metering", xlab = "", col="black"))
with(dataset, lines(as.numeric(Sub_metering_2), type = "l", col = "red"))
with(dataset, lines(as.numeric(Sub_metering_3), type = "l", col = "blue"))
axis(1, at=c(1, nrow(dataset)/2, nrow(dataset)), labels=c("Thu", "Fri", "Sat"))
axis(2)
box(which = "plot", lty = "solid")
legend("topright", text.width = 1750, bty = "n", col = c("black", "red", "blue"), lty = "solid", inset = 0.0, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(dataset, plot(as.numeric(Global_reactive_power), type = "l", axes=F, xlab = "datetime", ylab = "Global_reactive_power"))
axis(1, at=c(1, nrow(dataset)/2, nrow(dataset)), labels=c("Thu", "Fri", "Sat"))
axis(2)
box(which = "plot", lty = "solid")
dev.off()