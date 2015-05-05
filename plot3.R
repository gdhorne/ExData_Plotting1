# plot3.R
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

# Plot the graph as a PNG file and label the x-axis using weekday name and a legend for each sub-meter
png(filename = "./plot3.png", width = 480, height = 480, bg = "white")
with(dataset, plot(as.numeric(Sub_metering_1), type = "l", axes=F, ylab = "Energy sub metering", col="black", xlab = ""))
with(dataset, lines(as.numeric(Sub_metering_2), type = "l", col = "red"))
with(dataset, lines(as.numeric(Sub_metering_3), type = "l", col = "blue"))
axis(1, at=c(1, nrow(dataset)/2, nrow(dataset)), labels=c("Thu", "Fri", "Sat"))
axis(2)
legend("topright", col = c("black", "red", "blue"), lty = "solid", inset = 0.0, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
box(which = "plot", lty = "solid")
dev.off()