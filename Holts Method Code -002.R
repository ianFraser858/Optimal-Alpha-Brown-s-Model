#Reading in CSV file with header from set working directory
data<- read_excel("C:/Users/Gianna/Desktop/Seasonall.xlsx")
#Checking format of the data
head(data)
#Checking class of date column in data / confirming "factor" class
class(data[,1])
#Converting vector of "Organic Sessions" into time series object
Seasonall <- ts(data, start = c(1983,12), end = c(1992,6), frequency = 4)
na.omit(data, cols=seasonally(data), invert=FALSE)
#Avoiding scientific notation for y-axis values
options(scipen=999)
#Plotting our "Organic Traffic" data
plot(Seasonall, main = "Seasonal", ylab = "Seasoanl", ylim = c(0, 700000))
#Decomposing data into seasonal, trend and irregular components using classical decomposition
fit_decompose <- decompose(Seasonall, type = "multiplicative")
#Printing component data of decomposition 
fit_decompose
#Plotting component data of decomposition
plot(fit_decompose)
#Install and load forecast package if not installed
if(!require(forecast)) {
  install.packages("forecast", dependencies = T)
  library(forecast) }
#Fit simple exponential smoothing model to data and show summary
fit_ses <- ses(Seasonall, h = 6)
summary(fit_ses)
#Plot the forecasted values
plot(fit_ses)
#Fit Holt exponential smoothing model to data and show summary
fit_holt <- holt(Seasonall, h = 6)
summary(fit_holt)
#Plot the forecasted values
plot(fit_holt)
#Fit Holt-Winters exponential smoothing model to data and show summary
fit_hw <- hw(Seasonall, h = 6, seasonal = "multiplicative")
summary(fit_hw)
#Plot the forecasted values
plot(fit_hw)
#Fit automated exponential smoothing model to data and show summary
fit_auto <- forecast(Seasonall, h = 10)
summary(fit_auto)
#Plot the forecasted values
plot(forecast(fit_auto))
#Fit automated exponential smoothing model to training dataset and calculate forecast accuracy
train <- window(Seasonall, end = c(1992, 9))
test <- window(Seasonall, start = c(1983, 12))
fit_hw_train <- hw(train)
fit_auto_train <- forecast(train)
accuracy(forecast(fit_hw_train), test) ["Test set", "RMSE"]
accuracy(forecast(fit_auto_train), test) ["Test set", "RMSE"]
ts(data=, start = c(1983,12), end=c(1992,9), frequency=12, deltat=1/12)

is.na(DataBrowns)
is.nan(DataBrowns)
is.infinity(DataBrowns)

a<-"alpha"
exists ("a")
a = "alpha"
view(alpha)
b<-"beta"
exists("b")
b = "beta"
view(beta)
a=b

HoltWinters(DataBrowns,
    alpha=NULL, beta = NULL, gamma = FALSE, 
    start.periods=2, l.start=NULL, b.start=NULL,
    s.start = NULL)
#Calcuate mean of residuals and plot histogram for residuals
fit_hw_res <- residuals(forecast(fit_hw_train))
fit_auto_res <- residuals(forecast(fit_auto_train))
mean(fit_hw_res)
mean(fit_auto_res)
hist(fit_hw_res)

