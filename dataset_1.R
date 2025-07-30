library(TSA)
library(tseries)
library(lmtest)
library(fUnitRoots)

dataset_1 <- read.table("dataset_1.txt", header = TRUE)
ts_data_1 <- ts(dataset_1$dataset_1_200416J) # Convert to time series object
plot(ts_data_1, main = "Time Series Plot", col = "blue", type = "o", pch = 1) # Plot the raw series
lines(lowess(ts_data_1), col = "red", lwd = 2)

# Step 1: Model specification
adf.test(ts_data_1) # Augmented Dickey-Fuller Test for stationarity
acf(ts_data_1)
pacf(ts_data_1)
eacf(ts_data_1)

# Step 2: Model fitting
model_ar1 <- arima(ts_data_1, order = c(1, 0, 0), method = "ML") # "ML": Uses MLE estimation
model_ar1
AIC(model_ar1)
BIC(model_ar1)
coeftest(model_ar1)

model_ar1_ma1 <- arima(ts_data_1, order = c(1, 0, 1), method = "ML") # "ML": Uses MLE estimation
model_ar1_ma1
AIC(model_ar1_ma1)
BIC(model_ar1_ma1)

model_ar2_ma1 <- arima(ts_data_1, order = c(2, 0, 1), method = "ML") # "ML": Uses MLE estimation
model_ar2_ma1
AIC(model_ar2_ma1)
BIC(model_ar2_ma1)

# Step 3: Model diagnostics
res <- residuals(model_ar1)
hist(res)
plot(rstandard(model_ar1))

Box.test(residuals(model_ar1), lag=6, type="Ljung-Box", fitdf=0)
# tsdiag(model_ar1, gof=10, omit.initial=F)

qqnorm(rstandard(model_ar1))
abline(a=0, b=1,col = "red")
shapiro.test(rstandard(model_ar1))
