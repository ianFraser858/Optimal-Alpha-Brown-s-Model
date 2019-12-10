##getwd()
#install.packages("readxl")
#install.packages("tidyverse")
install.packages("fpp2")



##
library(readxl)
library(tidyverse)
library(fpp2)
library(forecast)
data<- read_excel("C:/Users/Gianna/Desktop/Seasonall.xlsx", col_names = T)



View(data)
head(data)



# Using the original date, make quarter data.



data <- ts(data, start = c(1983,12), frequency = 12)



##1.
#create training(70%) and cross-validation(30%) datasets 
n=nrow(data)

view(ses)


#data.training <- ts(data, start = c(1983,12), end = c(1990,9))
data.training <- data[1:28, ]
#data.training <- window(data, end = 28)



data.test <- data[29:n, ]
plot(data) # Option 1
plot.ts(data) # Option 2
na.omit(data, cols=seasonally(data), invert=FALSE)



# From both options, you can see the trend with repeated pattern(seasonality)# Simple exponential smoothing
ses<- ses(data, alpha = .2, h = 10)
#2. 
data.ses <- ses(data.training, alpha = .2, h = 100)



view(data.test)
accuracy(data.ses, data.test)



autoplot(data.ses)
autoplot(ses)
summary(ses)a <- seq(0, 1, 0.1) 
#3.



a <- seq(0.01, .99, 0.01)
sse <- NA
#4. 
for(i in seq_along(a)){ 
  #assign(paste0("fit", i), ses(data.training, alpha=a[i], initial="simple", h=1)) ##Instead of the whole dataset, I would use the training dataset here to train the model## 
  fit<- ses(data, alpha=a[i], h=100)
  #sse[i] <- sum(get(paste0("fit", i))$residuals^2)
  sse[i] <- accuracy(fit,data.test)[2,2]
}  
plot(a, sse, xlab=expression(alpha), ylab=expression(sum(e^2)),
     main="Simple Exponential Smoothing")
###IDENTIFY THE MINIMUM ALPHA VALUE (AA) FROM THIS "SSE vs. ALPHA" PLOT ABOVE THEN REFIT THE SES MODEL WITH THIS ALPHA VALUE



alpha.sse <- data.frame(a, sse)
alpha.sse[which.min(alpha.sse$sse),] 
#calculate optimum alpha based on mimumum sse
#mimumum alpha here is 0.28



ses.final<- ses(data, alpha=0.28, h=100)

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
##
