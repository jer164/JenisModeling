library(readr)
library(openxlsx)
library(tidyverse)
library(lme4)
library(MASS)

load("/Users/jacksonrudoff/Documents/Data Projects/Waffle Project/data_for_waffle_model_updated10-13.Rdata")

cone_modelGLM <- glm.nb(formula = 
                          cones_real ~ days_real + dailyprecip + dailytemp + 
                          snow + thunder + gallery_hop + is_holiday, data = newmodel)

bowl_modelGLM <- glm.nb(formula = 
                          bowls_real ~ days_real + dailyprecip + dailytemp + 
                          snow + thunder + gallery_hop + is_holiday, data = newmodel)


cones_function <- function(a,b,c,d,e){
  
  a <- readline('What day of the week is it? ')
  b <- readline('How much is it going to rain? (in) ')
  c <- readline('What is the average temp for the day? ')
  d <- readline('Is it gallery hop? ')
  e <- readline('Is it a holiday or holiday weekend? ')
  
  b <- as.numeric(paste(b))
  c <- as.numeric(paste(c))
  
  
  conepredict <- round(predict(cone_modelGLM, data.frame(days_real = a, 
                                                         dailyprecip = b, 
                                                         dailytemp = c, 
                                                         snow = 0, 
                                                         thunder = '0', 
                                                         gallery_hop = d, 
                                                         is_holiday = e), 
                               type = 'response'))
  
  bowlpredict <- round(predict(bowl_modelGLM, data.frame(days_real = a, 
                                                         dailyprecip = b, 
                                                         dailytemp = c, 
                                                         snow = 0, 
                                                         thunder = '0', 
                                                         gallery_hop = d, 
                                                         is_holiday = e), 
                               type = 'response'))
  
  overflowcone <- 0.5*sd(newmodel$cones_real)
  overflowbowl <- 0.5*sd(newmodel$bowls_real)
  
  predictions <- tibble(conepredict,bowlpredict) %>% add_column(.before = 'bowlpredict', 
                                                                'uppercones' = round(
                                                                  overflowcone+conepredict)) %>% 
    add_column(.after = 'bowlpredict', 
               'upperbowls' = 
                 round(overflowbowl+bowlpredict))
  
  print(predictions)
  
}