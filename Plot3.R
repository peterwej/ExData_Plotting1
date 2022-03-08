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

## Create smaller df

shpc3 <- shpc[c("date", "time", "submetering1", "submetering2", "submetering3")]

## Combine date and time

shpc3$DT <- as.POSIXct(with(shpc3, ymd(date) + hms(time)))

## create fourth plot

plot(shpc3$DT, shpc3$submetering1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(shpc3$DT, shpc3$submetering2, col = "red", type = "l", xlab = "", ylab = "")
lines(shpc3$DT, shpc3$submetering3, col = "blue", type = "l", xlab = "", ylab = "")
legend("topright", pch = "---", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## create .png

dev.copy(png, file = "Plot3.png")

dev.off()