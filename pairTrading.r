library(readxl)

gldData <- read_excel("C:\\finance\\r\\data\\GLD.xls")
gldDates = rev(as.Date(gldData$Date))
#gldDates = as.POSIXct(gldData$Date, format="%y%m%d")
gldAdjCls = rev(gldData$`Adj Close`)
gdxData <- read_excel("C:\\finance\\r\\data\\GDX.xls")
gdxDates = rev(as.Date(gdxData$Date))
#gdxDates = as.POSIXct(gdxData$Date, format="%y%m%d")
gdxAdjCls = rev(gdxData$`Adj Close`)

# get vector of common dates and vectors of the common indices for each
# date vector
intDates = intersect(gldDates, gdxDates)
gldDatesIdx = match(intDates, gldDates)
gdxDatesIdx = match(intDates, gdxDates)
gldCl1 = gldAdjCls[gldDatesIdx]
gdxCl1 = gdxAdjCls[gdxDatesIdx]

trainset = c(1:252)
#testset = 1:length(intDates)
results = lm(gldCl1[trainset], gdxCl1[trainset])
