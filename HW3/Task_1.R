setwd("/Users/Josh/Desktop/Universe/Computation/GitHub/HW3")
source("check_packages.R")
check_packages(c("dplyr", "data.table", "tidyr", "stringr", "rgdal", "rgeos", "httr", "rjson", "RDSTK"))

dm = tbl_df(read.csv("/home/vis/cr173/Sta523/data/parking/NYParkingViolations.csv", stringsAsFactors=FALSE))

hund <- seq(1, 9000000, 100)
hund
sdm <- dm[hund,] 

sdm2 <- select(sdm, Street.Code1, Street.Code2, Street.Code3, Street.Name, Intersecting.Street, House.Number, Violation.Precinct) %>%
mutate(Intersecting.Street=ifelse(str_detect(Street.Name,"@"), paste(stn$a2, Intersecting.Street), Intersecting.Street)) %>%
mutate(Street.Name=ifelse(str_detect(Street.Name,"@"), stn$Street.Name, Street.Name))

addrs = sdm2  %>%
       mutate(House.Number = str_trim(House.Number), Street.Name = str_trim(Street.Name), Intersecting.Street = str_trim(Intersecting.Street)) %>%
       filter(str_detect(House.Number,"[0-9]+")) %>%
       transmute(Violation.Precinct = Violation.Precinct, Intersecting.Street = Intersecting.Street,addr = paste(House.Number, Street.Name, ", NYC,", "NY")) 
