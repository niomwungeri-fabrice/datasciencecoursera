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

##we subset the data frames to only include data from New York ( State.Code == 36 ) and only include the County.
##Code and the Site.ID (i.e. monitor number) variables.
site0 <- unique(subset(pm0, State.Code == 36, c(County.Code, Site.ID)))
site1 <- unique(subset(pm1, State.Code == 36, c(County.Code, Site.ID)))

##we create a new variable that combines the county code and the site ID into a single string
site0 <- paste(site0[,1], site0[,2], sep = ".")
site1 <- paste(site1[,1], site1[,2], sep = ".")

##we want the intersection between the sites present in 1999 and 2012 so that we might choose
##a monitor that has data in both periods
both <- intersect(site0, site1)
print(both)

## Find how many observations available at each monitor
pm0$county.site <- with(pm0, paste(County.Code, Site.ID, sep = "."))
pm1$county.site <- with(pm1, paste(County.Code, Site.ID, sep = "."))

cnt0 <- subset(pm0, State.Code == 36 & county.site %in% both)
cnt1 <- subset(pm1, State.Code == 36 & county.site %in% both)
##we can split the data frames and count the number of observations
##at each monitor to see which ones have the most observations

## 1999
sapply(split(cnt0, cnt0$county.site), nrow)

## 2012
sapply(split(cnt1, cnt1$county.site), nrow)


##we will focus here on County 63 and site ID 2008
both.county <- 63
both.id <- 2008

## Choose county 63 and side ID 2008
pm1sub <- subset(pm1, State.Code == 36 & County.Code == both.county & Site.ID == both.id)
pm0sub <- subset(pm0, State.Code == 36 & County.Code == both.county & Site.ID == both.id)



##we plot the time series data of PM for the monitor in both years
dates1 <- as.Date(as.character(pm1sub$Date), "%Y%m%d")
x1sub <- pm1sub$Sample.Value
dates0 <- as.Date(as.character(pm0sub$Date), "%Y%m%d")
x0sub <- pm0sub$Sample.Value

## Find global range
rng <- range(x0sub, x1sub, na.rm = T)
par(mfrow = c(1, 2), mar = c(4, 5, 2, 1))
plot(dates0, x0sub, pch = 20, ylim = rng, xlab = "", ylab = expression(PM[2.5] * " (" * mu * g/m^3 * ")"))
abline(h = median(x0sub, na.rm = T))
plot(dates1, x1sub, pch = 20, ylim = rng, xlab = "", ylab = expression(PM[2.5] * " (" * mu * g/m^3 * ")"))
abline(h = median(x1sub, na.rm = T))

#calculate the mean of PM for each state in 1999 and 2012
## 1999
mn0 <- with(pm0, tapply(Sample.Value, State.Code, mean, na.rm = TRUE))
## 2012
mn1 <- with(pm1, tapply(Sample.Value, State.Code, mean, na.rm = TRUE))