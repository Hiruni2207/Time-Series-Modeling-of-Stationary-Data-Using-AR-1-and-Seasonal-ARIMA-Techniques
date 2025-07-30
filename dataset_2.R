library(TSA)
library(tseries)
library(lmtest)
library(fUnitRoots)
library(forecast)

dataset_2 <- read.table("dataset_2.txt", header = TRUE)

ts_data_2 <- ts(dataset_2$dataset_2_200416J) # Convert to time series object
plot(ts_data_2, main = "Time Series Plot", col = "blue", type = "o", pch = 1) # Plot the raw series
lines(lowess(ts_data_2), col = "red", lwd = 2)

# Step 1: Model specification
adf.test(ts_data_2) # Augmented Dickey-Fuller Test for stationarity
acf(ts_data_2)
pacf(ts_data_2)

# Step 2: Model Fitting - SARIMA(p,d,q)x(P,D,Q)[s]
ts_data_2 <- ts(dataset_2$dataset_2_200417M, frequency = 12) # s = 12

model_ma1_sma1 <- arima(ts_data_2, order = c(0,0,1), seasonal = c(0,0,1), method = "ML") # SARIMA(0,0,1)X(0,0,1)[12]
model_ma1_sma1
coeftest(model_ma1_sma1)

# Step 3: Model Diagnostics

# Assess normality
res <- residuals(model_ma1_sma1)
hist(res) # Check for normality
qqnorm(rstandard(model_ma1_sma1)) # Check for normality
abline(a=0, b=1,col = "red")
shapiro.test(rstandard(model_ma1_sma1)) # Check for normality

# Assess homoscedasticity
plot(rstandard(model_ma1_sma1)) # Check for homoscedasticity, zero mean 

# Assess independence
Box.test(residuals(model_ma1_sma1), lag=6, type="Ljung-Box", fitdf=0) # Check for independence
# tsdiag(model_ar1, gof=10, omit.initial=F)

# Assess whether additional parameters are required via overfitting 
model_ar1_ma1_sma1 <- arima(ts_data_2, order = c(1,0,1), seasonal = c(0,0,1), method = "ML") # SARIMA(1,0,1)X(0,0,1)[12]
model_ar1_ma1_sma1
coeftest(model_ar1_ma1_sma1)

model_ma1_sma1_sar1 <- arima(ts_data_2, order = c(0,0,1), seasonal = c(1,0,1), method = "ML") # SARIMA(0,0,1)X(1,0,1)[12]
model_ma1_sma1_sar1
coeftest(model_ma1_sma1_sar1)

model_ma2_sma1 <- arima(ts_data_2, order = c(0,0,2), seasonal = c(0,0,1), method = "ML") # SARIMA(0,0,2)X(0,0,1)[12]
model_ma2_sma1
coeftest(model_ma2_sma1)

model_ma1_sma2 <- arima(ts_data_2, order = c(0,0,1), seasonal = c(0,0,2), method = "ML") # SARIMA(0,0,1)X(0,0,2)[12]
model_ma1_sma2
coeftest(model_ma1_sma2)
