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

png("plot1.png",width=480,height=480)
## Based on the graph shown in the instructions, this sets a red histogram with 12 breaks 
##and labels appropriately
with(neededdata,hist(Global_active_power,col="red",breaks=12,
                     main="Global Active Power",xlab="Global Active Power (kilowatts)"))
## This closes the file to finish writing it
dev.off()
