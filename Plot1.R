library(dplyr)


df <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings = "NA", 
                 stringsAsFactors=F)


df %>% filter(as.Date(Date, format="%d/%m/%Y") >= as.Date("2007-02-01"),
              as.Date(Date, format="%d/%m/%Y") <= as.Date("2007-02-02")) %>% 
        mutate(Global_active_power = as.numeric(Global_active_power)) -> df2

hist(df2$Global_active_power, col = "red", breaks = 12, main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

dev.copy(png, 'Plot1.png')
dev.off()