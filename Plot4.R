library(dplyr)

#read data
df <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings = "NA", 
                 stringsAsFactors=F)

#filter and transform data
df %>% filter(as.Date(Date, format="%d/%m/%Y") >= as.Date("2007-02-01"),
              as.Date(Date, format="%d/%m/%Y") <= as.Date("2007-02-02")) %>% 
        mutate(datetime=paste(Date, Time, sep = ' ')) -> df2

df2$datetime <- strptime(df2$datetime, format = "%d/%m/%Y %H:%M:%S")

#create plots
par(mfrow = c(2, 2))
plot(df2$datetime, df2$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
plot(df2$datetime, df2$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(df2$datetime, df2$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", main="")
lines(df2$datetime, df2$Sub_metering_2, type="l", col="red")
lines(df2$datetime, df2$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1),
       lwd=c(2.5,2.5,2.5), col=c("black","red","blue"))
plot(df2$datetime, df2$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

#generate PNG version of plots
dev.copy(png, 'Plot4.png')
dev.off()    