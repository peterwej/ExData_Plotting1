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

shpc2 <- shpc[c("date", "time", "globalactivepower")]

## Combine date and time

shpc2$DT <- as.POSIXct(with(shpc2, ymd(date) + hms(time)))

## create second plot

plot(shpc2$DT, shpc2$globalactivepower, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## create .png

dev.copy(png, file = "Plot2.png")

dev.off()


