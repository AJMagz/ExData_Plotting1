
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

### Convert Date and Time & Sub_metering variables
subhhpower$datetime <- as.POSIXct(strptime(paste(subhhpower$Date, subhhpower$Time), "%d/%m/%Y %H:%M:%S"))
submeter1 <- as.numeric(as.character(subhhpower$Sub_metering_1))
submeter2 <- as.numeric(as.character(subhhpower$Sub_metering_2))
submeter3 <- as.numeric(as.character(subhhpower$Sub_metering_3))

### Creating Plot 4
par(mfrow = c(2, 2))

plot(subhhpower$datetime, as.numeric(as.character(subhhpower$Global_active_power)), type="l", xlab="", ylab="Global Active Power")

plot(subhhpower$datetime, as.numeric(as.character(subhhpower$Voltage)), type="l", xlab="datetime", ylab="Voltage")

plot(subhhpower$datetime, submeter1, type="l", ylab="Energy sub metering", xlab="")
lines(subhhpower$datetime, submeter2, type="l", col="red")
lines(subhhpower$datetime, submeter3, type="l", col="blue")
legend("topright", lty=1, lwd=2.5, col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)

plot(subhhpower$datetime, as.numeric(as.character(subhhpower$Global_reactive_power)), type="l", xlab="datetime", ylab="Global_reactive_power")

### Output Plot 4 PNG file
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()