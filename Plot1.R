#load some packages
library(dplyr, tidyr, lubridate)

#read in data
power <- read.table("household_power_consumption.txt", header = T, sep = ";")

#clean data
power <- tbl_df(power)
power$Date <- dmy(power$Date)
power$Time <- hms(power$Time)
power[3:9] <- apply(power[3:9], 2, function(x) x %>% as.character() %>% as.numeric())

#subset data
a <- ymd("2007-02-01")
b <- ymd("2007-02-02")
twodays <- filter(power, power$Date == a| power$Date == b)

#tidy up abit
rm(power,a,b)

#make and save graph
png("Plot1.png")
hist(twodays$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()