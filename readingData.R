## reading csv
CSVfileUrl <- "https://data.baltimorecity.gov/api/views/aqgr-xx9h/rows.csv?accessType=DOWNLOAD"
download.file(CSVfileUrl,"/home/inyenyeri/Downloads/cameras.csv")
CSVdataDowloaded <- date()
CSVbartimore.fixed.speed.camera.df <- read.csv("/home/inyenyeri/Downloads/cameras.csv")

##reading excel 
library(readxl)
EXCELfileUrl <- "https://www.ntia.doc.gov/files/ntia/publications/225-5000-composite-inventory_2015-12-16.xlsx"
download.file(EXCELfileUrl, "/home/inyenyeri/Downloads/camerasE.xlsx")
EXCELdataDowloaded <- date()
EXCELbartimore.fixed.speed.camera.df <- read_excel("/home/inyenyeri/Downloads/camerasE.xlsx")
head(bartimore.fixed.speed.camera.df)

##reading XML
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
rootNode[[1]][[2]]
##printout value
xmlSApply(rootNode,xmlValue)
##getting
xpathSApply(rootNode,"/EMPLOYEE", xmlValue)


##reading json
install.packages("jsonlite")
library(jsonlite)
jsonD<- fromJSON("https://data.baltimorecity.gov/api/views/aqgr-xx9h/rows.json?accessType=DOWNLOAD")
names(jsonD$meta$view$id)
?tbl_df

