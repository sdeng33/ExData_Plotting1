setwd("C:/Users/y2kyn/OneDrive/Documents")

if(!file.exists("data")){
  dir.create("data")
}

setwd("./data")

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <-"Household Power Consumption.zip"

#Checks to see if the required file has been downloaded.  If not, it downloads the file.#
if(!file.exists(filename)){
  download.file(fileUrl, destfile = filename , method = "curl")
}

dir.name <- "Household Power Consumption"

#Checks to see if the directory name exists.  If not, it unzips the required file and creates the directory name.#

if(!file.exists(dir.name)){
  unzip(filename)
}

#Reads the pertinent lines of the dataset into R.#
EPC <- suppressWarnings(read.table("household_power_consumption.txt", sep=";", skip=grep("1/2/2007", readLines("household_power_consumption.txt")),nrows=2879))

#Name the columns of the extracted dataset accordingly.#
names(EPC) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", 
                "Sub_metering_3")

#Paste the Date and Time columns together to form a date.time object.#
date.time <- paste(EPC$Date, EPC$Time, sep= " ")
date.time <- strptime(date.time, format = "%d/%m/%Y %H:%M:%S")

#Creates a .png file of the requisite plot and generates it accordingly.#
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

plot(date.time, EPC$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")

plot(date.time, EPC$Voltage, type="l", xlab = "datetime", ylab = "Voltage")

plot(date.time, EPC$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")
lines(date.time, EPC$Sub_metering_2, type="l", col="red")
lines(date.time, EPC$Sub_metering_3, type="l", col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col = c("black", "red", "blue"), lwd=1, bty = "n")

plot(date.time, EPC$Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()