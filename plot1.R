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
png("plot1.png", width = 480, height = 480, bg = "white")

# Plot histogram:
hist(data$Global_active_power,xlab="Global Active Power (kilowatts)", col = "red",main = "Global Active Power")
dev.off()