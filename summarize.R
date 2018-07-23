restaurant <- read.csv("/home/inyenyeri/Downloads/Restaurants.csv")
str(restaurant)
head(restaurant,3)
tail(restaurant,3)
f <-restaurant[restaurant$zipCode %in% c("21211","21224"),]

table(f$zipCode)

data(UCBAdmissions)
UCBA <- as.data.frame(UCBAdmissions)
summary(UCBA)
str(UCBA)

## CROSS TAB
xtabs(Freq ~ Admit + Gender, data = UCBA)

table(UCBA$Admit,UCBA$Gender)


ftable(UCBA)
restaurant$groups <- cut(restaurant$zipCode,breaks = quantile(restaurant$zipCode))

table(restaurant$groups)


##for the the grouping process above
##install.packages("Hmisc")
library(Hmisc)
restaurant$groupsCut2 <- cut2(restaurant$zipCode,g=4)
table(restaurant$groupsCut2)

####data reshiping
library(reshape2)
summary(mtcars)
str(mtcars)

mtcars$carnames <- rownames(mtcars)
##reformating
carMelt <- melt(mtcars, id = c("carnames", "gear", "cyl"), measure.vars = c("mpg", "hp"))
## casting
dcast(carMelt, gear ~ variable)
InsectSprays <-as.data.frame(InsectSprays)


tapply(InsectSprays$count, InsectSprays$spray, sum)


unlist(lapply(split(InsectSprays$count, InsectSprays$spray), sum))


## using plyr package 
library(plyr)
ddply(InsectSprays,.(spray), summarize,mean=round(mean(count),1))
###dplyr package
library(dplyr)
data(chicago)
chicago <- readRDS("/home/inyenyeri/Downloads/R/Learning/Coursera/R Programming/chicago.rds")
head(select(chicago,-(tmpd:pm25tmean2)))
head(select(chicago,tmpd:pm25tmean2))

library(lubridate)
month(Sys.Date())

chicago$month <- month(chicago$date)
    
table(chicago$month)



##create categorical variable
chicago <- mutate(chicago,temcat = factor(1 * (tmpd > 90), labels = c("cold","hot")))
hotcoldGroups <- group_by(chicago, temcat)

##calculating based on month
months <- group_by(chicago, month) 
summarise(months, sum = sum(o3tmean2))

##using pipeline
chicago %>% mutate(month = month(date)) %>% group_by(month) %>% summarise(sum=sum(o3tmean2))



