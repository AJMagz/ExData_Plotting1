
filezip <- "exdata_data_household_power_consumption.zip"

### Checks if the zip file containing the data set was not downloaded yet
if (!file.exists(filezip)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filezip, method="curl")
  unzip(filezip)
}

### Reads, subsetting the data set
hhpower <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
subhhpower <- subset(hhpower, hhpower$Date=="1/2/2007" | hhpower$Date =="2/2/2007")

### Convert Date and Time variables
subhhpower$datetime <- as.POSIXct(strptime(paste(subhhpower$Date, subhhpower$Time), "%d/%m/%Y %H:%M:%S"))

### Creating Plot 2
plot(subhhpower$datetime, as.numeric(as.character(subhhpower$Global_active_power)), type="l", xlab="", ylab="Global Active Power (kilowatts)")

### Output Plot 2 PNG file
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()