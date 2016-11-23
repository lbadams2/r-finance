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
sharpeRatioIGE = sqrt(252)*mean(excessReturn)/sd(excessReturn)

Ticker = "SPY"
Month_Begin <- 10
Day_Begin <- 26
Year_Begin <- 2001
Month_End <- 10
Day_End <- 14
Year_End <- 2007
baseUrl = 'http://ichart.finance.yahoo.com/table.csv?s='
url = paste(baseUrl, Ticker, '&a=', Month_Begin,"&b=",Day_Begin,"&c=",Year_Begin,"&d=",Month_End,"&e=",Day_End,"&f=",Year_End,"&g=d", sep="")
csv = getURL(url)
data = read.csv(text = csv)
closePrices = data$Adj.Close
closePrices = rev(closePrices)
divisor = shift(closePrices, 1, dir="right")
dailyReturnSPY = diff(closePrices)/divisor[-1]
netRet = (dailyReturn - dailyReturnSPY)/2
sharpeRatio = sqrt(252)*mean(netRet)/sd(netRet)

print(url)
