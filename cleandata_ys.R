rm(list = ls())

require(tidyverse)
require(readr)

# clean EXTR_HomeImpExempts.csv
# combine major and minor key
# delete columns BldgNbr, FirstBillYr, LastBillYr, ValuedBy, UpdatedBy, UpdateDate
# remove rows with 0 improvement value

# homeexe <- read.csv('EXTR_HomeImpExempts.csv')
# 
# homeexe <- homeexe %>%
#   mutate(mm_key = paste0(Major, '-', Minor), ValueDate = substr(ValueDate, 1, 4), .before = 1) %>%
#   select(-c(Major, Minor, BldgNbr, FirstBillYr, LastBillYr, ValuedBy, UpdatedBy, UpdateDate))
# 
# # filter those with an actual improvement value
# homeexe <- homeexe %>%
#   filter(HomeImpVal > 0)
# 
# 
# write.csv(homeexe, 'EXTR_HomeImpExempts.csv', row.names = FALSE)

# clean EXTR_ValueHistory_V.csv
# combine major and minor

valhist <- read.csv('EXTR_ValueHistory_V.csv')

valhist <- valhist %>%
  mutate(mm_key = paste0(Major, '-', Minor), .before = 1) %>%
  select(-c(Major, Minor, OmitYr, ApprLandVal, ApprImpsVal, ApprImpIncr, TaxValReason, TaxStatus, ChangeDate, ChangeDocId, Reason, SplitCode))

valhist <- valhist %>%
  filter(TaxYr > 2012)

write.csv(valhist, 'EXTR_ValueHistory_V.csv', row.names = FALSE)





