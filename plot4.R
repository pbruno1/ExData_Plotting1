## The text file containined the data must be contained in the current working directory
## This reads in the data
powerdata<-read.table("household_power_consumption.txt",header=TRUE,sep=";",
                      colClasses=c("character","character",rep("numeric",7)),na="?")

## These two set the information as a time and date we can use
powerdata$Time<-strptime(paste(powerdata$Date,powerdata$Time),"%d/%m/%Y %H:%M:%S")
powerdata$Date<-as.Date(powerdata$Date,"%d/%m/%Y")

## This separates out only the dates we need into a subset
datesneeded<-as.Date(c("2007-02-01","2007-02-02"),"%Y-%m-%d")
neededdata<-subset(powerdata,Date %in% datesneeded)

## This creates the plot as plot#.png in the current working directory with the 
##appropriate width and height values
png("plot4.png",width=480,height=480)

## The last plot has multiple plots in one so we set it to have a 2 by 2 grid
par(mfrow=c(2,2))

## The top left plot is a line plot which we label appropriately
with(neededdata,plot(Time,Global_active_power,xlab="",ylab="Global Active Power",
                     main="",type="l"))

## The top right plot comes next because mfrow places plots by row. This is another
## line plot labeled appropriately
with(neededdata,plot(Time,Voltage,xlab="datetime",ylab="Voltage",main="",type="l"))

## The bottom left plot is almost the exact same as plot3 which we set and label
## the bty="n" takes away the border which does not appear in the sample version
with(neededdata,plot(Time,Sub_metering_1,xlab="",ylab="Energy sub metering",type="l"))
with(neededdata,lines(Time,Sub_metering_2,type="l",col="red"))
with(neededdata,lines(Time,Sub_metering_3,type="l",col="blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=2,
       col=c("black","red","blue"),bty="n")

## the bottom right plot is another line plot which we set and label appropriately
with(neededdata,plot(Time,Global_reactive_power,xlab="datetime",
                     ylab="Global_reactive_power",main="",type="l"))

## This closes the file to finish writing it
dev.off()
