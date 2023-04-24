# libraries
library(modeltime)
library(plotly)
library(tidymodels)
library(tidyverse)
library(readxl)
library(CausalImpact)

# Loading the Covid_19 Datasets for Kenya (Daily New_cases)
set.seed(1) #for reproducibility
data <- read_excel("C:/Users/JIT/Downloads/COVID-19 DATASETS/python_19.xlsm")
data
str(data)
data$Date <- as.Date(data$Date)
data <- data %>%  select(Date, NewCases) 
attach(data)
head(data)
tail(data)

pre.period <-as.Date( c("2020-03-13", "2020-03-25"))
post.period <-as.Date( c("2020-04-30", "2022-03-28"))

time.points <- seq.Date(as.Date("2020-03-13"), by=1, length.out = 746)
intervention=zoo(NewCases, time.points)
impact <- CausalImpact(intervention, pre.period, post.period)
summary(impact)
summary(impact, "report")
plot(impact)
plot(impact, "original")

