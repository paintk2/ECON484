# Real Estate Analysis 
# ECON 484 
# Group 4 

# Packages 
library(tidyverse)

# Data Wrangling 

sales <- read.csv("rp_sales.csv")

#change document date to year/date format 

sales_clean <- sales %>% 
  filter(PropertyType %in% c(10, 11, 12, 13, 14, 18, 19, 2, 3, 6)) %>% 
  mutate(DocumentDate = as.numeric(substr(DocumentDate, 7, 10))) 

sales_2012 <- sales_clean %>% 
  filter(DocumentDate >= 2012)
  
  
  # not including mobile homes, check 6 



# Feature Selection 

# Choosing Model 

# Final Model Summary 