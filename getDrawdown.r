library(jsonlite)
library(RCurl)
library(binhf)

Ticker = "IGE"
Month_Begin <- 10
Day_Begin <- 26
Year_Begin <- 2001
Month_End <- 10
Day_End <- 14
Year_End <- 2007
baseUrl = 'http://ichart.finance.yahoo.com/table.csv?s='
igeUrl = paste(baseUrl, Ticker, '&a=', Month_Begin,"&b=",Day_Begin,"&c=",Year_Begin,"&d=",Month_End,"&e=",Day_End,"&f=",Year_End,"&g=d", sep="")
igeCsv = getURL(igeUrl)
igeData = read.csv(text = igeCsv)
closePricesIge = igeData$Adj.Close
closePricesIge = rev(closePricesIge)
divisor = shift(closePricesIge, 1, dir="right")
dailyReturnIge = diff(closePricesIge)/divisor[-1]
excessReturnIge = dailyReturnIge - .04/252
sharpeRatioIGE = sqrt(252)*mean(excessReturnIge)/sd(excessReturnIge)

Ticker = "SPY"
Month_Begin <- 10
Day_Begin <- 26
Year_Begin <- 2001
Month_End <- 10
Day_End <- 14
Year_End <- 2007
url = paste(baseUrl, Ticker, '&a=', Month_Begin,"&b=",Day_Begin,"&c=",Year_Begin,"&d=",Month_End,"&e=",Day_End,"&f=",Year_End,"&g=d", sep="")
csv = getURL(url)
data = read.csv(text = csv)
closePrices = data$Adj.Close
closePrices = rev(closePrices)
divisor = shift(closePrices, 1, dir="right")
dailyReturnSPY = diff(closePrices)/divisor[-1]
netRet = (dailyReturnIge - dailyReturnSPY)/2

cumret = cumprod(1 + netRet)-1
plot(cumret)
calculateMaxDrawdown(cumret)
print(dd)
print(ddDuration)

calculateMaxDrawdown = function(cumret) {
  print(cumret)
  highwatermark = rep(0, length(cumret))
  drawdown = rep(0, length(cumret))
  drawdownDuration = rep(0, length(cumret))
  for(t in 2:length(cumret)) {
    highwatermark[t] = max(highwatermark[t-1], cumret[t])
    drawdown[t] = (1 + highwatermark[t])/(1 + cumret[t])-1
    if(drawdown[t] == 0)
      drawdownDuration[t] = 0
    else
      drawdownDuration[t] = drawdownDuration[t-1]+1
  }
  dd = max(drawdown)
  ddDuration = max(drawdownDuration)
  return(c(dd,ddDuration))
}

debugSource("C:\\finance\\r\\getDrawdown.r")
