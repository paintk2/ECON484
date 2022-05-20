# Real Estate Analysis 
# ECON 484 
# Group 4 

# Packages 
library(tidyverse)

# Data Wrangling 

sales <- read.csv("./data/EXTR_RPSale.csv")

#change document date to year/date format 

sales_clean <- sales %>% 
  filter(PropertyType %in% c(10, 11, 12, 13, 14, 18, 19, 2, 3, 6)) %>% 
  mutate(DocumentDate = as.numeric(substr(DocumentDate, 7, 10))) 

sales_2012 <- sales_clean %>% 
  filter(DocumentDate >= 2012)
  
  
  # not including mobile homes, check 6 

# Combines Major and Minor columns
combineID <- function(df) {
  df %>% 
    mutate(mm_key = paste0(Major, '-', Minor), .before = 1) %>% 
    select(-c(Major, Minor))
}

sales_2012 <- combineID(sales_2012)

# removing useless information 
sales_2012 <- sales_2012 %>%
  select(-c(ExciseTaxNbr, SellerName, BuyerName))




# Feature Selection 

# Choosing Model 

# Final Model Summary 