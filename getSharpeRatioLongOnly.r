library(jsonlite)
library(RCurl)
library(binhf)

Get_Ticker <- function(){readline("Please enter a Ticker:>>> ")} 
Get_Month_Begin <- function(){as.numeric(readline("Enter the start month (MM):>>> "))}
Get_Day_Begin <- function(){as.numeric(readline("Enter the start day (1-31) :>>> "))}
Get_Year_Begin <- function(){as.numeric(readline("Enter the start year (YYYY) :>>> "))}
Get_Month_End <- function(){as.numeric(readline("Enter the end month (MM) :>>> "))}
Get_Day_End <- function(){as.numeric(readline("Enter the end day (1-31) :>>> "))}
Get_Year_End <- function(){as.numeric(readline("Enter the end year :>>> "))}

Ticker <- Get_Ticker()
Month_Begin <- Get_Month_Begin()
Day_Begin <- Get_Day_Begin()
Year_Begin <- Get_Year_Begin()
Month_End <- Get_Month_End()
Day_End <- Get_Day_End()
Year_End <- Get_Year_End()

Ticker = "IGE"
Month_Begin <- 10
Day_Begin <- 26
Year_Begin <- 2001
Month_End <- 10
Day_End <- 14
Year_End <- 2007
baseUrl = 'http://ichart.finance.yahoo.com/table.csv?s='
test2 = paste(baseUrl, Ticker, '&a=', Month_Begin,"&b=",Day_Begin,"&c=",Year_Begin,"&d=",Month_End,"&e=",Day_End,"&f=",Year_End,"&g=d", sep="")
csvTest = getURL(test2)
dataTest = read.csv(text = csvTest)
closePrices = dataTest$Adj.Close
closePrices = rev(closePrices)
divisor = shift(closePrices, 1, dir="right")
dailyReturn = diff(closePrices)/divisor[-1]
excessReturn = dailyReturn - .04/252
sharpeRatio = sqrt(252)*mean(excessReturn)/sd(excessReturn)


test <- paste('https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.historicaldata%20where%20symbol%20in%20(%22', symbol, '%22)%20and%20startDate%3D%27', fromDate, '%27%20and%20endDate%3D%27', toDate, '%27&format=json&diagnostics=true&env=http%3A%2F%2Fdatatables.org%2Falltables.env&callback=', sep="")
url <- 'https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.historicaldata%20where%20symbol%20in%20(%22IGE%22)%20and%20startDate%3D%272001-11-26%27%20and%20endDate%3D%272007-11-14%27&format=json&diagnostics=true&env=http%3A%2F%2Fdatatables.org%2Falltables.env&callback='
testDoc = fromJSON(txt = url)

a = c(1,3,5,6)
b = diff(a)
c = shift(a, 1, dir="right")
adiff = b/c[-1]

remove(list = ls())