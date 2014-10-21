setwd("/Users/Josh/Desktop/Universe/Computation/GitHub/HW3")
source("check_packages.R")
check_packages(c("dplyr", "date", "data.table", "tidyr", "stringr", "rgdal", "rgeos", "httr", "rjson", "RDSTK"))

#only use 1/10 data to run to save time
dm = read.csv("/home/vis/cr173/Sta523/data/parking/NYParkingViolations_small.csv",
              stringsAsFactors=FALSE) %>% 
  as.data.frame() %>%
  tbl_df()

#choose right issue date
dm$Issue.Date = mdy(dm$Issue.Date)
sdm = filter(dm, Issue.Date > "2013/09/01", Issue.Date < "2014/6/30")

#choose the correct precincts
sdm = filter(sdm, Violation.Precinct <= 34)

#@ should seperate intersecting and street name
stn <- sdm %>%
  filter(str_detect(Street.Name,"@")) %>%
  mutate(Street.Name = paste(Street.Name, " ")) %>%
  separate(Street.Name, c("Street.Name", "a2"), sep = "@") 

sdm2 <- select(sdm, Street.Code1, Street.Code2, Street.Code3, Street.Name, Intersecting.Street, House.Number, Violation.Precinct) %>%
mutate(Intersecting.Street=ifelse(str_detect(Street.Name,"@"), paste(stn$a2, Intersecting.Street), Intersecting.Street)) %>%
mutate(Street.Name=ifelse(str_detect(Street.Name,"@"), stn$Street.Name, Street.Name))

addrs = sdm2  %>%
       mutate(House.Number = str_trim(House.Number), Street.Name = str_trim(Street.Name), Intersecting.Street = str_trim(Intersecting.Street)) %>%
       filter(str_detect(House.Number,"[0-9]+")) %>%
       transmute(Violation.Precinct = Violation.Precinct, Intersecting.Street = Intersecting.Street,addr = paste(House.Number, Street.Name, ", NYC,", "NY"))

