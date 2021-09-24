install.packages('tidyverse')
library(readr)
library(openxlsx)
library(tidyverse)
library(lme4)

cone_model <- lm(formula = 
                   cones_real ~ days_real + dailyprecip + dailytemp + 
                   snow + thunder + gallery_hop + is_holiday, data = firstmodel)
summary(cone_model)

predict(cone_model, data.frame(days_real = 'Saturday', dailyprecip = 0.0, dailytemp = 75, snow = 0, thunder = '0', gallery_hop = 'Yes', is_holiday = "Yes"))

bowl_model <- lm(formula = 
                   bowls_real ~ days_real + dailyprecip + 
                   dailytemp + snow + thunder + gallery_hop + is_holiday, data = firstmodel)

summary(bowl_model)


cones_function <- function(a,b,c,d,e) {
  
  a <- readline('What day of the week is it? ')
  b <- readline('How much is it going to rain? (in) ')
  c <- readline('What is the average temp for the day? ')
  d <- readline('Is it gallery hop? ')
  e <- readline('Is it a holiday or holiday weekend? ')
  
  b <- as.numeric(paste(b))
  c <- as.numeric(paste(c))
  
  
  print(predict(cone_model, data.frame(days_real = a, dailyprecip = b, dailytemp = c, snow = 0, thunder = '0', gallery_hop = d, is_holiday = e), interval = 'confidence'))
  
  print(predict(bowl_model, data.frame(days_real = a, dailyprecip = b, dailytemp = c, snow = 0, thunder = '0', gallery_hop = d, is_holiday = e), interval = 'confidence'))
  
}
