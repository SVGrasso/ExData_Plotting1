library(dplyr, tidyr, lubridate)
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

png("Plot2.png")

plot(twodays$datetime, twodays$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "n")
lines(twodays$datetime, twodays$Global_active_power)

dev.off()