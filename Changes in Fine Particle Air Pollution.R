##loading dataset
pm0 <- read.table("/home/inyenyeri/Downloads/R/Learning/Coursera/R Programming/AirQuality/RD_501_88101_1999-0.txt", 
                  comment.char = "#", header = FALSE, sep = "|", na.strings = "")
pm1 <- read.table("/home/inyenyeri/Downloads/R/Learning/Coursera/R Programming/AirQuality/RD_501_88101_2012-0.txt", 
                  comment.char = "#",header = FALSE, sep = "|", na.strings = "", nrow = 1304290)
##loading dataset names
cnames <- readLines("/home/inyenyeri/Downloads/R/Learning/Coursera/R Programming/AirQuality/RD_501_88101_1999-0.txt",1)
cnames <- strsplit(cnames,"|", fixed = T)
## assignig names(header)
names(pm0) <- make.names(cnames[[1]])
names(pm1) <- make.names(cnames[[1]])

##extracting the interesting variable
x0 <- pm0$Sample.Value
x1 <- pm1$Sample.Value
##box plot to see on char
boxplot(log2(x0),log2(x1))

##summerise the interesting variable
summary(x0)
summary(x1)

##looking at the negative values in the variable table
x1N <- x1 < 0 
##looking the impact of the negative number by calcualting mean excluding NAs
mean(x1N,na.rm = T)

##extracting the data
dates <- pm1$Date
##formating the date
dates <- as.Date(as.character(dates), "%Y%m%d")

##extracting months from the whole data
missing.months <- month.name[as.POSIXlt(dates)$mon +  1]

##We can then extract the month from each of the dates with negative values and attempt to identify
#when negative values occur most often
tab <- table(factor(missing.months, levels = month.name))
round(100 * tab / sum(tab))






