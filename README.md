# 📈 Time Series Modeling of Stationary Data Using AR(1) and Seasonal ARIMA Techniques

This project presents a comprehensive analysis of two univariate stationary time series datasets using classical time series modeling techniques, including **Autoregressive (AR)** and **Seasonal ARIMA (SARIMA)** models. The analysis demonstrates step-by-step diagnostics and model validation, culminating in statistically sound and parsimonious models suitable for forecasting.

---

## Project Overview

Two datasets were analyzed:

- **Dataset 1**: Exhibits stationarity with short-term autocorrelation, best modeled with an AR(1) model.
- **Dataset 2**: Shows strong seasonal patterns (period = 12) in addition to short-term dependencies, modeled effectively using a SARIMA(0,0,1)(0,0,1)[12] model.

Both datasets underwent detailed statistical diagnostics including:

- **ADF (Augmented Dickey-Fuller) tests** for stationarity
- **ACF and PACF** plots for model identification
- **EACF** for ARMA order suggestion
- **Residual diagnostics** (Q-Q plots, Shapiro-Wilk, Ljung-Box) for validation

---

## Folder Structure
Time-Series-Stationary-Modeling/
│
├── data/ # Raw datasets
├── notebooks/ # Exploratory Jupyter notebooks
├── models/ # Python scripts for AR/SARIMA fitting
├── results/ # Output forecasts and plots
├── plots/ # ACF, PACF, residual diagnostics
├── requirements.txt # Python libraries required
└── README.md # Project documentation


---

##  Dataset 1 Summary – AR(1) Modeling

- **Stationarity** confirmed (ADF statistic: –6.3713, p < 0.05)
- **Model selected**: AR(1)
- **Equation**:  
  \[
  Y_t = 13.5325 + 0.6582 \cdot Y_{t-1} + \varepsilon_t, \quad \varepsilon_t \sim \mathcal{N}(0, 3.98)
  \]
- **Model performance**:
  - Low AIC and BIC values
  - Residuals approximately normal and uncorrelated
  - Passes Shapiro-Wilk and Ljung-Box tests

---

##  Dataset 2 Summary – SARIMA Modeling

- **Stationarity** confirmed (ADF test)
- **Seasonality** detected at lag 12
- **Model selected**: SARIMA(0,0,1)(0,0,1)[12]
- **Equation**:  
  \[
  Y_t = 1.0154 - 0.2815 \cdot \varepsilon_{t-1} - 0.6816 \cdot \varepsilon_{t-12} + \varepsilon_t
  \]
- **Model diagnostics**:
  - All coefficients statistically significant
  - Normality confirmed (Q-Q plot, Shapiro-Wilk)
  - Residuals exhibit no autocorrelation (Ljung-Box)

---


