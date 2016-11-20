library(dplyr)

#read table
df <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings = "NA", 
                 stringsAsFactors=F)

#filter and transform data
df %>% filter(as.Date(Date, format="%d/%m/%Y") >= as.Date("2007-02-01"),
              as.Date(Date, format="%d/%m/%Y") <= as.Date("2007-02-02")) %>% 
        mutate(Global_active_power = as.numeric(Global_active_power),
               datetime=paste(Date, Time, sep = ' ')) -> df2

df2$datetime <- strptime(df2$datetime, format = "%d/%m/%Y %H:%M:%S")

#create plot
plot(df2$datetime, df2$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

#generate PNG version of plot
dev.copy(png, 'Plot2.png')
dev.off()    