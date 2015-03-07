
# ...	-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# ...			coursera - exploratory data analysis - class project 1
#															 2015-fév-17
# ...	-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#

#names
# [1] "Date"                  "Time"                  "Global_active_power"  
# [4] "Global_reactive_power" "Voltage"               "Global_intensity"     
# [7] "Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3"       

rm(list=ls())

library(sqldf)
library(lubridate)

Sys.setlocale("LC_TIME", "en_US.UTF-8")

# ... original source file

data_file <- c("household_power_consumption.txt")

# ...	-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# ...	read the data file into data frame
# ...	-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	
	data <- read.table(data_file, header = TRUE, sep = ";",
				na.strings = "?",
				colClasses =
					c("character", "character",
						"numeric", "numeric", "numeric", "numeric",
						"numeric", "numeric", "numeric"),
				col.names =
					c("date", "time",
						"gap", "grp", "vlt", "gin",
						"sm1", "sm2", "sm3"),
				strip.white = TRUE)
	
# ...	-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# ...	select the data from 2 days in february
# ...	-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	
	ss <- sqldf("select * from data where date = '1/2/2007' OR date = '2/2/2007'")

# ...	-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
# ...	add data column with date-time column
# ...	-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

	ss$dt <- dmy_hms(paste(ss$date, ss$time))
		
# ... plot 1 ... histograph of Global Active Power

	par(mfrow=c(1,1))
	
	hist (ss$gap, col = "red",
			main = "Global Active Power",
			xlab = "Global Active Power (kilowatts)",
			ylab = "Frequency")
			
	dev.copy(png,"plot1.png",width=480,height=480,units="px")
	dev.off()


