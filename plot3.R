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
png("plot3.png",width=480,height=480)

## Based on the graph shown in the instructions, this sets a line graph for the 3 
##sub metering categories and labels appropriately with a legend
with(neededdata,plot(Time,Sub_metering_1,xlab="",ylab="Energy sub metering",type="l"))
with(neededdata,lines(Time,Sub_metering_2,type="l",col="red"))
with(neededdata,lines(Time,Sub_metering_3,type="l",col="blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=2,
       col=c("black","red","blue"))

## This closes the file to finish writing it
dev.off()
