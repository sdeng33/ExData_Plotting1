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
png("plot2.png", width=480, height=480)

plot(date.time, EPC$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()