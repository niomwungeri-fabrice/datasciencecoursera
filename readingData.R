## reading csv ##
CSVfileUrl <- "https://data.baltimorecity.gov/api/views/aqgr-xx9h/rows.csv?accessType=DOWNLOAD"
download.file(CSVfileUrl,"/home/inyenyeri/Downloads/cameras.csv")
CSVdataDowloaded <- date()
CSVbartimore.fixed.speed.camera.df <- read.csv("/home/inyenyeri/Downloads/cameras.csv")

##reading excel ##
library(readxl)
EXCELfileUrl <- "https://www.ntia.doc.gov/files/ntia/publications/225-5000-composite-inventory_2015-12-16.xlsx"
download.file(EXCELfileUrl, "/home/inyenyeri/Downloads/camerasE.xlsx")
EXCELdataDowloaded <- date()
EXCELbartimore.fixed.speed.camera.df <- read_excel("/home/inyenyeri/Downloads/camerasE.xlsx")
head(bartimore.fixed.speed.camera.df)

##reading XML ##
# Load the package required to read XML files.
library("XML")

# Also load the other required package.
library("methods")

# Give the input file name to the function.
result <- xmlTreeParse(file = "/home/inyenyeri/Downloads/employe.xml")
rootNode <- xmlRoot(result)
xmlName(rootNode)
names(rootNode)
##access specific element
rootNode[[1]][[1]][[2]]
##printout value
xmlSApply(rootNode[[1]],xmlValue)
##getting
xpathSApply(rootNode,"/EMPLOYEE", xmlValue)
rootNode$row$

##reading json
#install.packages("jsonlite")
library(jsonlite)
jsonD<- fromJSON("https://data.baltimorecity.gov/api/views/aqgr-xx9h/rows.json?accessType=DOWNLOAD")
names(jsonD$meta$view$id)
tbl_df

##reading mysql ##
library(DBI)
library(RMySQL)
#install.packages("RMySQL")
ucscDB <- dbConnect(MySQL(), user= "genome",
                    host = "genome-mysql.cse.ucsc.edu")
##run the this command in blackets. on ther mysql server.
result <- dbGetQuery(ucscDB,"show databases;");dbDisconnect(ucscDB)

##accessing a particular database
mm10Patch4 <- dbConnect(MySQL(), user="genome", db = "mm10Patch4",
                        host = "genome-mysql.cse.ucsc.edu" )

##reading all table in specified database.
allTables <- dbListTables(mm10Patch4)

##list fields for a specific table called chromInfo
dbListFields(mm10Patch4, "chromInfo")


##Mysql command
dbGetQuery(mm10Patch4, "select count(*) from chromInfo")

##read table from table(Mysql) to dataframe R

chromInfoDT <- dbReadTable(mm10Patch4,"chromInfo")

head(chromInfoDT,5)

############another tabale
hg19 <- dbConnect(MySQL(),
                  user = "genome", 
                  db = "hg19", 
                  host = "genome-mysql.cse.ucsc.edu")
dbListTables(hg19)

## for querying some rows not all list
query <- dbSendQuery(hg19, "SELECT * FROM affyU133Plus2 where misMatches BETWEEN 1 AND 3")
affy <- fetch(query)
quantile(affy$misMatches)

##fetch 10 only and remember to cleary the query

affy10 <- fetch(query,10); dbClearResult(query):
## disconnect database from server    
dbDisconnect(hg19)

##Read HDF5
source("https://bioconductor.org/biocLite.R")
biocLite("rhdf5")



## read from web(Web scraping)
library(XML)
con <- url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
con <- url("http://www.wunderground.com/history/airport/KMDW")
html2 <- htmlTreeParse(con,useInternalNodes = T)
xpathSApply(html2, "//title", xmlValue)



########Reading from API###############3
library(jsonlite)
library(httr)
myTwitterAPP =oauth_app("testTwitterAPIFABRICE",
                        key = "PVw9eGpWDMix7KsVJBj1Nn8lo",
                        secret = "i7e9scetW55nRlC6Nfo7ZABlBSFfKRy6WSdJtNok3tQHJ4dFKV")
sig = sign_oauth1.0(myTwitterAPP,
                    token = "1124668574-U2W2xSJed9V9oGGxBt6nKHactJnky4215Vt0kFe",
                    token_secret = "X4mvK7Jih9GWdy8lh59MX592o3zv80FqSBMXmFVLXR3dn")
home = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

rJson <- content(home)
rJson1 <- fromJSON(toJSON(rJson))
colnames(rJson1)
rJson1[1:3,c(4,19)]





####Quiz Coursera 
############### week 2 Question number 1
library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at 
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("testGitApis",
                   key = "565757338ef345d77072",
                   secret = "27ce79b0269f53d671bad4e62f0f9690b6e1f483")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
home <- GET("https://api.github.com/users/jtleek/repos", gtoken)


rJson <- content(home)
rJson1 <- fromJSON(toJSON(rJson))
colnames(rJson1)


rJson1[rJson1$name == "datasharing", 47]
############## question number 2
acs <-read.csv("/home/inyenyeri/Downloads/AmericanCommunitySurveyDF.csv")
install.packages("sqldf")
library(sqldf)

sqldf("select * from acs where AGEP < 50")
unique1 <- unique(acs$AGEP)
##############question 3
unique2 <- sqldf("select distinct AGEP from acs")

#############question 4
contact <- readLines("http://biostat.jhsph.edu/~jleek/contact.html")
nchar(contact[10])
nchar(contact[20])
nchar(contact[30])
nchar(contact[100])

#################question 5
x <- read.fwf(
    file=url("http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for"),
    skip=4,
    widths=c(12, 7, 4, 9, 4, 9, 4, 9, 4))


x[,9]
colSums(x[40,9])
sum(x$V6)
    