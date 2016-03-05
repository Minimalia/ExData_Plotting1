# This assignment uses data from the UC Irvine Machine Learning Repository,
# "Individual household electric power consumption Data Set" for dates:
# 1/2/2007: From line 66638 to 68077
# 2/2/2007: From line 68078 to 69517
# Need to Skip=66637 lines and read nrows = 2880

# Load needed libraries
library(plyr)

# Read data
data <- read.table("household_power_consumption.txt",sep=";",skip=66637, nrows= 2880,na.strings="?")
# Read header
header <- read.table("household_power_consumption.txt",header= TRUE,sep=";",nrows= 0)
# Names the data
names(data)<-names(header)

# Modify Date column as Date and Time as Date - Time column
data <-mutate(data,Time = strptime(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S")) 
data <-mutate(data,Date = as.Date(Date))

# Set graphic device as PNG file
png("plot4.png", width = 480, height = 480, bg = "white")

# Define 4 spaces and plot the graphs:
par(mfrow=c(2,2))

# 1st plot
with(data,plot(Time,Global_active_power,ylab = "Global Active Power",type ="l",xlab=""))

# 2nd plot
with(data,plot(Time,Voltage,ylab = "Voltage",type ="l",xlab="datetime"))

# 3rd plot
with(data,plot(Time,Sub_metering_1,type ="l",xlab="",ylab=""))
par(new=TRUE)
with(data,lines(Time,Sub_metering_2,type ="l",col="red",xlab="",ylab=""))
par(new=TRUE)
with(data,lines(Time,Sub_metering_3,type ="l",col="blue",xlab="",ylab=""))
legend("topright",bty="n",lty=c(1,1,1),lwd=2,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
title(xlab="",ylab="Energy sub metering")

# 4th plot
with(data,plot(Time,Global_reactive_power,type ="l",xlab="datetime"))

dev.off()