library(dplyr)

#read data
df <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings = "NA", 
                 stringsAsFactors=F)

#filter and transform data
df %>% filter(as.Date(Date, format="%d/%m/%Y") >= as.Date("2007-02-01"),
              as.Date(Date, format="%d/%m/%Y") <= as.Date("2007-02-02")) %>% 
        mutate(Global_active_power = as.numeric(Global_active_power),
               datetime=paste(Date, Time, sep = ' ')) -> df2

df2$datetime <- strptime(df2$datetime, format = "%d/%m/%Y %H:%M:%S")

#create plot
plot(df2$datetime, df2$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", main="")
lines(df2$datetime, df2$Sub_metering_2, type="l", col="red")
lines(df2$datetime, df2$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1),
       lwd=c(2.5,2.5,2.5), col=c("black","red","blue"))

#generate PNG version of plot
dev.copy(png, 'Plot3.png')
dev.off()    