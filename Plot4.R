## Load file

hpc <- read.table("household_power_consumption.txt", sep = ";")

## Fix names

colnames(hpc) <- c("date", "time", "globalactivepower", "globalreactivepower", "voltage", 
                   "globalintensity", "submetering1", "submetering2", "submetering3")

## remove bad names

hpcdata <- hpc[-c(1), ]

## load lubridate

library(lubridate)

## convert dates to dates.

hpcdata$date <- dmy(hpcdata$date)


## load dplyr

library(dplyr)

## Subset by date

shpc <- hpcdata[hpcdata$date >= "2007-02-01" & hpcdata$date <= "2007-02-02", ]

## convert character into numeric

shpc$globalactivepower <- as.numeric(shpc$globalactivepower)
shpc$globalreactivepower <- as.numeric(shpc$globalreactivepower)
shpc$submetering1 <- as.numeric(shpc$submetering1)
shpc$submetering2 <- as.numeric(shpc$submetering2)
shpc$submetering3 <- as.numeric(shpc$submetering3)
shpc$voltage <- as.numeric(shpc$voltage)

## Combine date and time

shpc$DT <- as.POSIXct(with(shpc, ymd(date) + hms(time)))

## create fourth plot

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))

# top left plot

plot(shpc$DT, shpc$globalactivepower, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# top right plot

plot(shpc$DT, shpc$voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# bottom left plot

plot(shpc$DT, shpc$submetering1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(shpc$DT, shpc$submetering2, col = "red", type = "l", xlab = "", ylab = "")
lines(shpc$DT, shpc$submetering3, col = "blue", type = "l", xlab = "", ylab = "")
legend("topright", pch = "-", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", 
                                                                            "Sub_metering_3"), bty="n")

# bottom right

plot(shpc$DT, shpc$globalreactivepower, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

## create .png

dev.copy(png, file = "Plot4.png")

dev.off()