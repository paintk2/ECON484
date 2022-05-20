require(tidyverse)
require(readr)

# Clean EXTR_Accessory_V.csv
# Combine major minor key
# Delete columns AccyDescr, UpdatedBy, UpdateDate

accessory <- read.csv("EXTR_Accessory_V.csv")

accessory <- accessory %>% 
  mutate(mm_key = paste0(Major, '-', Minor), .before = 1) %>% 
  select(-c(Major, Minor, AccyDescr, UpdatedBy, UpdateDate))

accessory <- accessory %>% 
  filter(Size >= 0)

accessory$AccyType <- as.factor(accessory$AccyType)

write.csv(accessory,'EXTR_Accessory_V.csv', row.names = FALSE)


# Clean EXTR_AptComplex.csv
# Combine major minor key
# Delete columns ComplexDescr, Address
# factor ProjectLocation, ProjectAppeal, ConstrClass, BldgQuality, Condition

aptcomplex <- read.csv("EXTR_AptComplex.csv")

aptcomplex <- aptcomplex %>% 
  mutate(mm_key = paste0(Major, '-', Minor), .before = 1) %>% 
  select(-c(Major, Minor, ComplexDescr, Address))

factor_cols <- c("ProjectLocation", "ProjectAppeal", 
                 "ConstrClass", "BldgQuality", "Condition")
aptcomplex[,factor_cols] <- lapply(aptcomplex[,factor_cols],as.factor)

write.csv(aptcomplex, 'EXTR_AptComplex.csv', row.names = FALSE)



# Clean EXTR_ChangeHist_V.csv
# Combine major minor key
# Delete columns EventPerson, DocId
# Factor Type

changehist <- read.csv("EXTR_ChangeHist_V.csv")

changehist <- changehist %>% 
  mutate(mm_key = paste0(Major, '-', Minor), .before = 1) %>% 
  select(-c(Major, Minor, EventPerson, DocId))
factor_cols <- c("Type")

# divide data and save
chunk <- 10000
n <- nrow(changehist)
r <- rep(1:ceiling(n/chunk), each=chunk)[1:n]
d <- split(changehist, r)
rm(changehist)


d <- lapply(d, function(x){
  x$Type <- factor(x$Type)
  return(x)
})

# combine subsets into one dataset
changehist <- bind_rows(d)

write.csv(changehist,'EXTR_ChangeHist_V.csv', row.names = FALSE)




# Clean EXTR_ChangeHistDetail_V.csv
# Combine major minor key
# Delete columns UpdatedBy, AttributeValue

require(readr)
changehist_detail<- readr::read_csv('EXTR_ChangeHistDetail_V.csv')

colnames(changehist_detail) <- c("Major", "Minor", "EventId", "Id", "Attribute", "AttributeValue", "UpdateDate", "UpdatedBy")

changehist_detail <- changehist_detail %>%
  select(-c(UpdatedBy, AttributeValue))

changehist_detail %>%
  filter(is.na(as.numeric(Minor))) %>%
  summarise(n())

# divide data and save
chunk <- 10000
n <- nrow(changehist_detail)
r <- rep(1:ceiling(n/chunk), each=chunk)[1:n]
d <- split(changehist_detail, r)
# rm(changehist_detail)

# apply factor
d <- lapply(d, function(x){
  x$Major <- as.numeric(x$Major)
  x$Minor <- as.numeric(x$Minor)
  x$EventId <- as.numeric(x$EventId)
  return(x)
})

d <- lapply(d, function(x){
  x <- x %>% 
    mutate(mm_key = paste0(Major, '-', Minor), .before = 1) %>% 
    select(-c(Major, Minor))
  return(x)
})

# combine subsets into one dataset
changehist_detail <- bind_rows(d)

write.csv(changehist_detail,'EXTR_ChangeHistDetail_V.csv', row.names = FALSE)




# Clean EXTR_UnitBreakdown.csv
# Combine major minor key
# Delete columns UpdatedBy, AttributeValue

unitbreakdown <- read.csv("EXTR_UnitBreakdown.csv")

unitbreakdown <- unitbreakdown %>% 
  mutate(mm_key = paste0(Major, '-', Minor), .before = 1) %>% 
  select(-c(Major, Minor))

unitbreakdown$UnitTypeItemId <- as.factor(unitbreakdown$UnitTypeItemId)

unitbreakdown$NbrBedrooms[unitbreakdown$NbrBedrooms == "s"] <- 0
unitbreakdown$NbrBedrooms <- as.number(unitbreakdown$NbrBedrooms)

write.csv(unitbreakdown,'EXTR_UnitBreakdown.csv', row.names = FALSE)
