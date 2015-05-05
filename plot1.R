# plot1.R
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

# Plot the histogram as a PNG file
png(filename = "./plot1.png", width = 480, height = 480, bg = "white")
hist(as.numeric(dataset$Global_active_power), main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()
