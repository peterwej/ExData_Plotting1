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

## create first plot

hist(shpc$globalactivepower, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")

## create .png

dev.copy(png, file = "Plot1.png")

dev.off()





