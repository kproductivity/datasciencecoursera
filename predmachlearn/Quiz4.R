
# Question 4
library(lubridate)
library(forecast)

dat = read.csv("~/Desktop/gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[year(dat$date) > 2011,]
tstrain = ts(training$visitsTumblr)
tstest = ts(testing$visitsTumblr, start=366)

plot(tstrain)

fit<-bats(tstrain)
fcast<-forecast(fit,235)

plot(fcast);lines(tstest,col="red")

x<-as.data.frame(fcast)
x$testing<-testing$visitsTumblr
prop.table(table(cbind( x[,4] <= x[,6] & x[,5] >= x[,6] )))
