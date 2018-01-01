library(dplyr, tidyr)
library(lubridate)
power <- read.table("household_power_consumption.txt", header = T, sep = ";", stringsAsFactors = F)
power <- tbl_df(power)

power <- mutate(power, datetime = paste(Date, Time))
power<- power[,c(10, 1:9)]
power <- mutate(power, datetime = dmy_hms(datetime), Date = dmy(Date), Time = hms(Time))

power[4:10] <- apply(power[4:10], 2, function(x) x %>% as.numeric())

a <- ymd("2007-02-01")
b <- ymd("2007-02-02")
twodays <- filter(power, power$Date == a| power$Date == b)

save(twodays, file = "twodays.RData")

rm(power,a,b)

png("Plot4.png")

par(mfrow = c(2,2))

#plot a
plot(twodays$datetime, twodays$Global_active_power, ylab = "Global Active Power", xlab = "", type = "n", cex.lab = 0.75, cex.axis = 0.75)
lines(twodays$datetime, twodays$Global_active_power)

#plot b
plot(twodays$datetime, twodays$Voltage, ylab = "Voltage", xlab = "datetime", type = "n", cex.lab = 0.75, cex.axis = 0.75)
lines(twodays$datetime, twodays$Voltage)

#plot c
plot(twodays$datetime, twodays$Sub_metering_1, type = "n", xlab = " ", ylab = "Energy sub metering", cex.lab = 0.75, cex.axis = 0.75)
lines(twodays$datetime, twodays$Sub_metering_1)
lines(twodays$datetime, twodays$Sub_metering_2, col = "red")
lines(twodays$datetime, twodays$Sub_metering_3, col = "blue")
legend("topright", legend = c("sub_metering_1", "sub_metering_2","sub_metering_3"), col = c("black", "red", "blue"), lty = 1, cex = 0.75,  bty = "n")

#plot d
plot(twodays$datetime, twodays$Global_reactive_power, ylab = "Global Reactive Power", xlab = "datetime", type = "n", cex.lab = 0.75, cex.axis = 0.75)
lines(twodays$datetime, twodays$Global_reactive_power)

dev.off()