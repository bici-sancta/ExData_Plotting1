
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
	
# ... plot 4 ... 4 figures arranged in 2 rows and 2 columns

	par(mfrow=c(2,2))
	
	plot(ss$dt, ss$gap,
		 type = "l",
		 ylab = "Global Active Power",
		 xlab = "")
	
	plot (ss$dt, ss$vlt, 
		type = "l",
		ylab = "Voltage",
		xlab = "")

	plt.legend.lbls = c("Sub_metering_3", "Sub_metering_2", "Sub_metering_1")
	
	plot (ss$sm3~ss$dt, type="n",
		ylim=c(0,40),
		ylab = "Energy Sub-metering",
		xlab = "")
	lines (ss$sm3~ss$dt, col = "blue")
	lines (ss$sm2~ss$dt, col = "red")
	lines (ss$sm1~ss$dt, col = "black")
	legend('topright', plt.legend.lbls , lty=1, col=c('blue', 'red',' black'), bty='y', cex=.50)

	plot (ss$dt, ss$grp, 
		type = "l",
		ylab = "Gloabl_reactive_power",
		xlab = "datetime")	
	
	dev.copy(png,"plot4.png",width=480,height=480,units="px")
	dev.off()
	
	
	
	

